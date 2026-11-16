Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794790282;
	b=IQLRvB+r6j03pEDYUQS8lV0OyUCUNb4HcaX32a0Bke2qjrf+ifVPeXqgab8Q+gMIyZy/
	 zfx4QCjUPySPFs8paeOXmp2Wec5Qxh9Uj75RNjIGh9X+nyzeizRM86Si33lAIWp3hlZD2
	 3V7+IO9DJtwsZem3y4TmMp6CWn91iWzAXwQsI556GpM/DAOZ79xv3c+x7BL+lbWHrUnGj
	 VwOT67/ROd6DfA1YAA1+O6P3k8YVfBGZ+acimbgjGa5W21RI8zWtF+GjtRa97Te23l9wV
	 oyMyltZE6b/hWXQHh3Nz71ImAAou5Gs4WpgLpclKZazov4Y5O6fi3q8KXmCqGB84weA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794790282;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4q5qcmlwImEHW4opagfSJu67mHlh6kx/M+zxLcR9Lys=;
	b=ah/6oyUTV9e3fCAX9UP7fbM5k4Pto+F/AlkeOXvP2dHVV+H6B5FJEh6Ho7LSQFcAgchO
	 Wfu6phI7nZOco02UX9evGsJC5IscpQ0LRf471T3yIyx3Bh3ShC02w5eZINiYiL8Rf0M5n
	 MoioYqAf+/LCCgTmMtw6tbHgpntEY/xMkcxJmfipAIP38MODVjSgXecCd39NzeYfJDkFY
	 fxzYFUroR2W7GzUDJjfqYYVGGS20gGLhJfELrYgnNCf8/faCMIdXQg3GZyiEaMjvH5UGP
	 4566Sp+k1hMzkHYbOMn7ngxNdB/ZmcphWZ6fKxws/v6oluCuctBZCLRKAhIVbNmngRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aU2Ozjr2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3212B606A323;
	Mon, 16 Nov 2026 00:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aU2Ozjr2
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 415701F000CC;
	Mon, 16 Nov 2026 00:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794790281;
	bh=4q5qcmlwImEHW4opagfSJu67mHlh6kx/M+zxLcR9Lys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aU2Ozjr2nYoRJqf6Dw3YV5BCddDzL3Q1UcvqK8bA8O6obKGq2PvXqKuSpvhpNJh9V
	 Ht1aM/OHym8CnIpQckfMaeAMjBI2MZozJqaEh77x6KN3f7n20QBVh6qc26YvvHHBWH
	 quRCzGpws/5UoUZ/WvqHbkijAeRKukknYuP2noGgt43yk1jHPCFQKlY4ol4EU4zYP6
	 GVOYdpKGDLNloVC7pyQLq7uKU+63+JJ4V72VEf0R3wBXXpIV9BqEP746N+0TefE+BQ
	 XShaMx8CAzqxhfGn4FfRMGGaVqt8RhtHkD/mO0EmnPJh1dOIoCiLtzGBNXhgrTWnTK
	 86h0gvXQKK8oQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Alec Brown <alec.r.brown@oracle.com>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	David Howells <dhowells@redhat.com>,
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
Subject: [PATCH v3 2/5] KEYS: trusted: Open code tpm2_buf_append_auth()
Date: Mon, 16 Nov 2026 02:51:01 +0200
Message-ID: <20261116005105.1573016-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116005105.1573016-1-jarkko@kernel.org>
References: <20261116005105.1573016-1-jarkko@kernel.org>
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

