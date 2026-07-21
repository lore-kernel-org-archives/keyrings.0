Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6475133120E
	for <keyrings@vger.kernel.org>; Tue, 21 Jul 2026 05:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784612726; cv=none; b=DBSbtFJdH92bDEb6OxPGhJU700OtFIw62875X6RQsUjjiGGRB9PH/9Hqzh//tGQAV0b/BT2J8jhF1QIhAGXCm5V1AOSihDY/jak9RB+AuP8+e7ceCsSvNX8Nf6AzapgqSrmyyW1fJ+TF23R4nyEQ4XmStsEKDpaIWcUA1Jvk/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784612726; c=relaxed/simple;
	bh=5BhgpjbYv7n6lehcfJMF8RfisXcwZAfesEnS0AHA5bw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HxbGQiRNoWMslRY6n8f2gIzY/uh35K2kpT1ZcPg0r16RYoCOloe2jmChjc9543O863EXc8ZIrkopOJHEpdRtq2m9ccrmHYATNMWm7B14izy1hs17mAf+W9BSD7fHi4ucEtZ05QtJtS5NaMrH5eWayZ0NbUytbWEJ7KLDZCPLTIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niyH+W0o; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niyH+W0o"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8485b358552so11752069b3a.2
        for <keyrings@vger.kernel.org>; Mon, 20 Jul 2026 22:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784612724; x=1785217524; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DUyTzWLCTMDNRWqM9Nwj51oZX76siHgXFAZY7PVYJ6I=;
        b=niyH+W0oCs7obIekqZcREwbib3WeiSvwm9cdmy+o16MBvpn6i7gu+oCxZU7vYi6WZb
         dHhzU31UysT4c6zDiFGBa/7as/1c3sE/oTKayW3DMoBDDOa3pcMowTbuHEFTPagU8Ij9
         yuTZHQKi4krAV1V9eFk9xP/hohACObK+FFZIjmn10SgXKjvjyAMNAbQ38BlLV7BMnP3e
         VgoC2dSKME/17DebW2KKAqUz/KYSNnUPY/8kLGaelyIerLZ6j7YyBgzqlaRXoKsRMJQe
         9JhsieoxbtWpgZkmUZT7jQzGUxhHE2vo49yeHqE37Ex/BwvOP4RaU8yeu9eWWsgRZRd3
         WL9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784612724; x=1785217524;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DUyTzWLCTMDNRWqM9Nwj51oZX76siHgXFAZY7PVYJ6I=;
        b=FuyOY+78bFXDhLetASHvQ9VgpjxinZ6EuW6SwKfF4E495BWY5mEt/WhuKyZB7orTcS
         D/bd+sPRnVJA8VHJR2Dv/3hQX1UWcbPDe0Wqa/1ZvicWYOnCrp+chRi1Z4V+YbBJOiEt
         soU0LXBVRy+FHMbkIH7FFxnGHmVQqhSNw9I1+vIFtqTAb8btFC+ZmvcBB2iYrIf+cQzu
         Yo/KbFg+8ZczgXHJX76+19lMst1jKgD7rwtneKB/kmSdaiuS/c4mf6JPsHJPOsLDIYOG
         VsuVCQ9/YvCsTrfR7bMmWKW1kYu5pZj+Iq8jvpihl9czQzQyFM5fakPGsyhnmSulmNLG
         zu3w==
X-Forwarded-Encrypted: i=1; AHgh+RpOWNX+F/rY6ZnojWr+Ie7lTjwCZVtdSpwsuWH6M3Mr/yolmXaitdnHfYKz+QB6Icz/Av5h+028oA==@vger.kernel.org
X-Gm-Message-State: AOJu0YziVnVQ86difQJr2N19chvRfBTUpT+CoIMTYEQWctMR8AhTqRjh
	nPfQBW2tZC0phcrNEhpY/Lm0Osj8qfZA3fK0umULiXr08/0cCpxGwws=
X-Gm-Gg: AfdE7cmVhmWqTVLlmQbW0zJAa93ED5nfREQf8+EEuaWHPblpEw2XFxeQUwiv13DhNEJ
	uqsZMhXPk+0ev/3PPKNFkhWgPOiLYm/Ztn85VfGO29wqx4hNnvX+jNPYyRr4MnY4SSVe5l3KuQG
	VjkpIk7FTq2EfA9wOq5fnc7U97pYaiiZI1XV22E2/FRupVWjbLcwQ9NHcAIaSeRwh+FDQHl/jba
	A4EoBM12fQE9niYOiXZ7yO8WRRdiqL2ENFjMMR26z1o7ytzaGuU9dLexzlssrwT4aU6xRKYWVAy
	A2HOMOYR0L3hVFebQbLe1rQdfF6DkNt7WAH4uI0fyB6PipJnpqE15+M2Q2m/HzxwCny5hk8W2as
	4ib6tJjLZnCO7yTiOw/ugUBwoUm+enJgaUmOuAXZ9LhHNyvkxtdRg4SUADGeeX2h/83oeq3Zc6B
	3skwPGoe38x8Ek5CZVhFmKNBfHK5abZRLxorg/jw==
X-Received: by 2002:a05:6a21:3b89:b0:3c3:64cc:311a with SMTP id adf61e73a8af0-3c3ad64b57emr18830801637.22.1784612723689;
        Mon, 20 Jul 2026 22:45:23 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([27.60.20.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a1bb770sm46620876eec.16.2026.07.20.22.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 22:45:21 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Add Apple T2 NHI device links
Date: Tue, 21 Jul 2026 01:45:00 -0400
Message-ID: <20260721054506.11871-1-atharvatiwarilinuxdev@gmail.com>
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

Changes in v2:
- Used a less generic name for has_t2_chip
- Used DMI instead of PCI for has_apple_t2_chip to avoid PCI problems
- Initialized ret in tb_apple_add_links

Link to v1:
https://lore.kernel.org/all/20260719180308.1398-1-atharvatiwarilinuxdev@gmail.com/

Atharva Tiwari (2):
  treewide: Add a flag to detect the Apple T2 chip
  thunderbolt: Add device links for Apple T2 NHI

 arch/x86/kernel/quirks.c                      | 105 ++++++++++++++++++
 drivers/thunderbolt/tb.c                      |  51 ++++++++-
 include/linux/platform_data/x86/apple.h       |   5 +
 security/integrity/platform_certs/load_uefi.c |  38 ++-----
 4 files changed, 168 insertions(+), 31 deletions(-)

-- 
2.43.0

