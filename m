Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0265619A2A3
	for <keyrings@vger.kernel.org>; Sat, 13 Jun 2026 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781355866; cv=none; b=UmNfz2NjYM24A86tf5AGy7HcYmGyNd5eHTy84oS1XqrKC1BbICBPVftS3Nbp638P4Ufs+alTOp2CuGnqGiM2iiAYyh7j1CRxp7t13us712pFREAs0xncWeYSYCav/GTctYu+ab3QnhlVfwbehpnfkVFLdIWC5eZnL8XT/k3V7M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781355866; c=relaxed/simple;
	bh=X7OGScrPB3yY8v+4SZVfnqVCa1sJajXf6ntS0Kunqn4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jYxCVEg2ry2WZdx9mML9VSP/IMTOA3vDGcTUfd6x40AHcIV5oAqtfQmsgBtyYVgwkd4DcFoBob/PWnNo5xLUgDoeQYpq/05XUUFtyIXDMB8PrQRU0A8HiXBqmMnDqFKIqOLVRCRFqrnmAgV+NQmdie/mWIoBj2MqDrI/HF1hHFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdgTrQux; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdgTrQux"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490c1915793so15637685e9.2
        for <keyrings@vger.kernel.org>; Sat, 13 Jun 2026 06:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781355863; x=1781960663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/sWTmGnPy5CRS6c/b3mIiUaSM3PjZW8cDV1skgU0XaQ=;
        b=HdgTrQuxBX0a9R0xmrm79S2dgCu1FuaEXA/I9BFzMezhBNTv/1qerlhfbLsZ9BjGEZ
         GeUd7416IKRwDogARZJGqIRdbSKIm8RrVulXYSvx4bKPyTSUYkKYd0074lpDlKZ3Unqz
         DATHvCXHN9PyNzprUgDqCRLAc2ZzDkIp8DyFHoJnqrye1SeNtGtV5OEw/uCyelL3iMvX
         OWJFoYpO8iVToVKoQnv02OUy/pHejGTB7TyWNwGHQ6vgKugC1GXxuBxomD3iutW1iVVg
         VpQnLNf6FC/6B+iFD4sfDNhyIBIjhbsic7aPVwNCGPXlCrzcME9l+OdYh+CNjftrmwvS
         lKWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781355863; x=1781960663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sWTmGnPy5CRS6c/b3mIiUaSM3PjZW8cDV1skgU0XaQ=;
        b=mNEZLrJzBeo2GmupJB5evcw3nrWKFLCQOt4rbnunoVdiF2seUVsHQUdJYcrwsbKv0d
         XOSKog+VA7IEdue5Qf8rKmwkq6K4aFMR2F63bKYqaRplUun6aSUIukRu2os9geFgiHSm
         ew8k3NNj62fcq7dlSk/6aBfMgZVz6Q4kTvOWJSbmQls1Xn0UKdN0cCHscH1U8zwgigrm
         CGsJtroj2zqLO+nJQibQc6x7zZkLN1qI5B1f+FjLhVYr5QVkV3MFEpfRt8BvVRwHmOoR
         kXcLTVaG1A0zIN4LktjO3OZep2eH/eXsmQ8no7HaP7Zm4+p0X095jZhjHNkSk0zzSOGf
         dnyw==
X-Forwarded-Encrypted: i=1; AFNElJ/FKD/U5M56zfxfH7YJVCJaZKjVi8CAAVL6kcXcQ45P+E32LebyemBWgJUa3i6aADnvpO5ni34SIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YydqDaEFpHUx1VH/szkd/HzA64YNymC/LyV/urKwmbgskip33lv
	5PuIdhkXN6q6ERAUNKx/uNOqbXRmowI/TSy6fZ2iFI0pX6wG0zzIdJ4=
X-Gm-Gg: Acq92OGUGx7lezpeJxWlwavK9BrNwDqDgBONrRAc4gmaOG5IVulNnc1FTl9LesnXaZg
	e08B2tTXlzpm77h0ovKOTDSYFIjN/5cXPDiZhDKF+Al5/V9/vc5ZPYjtHcs5rvwqRSp0JMYtyTD
	3j9uDrQfUhBQ9Iaf3OoLvgifE8LVik9NukVC/6oOMoavhQoqneE3zkdC01XTNxFuhZ1y/s+MO8b
	IdtIAMIB+j8e0/GrRpD5IfLnG0rZiRbVyIMGeyqVKYpqrQMBmMywXTIy9CLSh43WpeRGSy1ZOd/
	RzsP1O+86L0EohyqeRNwYAfF8zl3is6t3G5Qb6J/znRdtZarwF5qK4Tg4QZynOZtl4DUgHSM1KB
	fglxESZnNAgH8xeUFDJ7HNUhC9+C6VyEtg7uvDlCCouLX3vpC9xOi8qfQipV9+hzTHFbVUCY/8J
	Ra53j6R5poM4SzOlGZitf+8ZIaMte9YjKwXiP+TcKjpesHbdcRxA1PK8PBnNHFMCJ/uLrpIGK1C
	kfkbF4B3ntjM2WE5QVxc7wt241AyQ40u01NItOA
X-Received: by 2002:a05:600c:190b:b0:490:adb6:7957 with SMTP id 5b1f17b1804b1-490ec524ed1mr86995835e9.33.1781355863112;
        Sat, 13 Jun 2026 06:04:23 -0700 (PDT)
Received: from hp-ubuntu.. ([41.140.217.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203c0801sm66259515e9.10.2026.06.13.06.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 06:04:22 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: jarkko@kernel.org,
	dhowells@redhat.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	kees@kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH 0/2] security/keys: replace BUG() in unreachable default cases
Date: Sat, 13 Jun 2026 14:04:06 +0100
Message-ID: <20260613130408.13709-1-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace BUG() in two switch default cases with proper error
returns.

Mohammed EL Kadiri (2):
  keys: request_key: replace BUG with return -EINVAL
  keys: keyctl_pkey: replace BUG with return -EOPNOTSUPP

 security/keys/keyctl_pkey.c | 5 +++--
 security/keys/request_key.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.43.0

