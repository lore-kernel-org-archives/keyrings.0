Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC5522D785
	for <keyrings@vger.kernel.org>; Sat, 18 Jul 2026 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784406656; cv=none; b=Yi87oKV1R8lmFaeKTY4RVdUDXt2ULqN7ZYRz5l3pwY0SMRq1FWmRZInUhXPD+34aqeE+pp7GVnh0qh9M4pi4g7V09v3r7lqjW6jlf1b+3drNkLsDZjSXBQPuu7ifjT5KBq1iMnMexPKE+KH/Lo6jbW4EMGGbzJ+ZhkrFrweOD0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784406656; c=relaxed/simple;
	bh=Lyu8ac78TPBaV2+aEeLIPYeXoG2wMcK2gLCLcrzNmcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=neGXzAvPaUJuPIuTc9hnmuV3aHT7ueluhl7zRc9wMYtQt47kA8mgQ+gqcK69ULJzPtszDsH0c2QfMIWPXCjWX3xuA9QhrsWU3gF76WT/eoe1aWeC0I2FsZaS3U2GHk+csPz9xXvo8Fpn4rE4xE6yh1s8kr9L0eG/kGpOX3Pz158=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=OiIpfdsS; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="OiIpfdsS"
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7CA393FBD7
	for <keyrings@vger.kernel.org>; Sat, 18 Jul 2026 20:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1784406646;
	bh=VKlRsjL0rTkUkTaF0nyGM5da05g+lT4Jx3aOlQ7adis=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=OiIpfdsSVIynP2dIELECb25OKM110nIzRc2IsCt8fS4myMzrncHJDf2QyrrNPvtSl
	 KRoAAsaZ0u0DRhg3XxBzIJgiSFy4MISb2jj43T0S1Vx5qrwRPXK4nxGGRaqqmuT3rF
	 8v1k62D5Lxl/PB9zlze0pD0IVp8ck/9IMUNMucz/w6jwUYDwJQttoGBgHksH+aiRil
	 OmtD7kwMIe1Xc/BfXi6f9tHsdKHtLqYKeXjLWWQPOHrb1iKIaY/QRW6uiZM/dzWfOP
	 A7gyezCklFyMnhO6hBZ22T0a2FhUJ1VZTle7xxE/ZBJR5jCHDNSJYyfEbqphI2v9tY
	 OvhvUZRgdI+FLGrE2RAQ3jKWdJLgWbOgK/YkGFmfpASokYHIpXdhV+PTa3HaQchGEs
	 0/nrI3hkzjk6eK1xs8AUMAGqOZSQXm/PZoXvXGrVacmil/SRev5o+6ZkZ1jjp1Lety
	 n34jfZsIdY/wgNKlC2L3WIKPvbL3WrJVccJzFmIBMRtODK/1XQQrPP7xMU9+/zOZJs
	 CWqfPhlHBCUGw1yKWf6MJxb3N7LXgl0v0TIq7xsyqMDudxJC+ZQJtLjChjBKsJ9JXY
	 TTZkWVsbBnT7bIny/YSRirUx0/ZXmCi8O0kVgvyurnyH1W5tL34GxLXTMHLsGs02wK
	 Y48zNfT1mCP7jN51HCvuLV34=
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f726186c4so21049f8f.2
        for <keyrings@vger.kernel.org>; Sat, 18 Jul 2026 13:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784406646; x=1785011446;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VKlRsjL0rTkUkTaF0nyGM5da05g+lT4Jx3aOlQ7adis=;
        b=ZIY3Nj/v1VqR8+N4E2UcXGdGfcb0YOAU2e0NiKLSvorn0sy3LdKGsZ+hp5bKLHAuqo
         s3SBlsE4lZDHfBZ2gq3rGzi/vO0I/ry1LtI2GIROF1yfaPtr2SBeexI/HiMxH+cd0l7D
         SAzCKJDWsxxEa2saCRmVH+zAUfsP6/nVwfD+HWUf/MeH28cIwBKddKSfnk3/n9g5MHvg
         5V1Axms4oArw8cW9rCf0iHMkYTgp32ARI6e9BOl+7Wl+Cz2GfSk57ryc/xKjHCAFzk/t
         XtLCYvDM2sfR6hdX5oAfcsTquUhdawIfjHhxI0KL5Deyk5O2fuu5Tsugm8xogNOjOUuD
         sDkQ==
X-Gm-Message-State: AOJu0YwDypZM8uJmEXsWR0o9z3ekBKrk+E6TD1AbfAvA88a6nFCvHZ0s
	edUnN5uDn6UCkP7KH+nxUaaqQM8EDFTi/F/KppwTNFVO7J7L55UV81FnVRMmxyqHFe5lmyJl1Ow
	L7YsOOAXBAE+bKWRt7YrVB0Y0KsLUz4j+XCanQoYLyxfvvsP0G1tJI1pO7QQUpSadVif0EsTFgF
	Vx6idY/ZcB4b8=
X-Gm-Gg: AfdE7cnsKobv/ZS1qxSAd0rEoUgyU1tv6Q+tVv3dgQWTGtYBo8sxR0XjMRNNVmOH+1/
	OVbQV0+wjMRevUvWGW/UT/sUxrleOKA+te2kiYcoPXEJBueEzZFTJg1pao9bBLk9KK/os8A7J2L
	VlPk4JMQ019cZeLkHIE8p1iqGo3IGh0I/VPbflOczVoFGZCM9Qrfxiwe7V/6Jay3W2BIfuMOxhk
	e6ZMJ9E6yQ2q8hrcgwVZh3H3PCL8roAMDZF5iLz0A0BF95jsvfFS5pMJJauw3WnhylbtYfBrGpr
	kM67wj7LZK0TL6zhIe4WpWs+wWMlA6G8CbDhPrkYo/tytrDeEEc/gXnsx2ZAkknMBjlIDdBe9N3
	WYBuUULvt1pRZpr3Zueb2+ibT0ekuSosDU+EI4Nmp8tvjnTl/yw2tcw9df0ScnxEovzFC7gFhw+
	+j5dXP+k7y
X-Received: by 2002:a05:600c:4503:b0:493:c84c:2b57 with SMTP id 5b1f17b1804b1-4954a513f99mr82923845e9.29.1784406645992;
        Sat, 18 Jul 2026 13:30:45 -0700 (PDT)
X-Received: by 2002:a05:600c:4503:b0:493:c84c:2b57 with SMTP id 5b1f17b1804b1-4954a513f99mr82923695e9.29.1784406645561;
        Sat, 18 Jul 2026 13:30:45 -0700 (PDT)
Received: from t-14 (lfbn-idf1-1-452-109.w86-242.abo.wanadoo.fr. [86.242.159.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63e49ce4sm15852571f8f.8.2026.07.18.13.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2026 13:30:45 -0700 (PDT)
From: Fabrice Derepas <fabrice.derepas@canonical.com>
To: keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org
Cc: Fabrice Derepas <fabrice.derepas@canonical.com>,
	david@sigma-star.at,
	upstream+dcp@sigma-star.at,
	jarkko@kernel.org,
	zohar@linux.ibm.com,
	dhowells@redhat.com
Subject: [PATCH] KEYS: trusted: dcp: fix key_len validation and calc_blob_len() return type
Date: Sat, 18 Jul 2026 22:28:17 +0200
Message-ID: <20260718202820.1890313-1-fabrice.derepas@canonical.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two defects in trusted_dcp_unseal() combine to allow a heap
out-of-bounds write in kernel context.

The primary defect is a missing upper-bound check:
trusted_dcp_unseal() reads p->key_len from an attacker-supplied blob
with no validation that it is at most MAX_KEY_SIZE (128).  It then
passes p->key_len + DCP_BLOB_AUTHLEN to do_aead_crypto() as the
operation length.  Because p->key is only MAX_KEY_SIZE + 1 = 129
bytes, any payload_len above 128 in the blob overruns p->key.  On
implementations where AES-128-GCM decryption writes plaintext before
verifying the authentication tag, up to 330 bytes of out-of-bounds
heap overwrite can occur before -EBADMSG is returned.

The secondary defect is an integer overflow in calc_blob_len(), which
computes its sum in size_t but returns unsigned int, truncating the
result on 64-bit platforms.  This allows a crafted blob with
payload_len near UINT_MAX to bypass the sanity check
(blen != p->blob_len).  Due to a second wrap in the expression
p->key_len + DCP_BLOB_AUTHLEN (computed in unsigned int at the call
site), the len value that reaches do_aead_crypto() via this path is
at most 15 bytes and does not directly amplify the OOB write, but
the integrity check bypass must be fixed.

Fix the primary OOB by validating p->key_len against MIN_KEY_SIZE
and MAX_KEY_SIZE immediately after reading it from the blob, matching
the validation already performed in trusted_core.c on the Opt_new
path.  Fix the overflow by changing the return type of calc_blob_len()
to size_t; update the two blen declarations from int to size_t to
avoid narrowing-conversion warnings, and update the pr_err format
specifier for blen accordingly.

The seal path is not affected: p->key_len is validated by
trusted_core.c before trusted_dcp_seal() is called, and the
blen > MAX_BLOB_SIZE guard provides defence in depth there.

Exploitation requires high privileges.  The unseal path is reached
via add_key("trusted", ..., KEY_SPEC_*) with the Opt_load command,
which requires write permission to a keyring that accepts trusted
keys -- in practice CAP_SYS_ADMIN.  Additionally,
CONFIG_TRUSTED_KEYS_DCP must be enabled. The attacker must also supply
a crafted sealed blob, which in the typical dm-crypt use case means
either physical access to modify on-disk key material or a prior
compromise of a privileged process that writes the blob.

How this was found:
Found by applying the Squeeze Loop strategy ("The Squeeze Loop
Strategy: Catching Coherent-and-Wrong Artifacts with an
Author-Independent Executable Oracle," Zenodo
DOI 10.5281/zenodo.20787816, 2026) on its C terrain using
deductive verification.  The formal proof of calc_blob_len (12/12
goals discharged) required a no_wrap precondition on payload_len;
removing that precondition caused 3 of 6 proof goals to fail.
Tracing the caller path confirmed the bounds bypass and the missing
key_len validation.

Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>
---
 security/keys/trusted-keys/trusted_dcp.c | 13 ++++++++++---
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/trusted-keys/trusted_dcp.c
index XXXXXXXXXXXXXXXX..YYYYYYYYYYYYYYYY 100644
--- a/security/keys/trusted-keys/trusted_dcp.c
+++ b/security/keys/trusted-keys/trusted_dcp.c
@@ -69,7 +69,7 @@ module_param_named(dcp_skip_zk_test, skip_zk_test, bool, 0);
 MODULE_PARM_DESC(dcp_skip_zk_test, "Don't test whether device keys are zero'ed");
 
-static unsigned int calc_blob_len(unsigned int payload_len)
+static size_t calc_blob_len(unsigned int payload_len)
 {
 	return sizeof(struct dcp_blob_fmt) + payload_len + DCP_BLOB_AUTHLEN;
 }
@@ -200,7 +200,8 @@ static int trusted_dcp_seal(struct trusted_key_payload *p, char *datablob)
 {
 	struct dcp_blob_fmt *b = (struct dcp_blob_fmt *)p->blob;
-	int blen, ret;
+	size_t blen;
+	int ret;
 	u8 *plain_blob_key;
 
 	blen = calc_blob_len(p->key_len);
@@ -242,21 +243,25 @@ static int trusted_dcp_unseal(struct trusted_key_payload *p, char *datablob)
 {
 	struct dcp_blob_fmt *b = (struct dcp_blob_fmt *)p->blob;
-	int blen, ret;
+	size_t blen;
+	int ret;
 	u8 *plain_blob_key = NULL;
 
 	if (b->fmt_version != DCP_BLOB_VERSION) {
 		pr_err("DCP blob has bad version: %i, expected %i\n",
 		       b->fmt_version, DCP_BLOB_VERSION);
 		ret = -EINVAL;
 		goto out;
 	}
 
 	p->key_len = le32_to_cpu(b->payload_len);
+	if (p->key_len < MIN_KEY_SIZE || p->key_len > MAX_KEY_SIZE)
+		return -EINVAL;
+
 	blen = calc_blob_len(p->key_len);
 	if (blen != p->blob_len) {
-		pr_err("DCP blob has bad length: %i != %i\n", blen,
+		pr_err("DCP blob has bad length: %zu != %u\n", blen,
 		       p->blob_len);
 		ret = -EINVAL;
 		goto out;
-- 
2.43.0
