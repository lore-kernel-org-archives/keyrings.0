From: James Prestwood <prestwoj@gmail.com>
Date: Mon, 18 May 2020 17:26:51 +0000
Subject: [PATCH 04/17] tpm2-space: export the context save and load commands
Message-Id: <20200518172704.29608-5-prestwoj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200518172704.29608-1-prestwoj@gmail.com>
In-Reply-To: <20200518172704.29608-1-prestwoj@gmail.com>
To: keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com

From: James Bottomley <James.Bottomley@HansenPartnership.com>

The TPM2 session handling code needs to save and restore a single
volatile context for the elliptic curve version of the NULL seed, so
export the APIs which do this for internal use.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm.h        | 4 ++++
 drivers/char/tpm/tpm2-space.c | 8 ++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index c75340dc3bce..ba76bec04ca4 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -250,6 +250,10 @@ int tpm2_prepare_space(struct tpm_chip *chip, struct tpm_space *space, u8 *cmd,
 		       size_t cmdsiz);
 int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space, void *buf,
 		      size_t *bufsiz);
+int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
+		      unsigned int buf_size, unsigned int *offset);
+int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
+		      unsigned int *offset, u32 *handle);
 
 int tpm_bios_log_setup(struct tpm_chip *chip);
 void tpm_bios_log_teardown(struct tpm_chip *chip);
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 982d341d8837..ca1cb56ccc51 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -65,8 +65,8 @@ void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
 	kfree(space->session_buf);
 }
 
-static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
-			     unsigned int *offset, u32 *handle)
+int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
+		      unsigned int *offset, u32 *handle)
 {
 	struct tpm_buf tbuf;
 	struct tpm2_context *ctx;
@@ -116,8 +116,8 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
 	return 0;
 }
 
-static int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
-			     unsigned int buf_size, unsigned int *offset)
+int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
+		      unsigned int buf_size, unsigned int *offset)
 {
 	struct tpm_buf tbuf;
 	unsigned int body_size;
-- 
2.21.1
