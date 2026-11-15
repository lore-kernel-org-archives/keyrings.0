Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794782867;
	b=Rg7EQTEEw7SutyhjGeDI8Zy9zBjT/b9DZKtJuvFtde2Cz81evOsVOgABMiMYuiCZ5JGJ
	 vPk3EzhKNqrgA1ElxnlPcTH4N6Th7JpQUB8YnQRUgg/Z2tbaknSjAmjht6kVcdzY1KqdF
	 TbqmoSAbreZTEH0pGowa8puza2LNsfUyaYHPXjaI9Suao9vCvbZmZ0yc8VsHfYllL/ASg
	 TMoKs/Y9nnDiNYKtehP+UH1dOiNb83ToemdNh9T1nBB7DHpza6/yhiZFtpZ4LWW0m00Sd
	 yDonq2cqkFVOQ/schztKj+BRnSpQx9yUCzRxg5PAX5tyGxja1t8N2HDI21y4BEKNZAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794782867;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4q5qcmlwImEHW4opagfSJu67mHlh6kx/M+zxLcR9Lys=;
	b=e+W/XJ3EzFU45uwcM30F5rAMDbetrzOaPYTrS9Dgeuig9mTVBn/c/b3RhsYPNT7R2giU
	 OU+4moZZ4oEfIh/CEcmDrhmfH2vNH+jf3gabw3oLOoYbaeutgLgM0AyRP7jZ2j6flZaeP
	 dECOlVZjQgjxT9dKdS0gvIybfv6qdcO4Fn8lfRXlzFclSgAbTvKHRBoyq759qtGbmMb90
	 GxC3oH2l/bgMMc9bbK5ei5SGtA3r7BwD6xV1aD7cm36SnlBN5m+acxkyIlCBkQ07w0aRt
	 uwJhv3A60F6rXdh6D05U8S52B1SM//zg4OuOvpkAolXIRkRiYHFgrI2Si5WT3QT15Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlgYPtpc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id ADC61606A32F;
	Sun, 15 Nov 2026 22:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HlgYPtpc
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BF4C81F000CD;
	Sun, 15 Nov 2026 22:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794782867;
	bh=4q5qcmlwImEHW4opagfSJu67mHlh6kx/M+zxLcR9Lys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HlgYPtpcFp8L4Pa3NbLWP4fqCf+XT5Vi33JI9+rgW0q2tk7cH0rCwwFUcSougZQz2
	 aQZ63iqVPzXmOZEOCDEa8Rf44L8NDLgEhvm/bQlYLwEGZq3/A3LRYXA4d/Bprr+61q
	 qvTW3VCOnH2BVK+eN3JYtuqqy2H0q/upbdAHXzitjFvHGome/ERRB7mjF08X8pb/nN
	 YCj1c+aTHu9gaz+NfB4CS0Zy58LDndMMTR2GdMglSInAnIqV8DCLAz1jpX8uaieLpS
	 O0EF9FTMBJatFnWTYkLk2839XwyfvC9rY3cyRKzh09ywVEwH3neANyGrk7w2UQOTo9
	 OyXMQJFPtKsSg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Alec Brown <alec.r.brown@oracle.com>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	James Morris <jmorris@namei.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan McDowell <noodles@earth.li>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Ross Philipson <ross.philipson@gmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH 2/4] KEYS: trusted: Open code tpm2_buf_append_auth()
Date: Mon, 16 Nov 2026 00:47:20 +0200
Message-ID: <20261115224722.1450498-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115224722.1450498-1-jarkko@kernel.org>
References: <20261115224722.1450498-1-jarkko@kernel.org>
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

