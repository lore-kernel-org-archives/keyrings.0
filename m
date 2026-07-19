Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558AB2BEC2C
	for <keyrings@vger.kernel.org>; Sun, 19 Jul 2026 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784479315; cv=none; b=H8JciSE/t+rAOyMo5BLLSoQR8hwfeGPbF8OHzsntqGBp9fAAKHrdgI3d1Agi9Tapv5db2mVFeKIdadwmLLCTHwCU4tUBYaCvX2Vuw/2DJHADzar7Trq9mxAP/C2j/OC1T3XK3wqC0qA3ecCBcB93lG8DkPupxg5Z0Gav2eHt8W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784479315; c=relaxed/simple;
	bh=kM9lXnzDuQLhmYTlwT6DIah52BHbORMFMEfPJmUpbPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+59T4wul8ZtE40kwI0sFUvOKcEyuh8vNzqpV12Qgi54S+iVjuxtPkcMpoUoGseapZJUgIZlSBMDedkXwJNjNg7wBCEEWb1wI5Pg5acX5Ts86uHzBBE+zHalsi0PnYFakcaTUJhJQFsPpnGruj8XdH6YJWsiHvIxRhF25VSAIA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=deKZ3Aly; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="deKZ3Aly"
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 489FF3F125
	for <keyrings@vger.kernel.org>; Sun, 19 Jul 2026 16:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784479310;
	bh=k8tWkKjs5KjNi+HuqkD4ay7QtP1AHEL1UJFoTXYC6Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=deKZ3AlytP/kcBPqy5ioK/HJ/XBtJRiOo7U76vruHbgk+olFsN8rpkXvVfvMmroQe
	 1qfiSXIY4KfqEFL1wQx2QrmV9EuPQz/xZjuQjYnG9xycrP2yA3u3o8jyPoeN/AbXC/
	 MifxhD+sDHCnyoByH0KU0IlgSLNifR/r9bi9Ps6VrLZknblDD4awHLA2iUDn6+Ju9+
	 LLm+L2AZouRybgHFYOaZxuZja11T1qkk+bF8XB89KQnhueMb8PA8bMkBU5jHH+LBt+
	 WxoOqMnmRubYlU0I+BUdNTBxxAfEea1jSq2VBlLgMg6KWUcsM9FDoP2cjyWZD/SeGK
	 n+XJ+CIQ0tM0nUmM5SA1Y5fzPh0ada+e1tIo/GTXnGRPkj7RwWJoBHdedKQ9AbWo83
	 ZbtiGQOCYFinbDg9ulemPMFyKnBrEEZ7g2ZkZAGOxfO5bNqOLjU+nv1P1Q9znIDFdD
	 iZaNPNABT9oUTmpOTtG2wUGe+2XdDgZCubp2iP5FmCwYHCJYwR5QLqqUH/ShEAefOD
	 iRTXk8tQ9uuXbNwkQVAOCNwDtQQr9tHDUTKQw9GgOTEvcKKgmLucr0eze2andQ40b9
	 UZba0s8MiL9hxefhGiUcrjWDQeq3IJsC+eQ8oViTsL0SxRqST2sDyc9CgaNJdP9U24
	 j2E5IWt/twjJB46qlSPlzsOg=
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-472c330e555so4493928f8f.1
        for <keyrings@vger.kernel.org>; Sun, 19 Jul 2026 09:41:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784479310; x=1785084110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k8tWkKjs5KjNi+HuqkD4ay7QtP1AHEL1UJFoTXYC6Ys=;
        b=KB8Sa01Uv36G81Om+O7Cv1zAah5hgL8NpON0nhHuORmpr9EpcXU6TGfXgeLdS3cppU
         rh6m8Oc8dty+TtKQdVam3Z6ZisNphDLZFVM75rdiSxvCpsvR7V8/lbOih5FMYqvF2c2x
         3MlsSwjDtPO0M+wKXE1/mWSvv3+yUSoTbPEAh6QBlYvDYj4U0Fja4YLaU+8YbnP5yXhV
         xU3UKVMu4PHuIP1JS0CsUiJOuaIC/jIseywc6cJ3nRx6aUDc+VApC5TYMo6HPYNoqONi
         NNE+TvgBBbCyv0LepHhH86Ugv0A8kULJB3Txd2yNHImBngkOjTAAwl3M2ImzRvFUkzXY
         FiPw==
X-Gm-Message-State: AOJu0YzaKuUW+yDnvwzrHAhMfivy+3uhw45Nrc0wlUIeopLJJmlbDkD5
	Rt8iiL4TAVTAxbcSvEK87jS4IfyI3BCNZx1RekD3dWGbjgGCv/E2Y5RZvpMzokNMDPjMeuA+CoO
	MnMTFKpYE1uhBkrEaWsO2WuCyJiQzV9EvP+vrN2VUFO29fKHdYZZXJtS6lZ1fXEKmimed/fSxeB
	fp9B0aVN8Tlcg=
X-Gm-Gg: AfdE7cm2N8ZVmsAXfqO6vKby7TQWQmSouIKBAiLYN+A5nZgYMLToCE0fUzMTqtg5L15
	dCfUFvsJ/rZ5xqZp6EkEUDPQXksj18IvElGCQnRv9Uck56ChnW7uZ/5qOn6abvRWnLeeazjYkhu
	pH4o/PRSiC0J9fX+5vv5HnpljetOwKfeDjNU2Za00a2n2iUK6fVvE6AOF/X2E/8o+7Z13PBPZpU
	mHBSvUSp9sa3yuvscxAjPCCxIcHaXENxaNc0eXA6ScDX8NGrzBPnJXiSRKZXBoeAfWt/IVpU397
	RPoSWjOAai3G5UGQjNXRvrTVAOO01rGqUBUgJ4yjfm5gK7/4K9LGfmlGQlbNDu5pH/z5hGQcuo6
	LR3C73UrT/2iyRQ0AXJniD98szMBjjVOcDX3qlzyOcPdJFYkffZ3maEwT7xH6zJZey8TzKqA/KF
	SmTBRnTOwe
X-Received: by 2002:a05:6000:40cf:b0:473:a376:815e with SMTP id ffacd0b85a97d-47f6232826fmr12998053f8f.33.1784479309835;
        Sun, 19 Jul 2026 09:41:49 -0700 (PDT)
X-Received: by 2002:a05:6000:40cf:b0:473:a376:815e with SMTP id ffacd0b85a97d-47f6232826fmr12998029f8f.33.1784479309435;
        Sun, 19 Jul 2026 09:41:49 -0700 (PDT)
Received: from t-14 (lfbn-idf1-1-452-109.w86-242.abo.wanadoo.fr. [86.242.159.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e51986sm25378442f8f.11.2026.07.19.09.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 09:41:49 -0700 (PDT)
From: Fabrice Derepas <fabrice.derepas@canonical.com>
To: keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org
Cc: Fabrice Derepas <fabrice.derepas@canonical.com>,
	david@sigma-star.at,
	upstream+dcp@sigma-star.at,
	jarkko@kernel.org,
	zohar@linux.ibm.com,
	dhowells@redhat.com
Subject: [PATCH v2] KEYS: trusted: dcp: fix key_len validation and calc_blob_len() return type
Date: Sun, 19 Jul 2026 18:39:37 +0200
Message-ID: <20260719163939.3624767-1-fabrice.derepas@canonical.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <alv7LVoTQJOMyk2J@kernel.org>
References: <alv7LVoTQJOMyk2J@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two correctness and type-hygiene issues exist in the DCP trusted keys
implementation.

First, trusted_dcp_unseal() reads p->key_len from a user-supplied blob
without checking if it exceeds MAX_KEY_SIZE.  If a crafted blob provides
a payload_len larger than 128, the subsequent do_aead_crypto() call
writes past the end of the p->key array into the adjacent p->blob
buffer within the same struct trusted_key_payload -- the caller's own
input, not unrelated kernel memory.  While not exploitable, this
violates strict array bounds and triggers static analyzers.  Fix this by adding a validation check against
MIN_KEY_SIZE and MAX_KEY_SIZE immediately after reading the length,
matching the checks already done in trusted_core.c.

Second, calc_blob_len() calculates a sum in size_t that truncates to
unsigned int on 64-bit platforms.  Because the DCP hardware is only
present on 32-bit i.MX SoC platforms, size_t and unsigned int are
functionally equivalent in production, making this truncation harmless in
practice.  Nevertheless, updating the return type to size_t (and
subsequently updating 'blen' in the seal/unseal paths) resolves
type-narrowing warnings and improves overall code hygiene.

Fixes: 2e8a0f40a39c ("KEYS: trusted: Introduce NXP DCP-backed trusted keys")
Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
---
Changes in v2:
  - Reframed commit message as correctness/hardening fix (Richard, Jarkko)
  - Changed bare return -EINVAL to goto out for consistency
  - Added Fixes tag

Compile-tested with arm-linux-gnueabihf-gcc on imx_v6_v7_defconfig
with CONFIG_TRUSTED_KEYS_DCP=y (W=1, zero warnings). No DCP hardware
available for runtime testing.

 security/keys/trusted-keys/trusted_dcp.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trusted-keys/trusted_dcp.c
index 7b6eb655d..c078adebe 100644
--- a/security/keys/trusted-keys/trusted_dcp.c
+++ b/security/keys/trusted-keys/trusted_dcp.c
@@ -69,7 +69,7 @@ static bool skip_zk_test;
 module_param_named(dcp_skip_zk_test, skip_zk_test, bool, 0);
 MODULE_PARM_DESC(dcp_skip_zk_test, "Don't test whether device keys are zero'ed");
 
-static unsigned int calc_blob_len(unsigned int payload_len)
+static size_t calc_blob_len(unsigned int payload_len)
 {
 	return sizeof(struct dcp_blob_fmt) + payload_len + DCP_BLOB_AUTHLEN;
 }
@@ -200,7 +200,8 @@ static int encrypt_blob_key(u8 *plain_key, u8 *encrypted_key)
 static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)
 {
 	struct dcp_blob_fmt *b = (struct dcp_blob_fmt *)p->blob;
-	int blen, ret;
+	size_t blen;
+	int ret;
 	u8 *plain_blob_key;
 
 	blen = calc_blob_len(p->key_len);
@@ -242,7 +243,8 @@ static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)
 static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
 {
 	struct dcp_blob_fmt *b = (struct dcp_blob_fmt *)p->blob;
-	int blen, ret;
+	size_t blen;
+	int ret;
 	u8 *plain_blob_key = NULL;
 
 	if (b->fmt_version != DCP_BLOB_VERSION) {
@@ -253,9 +255,14 @@ static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
 	}
 
 	p->key_len = le32_to_cpu(b->payload_len);
+	if (p->key_len < MIN_KEY_SIZE || p->key_len > MAX_KEY_SIZE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	blen = calc_blob_len(p->key_len);
 	if (blen != p->blob_len) {
-		pr_err("DCP blob has bad length: %i != %i\n", blen,
+		pr_err("DCP blob has bad length: %zu != %u\n", blen,
 		       p->blob_len);
 		ret = -EINVAL;
 		goto out;

base-commit: 6d41c11ef3044788902a05e292cd7f0a9c7a8157
-- 
2.53.0

