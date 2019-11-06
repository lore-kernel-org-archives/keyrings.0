From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Wed, 06 Nov 2019 19:01:07 +0000
Subject: [PATCH v4 01/10] IMA: Defined an IMA hook to measure keys on key create or update
Message-Id: <20191106190116.2578-2-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191106190116.2578-1-nramas@linux.microsoft.com>
In-Reply-To: <20191106190116.2578-1-nramas@linux.microsoft.com>
To: zohar@linux.ibm.com, dhowells@redhat.com, matthewgarrett@google.com, sashal@kernel.org, jamorris@linux.microsoft.com, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

Asymmetric keys used for verifying file signatures or certificates
are currently not included in the IMA measurement list.

This patch defines a new IMA hook namely ima_post_key_create_or_update()
to measure asymmetric keys.

Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
---
 security/integrity/ima/ima_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index d7e987baf127..a0e233afe876 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -721,6 +721,22 @@ void ima_kexec_cmdline(const void *buf, int size)
 					   KEXEC_CMDLINE, 0);
 }
 
+/**
+ * ima_post_key_create_or_update - measure asymmetric keys
+ * @keyring: keyring to which the key is linked to
+ * @key: created or updated key
+ * @flags: key flags
+ * @create: flag indicating whether the key was created or updated
+ *
+ * Keys can only be measured, not appraised.
+ */
+void ima_post_key_create_or_update(struct key *keyring, struct key *key,
+				   unsigned long flags, bool create)
+{
+	if ((keyring != NULL) && (key != NULL))
+		return;
+}
+
 static int __init init_ima(void)
 {
 	int error;
-- 
2.17.1
