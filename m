Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794790285;
	b=G1+8jdHih1MG6BejfQUQV8yvJa3XrnpZSMtaBfDAqF5Kn7Mh7fhlrh9/9KA/4JZ5lg5+
	 jM5zZBFG3Hw4RvelTw4NrYvlaw8+RdUj7nygkhlCibOj4Iau73AS3ITxLq5J0ZTN2aOVw
	 Z5MXgPd4hVpxWKVj4G5HoKom/VIgaoYlUtvwj5aJ5Jla5lqCpwAf4Ownup0XEhlxxewHa
	 cs6Swt+GCPxq9sfuamv345iiOKsugU1gJhMUynv8LjDnmqOnGTgA3b6+Qed3o4nNpBFWE
	 e6dNYtWqEmGZeIIeY6nW9Y1kZHxll0nj2S3zJh85pvbZ5FggTc5NLDkshIkw4x8ljgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794790285;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Lw/2Sknje3EGI75DWj24OrTfi16M+xJmFFH2q6PuZi0=;
	b=Cd/7xjmTjWdpP2e/frVJg2VFQy+iHwhUU/51PrDTrQeh+ELaUZl5kv6P285icfTOn0L3
	 vRFnSG/NvF7WxDHjoP0nDwzWR/mYQUpuN5UE7GZ3VnfLProVf6MOu2cWmtBK9vYP60U7n
	 A9o7TVRozP22gGyXt4HNMLUkYVfCJgHU/aufZsixvlBQHQIPMW39z2vqGXQS1QPnIh16z
	 vixOFrvI391coxRgK99q5InPxWSIQo9IS1/L1Xjtni645cRW4VnMYpms97AX5gjCvMM+s
	 3wA1Rn3gwZTQabqcFCPbfIke4zT4j9HzGIb+z52BiaefsqKe4eHq21DjERA9zfcWHjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GKmGICAL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9F0BE606A334;
	Mon, 16 Nov 2026 00:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GKmGICAL
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0421B1F000D0;
	Mon, 16 Nov 2026 00:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794790285;
	bh=Lw/2Sknje3EGI75DWj24OrTfi16M+xJmFFH2q6PuZi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GKmGICALHxfQAXj1vDvLn+LTY/sTlf5ZXKlTpzX9zyrQsx/R5TghOOH1Kkb6zy4av
	 4knMPKvLp5YENzZuOKO/ZvtftiP9OkxvgoOXr4mbVTlk47Ercu19QAiAk+nCuO5Bnh
	 D35Yy7FqC+JIBqOXp7iz36PJR8A+dTizq4a6tr7hrva1aHH33rjjiTtzaucwpLYg2v
	 LfD4TeGIsE+Tm+eNn2tbgJ6DwvyLhwVYddoBrwnHs2WycQWF2wGVa6CDjMYf1sIhlJ
	 qUwY9zuS/SN74oX365pWaqcd/3IK1T/vSStttSG0AB63hEdXAMO69mFxyovIkI2nLQ
	 DJVWkCIbG1v1w==
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
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan McDowell <noodles@meta.com>
Subject: [PATCH v3 3/5] KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
Date: Mon, 16 Nov 2026 02:51:02 +0200
Message-ID: <20261116005105.1573016-4-jarkko@kernel.org>
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

TPM2_Unseal requires TPM2_ST_SESSIONS, and tpm2_unseal_cmd() always does
set up either password or HMAC session.

Remove the branch in tpm2_unseal_cmd() conditionally setting
TPM2_ST_NO_SESSIONS. It is faulty but luckily it is never exercised at
run-time, and thus does not cause regressions.

Reviewed-by: Jonathan McDowell <noodles@meta.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_tpm2.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 563997600636..22d27e2512db 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -467,10 +467,8 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			   u32 blob_handle)
 {
 	struct trusted_key_tpm *private = options->private;
-	struct tpm_header *head;
 	struct tpm_buf *buf __free(kfree) = NULL;
 	u16 data_len;
-	int offset;
 	u8 *data;
 	int rc;
 
@@ -514,15 +512,9 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		tpm_buf_append_u16(buf, private->blobauth_len);
 		tpm_buf_append(buf, private->blobauth, private->blobauth_len);
 
-		if (tpm2_chip_auth(chip)) {
+		if (tpm2_chip_auth(chip))
 			tpm_buf_append_hmac_session(chip, buf, TPM2_SA_ENCRYPT,
 						    NULL, 0);
-		} else  {
-			offset = buf->handles * 4 + TPM_HEADER_SIZE;
-			head = (struct tpm_header *)buf->data;
-			if (tpm_buf_length(buf) == offset)
-				head->tag = cpu_to_be16(TPM2_ST_NO_SESSIONS);
-		}
 	}
 
 	rc = tpm_buf_fill_hmac_session(chip, buf);
-- 
2.47.3

