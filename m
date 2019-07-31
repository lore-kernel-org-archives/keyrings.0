From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:07:53 +0000
Subject: [PATCHv2 39/59] keys/mktme: Support CPU hotplug for MKTME key service
Message-Id: <20190731150813.26289-40-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Alison Schofield <alison.schofield@intel.com>

The MKTME encryption hardware resides on each physical package.
The encryption hardware includes 'Key Tables' that must be
programmed identically across all physical packages in the
platform. Although every CPU in a package can program its key
table, the kernel uses one lead CPU per package for programming.

CPU Hotplug Teardown
--------------------
MKTME manages CPU hotplug teardown to make sure the ability to
program all packages is preserved when MKTME keys are present.

When MKTME keys are not currently programmed, simply allow
the teardown, and set "mktme_allow_keys" to false. This will
force a re-evaluation of the platform topology before the next
key creation. If this CPU teardown mattered, MKTME key service
will report an error and fail to create the key. (User can
online that CPU and try again)

When MKTME keys are currently programmed, allow teardowns
of non 'lead CPU's' and of CPUs where another, core sibling
CPU, can take over as lead. Do not allow teardown of any
lead CPU that would render a hardware key table unreachable!

CPU Hotplug Startup
-------------------
CPUs coming online are of interest to the key service, but since
the service never needs to block a CPU startup event, nor does it
need to prepare for an onlining CPU, a callback is not implemented.

MKTME will catch the availability of the new CPU, if it is
needed, at the next key creation time. If keys are not allowed,
that new CPU will be part of the topology evaluation to determine
if keys should now be allowed.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 security/keys/mktme_keys.c | 47 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
index 70662e882674..b042df73899d 100644
--- a/security/keys/mktme_keys.c
+++ b/security/keys/mktme_keys.c
@@ -460,9 +460,46 @@ static int mktme_alloc_pconfig_targets(void)
 	return 0;
 }
 
+static int mktme_cpu_teardown(unsigned int cpu)
+{
+	int new_leadcpu, ret = 0;
+	unsigned long flags;
+
+	/* Do not allow key programming during cpu hotplug event */
+	spin_lock_irqsave(&mktme_lock, flags);
+
+	/*
+	 * When no keys are in use, allow the teardown, and set
+	 * mktme_allow_keys to FALSE. That forces an evaluation
+	 * of the topology before the next key creation.
+	 */
+	if (mktme_available_keyids = mktme_nr_keyids()) {
+		mktme_allow_keys = false;
+		goto out;
+	}
+	/* Teardown CPU is not a lead CPU. Allow teardown. */
+	if (!cpumask_test_cpu(cpu, mktme_leadcpus))
+		goto out;
+
+	/* Teardown CPU is a lead CPU. Look for a new lead CPU. */
+	new_leadcpu = cpumask_any_but(topology_core_cpumask(cpu), cpu);
+
+	if (new_leadcpu < nr_cpumask_bits) {
+		/* New lead CPU found. Update the programming mask */
+		__cpumask_clear_cpu(cpu, mktme_leadcpus);
+		__cpumask_set_cpu(new_leadcpu, mktme_leadcpus);
+	} else {
+		/* New lead CPU not found. Do not allow CPU teardown */
+		ret = -1;
+	}
+out:
+	spin_unlock_irqrestore(&mktme_lock, flags);
+	return ret;
+}
+
 static int __init init_mktme(void)
 {
-	int ret;
+	int ret, cpuhp;
 
 	/* Verify keys are present */
 	if (mktme_nr_keyids() < 1)
@@ -500,10 +537,18 @@ static int __init init_mktme(void)
 	if (!encrypt_count)
 		goto free_targets;
 
+	cpuhp = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
+					  "keys/mktme_keys:online",
+					  NULL, mktme_cpu_teardown);
+	if (cpuhp < 0)
+		goto free_encrypt;
+
 	ret = register_key_type(&key_type_mktme);
 	if (!ret)
 		return ret;			/* SUCCESS */
 
+	cpuhp_remove_state_nocalls(cpuhp);
+free_encrypt:
 	kvfree(encrypt_count);
 free_targets:
 	free_cpumask_var(mktme_leadcpus);
-- 
2.21.0
