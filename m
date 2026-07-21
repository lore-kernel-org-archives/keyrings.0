Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6794439348
	for <keyrings@vger.kernel.org>; Tue, 21 Jul 2026 06:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784615672; cv=none; b=nCsHHAFGhwCLJq3vQrIjAogxXGaKps7Ia4Eg7VytW+Ib/VZB8KIiUE3FPhOjMMFhhFzniIx1K6wKnCpPtRUzpOjCb0q1+6Z/2lciQeJ/4kpUMppePE4qWSHy4QHUdk+LvpGTFyJZubLr9HbrfMflW/c/A3WuttmYCZX9Lp4cmT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784615672; c=relaxed/simple;
	bh=CuR5q0hG/ysY6cDljY7+7vdeuayA1M3MknJPwWSlmnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RbWGbmpzyhDOdYVmlqqoruWXfUr/PIJrAxQyyyUSoSk+PqHuf9u3+uPThLBHmXVa92aRm+YLUKW+tEpEyBwr2TXyWEDCGkLSYQjS9miH8N1KLYw5Y/Eah6zeWO7LbTjrkec6tlHOhEn3n8t8yFqjqYvECv6HduMKG0xgtYJvmdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbhARNiu; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbhARNiu"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2caea3f742bso130637555ad.0
        for <keyrings@vger.kernel.org>; Mon, 20 Jul 2026 23:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784615666; x=1785220466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qpio1MA//9AANLCzTxy+rZBs26K9YsY9hJV884pqdVI=;
        b=QbhARNiuqzABgVH5uyyQxIQ6PqIS2awdcowz7+cYZWFgLmQCMzKDQUg+QLptRpDDF9
         /F5s7QE88eK8nGgCs5LYEvSo3VCotaBu2q3TbsmErsIveUeOLHlOf2jz+1EwT+ebalD7
         8+jMhAJmnNfsmfHUng1HKScAIFjh4Imis6WNztTjzXcRTrdYfGMSJoHTFFCgefrBMuDr
         UnshuyjcvR10IEWyAWYHSOwD44aCLOjD/ky8zhfC/PKAQScSB1auM23jaj/rBEGNkq1b
         F4NbJHTr/RO8x5VN54YJOtpJjRha/MvSqmSwbe6aM0SdpAoamurIJSXaqygvi/ca8y4J
         r4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784615666; x=1785220466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qpio1MA//9AANLCzTxy+rZBs26K9YsY9hJV884pqdVI=;
        b=Qy/9PbDKiiUlI5Izksu0I71u2+Do7zae2D/0SdmhMSzYeThY1hzXSJZ45dMg2rPg2X
         ynl8jpF9+5GlgbzlBvFeaY7CY081YlwDPOJ4XkCS5L2RQcYQrKsAxdBHkibSXJdEu92Z
         C6/Xlk2fugkBoMnGUdJ8QQaAUZcPQtOnP+q6nq9ELi3Y5v05ineO5XzBqJMjAiCtPARs
         wIP8QNFO3U1Wrb4zUO+Pbqij7Pc5lh3z0b9y2huOTas/5xakSK/HMf7d2zU8m56oajuw
         ThLhjpcN20ni+5yaUuvGqgxzOYtPyknnni6bZpNt8KretMyS78uj+WAx53sdLh6mDdvD
         KfEw==
X-Forwarded-Encrypted: i=1; AHgh+Rpee3pskQ7kl5K6hY23QtBr82s5aoCa9WDNU0lHd4wNz1m6ZRx2m/OdXBU15DsIWr9bGSEp9Kk4kA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcG5vmGOF7TSfzV5EUA0BuLHyKc+qje6N/dLLT+gr8knFJqlfe
	JGcyg5UJ8vebA2gb2sr5+ce14ysuMD1/BWoSEP3djOxupyqe+yzIOaQ=
X-Gm-Gg: AR+sD13Uhsw/3PtkAHTzAAfFUEdA0oSHXQZD43U0617+3D2eemHQkX/Jf3g2si9GryS
	nij8DtMQIL7AuLLb6mBr2TxUeoNvEpb4zTW4XP1yK9LxZh5Gzj6XsIcQND56r1Xm3blBvRADj4k
	h52Lq8qfmeFBGtxkgHxX8EKYYCtFcwcWIwt6Dwz/7Yw3rCFKP+5sDkYtmmRa3mKNVHWbOQxMk8f
	m3tcIeP/PqgM1KfljGOD7QC5kBVxkv9AFOaL5wcGHv/RGSCJjt9NMbC+wDnhBJRZUAe+pRyIBzI
	pPTtJmZhWSf2O7ZB+8+2zAcWliJNKpObnA0seaMtcZhKVlBVaXKdM71xVnthb9nW/SNv4q3hDvi
	BbClsErKDMA6Wbu75JjG0l+KR45/Q9rtQQZvotWI1Y9zqCZ0u+kmrfKLIIe4+O8Bgfkjg+Avqc4
	oPDPLtTRh0duE7hGvKov2xB82q5GmXf49J3291Zs5K8adKo55w
X-Received: by 2002:a17:902:ce87:b0:2c9:bf82:dd11 with SMTP id d9443c01a7336-2cf34895290mr177684225ad.7.1784615665937;
        Mon, 20 Jul 2026 23:34:25 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([27.60.20.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1dde81sm73608386eec.21.2026.07.20.23.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 23:34:25 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: 
Cc: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 0/2] Add Apple T2 NHI device links
Date: Tue, 21 Jul 2026 02:34:05 -0400
Message-ID: <20260721063412.11588-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a cached flag to detect Apple T2 systems, then uses it
to create device links for the Thunderbolt NHI.

Changes in v3:
- Fix build errors with non-x86 machines
- Used __initconst for apple_t2_devices
- Removed UEFI_QUIRK_SKIP_CERT as its unused now
- Used IS_ENABLED(CONFIG_ACPI) in tb_apple_add_links for the T2 part
- Removed !bid check to remove warning with -Waddress

Changes in v2:
- Used a less generic name for has_t2_chip
- Used DMI instead of PCI for has_apple_t2_chip to avoid PCI problems
- Initialized ret in tb_apple_add_links

Link to v2:
https://lore.kernel.org/all/20260721054506.11871-1-atharvatiwarilinuxdev@gmail.com/

Link to v1:
https://lore.kernel.org/all/20260719180308.1398-1-atharvatiwarilinuxdev@gmail.com/

Atharva Tiwari (2):
  treewide: Add a flag to detect the Apple T2 chip
  thunderbolt: Add device links for Apple T2 NHI

 arch/x86/kernel/quirks.c                      | 105 ++++++++++++++++++
 drivers/thunderbolt/tb.c                      |  51 ++++++++-
 include/linux/platform_data/x86/apple.h       |   5 +
 .../platform_certs/keyring_handler.h          |   8 --
 security/integrity/platform_certs/load_uefi.c |  38 ++-----
 5 files changed, 168 insertions(+), 39 deletions(-)

-- 
2.43.0

