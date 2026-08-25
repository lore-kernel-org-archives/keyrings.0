Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B355D35AC3B
	for <keyrings@vger.kernel.org>; Tue, 25 Aug 2026 18:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787682574; cv=none; b=ot6+FrMTTrSa6825llw5GWWgT7a0HgaWcUQ6ugvRjCq3OAlecLtqAD6Bh000sl6Dw+U3yZRH0zVA+vrEXnfsX1jh82pMyxHaYLEw6p3x7Bx4SktIPaP37Ahzn9F92uRCmxTlZOyj2aKpvJ38xOA1x/0kFPBaCMb6xo7TqvMupF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787682574; c=relaxed/simple;
	bh=2LHAtjESN6S66Bv21aGOPHTI3dmXGbwU9JZCPapdB0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=La5vU5fXnsq/mgarMIQrWoVfrcwwx3jb0bjpb/bvslR6wuLgyJk9RDQPLyvpr1K0+Ql2G1pRoHARAwwOzkYjkA3gySVNIYPWOjzcHAdkLqaNikmxDuLUd8a/5pyqyov7fE0w2z/0UIQvrvwZBzQ+hjVNMOMU0U8ypww4FFGjzbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky25Mvbk; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky25Mvbk"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cc149372c14so45891a12.1
        for <keyrings@vger.kernel.org>; Tue, 25 Aug 2026 11:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787682573; x=1788287373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0VdoKFgGtyQlCKk61/VSjfvx4udEVyz2pZTOZw5/z+M=;
        b=Ky25Mvbkhooa4TlV4ffDyMvkyWjqixuCeIjaOMZmEwAhTQCPsLa07P/bc6/NYcdZ2u
         j5oYH3I4+geEDpCQ+4QHHPdSwl88vgM/WzOzeovV2oihxnJD1gVI0oGxrfgORnVTUAyd
         lSoqcBdQniAxTMQiziOdO5iQQcHIqgL+Sw+R+XlIJo5Izir5GopaX0y3LvjbN7C6dy5+
         TkVfMj44lI1vAkkqaGl7eDRTA3XO5c5kse03TQPPJjngG0gV3ywMzcUoD+iRGbo1VKYC
         a3Wyl8NLQiQrhl0mPyR2ErDcOrmLr+q3UMjp9/VjdBpjkg6fxonM58AUhzDW2qPV4jT/
         RXUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787682573; x=1788287373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0VdoKFgGtyQlCKk61/VSjfvx4udEVyz2pZTOZw5/z+M=;
        b=QwQG9wJCG0AKL0eHJ3t5FnPdyWiSxE/mQhpI/7ur6axE+rwhY1wA1x8xRjSDoTvdNC
         C3pbw8WxtT8RDRYS5IhK75OV96HbAsneoOZPsGtjaj0UdaCdwapNSSHIENNdP1/kolVm
         7cauUd7ZT5dd6mSwGnKKZtafFwwaUGcDEZgUw+5Am0Lqx4v8tA8nNgR4BVJir1AUH/Wj
         lTjjg2v2Nlt3YWm/kmLE8uXpKl8MeR5DLgYkqotE2v+QSHCdP4+GvJbCZy3GgJ7XmAe/
         dnazpTg+CzYxnr398WlPqHk8N2Jh8qGXfXphkHYXCyod3gp/gaQEfsN5xxUakKNSPd2j
         P+YA==
X-Forwarded-Encrypted: i=1; AHgh+RrwaUU2IlfGsOmWiIwQ5X3fDcgnJ8kxsFL//jv+kdChQzT28WKEUDau4TdVXvxdswftT4ctrVEa+w==@vger.kernel.org
X-Gm-Message-State: AFuF++kdnn1n7pdQxzSP4LTBDO7imE+0/pvcCIBW2P94U8f4hvZwN/8m
	LMilLLuNIAgT75egbn+7SQ+7Udcm5vZQyfABnFBArLnjT/bDulJVRegg
X-Gm-Gg: AR+sD10OU15ie/zUMoo6bAC98gZ3i7O1A+E9rTdH0DgWgzB54EF/8qMTdIkCld24JdP
	cwSLog+ChJJt5SKIfygqKkhG70L5k0sVu3HDpEFe+cj2ymHVHMJewBYMJ1JuyfM1u1RZ0LAOa6q
	/ib5d09KosJx9xuUbCA83ZLmMEsHZbJ2YV1joPa1tmv9HUj+wyz6DPZniyfaCoUsCeG6jrVeQrT
	gFSj/nFAKCqgIFb5oCFPRI5HSBWeR27NxPkg0Yee0wO4kR/bXKwTIpdRoDWD0R67ipqdcgaJLtS
	XzYaT9uDG1jexcnWRlW7iGCaMOEDKNQH7lXqQ08wwbIAO0vi4XmYeHt3ZdItzMnJSxmjNUP33N2
	eOezkyCdJ1HKynbWj/zdrxFBCeEauuwGQ1YpyL5+CCL5IZaTGkJC1QHnMoD0rZLBH/AiYuOun6w
	hgQnZyTCe8wv7/dTaTIzBBunC3/6f0FIMy+SHWr5QI8eVgrfN//XcLqU1mgoXle37JbrZ65XVhl
	IWhBb/d7TS/9kbfTPTCBR3DKo7s6dExgphTP4DUizoxZT1cYEReHMDdREs=
X-Received: by 2002:a05:6a21:390:b0:3cc:b26a:7686 with SMTP id adf61e73a8af0-3cf7628564bmr850511637.6.1787682572983;
        Tue, 25 Aug 2026 11:29:32 -0700 (PDT)
Received: from MSI.localdomain ([157.20.184.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d8861d3sm1230188eec.18.2026.08.25.11.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:29:32 -0700 (PDT)
From: sn0x-sharma <sanketsharmacsec@gmail.com>
To: jarkko@kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	zohar@linux.ibm.com,
	dhowells@redhat.com,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	w@1wt.eu,
	sn0x-sharma <sanketsharmacsec@gmail.com>
Subject: [PATCH 1/2] keys: trusted: tpm1: add bounds check in tpm_seal() before memcpy
Date: Tue, 25 Aug 2026 18:29:18 +0000
Message-ID: <20260825182919.15943-1-sanketsharmacsec@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm_seal() computes storedsize from TPM response fields and passes
it directly to memcpy() into a MAX_BLOB_SIZE buffer without bounds
validation. A forged TPM response can set storedsize to 4086,
overflowing the 512-byte blob by 3574 bytes into adjacent slab
objects.

Add a check that storedsize does not exceed MAX_BLOB_SIZE before
the memcpy, returning -EINVAL on oversized responses.

Reported-by: sn0x-sharma <sanketsharmacsec@gmail.com>
Link: https://lore.kernel.org/linux-integrity/
Signed-off-by: sn0x-sharma <sanketsharmacsec@gmail.com>
---
 security/keys/trusted-keys/trusted_tpm1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 8f57c6111..d47cb7108 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -531,6 +531,10 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
 
 	/* copy the returned blob to caller */
 	if (!ret) {
+		if (storedsize > MAX_BLOB_SIZE) {
+			ret = -EINVAL;
+			goto out;
+		}
 		memcpy(blob, tb->data + TPM_DATA_OFFSET, storedsize);
 		*bloblen = storedsize;
 	}
-- 
2.53.0

