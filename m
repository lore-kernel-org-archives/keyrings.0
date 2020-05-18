From: James Prestwood <prestwoj@gmail.com>
Date: Mon, 18 May 2020 17:26:55 +0000
Subject: [PATCH 08/17] tpm2: add session encryption protection to tpm2_get_random()
Message-Id: <20200518172704.29608-9-prestwoj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200518172704.29608-1-prestwoj@gmail.com>
In-Reply-To: <20200518172704.29608-1-prestwoj@gmail.com>
To: keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com

From: James Bottomley <James.Bottomley@HansenPartnership.com>

If some entity is snooping the TPM bus, they can see the random
numbers we're extracting from the TPM and do prediction attacks
against their consumers.  Foil this attack by using response
encryption to prevent the attacker from seeing the random sequence.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 drivers/char/tpm/tpm2-cmd.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index b29824ae237c..92e381bfd7c8 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -291,29 +291,40 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	int total = 0;
 	int retries = 5;
 	u8 *dest_ptr = dest;
+	struct tpm2_auth *auth;
 
 	if (!num_bytes || max > TPM_MAX_RNG_DATA)
 		return -EINVAL;
 
-	err = tpm_buf_init(&buf, 0, 0);
+	err = tpm2_start_auth_session(chip, &auth);
 	if (err)
 		return err;
 
+	err = tpm_buf_init(&buf, 0, 0);
+	if (err) {
+		tpm2_end_auth_session(auth);
+		return err;
+	}
+
 	do {
-		tpm_buf_reset(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_RANDOM);
+		tpm_buf_reset(&buf, TPM2_ST_SESSIONS, TPM2_CC_GET_RANDOM);
+		tpm_buf_append_hmac_session_opt(&buf, auth, TPM2_SA_ENCRYPT
+						| TPM2_SA_CONTINUE_SESSION,
+						NULL, 0);
 		tpm_buf_append_u16(&buf, num_bytes);
+		tpm_buf_fill_hmac_session(&buf, auth);
 		err = tpm_transmit_cmd(chip, &buf,
 				       offsetof(struct tpm2_get_random_out,
 						buffer),
 				       "attempting get random");
+		err = tpm_buf_check_hmac_response(&buf, auth, err);
 		if (err) {
 			if (err > 0)
 				err = -EIO;
 			goto out;
 		}
 
-		out = (struct tpm2_get_random_out *)
-			&buf.data[TPM_HEADER_SIZE];
+		out = (struct tpm2_get_random_out *)tpm_buf_parameters(&buf);
 		recd = min_t(u32, be16_to_cpu(out->size), num_bytes);
 		if (tpm_buf_length(&buf) <
 		    TPM_HEADER_SIZE +
@@ -330,6 +341,8 @@ int tpm2_get_random(struct tpm_chip *chip, u8 *dest, size_t max)
 	} while (retries-- && total < max);
 
 	tpm_buf_destroy(&buf);
+	tpm2_end_auth_session(auth);
+
 	return total ? total : -EIO;
 out:
 	tpm_buf_destroy(&buf);
-- 
2.21.1
