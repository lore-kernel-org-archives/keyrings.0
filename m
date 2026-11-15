Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794785531;
	b=cPajaadaFJzvnK/5xo4dj0NK2zuTqqGTVf75x3xzDlegBe/hz1eOA153iiFXYhFmZZEQ
	 4WMU9qzubvWb0XaxaXLwgoSMK9JcSeokezw8txFGRSvKMwrPD1P+bI+gFPL5i7FOJ5tYH
	 jcCZlo92DmQsthmrl2jGjRMF5wp+wZwEQjh33eFNC+1GEmZ8Sxo7O2+1hFYJBYbfT6rSk
	 f3C00nEXrgQUh3m5cmisfxzMoa93ECiDn8k+dR/esVA6Mmh/yHnqlGdPfqV0cV7mMp+vv
	 T//UTENad1odDyjS5vcfJz78rRPmg4mjKECxqdSZFIhRxny9EgVdz6Ythn7tqwzgEMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794785531;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4q5qcmlwImEHW4opagfSJu67mHlh6kx/M+zxLcR9Lys=;
	b=NLzKv+ACf8eEhi9rOiBzahLilNCxmxnNX+dhzsSXPPJKhnoV2PXl+3oSUCxdglM7L2O+
	 BN7gHEO4l9cZgH9x2dOmD7wvZAgU3eth8DkqrkWhO8TwMeQiunwP3uoOay0PEweF6WXy+
	 B3FWqh6YRRd9JJHP35ymvdHDBOGrGftVeGbT4Cnp/uvfbXsmmg4NzAEAGWnQQFPGqOC18
	 QWcykp0UWJqj/u4r01mOSPTmRgOyWM+6UwrNnrek6vcH3DXt/HMTzPfZ+x0b66gWraLTK
	 UDt/cbZJ+zB+OKlxatZA2wmHIndRJAJNpAFGphrtOZKEx1H8wE3Lab8D8njjbvS1IZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+dyko6i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 50F96606A323;
	Sun, 15 Nov 2026 23:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M+dyko6i
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5AD061F000D4;
	Sun, 15 Nov 2026 23:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794785530;
	bh=4q5qcmlwImEHW4opagfSJu67mHlh6kx/M+zxLcR9Lys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M+dyko6iMaEZAe2w/FHQj41bR/rF3yeMIx24zQJxeYupiSF1fWhtUNOQVUjalL4Xy
	 /9TEUPeAvIC0C8OL70FUqOUDnWznjOt1yzubuq9rcnPhBLrPUnNQ1ruqVue0rzJ0NG
	 c4IZvrSU2pZqoUFKEkb3W3IeoUs46gR3/ltEPmp0BUtDSmalJimGUHlMbdT+nPzLxP
	 M705Lu1tE8Ss82kmIMsTpThwr4wBzqysNqARzQ/gdds92xODK5fBtRF0rw46hqzABQ
	 ptM/9lnSL3jj3IbgXKqgIjtr1o8oXtozvVTZ1st/5mgNngVdv/3nBghtPaWbq9WyGf
	 Oy8oGCkpbBz2g==
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
Subject: [PATCH v2 2/4] KEYS: trusted: Open code tpm2_buf_append_auth()
Date: Mon, 16 Nov 2026 01:31:54 +0200
Message-ID: <20261115233156.1485238-3-jarkko@kernel.org>
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

tpm2_buf_append_auth() has a single call site and most of its parameters
are redundant. Open code it to the call site so that less cross-referencing
is required while browsing the source code.

Reviewed-by: Jonathan McDowell <noodles@earth.li>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_tpm2.c | 40 ++++-------------------
 1 file changed, 7 insertions(+), 33 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 30188a0ec676..563997600636 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -197,36 +197,6 @@ int tpm2_key_priv(void *context, size_t hdrlen,
 	return 0;
 }
 
-/**
- * tpm2_buf_append_auth() - append TPMS_AUTH_COMMAND to the buffer.
- *
- * @buf: an allocated tpm_buf instance
- * @session_handle: session handle
- * @nonce: the session nonce, may be NULL if not used
- * @nonce_len: the session nonce length, may be 0 if not used
- * @attributes: the session attributes
- * @hmac: the session HMAC or password, may be NULL if not used
- * @hmac_len: the session HMAC or password length, maybe 0 if not used
- */
-static void tpm2_buf_append_auth(struct tpm_buf *buf, u32 session_handle,
-				 const u8 *nonce, u16 nonce_len,
-				 u8 attributes,
-				 const u8 *hmac, u16 hmac_len)
-{
-	tpm_buf_append_u32(buf, 9 + nonce_len + hmac_len);
-	tpm_buf_append_u32(buf, session_handle);
-	tpm_buf_append_u16(buf, nonce_len);
-
-	if (nonce && nonce_len)
-		tpm_buf_append(buf, nonce, nonce_len);
-
-	tpm_buf_append_u8(buf, attributes);
-	tpm_buf_append_u16(buf, hmac_len);
-
-	if (hmac && hmac_len)
-		tpm_buf_append(buf, hmac, hmac_len);
-}
-
 /**
  * tpm2_seal_trusted() - seal the payload of a trusted key
  *
@@ -537,9 +507,13 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		 * could repeat our actions with the exfiltrated
 		 * password.
 		 */
-		tpm2_buf_append_auth(buf, private->policyhandle,
-				     NULL /* nonce */, 0, 0,
-				     private->blobauth, private->blobauth_len);
+		tpm_buf_append_u32(buf, 9 + private->blobauth_len);
+		tpm_buf_append_u32(buf, private->policyhandle);
+		tpm_buf_append_u16(buf, 0);
+		tpm_buf_append_u8(buf, 0);
+		tpm_buf_append_u16(buf, private->blobauth_len);
+		tpm_buf_append(buf, private->blobauth, private->blobauth_len);
+
 		if (tpm2_chip_auth(chip)) {
 			tpm_buf_append_hmac_session(chip, buf, TPM2_SA_ENCRYPT,
 						    NULL, 0);
-- 
2.47.3

