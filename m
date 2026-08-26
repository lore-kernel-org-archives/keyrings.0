Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DE83803FD
	for <keyrings@vger.kernel.org>; Wed, 26 Aug 2026 08:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731520; cv=none; b=lZpgHq5rtNHcDoh9NIdKzffdC5rcNRTGX7vXry49tWZxTSRgLiXVdMNYZbpyHqeeWVwmjymldH1pxsjyfzBR+7XvPf1PFVeh5HZRPyalVkERVEDoPtF7NERTetF29jKVLz6JOo8wG59zRjdFY0yJYWXUh1wqhbEKRMQgJRD3320=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731520; c=relaxed/simple;
	bh=K8sgNMD+lhoLDVxxJtRUbAtwJnEs5Vs65ayfE57jHlE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XfoXMcSlQqeI58meFpFG5LNa21LIYihMja81vSQICWZuhm+hjWND7FVcZzdVZLYdWNq9chOHCdxpKMNBRHeBXA3OvfAszvOY2LGxclmBARPV9WtObuei8ugJbYY1wVa9rwORCnDDQcBJlZidbf+uU+XSYG8GqD0L727CMPtGeYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmNiyGGD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmNiyGGD"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d6b5aa7535so7211575ad.2
        for <keyrings@vger.kernel.org>; Wed, 26 Aug 2026 01:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731519; x=1788336319; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h4mwt0a14dx+ccRRrwmOcVtB1mc3b0oWKjoF8Tw/vUw=;
        b=MmNiyGGDN3ee5NgGOlXc8wDc1o857kHDzKa6bdHJ0Jykt4m7TsnA/vnBMWGJRR62UV
         lDpupAJcWLsfZ1pEFTqlBIWDJMuJEumyjlnsChaUkWvohiaxlTdEc6VvQoB5y6ANQuT1
         AgwX2ky85SVRd66Xxt2OdhGiPdcP17CRYrIPmxI8hDiEyOTKuc9KphzwD+zpntmgItM/
         CpXOdGf4MSQsP+GzkHShm6SWT7pgfaVo6mwNwWoycJH6GMdrUDMt/h+pHBQe2gt1UjhE
         xaG/WQVZEExkhzHKWY66HNkmeB9RJXt4KK2YR4Bc57VQ5YXzb+UQM/46oonSfov8YW5B
         Ml+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731519; x=1788336319;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=h4mwt0a14dx+ccRRrwmOcVtB1mc3b0oWKjoF8Tw/vUw=;
        b=L4nbhIeAb1g3R2ywqtYGGOJIA9/9SSEE1f0K+dkhMr7DVJ9y5Bbqzo+oyjeJDSTcFN
         woW1vCtY2rIg+B8YiqvLlKCvOTOCRyfnKDtbt95HhS2iWd96IDoNX6JIEZ5xCgoMRUAk
         aQswgN0uBax4vht1s1wsUTe5N7aBqt6m4u7awfujB81p0HzUvSB1jMySYFqIrGdo1lWg
         whptnaCjVSJyTBOUwZEofulYVZYcJtpXY4OJnbulmTGV3W+SsZBIATKgIsyeSRa0BxKU
         BUjLRtvkgQ+PtvxUnKXlI2DZqCYWN2mOEIa9zHm4H2nMo/+bMLsuDCUHSnbIAz4GWFy3
         HRUw==
X-Forwarded-Encrypted: i=1; AHgh+RpIdpUe8Ng4H2wiFDzVFh2Qzc4A7wS8ok347L8TkypqGJFr1GRHI6/VFFR3XOBH/x88RQ4p1tnGNA==@vger.kernel.org
X-Gm-Message-State: AFuF++nax19Y1Tq2tzZMkocuUyu8QvPD2i5n/7idiH0FKsktCgrOr5E4
	zOaWOUI2Fg9N8dTnnZi9K+gMbQ+qAyH+OHzsNYvxSdb4E0JLN5lfZwhK
X-Gm-Gg: AR+sD13IHPMQ/NUUir4RG2kXvYOtlEkyvFzogCwPs4U7mqrJs1NnUWhNFfH0Flj+tIn
	E9YOy3vOcQsWx4e+nu3OalMuQh2uv8awO4+8RooMW/vDxBjfIOOfGAbItk1V/wzrcuh8YU6SLV/
	w3aHxi7AeLCDMyNLQES4RxUqMPeiqMPOw4mfTtwOiVY3amABm5aydLuEDi2+ON57GwMoQ5BurqA
	VnwkYCGQMGAqf4RMgqpN4AVAKR5tpO5qB8yLCZJVTbPyFNrNV0RvOs9XclonYsb0rTqf9y0FLl6
	rCj6cdo8J5CAhTlag+5AnPcWOZCmbiH7pL+7/Ke5C8k3Zeqsk+8ZH0HYIcrX7+mckSU9RBeiqVL
	uW6QmTLXrm/Xgy1QBZL+KDXR6B5Mvak51la1ETYg5BouaJ3PZAcJQAw99RNQ+E1Y79QfYUP9qWg
	lm2FJo75G0ZjdS+FvJ4ocuypbLGSV+pBqVcpujlJJPGeiHU87z88XLi8ZgnJUjwfrZXH6FB2ICO
	X3hoDE41a9bgECkerGugb3HUmtZrpv4NV9LfqqR6yq0/4VAjZhOCeFkGd8=
X-Received: by 2002:a17:903:1104:b0:2d6:e401:9676 with SMTP id d9443c01a7336-2d707955aa3mr79322015ad.1.1787731518542;
        Wed, 26 Aug 2026 01:05:18 -0700 (PDT)
Received: from MSI.localdomain ([157.20.184.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60c2b4sm9566068eec.5.2026.08.26.01.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 01:05:18 -0700 (PDT)
From: Sanket Sharma <sanketsharmacsec@gmail.com>
To: jarkko@kernel.org
Cc: gregkh@linuxfoundation.org,
	James.Bottomley@HansenPartnership.com,
	zohar@linux.ibm.com,
	dhowells@redhat.com,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	w@1wt.eu,
	Sanket Sharma <sanketsharmacsec@gmail.com>
Subject: [PATCH v2 2/2] keys: trusted: tpm1: reject unauthenticated response tag in TSS_checkhmac1/2
Date: Wed, 26 Aug 2026 08:04:05 +0000
Message-ID: <20260826080405.255083-2-sanketsharmacsec@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260826080405.255083-1-sanketsharmacsec@gmail.com>
References: <20260825182919.15943-1-sanketsharmacsec@gmail.com>
 <20260826080405.255083-1-sanketsharmacsec@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TSS_checkhmac1() and TSS_checkhmac2() silently return success when the
response tag is TPM_TAG_RSP_COMMAND (0x00c4), bypassing HMAC
verification entirely. A forged TPM response with this unauthenticated
tag allows an attacker to skip integrity checks on TPM responses.

Reject TPM_TAG_RSP_COMMAND with -EINVAL in both functions, requiring
all responses to carry a proper authenticated tag.

Signed-off-by: Sanket Sharma <sanketsharmacsec@gmail.com>
---
 security/keys/trusted-keys/trusted_tpm1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index d47cb7108..c89fc6cfe 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -202,7 +202,7 @@ static int TSS_checkhmac1(unsigned char *buffer,
 	ordinal = command;
 	result = LOAD32N(buffer, TPM_RETURN_OFFSET);
 	if (tag == TPM_TAG_RSP_COMMAND)
-		return 0;
+		return -EINVAL;
 	if (tag != TPM_TAG_RSP_AUTH1_COMMAND)
 		return -EINVAL;
 	authdata = buffer + bufsize - SHA1_DIGEST_SIZE;
@@ -270,7 +270,7 @@ static int TSS_checkhmac2(unsigned char *buffer,
 	result = LOAD32N(buffer, TPM_RETURN_OFFSET);
 
 	if (tag == TPM_TAG_RSP_COMMAND)
-		return 0;
+		return -EINVAL;
 	if (tag != TPM_TAG_RSP_AUTH2_COMMAND)
 		return -EINVAL;
 	authdata1 = buffer + bufsize - (SHA1_DIGEST_SIZE + 1
-- 
2.53.0

