Received: from mail-pz2-f27.google.com (mail-pz2-f27.google.com [74.125.228.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCF747ACE3
	for <keyrings@vger.kernel.org>; Fri, 25 Sep 2026 09:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790330005; cv=none; b=NqSDsLkDABs0nqDFqH3Guju8fFtapW+lwgkVFqW8UH09Sk/w9SRdpREX14eGvnzvnjqumcrZaZ+BHE8/Q6PHxxZVXGGoTZnRSXDXhkhDbKSKmhw1Tfx6FPzhAZ0/iRD6j5t/0eFtV5Q7ZWkOoM0WLrDyzQoOmIHnLaHyA3gXGyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790330005; c=relaxed/simple;
	bh=6GRmHPLR3TCBKfBWB4SA0tOdNi5yoK35GggbLziGW1k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J40iKey9EJFj1nT7x+otfi0m+zLRMPZF3h/WnXdk8wsjAvbByl5osuIlLPqg7znK2WqKDlXCHjYWHwUpCn7kZ4gZXKWfsNtQw46NbHOZYqxW+b86wgXsGoTkYef/cadvTjOLyroN80DBCInEHF4czhqqNOTxjRW9VQh6egjZ0BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A17fV1CN; arc=none smtp.client-ip=74.125.228.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A17fV1CN"
Received: by mail-pz2-f27.google.com with SMTP id 41be03b00d2f7-cc1cea50dc3so250303a12.3
        for <keyrings@vger.kernel.org>; Fri, 25 Sep 2026 02:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790330003; x=1790934803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UGO9gkMm/hjzd0yK8CgZnet7IwsFNqJtn1zmuKbVxic=;
        b=A17fV1CNmzpX8DYQKR5KtWko7KWDsPPZcJU4zFxVkAQYBNz1vvUjfD4vSL7GrA/5/m
         HDXY6JCeMEp8y+k/KTFxj6J4vTvI/Mom7Bcl46NdwfuLNvFTMFwmNj51bGImrkNPZX2J
         yqtVxMtUtpfnkLpmi/KsO4GZv8V5MlmKgBFK2MfHqRACiJAtbEs2ElFjjxejbEl2xCxy
         /p7I1bhaKeBz7UvWxWWGZPO3DgNepS3AcoTMHVxcTBxEMB6+ILqUk1E4Qv0sEUd86y2y
         xL+8ucnmNiVwHQbO272R4Ett0IY0vBBWAyfVlHBigqfzxYFDPr9OLJs9rxkM6r+OckRZ
         mJ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790330003; x=1790934803;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UGO9gkMm/hjzd0yK8CgZnet7IwsFNqJtn1zmuKbVxic=;
        b=pDChFWrSGlG6E+mLU8TvIhmiS8xlqqerQjF6ZJj9QMHt7vn0/Y8+2RqWHptqatu7xw
         aA5pA4bFIl/Nnz0V1YHpLp4R2Eb6rHQLOHHgN9FQVZ2bqrIU17XEV07ieT59LfOyCYYc
         bpxhAULqzArN4vZaszWBjqm94kYkl0/LU2ZNIwW1bwSbH0hnzMKutPwRUt+MewFmB/+B
         vLbHvxcdudoGnx4jIhZybr5XAlMlQ72eF69QwhNVZ387IpEUeTytxAAHjpInN2ofkbpT
         36IFgO/S792Y2SXzHmjJRyN6Zwf2Nb9f5B76VXWMAlxFVgTeoiPvL0VRcEdaw6kToBbw
         nraQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsoT0ApDbIuxpcL15qPpeBr4z2VVldssa6NXcAnZ2OYtf5toPXuhWOjjwwPGJG0F5U2+9byRhC2g==@vger.kernel.org
X-Gm-Message-State: AFuF++l2weBjokN0Z3TBSnG7ckn0rrmuGUreynMVpVUq6GnzhuEV58Qd
	gUkWNH8mKXw807H6boplCr+R7RZfMu8ZJUag96You1sgHQ4kdH2EY0wy
X-Gm-Gg: AYBFou2SxqS7PCiHfco/IoPg6TDJwcmHlSjkhk76SP1w3LwLPNDM+PKXLB7QDEAXENq
	l0xWDckrM8DuEnuM6WP64uYiee4DqIL+kaHrhHU9BfmMKswiB/TQkqrpK5D9ixpBtYOKlkV6ZSR
	aarKDKdP518xhPfKkzsyIGHrot3lCY6x/+jtioAaohhyNxEsQDA4iwIDdqYdxCbVetUFwPzNOuJ
	DYjkfc1PzIrRaythvsmjwupFNzcKe/5Gm8K7dIZdKGQ5iq8XtfmNXj2SYA/rdqtdDoTnAhsU5oH
	kHisbNhLSlGVFOEA7FYvrRlxFBCQ507MJ3PnZ+O0l+go8x+wRIvZmrkOtl2+wBxv88pyiNmUNST
	/XBrMnTKhwdlh3+DEaefAKbtTibrnjlC3VoCL+2LtNoiCVnVl3x1aeaWbAybsKpSpsTCSnL7qRQ
	6nOmFre03QeFsgC4D1C1QZx1SwGQOo4NJAXf+DVLEH4Ia45pjh6egqKn3x252YOqzvRjDyi3Gax
	HyKv9x7n36U
X-Received: by 2002:a05:6a20:3d20:b0:3db:3d0b:31fd with SMTP id adf61e73a8af0-3de0e703d8dmr5190620637.1.1790330003117;
        Fri, 25 Sep 2026 02:53:23 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc78796cf39sm924154a12.32.2026.09.25.02.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 02:53:22 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KEYS: trusted: Reject short TPM2 public areas
Date: Fri, 25 Sep 2026 18:53:08 +0900
Message-ID: <20260925095308.3248297-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm2_load_cmd() reads TPMA_OBJECT with get_unaligned_be32(pub + 4), but
does not require public_len to cover that field.

A new-format blob with public_len zero makes the read begin at the end of
the B + 4-byte decoded allocation, causing a four-byte heap out-of-bounds
read before the TPM command is transmitted. This is reachable from an
unprivileged add_key() call when TPM trusted keys and a TPM2 device are
available.

This affects v5.13-rc1 and later kernels built with CONFIG_TRUSTED_KEYS=y
and CONFIG_TRUSTED_KEYS_TPM=y when a TPM2 device is present. A KASAN run
as UID 1000 with no effective capabilities reported:

BUG: KASAN: slab-out-of-bounds in tpm2_unseal_trusted
Read of size 4 at addr ffff888106273b48 by task exploit/160
CPU: 1 UID: 1000 PID: 160 Comm: exploit
The buggy address belongs to the object at ffff888106273b40
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 0 bytes to the right of
 allocated 8-byte region [ffff888106273b40, ffff888106273b48)

TPMT_PUBLIC starts with the two-byte type, two-byte nameAlg and four-byte
objectAttributes fields. Require public_len to cover all eight bytes before
reading the attributes.

The exact input produced the KASAN read in 3/3 fresh boots. The fixed build
rejected it with -E2BIG and no KASAN report in 3/3 boots; valid new- and
old-format trusted-key loads continued to succeed.

Fixes: e5fb5d2c5a03 ("security: keys: trusted: Make sealed key properly interoperable")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Tested with QEMU tpm-tis and swtpm: vulnerable 3/3 KASAN reports,
fixed 3/3 clean -E2BIG rejections, with public_len 7/8 and new/old-format
controls passing. Stable 5.15+ requires 114f00d738f1 first; both patches
apply cleanly in that order.

The source reproducer and full logs are available privately on request.

 security/keys/trusted-keys/trusted_tpm2.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index c2a69bcf381d7..b3109e0a924f5 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -418,6 +418,8 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	public_len = get_unaligned_be16(blob + 2 + private_len);
 	if (private_len + 2 + public_len + 2 > blob_len)
 		return -E2BIG;
+	if (public_len < 8)
+		return -E2BIG;
 
 	pub = blob + 2 + private_len + 2;
 	/* key attributes are always at offset 4 */

base-commit: 27d14d3b15d5691bcbf0683883a2ea12469edbea
