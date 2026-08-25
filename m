Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1623A5422
	for <keyrings@vger.kernel.org>; Tue, 25 Aug 2026 18:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787682584; cv=none; b=RiKcRlrn4d8LyYGHn+vlRmrt+0hXlUcXCPEIEfr60ehH0ySQlF9v//bUaM8S2XLHml2/AQutScSysZQw4FYKF7pnIMzrt/zkxrSuzaVy7gt/jbZfHU5nCjWrcJy9UzJ9PP2iX08/q8XkI7CKEyxG0PXveLi/DHM3hHJLASUhzYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787682584; c=relaxed/simple;
	bh=Qv5tizse7uM28ZMHWSBW/iFPF10dPIhLhOmQxkHnFTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1H0m9kORVq2B2L9T69IssMGoleJlWOMRTwzroCXcLfTFM+RY/Wa+X6HSnNv8ZxKos2dKR2R+cQVsXCDx1DdkwoMyaBA3SJznLcdI+LnTQZZeEY/E0t/Dq/gE4WYeRr+Qnhi9JI7egPfdP90QzeqZK9sTe9fl8RIlQdwSwtmnFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cotBJVFh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cotBJVFh"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d6e954afbdso1421755ad.2
        for <keyrings@vger.kernel.org>; Tue, 25 Aug 2026 11:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787682583; x=1788287383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0TwaP32PT5H2i9bdrec6QBaBFNAsZuH5F1e7X2AhLIU=;
        b=cotBJVFhYVrwQ7Pqi2AzKyEdhI2Q+9ujeT/SBkgj07ZLulLUom6zm392qKXytJ5Gwo
         rQSJz2P6crqlTK991Q7XNNc2TDLMW1RKLi6qX7vSL/D2oadqyjcZlOH8tJuiP2PnkbT0
         dQw+/ybED65bY/TP8Kwgx+dZ+CnNgDF8bhLjnw7QGW7G/DRFIkcs4ihfg16pAIKMZN5y
         sjHx31F7NI0MNBJsDcgJvy8KHl7Zb6poAVn4FJQnBhvL6MYdb568usPgzjt4JiAIjdAR
         8R34i5Vn0O++uGn1Im6wDNz4+yg8i+YKSeyM43+etBE5zSerCec4IEt+CVcM5l7Lik1f
         23kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787682583; x=1788287383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0TwaP32PT5H2i9bdrec6QBaBFNAsZuH5F1e7X2AhLIU=;
        b=nHjohKixc7w5zvaufs09/NRJP3dRvdh4rQY44ZvxepoJrLHHPoYPRHlUb6Gig9pNf6
         y2xn4k3Y3I8aO1Q5jRoKMSPwFts/ryppDOhFbxJ01/KeWYm7jnTm1oLJA7bd7wb2i+I8
         jIgoCq/P8LVE9mEoYUgynHlDrdqAzlCo1/8zYAq4xGSiMQB8Kq2CjUqNnxkMTA8bZzzB
         b9zeHk237uw2aPk8e8AwsIG+6LarY2szNATzWGNOhPYSaeym34a7RoF3r/Zd920u51z+
         b0i7eIwdxGJatNgsgeuJikzZNdtrf7x3bhh3uHsDKUQ5fE9XDi/selBLB491uG31il3n
         py+g==
X-Forwarded-Encrypted: i=1; AHgh+RpYUa/6j2xxiAHg98c0+gefSrlwPDzb+DUAvAfnXaIDG2AO+z0ILW1XQGMDkle0sEXan1kn3eWoxQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mrDiA+K6s+VMPSpJqiRKuYpFfge/4l0nyhOq/r4QoGZVP6Np9Z
	6GSB6NgwPEUWJ5pUx9khFLBWLEeM4z0MhPqk3KvhnOC6D7/G+szQv9enXI93ZZ3V
X-Gm-Gg: AR+sD12vhcl4ww4D8BT1yoQblFuM5XxetOzJOYQheq7iw9o3QqvjN9umXydZZPsiKov
	zynqxP4DJyvHLB1kYbaw7HvwtOvJq2Eal6uhZl+VfIlJmy+tt2ZYInTvvSmVrspI+/o+lCsoKOI
	JslrcJw6YCDY8dlCF1sQ3Px6BM4lWIfF3jIjdW5r8SCUQYK5l8a2NW4iXVU9EDwoyzG2AJpncAA
	qM23RpghAvCiCPxEuKvKIOWaml2sYRa1/UXpuOTmmfCtxapqihiXC40B2rINKjxzMEdsWUsZXcv
	NTh851ehVpp2ULoX/wjQVDoW54dz8nvp6PbXB+hd4iMeOCEm0+9kAaMu0q/kc5zVUsucciZhRu0
	Y1OQEe458srUuzAsnFwQsF/6G1jCj/1p3AzyJKcdrgHPa8ISHQDxEAJZWwXp8g4KuXCps1Sln8t
	0rN6QwOaAJJqeXfz7Y+txmqkyJnA08sHtlfIP3K0Y6fl5/FQ3QFTqal7uGFTCTaVOq8SdbJ98FZ
	dvOK0DQTYXI4r4jA9Pr9u/BYDkXrXwLDIVh4s0w/vEbMyIPIZjiz4YkL5E=
X-Received: by 2002:a17:90b:4484:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-3966d5bc8b2mr1422567a91.16.1787682582620;
        Tue, 25 Aug 2026 11:29:42 -0700 (PDT)
Received: from MSI.localdomain ([157.20.184.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d8861d3sm1230188eec.18.2026.08.25.11.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:29:42 -0700 (PDT)
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
Subject: [PATCH 2/2] keys: trusted: tpm1: reject unauthenticated response tag in TSS_checkhmac1/2
Date: Tue, 25 Aug 2026 18:29:19 +0000
Message-ID: <20260825182919.15943-2-sanketsharmacsec@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825182919.15943-1-sanketsharmacsec@gmail.com>
References: <20260825182919.15943-1-sanketsharmacsec@gmail.com>
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

Reported-by: sn0x-sharma <sanketsharmacsec@gmail.com>
Link: https://lore.kernel.org/linux-integrity/
Signed-off-by: sn0x-sharma <sanketsharmacsec@gmail.com>
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

