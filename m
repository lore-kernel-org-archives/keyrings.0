Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E184457CB
	for <keyrings@vger.kernel.org>; Wed, 26 Aug 2026 17:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787764109; cv=none; b=ZnXBVwEXJDDR3Y0jaEjxoiNrMt+mH4TZpLCqiRZTyrcWgaNS2q4MF057iyigar4x53c1K4BC5+PCXN3uDwRsMK5T0C/14IZjWG+/HpZzpDjgW/+wEhF5oewsSd1PjfCc8yluWOFlmuOUUGoSL9pIG4QxktulFVZu24LfgLZ9Unw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787764109; c=relaxed/simple;
	bh=adQmRDDMdEGHtE5WpnEdo09OXdFUdHwAT/L+LntBHsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxeLXsn7BwJi2pwID3r4nFfWAzhVgAgK7AAPXEzsBGiWNeWAdbq0ibQOZc656wI2+wVL6IhMy34Q6p/lE56l7x56ffGrr112aLrZSc4nsc0qIZ9NFK6fS0+XrklXJJ01MTLZQ5YGARueQkDhOLa8OKvjl4UoX7EA0c6Yi61Ey8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bpZyyOmn; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bpZyyOmn"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-ca7c1176317so1084925a12.1
        for <keyrings@vger.kernel.org>; Wed, 26 Aug 2026 10:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787764074; x=1788368874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hZ4cvnua3/lcbY1rMV0XghgCcnC0CL+DamLLaniAE34=;
        b=bpZyyOmnCJmgCgVZBMX3CNnP3aVVc+YYT70KgS+9inyaKNblvSQ6Gwgh128S6y+7Np
         JLs41SiVtaQNTKtoJtAL5yFpbmTNik0O4AAXlkDWhv+1a3agO7uWcws2hVcMlcWBk3un
         syqDlS9QjkMtrdjng6cmqDMGCt2kvOeiKybHw3OqIUVReoiTfDwSKcgZGhkamipE3362
         BoS2A/tEvtaxlhJd55OVg92PEu5gfvuEWdcPiIPimfSZhyaFh0Wk9rCK6KZ34ygcGIzb
         9Sye3Z1CSHriRZkZbk1VNTmihXVwf63vCJt3pw0+d1JkG5NGffvaP1nBPa34JiL5v1sQ
         LSRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787764074; x=1788368874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hZ4cvnua3/lcbY1rMV0XghgCcnC0CL+DamLLaniAE34=;
        b=Z4O+Lz/cXERQDqG7ss/UmLHdFSqkly62cjpUcoJlwVOwkreipxFgZWiUksRtjH+IJI
         B/m4lVNBezde7zkt8UWBMXLDN4Q32FHvupb8TvhdvXjtbTyH/VC1B5HRUr6y9KcD4s9r
         buVHIh7MFMZmy04yBpHVRJbrtQYA9RnhBO9tZVPAYbJrHzhwRRXo8RIIDhu+VHsic87C
         5DSuqiUyIV6diompwbA4PSOgazZ7JTQ5VdDCaApqpg0ZmmWbXAuk+Syz2CokmdQPWebJ
         RJHTP4Xx2Z70MAhElbYJ936e3lcwKs4Tb9OOtqrz8HcoBysaDu+h3kXyOeeuQaCDbEbk
         F9SQ==
X-Forwarded-Encrypted: i=1; AHgh+RrP6WUBYTr/geEo6hoaH3sjcy9VThFJR5X4AtoC6BlR/9tMoJ4RPn97vGjZ8D4zKuZZki/00NAXJg==@vger.kernel.org
X-Gm-Message-State: AFuF++mNpz+Fr96nqXp0iWJFhbXGk87E7O0MWEOdHmVqtVDnwxTb7JSs
	l+FRzkZGWMrYA/JlWX4UlsA1B0bSXbBVeteS2ZoTz6S6kueT0Yt/R0Xr
X-Gm-Gg: AR+sD12t/yTyLboaN//GnFS64Z+yCC2GIBvAhtpzbrRKRrFLyO7Lg9ze9Wu2j+7qgPl
	9YOJZO8a7/udaZu4mQPyrGuEE+qteF3G7l1F0y/E9ouc7aSGblNQhqfTVFRQhhYoA58zm/uisPa
	4ZCq/7ThGXLQWak0d3UlHAvhT+2rXlHkEVHjSRe2I+zeYvixKYGyQBgErA5NPX6UH6gpK6aQ737
	xkaYSLLzxgVM0Mds3aVDJ1ICKn3oH2mLDxKCTNI29gz4vHC5/Fhr+tIdGgoFYoO8bJ9+Z995mzY
	q6jRtHrPsZBHvDUw54fKJ46IovwtJogiedbUH2L5Z9VP1PBLK/uhx6GWzzDHFW+xmjri4SHLWJe
	QDgzTnD0ENHcZKOqBywxItHySX70L/L3b/RTRv5abfa2meVDoGBsB0ZLKn9DUicyuqfppLhdEce
	+yPa8lyl/jvk5t8f4//oV06L2Gt7R+4ls854czW3cykqjasVOs6PQibxuG5zaYjGN3wkjXl+ERU
	22sW3BbZSN0Nut2COdecxoT0hayCkeSwZAp3wWTpgLyxrZs8wFUCvrHVfc=
X-Received: by 2002:a17:90b:3c12:b0:395:4de4:92c8 with SMTP id 98e67ed59e1d1-3966d484268mr19640797a91.15.1787764074277;
        Wed, 26 Aug 2026 10:07:54 -0700 (PDT)
Received: from MSI.localdomain ([157.20.184.42])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eefd82sm8945491c88.2.2026.08.26.10.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 10:07:53 -0700 (PDT)
From: Sanket Sharma <sanketsharmacsec@gmail.com>
To: jarkko@kernel.org
Cc: sudhakar@linux.ibm.com,
	gregkh@linuxfoundation.org,
	James.Bottomley@HansenPartnership.com,
	zohar@linux.ibm.com,
	dhowells@redhat.com,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	w@1wt.eu,
	Sanket Sharma <sanketsharmacsec@gmail.com>
Subject: [PATCH v3 1/2] keys: trusted: tpm1: add bounds check in tpm_seal() before memcpy
Date: Wed, 26 Aug 2026 17:06:59 +0000
Message-ID: <20260826170700.616-1-sanketsharmacsec@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826080405.255083-1-sanketsharmacsec@gmail.com>
References: <20260826080405.255083-1-sanketsharmacsec@gmail.com>
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

Signed-off-by: Sanket Sharma <sanketsharmacsec@gmail.com>
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

