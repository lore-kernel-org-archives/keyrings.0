Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794782871;
	b=W1m0G3sr5Vu6yB9kgY/Tb10r0T/aXyV1KoRxAPsCykQgDpbkVEKQPQCiieHFI8nbk3xq
	 +uQJuXXyCcr+alRNqcvIzJ7xjFzTkYqO1wjMq9KheRXIoEQRDMtf2JcUwCuOwOMIUIcrr
	 NbI62mmyirrmz5NOU0yKk5pKpgwMOes05wgUFN9UnmSlN7CEUmh9fC81MMaLaYLni2yUS
	 IR6Q325EZOCLLpaFfgERxEu0ZdAtYGaWIlFk6RRZTcr2R2YHNCG5Cyj8TvOJSzLVo0N6m
	 mm57Z/N9f7z4cUD5VKBiQwFrJiaCiodUGHrybPmjwtWXdPKnR6TRYPMISHdgZy1d0bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794782871;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Lw/2Sknje3EGI75DWj24OrTfi16M+xJmFFH2q6PuZi0=;
	b=DC8XzwYRpSf7TtcVgo0Aiyr9nCwBP3GHqPeFmtk4XNj4miDbDkgeE0QKaLU/YN5gzI8K
	 rkDgr8GKWpZMM4ld6ooF36ySBTrmabbza2DGGFBznStDimOLLSx/Kx8/a50fhNEzYOaNu
	 7azyGFSW3MIs5GzQ/3Eyz+cxmh7gYdfovdzzpR3UOjmZVKW0IBtTWQEeDU2WRLANCcBpn
	 kjea2pa0TLHznGqOUoRVZwaqg6ZNKwEU4A55dT0B49XPf7sxGu6YjP8yNlgK+btsPLFso
	 ANJaqz8yNpJoxoZHFbN6CtgpC0ejJoixlir/9ueAqy+Gic5ZKFuFP0xNAEvdnPyHuIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="NkqBw//d";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 6B82D606A31F;
	Sun, 15 Nov 2026 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NkqBw//d
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9A8811F000CB;
	Sun, 15 Nov 2026 22:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794782871;
	bh=Lw/2Sknje3EGI75DWj24OrTfi16M+xJmFFH2q6PuZi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NkqBw//dmQCb+/QBx+0ehWMc5vyX0gXR9SmS+fTQoUGJoX0dlQDHiiSNw6RSGPEyo
	 O6v4ItxtMp/3iy01GwQXbDDMR8jLpYfbjhOvXqAaCRyEHqbB3cWClRh5AdNifPCoGy
	 gSnq+b8rYB3ROL4YvaeYmhH6nLFsQ8+mTD5WT1HDLlq0KaEHprHFxER/enSsRtKs1K
	 r2DHPKDEhyEtDaCu2C0TrL2uBgonnlCXTsIIr5zJWEI8Akdg+XqSMSMnlMjto4hPpE
	 bwVEvv3H/OXbO6OOs41vCFG23q8sx0poHhVBKw8sO5OFfB2yMZBxq4hw3waPBFBK1P
	 HLCqxGPFhOwwA==
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
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan McDowell <noodles@meta.com>
Subject: [PATCH 3/4] KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
Date: Mon, 16 Nov 2026 00:47:21 +0200
Message-ID: <20261115224722.1450498-4-jarkko@kernel.org>
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

