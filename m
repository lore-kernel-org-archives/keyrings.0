From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Wed, 08 May 2019 14:44:00 +0000
Subject: [PATCH, RFC 40/62] keys/mktme: Program new PCONFIG targets with MKTME keys
Message-Id: <20190508144422.13171-41-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190508144422.13171-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Alison Schofield <alison.schofield@intel.com>

When a new PCONFIG target is added to an MKTME platform, its
key table needs to be programmed to match the key tables across
the entire platform. This type of newly added PCONFIG target
may appear during a memory hotplug event.

This key programming path will differ from the normal key
programming path in that it will only program a single PCONFIG
target, AND, it will only do that programming if allowed.

Allowed means that either user type keys are stored, or, no
user type keys are currently programmed.

So, after checking if programming is allowable, this helper
function will program the one new PCONFIG target, with all
the currently programmed keys.

This will be used in MKTME's memory notifier callback supporting
MEM_GOING_ONLINE events.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 security/keys/mktme_keys.c | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
index 2c975c48fe44..489dddb8c623 100644
--- a/security/keys/mktme_keys.c
+++ b/security/keys/mktme_keys.c
@@ -582,6 +582,50 @@ static int mktme_get_new_pconfig_target(void)
 	return new_target;
 }
 
+static int mktme_program_new_pconfig_target(int new_pkg)
+{
+	struct mktme_payload *payload;
+	int cpu, keyid, ret;
+
+	/*
+	 * Only program new target when user type keys are stored or,
+	 * no user type keys are currently programmed.
+	 */
+	if (!mktme_storekeys &&
+	    (bitmap_weight(mktme_bitmap_user_type, mktme_nr_keyids)))
+		return -EPERM;
+
+	/* Set mktme_leadcpus to only include new target */
+	cpumask_clear(mktme_leadcpus);
+	for_each_online_cpu(cpu) {
+		if (topology_physical_package_id(cpu) = new_pkg) {
+			__cpumask_set_cpu(cpu, mktme_leadcpus);
+			break;
+		}
+	}
+	/* Program the stored keys into the new key table */
+	for (keyid = 1; keyid <= mktme_nr_keyids; keyid++) {
+		/*
+		 * When a KeyID slot is not in use, the corresponding key
+		 * pointer is 0. '-1' is an intermediate state where the
+		 * key is on it's way out, but not gone yet. Program '-1's.
+		 */
+		if (mktme_map->key[keyid] = 0)
+			continue;
+
+		payload = &mktme_key_store[keyid];
+		ret = mktme_program_keyid(keyid, payload);
+		if (ret != MKTME_PROG_SUCCESS) {
+			/* Quit on first failure to program key table */
+			pr_debug("mktme: %s\n", mktme_error[ret].msg);
+			ret = -ENOKEY;
+			break;
+		}
+	}
+	mktme_update_pconfig_targets();		/* Restore mktme_leadcpus */
+	return ret;
+}
+
 static int __init init_mktme(void)
 {
 	int ret, cpuhp;
-- 
2.20.1
