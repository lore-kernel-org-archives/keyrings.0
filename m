Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794785538;
	b=f9JTK80ahw6BdoVw+9kf+HVFdq42jNS7G5Q+FBppVu8ryK8PfcU/7EHvvVsGP4G8QCGF
	 TiOR827uVxWrzfy9xVBOIqolYWzN1ho72R1hBoxQIo/M0YDHi3H0H9xwVHSJl4LESYRv8
	 bnEv3Jb/LgT+fgAm/I7jgxK0Ip/uuLI2/AyQ/2wpQzM2x5oDYJe6tDXYQylImTghVPUe5
	 dje7taYuWhpzQ98xR90kuWsEsnG+RsV1kEwGOmnNiU8TVIZNKhplzXNEnWTzk0N6j0JrY
	 qfCx/qWdsl21/PqU5FlPoPl5YtK2+dl8VLe/Cq2U6ZqqvLMZXz9ZLauodjQ6RNCDgJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794785538;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mmfc01cB3fVIu0LeL0rTddoei11XdssT07yxj2L2bWw=;
	b=YIl0cT8i3YTZDQBSgsDqfW4Ke6+EvGvuL3xMTdcajyKO2N7SO3K/F7iiSm3KVxLU8NKH
	 G01jQtxn8W3ZpDxE/u8/uFahQq9p0KHzwTnVlkRXnOuc1Bp9NBGxxd0XtETctsLIp3KpK
	 dmrGO1JLlXAwhtButeTCDWbkTw1kpYuz6h6xiNA9r4/QgdlMMSPyVA29rLUQO9RUE7tW/
	 mZgAT9TtxEciN/UqmKqoXE2FYE1zoTIKdy7NQCPpTKvvtdUv7xZcObgdqaPJ4L33iTwng
	 YsCgmU06i93A/m7nk+RPSQ/6SjOV9Uwtw5TyaXyhUZtL6m0WKba7mypuzXNxynywHMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WqOY92GL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 90663606A329;
	Sun, 15 Nov 2026 23:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WqOY92GL
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D138B1F000C4;
	Sun, 15 Nov 2026 23:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794785538;
	bh=mmfc01cB3fVIu0LeL0rTddoei11XdssT07yxj2L2bWw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WqOY92GLw2DFM1PkIAdJfiliKoiBwh/noh/xMjlPpYjfd4KbOyIJGMF25VYVznBgP
	 TCK1V9wTGsLUwuGIvW+Mj6w5m4jjnUU1JXFb0VQ+SYiPj81ZlM/g9/t7e2pE8bLOKp
	 FrKqMrXFYTtdusirDPpXBPl/1X6TXy2ZTD7vS+g+0H/G4ZTGlwtXU+VCpLUZT2gQiz
	 MQ/uISwe//1J4FNgh6c55SORFxw4B/tFM3X6N0cLxssPaxrTiMuN4KXzSUWgnegLa2
	 kHL+7V/XGjR5thHOsst/92KofiaU5/MkPrFoPnbGWzX0L5YGoL+TDwcruvlaihLRHO
	 alHxRzFzc45+Q==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Alec Brown <alec.r.brown@oracle.com>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	James Morris <jmorris@namei.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan McDowell <noodles@earth.li>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Ross Philipson <ross.philipson@gmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH v2 4/4] tpm2-sessions: Re-orchestrate tpm2_read_public() use
Date: Mon, 16 Nov 2026 01:31:56 +0200
Message-ID: <20261115233156.1485238-5-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115233156.1485238-1-jarkko@kernel.org>
References: <20261115233156.1485238-1-jarkko@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move TPM handle name resolution out of tpm_buf_append_name(), so that
callers resolve object names explicitly before constructing HMAC-protected
commands:

1. Export tpm2_read_public(), so that trusted_tpm2 can resolve handle
   names, and store non-object handles in big-endian byte order matching
   the TPM 2.0 handle Name definition.
2. Call tpm2_read_public() explicitly in tpm2_seal_trusted(),
   tpm2_load_cmd(), and tpm2_unseal_cmd() before starting the auth
   session, and pass the pre-resolved name and size to
   tpm_buf_append_name().
3. Rework tpm_buf_append_name() and tpm_buf_fill_hmac_session() to use
   the caller-supplied name and size directly.

This reduces fallible exits from tpm2_buf_append_name().

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 drivers/char/tpm/tpm2-cmd.c               |   9 +-
 drivers/char/tpm/tpm2-sessions.c          | 122 +++++++---------------
 include/linux/tpm.h                       |  10 +-
 security/keys/trusted-keys/trusted_tpm2.c |  33 +++++-
 4 files changed, 84 insertions(+), 90 deletions(-)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 4b2bb2ddc321..9c7e8b9aff4d 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -194,11 +194,12 @@ int tpm2_pcr_extend(struct tpm_chip *chip, u32 pcr_idx,
 	tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_PCR_EXTEND);
 
 	if (!disable_pcr_integrity) {
-		rc = tpm_buf_append_name(chip, buf, pcr_idx, NULL);
-		if (rc) {
-			tpm2_end_auth_session(chip);
+		__be32 pcr_idx_be = cpu_to_be32(pcr_idx);
+
+		rc = tpm_buf_append_name(chip, buf, pcr_idx,
+					 (u8 *)&pcr_idx_be, sizeof(pcr_idx_be));
+		if (rc)
 			return rc;
-		}
 		tpm_buf_append_hmac_session(chip, buf, 0, NULL, 0);
 	} else {
 		tpm_buf_append_handle(buf, pcr_idx);
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
index 94c11135beb3..fa107719b4f9 100644
--- a/drivers/char/tpm/tpm2-sessions.c
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -136,8 +136,8 @@ struct tpm2_auth {
 	 * handle, but they are part of the session by name, which
 	 * we must compute and remember
 	 */
-	u32 name_h[AUTH_MAX_NAMES];
 	u8 name[AUTH_MAX_NAMES][TPM2_MAX_NAME_SIZE];
+	u16 name_size_tbl[AUTH_MAX_NAMES];
 };
 
 #ifdef CONFIG_TCG_TPM2_HMAC
@@ -163,7 +163,17 @@ static int name_size(const u8 *name)
 	}
 }
 
-static int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
+/**
+ * tpm2_read_public() - Resolve TPM name for a handle
+ * @chip:	TPM chip to use.
+ * @handle:	TPM handle.
+ * @name:	Buffer for returning the name blob. Must have a capacity of at
+ *		least %TPM2_MAX_NAME_SIZE bytes.
+ *
+ * Return: Size of the TPM handle name on success, or a negative errno when
+ * TPM2_ReadPublic fails.
+ */
+int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
 {
 	u32 mso = tpm2_handle_mso(handle);
 	off_t offset = TPM_HEADER_SIZE;
@@ -172,7 +182,7 @@ static int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
 
 	if (mso != TPM2_MSO_PERSISTENT && mso != TPM2_MSO_VOLATILE &&
 	    mso != TPM2_MSO_NVRAM) {
-		memcpy(name, &handle, sizeof(u32));
+		put_unaligned_be32(handle, name);
 		return sizeof(u32);
 	}
 
@@ -189,7 +199,8 @@ static int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
 		return tpm_ret_to_err(rc);
 
 	/* Skip TPMT_PUBLIC: */
-	offset += tpm_buf_read_u16(buf, &offset);
+	rc = tpm_buf_read_u16(buf, &offset);
+	offset += rc;
 
 	/*
 	 * Ensure space for the length field of TPM2B_NAME and hashAlg field of
@@ -212,39 +223,34 @@ static int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name)
 	memcpy(name, &buf->data[offset], rc);
 	return name_size_alg;
 }
+EXPORT_SYMBOL_GPL(tpm2_read_public);
 #endif /* CONFIG_TCG_TPM2_HMAC */
 
 /**
- * tpm_buf_append_name() - add a handle area to the buffer
- * @chip: the TPM chip structure
- * @buf: The buffer to be appended
- * @handle: The handle to be appended
- * @name: The name of the handle (may be NULL)
+ * tpm_buf_append_name() - Append a handle and store TPM name
+ * @chip:	TPM chip to use.
+ * @buf:	TPM buffer containing the TPM command in-transit.
+ * @handle:	TPM handle to be appended.
+ * @name:	TPM name of the handle.
+ * @name_size:	Size of the TPM name.
  *
  * In order to compute session HMACs, we need to know the names of the
- * objects pointed to by the handles.  For most objects, this is simply
- * the actual 4 byte handle or an empty buf (in these cases @name
- * should be NULL) but for volatile objects, permanent objects and NV
- * areas, the name is defined as the hash (according to the name
- * algorithm which should be set to sha256) of the public area to
- * which the two byte algorithm id has been appended.  For these
- * objects, the @name pointer should point to this.  If a name is
- * required but @name is NULL, then TPM2_ReadPublic() will be called
- * on the handle to obtain the name.
+ * objects pointed to by the handles. For permanent and PCR handles this is
+ * the 4-byte big-endian handle; for volatile objects, persistent objects
+ * and NV areas this is the name resolved with tpm2_read_public().
  *
  * As with most tpm_buf operations, success is assumed because failure
  * will be caused by an incorrect programming model and indicated by a
  * kernel message.
  *
- * Ends the authorization session on failure.
+ * Return: 0 on success, or -EIO when the authorization area state is
+ * malformed.
  */
 int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
-			u32 handle, u8 *name)
+			u32 handle, u8 *name, u16 name_size)
 {
 #ifdef CONFIG_TCG_TPM2_HMAC
-	enum tpm2_mso_type mso = tpm2_handle_mso(handle);
 	struct tpm2_auth *auth;
-	u16 name_size_alg;
 	int slot;
 	int ret;
 #endif
@@ -263,45 +269,26 @@ int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
 	}
 	auth = chip->auth;
 	if (auth->session != tpm_buf_length(buf)) {
-		dev_err(&chip->dev, "session state malformed");
+		dev_err(&chip->dev, "session state malformed\n");
+		ret = -EIO;
+		goto err;
+	}
+	if (name_size > TPM2_MAX_NAME_SIZE) {
+		dev_err(&chip->dev, "name too long: %u\n", name_size);
 		ret = -EIO;
 		goto err;
 	}
 	tpm_buf_append_u32(buf, handle);
 	auth->session += 4;
-
-	if (mso == TPM2_MSO_PERSISTENT ||
-	    mso == TPM2_MSO_VOLATILE ||
-	    mso == TPM2_MSO_NVRAM) {
-		if (!name) {
-			ret = tpm2_read_public(chip, handle, auth->name[slot]);
-		} else {
-			ret = name_size(name);
-		}
-
-		if (ret < 0)
-			goto err;
-
-		name_size_alg = ret;
-	} else {
-		if (name) {
-			dev_err(&chip->dev, "handle 0x%08x does not use a name\n",
-				handle);
-			ret = -EIO;
-			goto err;
-		}
-	}
-
-	auth->name_h[slot] = handle;
-	if (name)
-		memcpy(auth->name[slot], name, name_size_alg);
+	memcpy(auth->name[slot], name, name_size);
+	auth->name_size_tbl[slot] = name_size;
 #endif
 	return 0;
 
 #ifdef CONFIG_TCG_TPM2_HMAC
 err:
 	tpm2_end_auth_session(chip);
-	return tpm_ret_to_err(ret);
+	return ret;
 #endif
 }
 EXPORT_SYMBOL_GPL(tpm_buf_append_name);
@@ -629,22 +616,8 @@ int tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 	attrs = chip->cc_attrs_tbl[i];
 
 	handles = (attrs >> TPM2_CC_ATTR_CHANDLES) & GENMASK(2, 0);
+	offset_s += handles * sizeof(u32);
 
-	/*
-	 * just check the names, it's easy to make mistakes.  This
-	 * would happen if someone added a handle via
-	 * tpm_buf_append_u32() instead of tpm_buf_append_name()
-	 */
-	for (i = 0; i < handles; i++) {
-		u32 handle = tpm_buf_read_u32(buf, &offset_s);
-
-		if (auth->name_h[i] != handle) {
-			dev_err(&chip->dev, "invalid handle 0x%08x\n", handle);
-			ret = -EIO;
-			goto err;
-		}
-	}
-	/* point offset_s to the start of the sessions */
 	val = tpm_buf_read_u32(buf, &offset_s);
 	/* point offset_p to the start of the parameters */
 	offset_p = offset_s + val;
@@ -705,23 +678,8 @@ int tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf)
 	/* ordinal is already BE */
 	sha256_update(&sctx, (u8 *)&head->ordinal, sizeof(head->ordinal));
 	/* add the handle names */
-	for (i = 0; i < handles; i++) {
-		enum tpm2_mso_type mso = tpm2_handle_mso(auth->name_h[i]);
-
-		if (mso == TPM2_MSO_PERSISTENT ||
-		    mso == TPM2_MSO_VOLATILE ||
-		    mso == TPM2_MSO_NVRAM) {
-			ret = name_size(auth->name[i]);
-			if (ret < 0)
-				goto err;
-
-			sha256_update(&sctx, auth->name[i], ret);
-		} else {
-			__be32 h = cpu_to_be32(auth->name_h[i]);
-
-			sha256_update(&sctx, (u8 *)&h, 4);
-		}
-	}
+	for (i = 0; i < handles; i++)
+		sha256_update(&sctx, auth->name[i], auth->name_size_tbl[i]);
 	if (offset_s != tpm_buf_length(buf))
 		sha256_update(&sctx, &buf->data[offset_s],
 			      tpm_buf_length(buf) - offset_s);
diff --git a/include/linux/tpm.h b/include/linux/tpm.h
index 84c8fe226235..a9fd53363dc4 100644
--- a/include/linux/tpm.h
+++ b/include/linux/tpm.h
@@ -300,7 +300,7 @@ static inline struct tpm2_auth *tpm2_chip_auth(struct tpm_chip *chip)
 }
 
 int tpm_buf_append_name(struct tpm_chip *chip, struct tpm_buf *buf,
-			u32 handle, u8 *name);
+			u32 handle, u8 *name, u16 name_size);
 void tpm_buf_append_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf,
 				 u8 attributes, u8 *passphrase,
 				 int passphraselen);
@@ -314,6 +314,7 @@ int tpm_buf_fill_hmac_session(struct tpm_chip *chip, struct tpm_buf *buf);
 int tpm_buf_check_hmac_response(struct tpm_chip *chip, struct tpm_buf *buf,
 				int rc);
 void tpm2_end_auth_session(struct tpm_chip *chip);
+int tpm2_read_public(struct tpm_chip *chip, u32 handle, void *name);
 #else
 #include <linux/unaligned.h>
 
@@ -337,6 +338,13 @@ static inline int tpm_buf_check_hmac_response(struct tpm_chip *chip,
 {
 	return rc;
 }
+
+static inline int tpm2_read_public(struct tpm_chip *chip, u32 handle,
+				   void *name)
+{
+	put_unaligned_be32(handle, name);
+	return sizeof(u32);
+}
 #endif	/* CONFIG_TCG_TPM2_HMAC */
 
 #endif
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 22d27e2512db..f7a0a312a652 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -211,9 +211,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		      struct trusted_key_options *options)
 {
 	struct trusted_key_tpm *private = options->private;
+	u8 parent_name[TPM2_MAX_NAME_SIZE];
 	off_t offset = TPM_HEADER_SIZE;
 	struct tpm_buf *buf __free(kfree) = NULL;
 	struct tpm_buf *sized __free(kfree) = NULL;
+	u16 parent_name_size;
 	int blob_len = 0;
 	int hash;
 	u32 flags;
@@ -230,6 +232,12 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	if (rc)
 		return rc;
 
+	rc = tpm2_read_public(chip, private->keyhandle, parent_name);
+	if (rc < 0)
+		goto out_put;
+
+	parent_name_size = rc;
+
 	rc = tpm2_start_auth_session(chip);
 	if (rc)
 		goto out_put;
@@ -253,7 +261,8 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 
 	tpm_buf_init_sized(sized, TPM_BUFSIZE);
 
-	rc = tpm_buf_append_name(chip, buf, private->keyhandle, NULL);
+	rc = tpm_buf_append_name(chip, buf, private->keyhandle, parent_name,
+				 parent_name_size);
 	if (rc)
 		goto out;
 
@@ -358,7 +367,9 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 {
 	u8 *blob_ref __free(kfree) = NULL;
 	struct trusted_key_tpm *private = options->private;
+	u8 parent_name[TPM2_MAX_NAME_SIZE];
 	struct tpm_buf *buf __free(kfree) = NULL;
+	u16 parent_name_size;
 	unsigned int private_len;
 	unsigned int public_len;
 	unsigned int blob_len;
@@ -409,6 +420,12 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	if (blob_len > payload->blob_len)
 		return -E2BIG;
 
+	rc = tpm2_read_public(chip, private->keyhandle, parent_name);
+	if (rc < 0)
+		return rc;
+
+	parent_name_size = rc;
+
 	rc = tpm2_start_auth_session(chip);
 	if (rc)
 		return rc;
@@ -422,7 +439,8 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	tpm_buf_init(buf, TPM_BUFSIZE);
 	tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
 
-	rc = tpm_buf_append_name(chip, buf, private->keyhandle, NULL);
+	rc = tpm_buf_append_name(chip, buf, private->keyhandle, parent_name,
+				 parent_name_size);
 	if (rc)
 		return rc;
 
@@ -467,11 +485,19 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			   u32 blob_handle)
 {
 	struct trusted_key_tpm *private = options->private;
+	u8 blob_name[TPM2_MAX_NAME_SIZE];
 	struct tpm_buf *buf __free(kfree) = NULL;
+	u16 blob_name_size;
 	u16 data_len;
 	u8 *data;
 	int rc;
 
+	rc = tpm2_read_public(chip, blob_handle, blob_name);
+	if (rc < 0)
+		return rc;
+
+	blob_name_size = rc;
+
 	rc = tpm2_start_auth_session(chip);
 	if (rc)
 		return rc;
@@ -485,7 +511,8 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	tpm_buf_init(buf, TPM_BUFSIZE);
 	tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_UNSEAL);
 
-	rc = tpm_buf_append_name(chip, buf, blob_handle, NULL);
+	rc = tpm_buf_append_name(chip, buf, blob_handle, blob_name,
+				 blob_name_size);
 	if (rc)
 		return rc;
 
-- 
2.47.3

