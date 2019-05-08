From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 08 May 2019 14:43:48 +0000
Subject: [PATCH, RFC 28/62] keys/mktme: Set up PCONFIG programming targets for MKTME keys
Message-Id: <20190508144422.13171-29-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Alison Schofield <alison.schofield@intel.com>

MKTME Key service maintains the hardware key tables. These key tables
are package scoped per the MKTME hardware definition. This means that
each physical package on the system needs its key table programmed.

These physical packages are the targets of the new PCONFIG programming
command. So, introduce a PCONFIG targets bitmap as well as a CPU mask
that includes the lead CPUs capable of programming the targets.

The lead CPU mask will be used every time a new key is programmed into
the hardware.

Keep the PCONFIG targets bit map around for future use during hotplug
events.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 security/keys/mktme_keys.c | 42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
index 9fdf482ea3e6..b5b44decfd3e 100644
--- a/security/keys/mktme_keys.c
+++ b/security/keys/mktme_keys.c
@@ -2,6 +2,7 @@
 
 /* Documentation/x86/mktme_keys.rst */
 
+#include <linux/cpu.h>
 #include <linux/init.h>
 #include <linux/key.h>
 #include <linux/key-type.h>
@@ -17,6 +18,8 @@
 
 static DEFINE_SPINLOCK(mktme_lock);
 struct kmem_cache *mktme_prog_cache;	/* Hardware programming cache */
+unsigned long *mktme_target_map;	/* Pconfig programming targets */
+cpumask_var_t mktme_leadcpus;		/* One lead CPU per pconfig target */
 
 /* 1:1 Mapping between Userspace Keys (struct key) and Hardware KeyIDs */
 struct mktme_mapping {
@@ -303,6 +306,33 @@ struct key_type key_type_mktme = {
 	.destroy	= mktme_destroy_key,
 };
 
+static void mktme_update_pconfig_targets(void)
+{
+	int cpu, target_id;
+
+	cpumask_clear(mktme_leadcpus);
+	bitmap_clear(mktme_target_map, 0, sizeof(mktme_target_map));
+
+	for_each_online_cpu(cpu) {
+		target_id = topology_physical_package_id(cpu);
+		if (!__test_and_set_bit(target_id, mktme_target_map))
+			__cpumask_set_cpu(cpu, mktme_leadcpus);
+	}
+}
+
+static int mktme_alloc_pconfig_targets(void)
+{
+	if (!alloc_cpumask_var(&mktme_leadcpus, GFP_KERNEL))
+		return -ENOMEM;
+
+	mktme_target_map = bitmap_alloc(topology_max_packages(), GFP_KERNEL);
+	if (!mktme_target_map) {
+		free_cpumask_var(mktme_leadcpus);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
 static int __init init_mktme(void)
 {
 	int ret;
@@ -320,9 +350,21 @@ static int __init init_mktme(void)
 	if (!mktme_prog_cache)
 		goto free_map;
 
+	/* Hardware programming targets */
+	if (mktme_alloc_pconfig_targets())
+		goto free_cache;
+
+	/* Initialize first programming targets */
+	mktme_update_pconfig_targets();
+
 	ret = register_key_type(&key_type_mktme);
 	if (!ret)
 		return ret;			/* SUCCESS */
+
+	free_cpumask_var(mktme_leadcpus);
+	bitmap_free(mktme_target_map);
+free_cache:
+	kmem_cache_destroy(mktme_prog_cache);
 free_map:
 	kvfree(mktme_map);
 
-- 
2.20.1
