Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="bmWvQzZY"
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB7010D1;
	Mon, 27 Nov 2023 11:15:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1701112532;
	bh=Btceq8mJqLYqvLA8pp60ha5LnD7gtowQ5e8eln971ug=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=bmWvQzZYSrivWLnDMJCfBAjXBEWEYCqBrMsAsVjISszXhTP2Eq2BQfNGQzRbTDhqV
	 iouqD9uJZkE9ZefkclgyEwzJh9jwENcP9HYl0hJw4XB15E/mlUq+tH4gYykqt28HXN
	 b5aBvYaD+tKaFbO/8Hf/x+OORMAR8r7H9XsY3ZC4=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id F3217128645F;
	Mon, 27 Nov 2023 14:15:32 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id iX5HRG-a-z5a; Mon, 27 Nov 2023 14:15:32 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 602B41285EC7;
	Mon, 27 Nov 2023 14:15:32 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v5 11/17] tpm: export the context save and load commands
Date: Mon, 27 Nov 2023 14:08:48 -0500
Message-Id: <20231127190854.13310-12-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231127190854.13310-1-James.Bottomley@HansenPartnership.com>
References: <20231127190854.13310-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The TPM2 session HMAC and encryption handling code needs to save and
restore a single volatile context for the elliptic curve version of
the NULL seed, so export the APIs which do this for internal use.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

---

v5: add review
---
 drivers/char/tpm/tpm.h        | 4 ++++
 drivers/char/tpm/tpm2-space.c | 8 ++++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 61445f1dc46d..cbc9d1e2974d 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -312,6 +312,10 @@ int tpm2_commit_space(struct tpm_chip *chip, struct tpm_space *space, void *buf,
 		      size_t *bufsiz);
 int tpm_devs_add(struct tpm_chip *chip);
 void tpm_devs_remove(struct tpm_chip *chip);
+int tpm2_save_context(struct tpm_chip *chip, u32 handle, u8 *buf,
+		      unsigned int buf_size, unsigned int *offset);
+int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
+		      unsigned int *offset, u32 *handle);
 
 void tpm_bios_log_setup(struct tpm_chip *chip);
 void tpm_bios_log_teardown(struct tpm_chip *chip);
diff --git a/drivers/char/tpm/tpm2-space.c b/drivers/char/tpm/tpm2-space.c
index 363afdd4d1d3..24479a81c23c 100644
--- a/drivers/char/tpm/tpm2-space.c
+++ b/drivers/char/tpm/tpm2-space.c
@@ -68,8 +68,8 @@ void tpm2_del_space(struct tpm_chip *chip, struct tpm_space *space)
 	kfree(space->session_buf);
 }
 
-static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
-			     unsigned int *offset, u32 *handle)
+int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
+		      unsigned int *offset, u32 *handle)
 {
 	struct tpm_buf tbuf;
 	struct tpm2_context *ctx;
@@ -119,8 +119,8 @@ static int tpm2_load_context(struct tpm_chip *chip, u8 *buf,
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
2.35.3

