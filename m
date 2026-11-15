Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794785534;
	b=CbUaKV5b39/2+l2IZNd/Mj/LbkAeVsUmKDKzb23Vb7P/S8SrrnXjYJUu36QhOgyBZ5TX
	 vedPJEFkvJM00UnkdLBwZMeXptkyycnISLuig7ldDBoloUTPkw37FIAECnjZG3ouQP2Fv
	 r0eWlNQk80eDMT2fPC/9CFecfP28lOItTHgJcw9KCPUwg6XL2yEbVS7zz4pjWrzlNQuTo
	 BCLQn2CGZrZX/eMYpLiwbdhOfjXYmDY+/uwnlqTh+ru4RQs7BZHsbL9kK0hziDBtemsrm
	 17SQOYbz6XQsIF7dp0nL/Q6Rk4yfFmNQ/rzFfw6KkiMXrU53VwzzHzsidYVMBhlmysQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794785534;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Lw/2Sknje3EGI75DWj24OrTfi16M+xJmFFH2q6PuZi0=;
	b=tu2LCbHqC74C/5JIK+w41lsbc56tMjmoveuxih9ZJVhapnJa/E/cAhSO9AChSg4B8jUw
	 MXWGR1x6ZGcECFhU09N18Hk9QdCtEMJ9dedrU23wox2/ePL9gGqhCbpWX8riaSg+EDPa4
	 emSne5ivItX7m63o+WIRX20zF2WgVoejXeHK+uA6gYkkvrp5yF6mNHk+HhT8WSVFGk0UN
	 ftI4pqnro0cDrbLPqfgI8bN+ZyTovMd/6Ho4hgO4rKft/CcrIIaZoeGLslk0Xq8W3ciBz
	 VI1uxf55Twxj3mrNK0yoAHNR124c3I/NacalVmLuqIqVaJmyThKlF9rVLw4MQ2rtMGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nF7RtcjT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id BD73B606A323;
	Sun, 15 Nov 2026 23:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nF7RtcjT
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 22E591F000C4;
	Sun, 15 Nov 2026 23:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794785534;
	bh=Lw/2Sknje3EGI75DWj24OrTfi16M+xJmFFH2q6PuZi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nF7RtcjTAVoTDSK/aBMbfW1n36lKVsSpkg0hO+Yao61lpPyk+jt16kgaGoK6bFjs7
	 wJSVtbWcw3VMcIW1n/V4b1YuM+/pSfhDKxd7SkBGPAc2jD0vPFxcFTRF8aqitrOaDL
	 3bXr+XbMxc8c3B4QA182RdPg1BEKD1xQxk0+EwiEb1To2MlU6Gw/aU8IXDKZDm1cud
	 WOmDgYVlWwnPAtmBNZ6wYbgUxlSvmjYo6vkN6j0SLHPgK+G302iON/iM9pQ/uuWi0L
	 czMNLej7zWT2HNjbQ7dF3n9uOTXbpkrEJwcio9u3oculLwS0dhnjVQOqx2xmuABZKS
	 WWblM09yn4SSg==
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
	"Serge E. Hallyn" <serge@hallyn.com>,
	Jonathan McDowell <noodles@meta.com>
Subject: [PATCH v2 3/4] KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
Date: Mon, 16 Nov 2026 01:31:55 +0200
Message-ID: <20261115233156.1485238-4-jarkko@kernel.org>
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

