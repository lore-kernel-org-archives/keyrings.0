From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:07:46 +0000
Subject: [PATCHv2 32/59] keys/mktme: Clear the key programming from the MKTME hardware
Message-Id: <20190731150813.26289-33-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Alison Schofield <alison.schofield@intel.com>

Send a request to the MKTME hardware to clear a previously
programmed key. This will be used when userspace keys are
destroyed and the key slot is no longer in use. No longer
in use means that the reference has been released, and its
usage count has returned to zero.

This clear command is not offered as an option to userspace,
since the key service can execute it automatically, and at
the right time, safely.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 security/keys/mktme_keys.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
index 18cb57be5193..1e2afcce7d85 100644
--- a/security/keys/mktme_keys.c
+++ b/security/keys/mktme_keys.c
@@ -72,6 +72,9 @@ int mktme_keyid_from_key(struct key *key)
 	return 0;
 }
 
+static void mktme_clear_hardware_keyid(struct work_struct *work);
+static DECLARE_WORK(mktme_clear_work, mktme_clear_hardware_keyid);
+
 struct percpu_ref *encrypt_count;
 void mktme_percpu_ref_release(struct percpu_ref *ref)
 {
@@ -88,8 +91,9 @@ void mktme_percpu_ref_release(struct percpu_ref *ref)
 	}
 	percpu_ref_exit(ref);
 	spin_lock_irqsave(&mktme_lock, flags);
-	mktme_release_keyid(keyid);
+	mktme_map[keyid].state = KEYID_REF_RELEASED;
 	spin_unlock_irqrestore(&mktme_lock, flags);
+	schedule_work(&mktme_clear_work);
 }
 
 enum mktme_opt_id {
@@ -213,6 +217,27 @@ static int mktme_program_keyid(int keyid, u32 payload)
 	return ret;
 }
 
+static void mktme_clear_hardware_keyid(struct work_struct *work)
+{
+	u32 clear_payload = MKTME_KEYID_CLEAR_KEY;
+	unsigned long flags;
+	int keyid, ret;
+
+	for (keyid = 1; keyid <= mktme_nr_keyids(); keyid++) {
+		if (mktme_map[keyid].state != KEYID_REF_RELEASED)
+			continue;
+
+		ret = mktme_program_keyid(keyid, clear_payload);
+		if (ret != MKTME_PROG_SUCCESS)
+			pr_debug("mktme: clear key failed [%s]\n",
+				 mktme_error[ret].msg);
+
+		spin_lock_irqsave(&mktme_lock, flags);
+		mktme_release_keyid(keyid);
+		spin_unlock_irqrestore(&mktme_lock, flags);
+	}
+}
+
 /* Key Service Method called when a Userspace Key is garbage collected. */
 static void mktme_destroy_key(struct key *key)
 {
-- 
2.21.0
