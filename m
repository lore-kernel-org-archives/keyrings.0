From: "Kirill A. Shutemov" <kirill@shutemov.name>
Date: Wed, 31 Jul 2019 15:07:44 +0000
Subject: [PATCHv2 30/59] keys/mktme: Program MKTME keys into the platform hardware
Message-Id: <20190731150813.26289-31-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20190731150813.26289-1-kirill.shutemov@linux.intel.com>
To: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@amacapital.net>, David Howells <dhowells@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Dave Hansen <dave.hansen@intel.com>, Kai Huang <kai.huang@linux.intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>, Alison Schofield <alison.schofield@intel.com>, linux-mm@kvack.org, kvm@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>

From: Alison Schofield <alison.schofield@intel.com>

Finally, the keys are programmed into the hardware via each
lead CPU. Every package has to be programmed successfully.
There is no partial success allowed here.

Here a retry scheme is included for two errors that may succeed
on retry: MKTME_DEVICE_BUSY and MKTME_ENTROPY_ERROR.
However, it's not clear if even those errors should be retried
at this level. Perhaps they too, should be returned to user space
for handling.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 security/keys/mktme_keys.c | 92 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/security/keys/mktme_keys.c b/security/keys/mktme_keys.c
index 272bff8591b7..3c641f3ee794 100644
--- a/security/keys/mktme_keys.c
+++ b/security/keys/mktme_keys.c
@@ -83,6 +83,96 @@ static const match_table_t mktme_token = {
 	{OPT_ERROR, NULL}
 };
 
+struct mktme_hw_program_info {
+	struct mktme_key_program *key_program;
+	int *status;
+};
+
+struct mktme_err_table {
+	const char *msg;
+	bool retry;
+};
+
+static const struct mktme_err_table mktme_error[] = {
+/* MKTME_PROG_SUCCESS     */ {"KeyID was successfully programmed",   false},
+/* MKTME_INVALID_PROG_CMD */ {"Invalid KeyID programming command",   false},
+/* MKTME_ENTROPY_ERROR    */ {"Insufficient entropy",		      true},
+/* MKTME_INVALID_KEYID    */ {"KeyID not valid",		     false},
+/* MKTME_INVALID_ENC_ALG  */ {"Invalid encryption algorithm chosen", false},
+/* MKTME_DEVICE_BUSY      */ {"Failure to access key table",	      true},
+};
+
+static int mktme_parse_program_status(int status[])
+{
+	int cpu, sum = 0;
+
+	/* Success: all CPU(s) programmed all key table(s) */
+	for_each_cpu(cpu, mktme_leadcpus)
+		sum += status[cpu];
+	if (!sum)
+		return MKTME_PROG_SUCCESS;
+
+	/* Invalid Parameters: log the error and return the error. */
+	for_each_cpu(cpu, mktme_leadcpus) {
+		switch (status[cpu]) {
+		case MKTME_INVALID_KEYID:
+		case MKTME_INVALID_PROG_CMD:
+		case MKTME_INVALID_ENC_ALG:
+			pr_err("mktme: %s\n", mktme_error[status[cpu]].msg);
+			return status[cpu];
+
+		default:
+			break;
+		}
+	}
+	/*
+	 * Device Busy or Insufficient Entropy: do not log the
+	 * error. These will be retried and if retries (time or
+	 * count runs out) caller will log the error.
+	 */
+	for_each_cpu(cpu, mktme_leadcpus) {
+		if (status[cpu] = MKTME_DEVICE_BUSY)
+			return status[cpu];
+	}
+	return MKTME_ENTROPY_ERROR;
+}
+
+/* Program a single key using one CPU. */
+static void mktme_do_program(void *hw_program_info)
+{
+	struct mktme_hw_program_info *info = hw_program_info;
+	int cpu;
+
+	cpu = smp_processor_id();
+	info->status[cpu] = mktme_key_program(info->key_program);
+}
+
+static int mktme_program_all_keytables(struct mktme_key_program *key_program)
+{
+	struct mktme_hw_program_info info;
+	int err, retries = 10; /* Maybe users should handle retries */
+
+	info.key_program = key_program;
+	info.status = kcalloc(num_possible_cpus(), sizeof(info.status[0]),
+			      GFP_KERNEL);
+
+	while (retries--) {
+		get_online_cpus();
+		on_each_cpu_mask(mktme_leadcpus, mktme_do_program,
+				 &info, 1);
+		put_online_cpus();
+
+		err = mktme_parse_program_status(info.status);
+		if (!err)			   /* Success */
+			return err;
+		else if (!mktme_error[err].retry)  /* Error no retry */
+			return -ENOKEY;
+	}
+	/* Ran out of retries */
+	pr_err("mktme: %s\n", mktme_error[err].msg);
+	return err;
+}
+
 /* Copy the payload to the HW programming structure and program this KeyID */
 static int mktme_program_keyid(int keyid, u32 payload)
 {
@@ -97,7 +187,7 @@ static int mktme_program_keyid(int keyid, u32 payload)
 	kprog->keyid = keyid;
 	kprog->keyid_ctrl = payload;
 
-	ret = MKTME_PROG_SUCCESS;	/* Future programming call */
+	ret = mktme_program_all_keytables(kprog);
 	kmem_cache_free(mktme_prog_cache, kprog);
 	return ret;
 }
-- 
2.21.0
