From: James Prestwood <prestwoj@gmail.com>
Date: Mon, 18 May 2020 17:27:01 +0000
Subject: [PATCH 14/17] include: linux: tpm: expose tpm2_rsa_decrypt
Message-Id: <20200518172704.29608-15-prestwoj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200518172704.29608-1-prestwoj@gmail.com>
In-Reply-To: <20200518172704.29608-1-prestwoj@gmail.com>
To: keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, James Prestwood <prestwoj@gmail.com>

Expose these APIs so other modules can use them.
---
 include/linux/tpm.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index b1c96ee7b672..7dd33f144bce 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -387,6 +387,9 @@ static inline u32 tpm2_rc_value(u32 rc)
        return (rc & BIT(7)) ? rc & 0xff : rc;
 }
 
+extern int tpm2_rsa_decrypt(struct tpm_chip *chip, u32 parent,
+			    const unsigned char *keyblob, size_t bloblen,
+			    const void *data, size_t len, void *out);
 #else
 static inline int tpm_is_tpm2(struct tpm_chip *chip)
 {
@@ -418,5 +421,11 @@ static inline struct tpm_chip *tpm_default_chip(void)
 {
 	return NULL;
 }
+static inline int tpm2_rsa_decrypt(struct tpm_chip *chip, u32 parent,
+				   const unsigned char *keyblob, size_t bloblen,
+				   const void *data, size_t len, void *out)
+{
+	return -ENODEV;
+}
 #endif
 #endif
-- 
2.21.1
