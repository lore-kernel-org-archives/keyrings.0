Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183453B42DE
	for <keyrings@vger.kernel.org>; Sun, 19 Jul 2026 18:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784484232; cv=none; b=pWi85l7c7XWowW/yi17JPAO3B7SA0s5uE/k1Ds/HNWHty8yv6X/s2393Oy/L/BT2O19w53PggDU+RGWcjhYCWPfz5SKoY59Bs9ZJCw+yeIuvYPe3R7ZaMoZt7xJKzXARHhnKp+ODdLaL9PZkoJG0/LFvPLfJvDLDRZV0OfrfXDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784484232; c=relaxed/simple;
	bh=sVlAnhzfkzYQa1PcZYfpNzgJJd87BozZZNakBNALqlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BVLIMvzSLu00F+thIpRwJZmpGwwz6SRLlYKM442ywY4P1jg7Sry0uq+dwOWKkk/vU70NfVVnpnccrDU1bXNwX4zwwl4X+r1dR95N2Zk94HkxUh3SGPyDmEUsYud0oWMCOJ4TCVBxWbWn3svzSCLA0QDKeD4zU3FpXrI6+pFx6qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VO41oVYo; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VO41oVYo"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf52d15d88so7425855ad.2
        for <keyrings@vger.kernel.org>; Sun, 19 Jul 2026 11:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784484226; x=1785089026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jxozXjIKJbQZrZVReseOqoF/OLImpOhluGTGzSR1yOE=;
        b=VO41oVYojY5nNLDlQiMn6nnfXahXoClP/cwC9XHBUJf/aNsn76YDQYHUlyO81zd557
         YvWIt5o0EWh+URbiaqycX6C7b4JQt/Jkzlwh8vd7xrZXTmKfEfuwHMSGnTkXrDaN7FE2
         jSZFoJRDwcnJip5qO88NGfDWikr7Cx+J5uULPkgBrEJWj6uiMOdjQ6rzsYZ/1KKRU7RC
         1BVYN7Zxn4jAfRXOB8M5vEabMD6GvZgJYYREyQE5nBg4nf/rgZZkgSgCRUcqXBJbJHhl
         49JfSkQ30IgEDQQ63i5kq6otw8ArRObpqTIcFtA6nlbIUih6FG2u+71BRPxJlAbaoVwW
         aAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784484226; x=1785089026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jxozXjIKJbQZrZVReseOqoF/OLImpOhluGTGzSR1yOE=;
        b=CHSYzx/pLZNXLPhwCyop2pr1cmbM+sLa3zI7eMTg5uO0GYCQpn5F2IbY2hmg3js7m3
         HAE29HmXWg4htjmrvUDZK/yucWiCCOPrdqUoFtq1zjt91BGAhn8Rz0fqVgdVy+8SBltP
         F7XEoi4Vk0SP7xdXJK4meMZYUNbs7Urjt93B5jCvIwdNXDvc8tM2zFX19j3jzUPnblhD
         prOl3+qdY0dKm6RCQ1P6UCBcqPhhniNTr5z6BBVYuaCdjGDtxSrvaMzF/4MbzKkqt+ux
         IBqP15B+g4GQ4aXpuRSGjupwDTI3tBGvP9eNLjZzckxbsaK6OMQhxEymtfzndmDVelvT
         BrDQ==
X-Forwarded-Encrypted: i=1; AHgh+RroOQLSGYNUek6Y4XXViTd779xSBGg72aoPUyjnMgQqM9EYsw4SxQDhPOVMnlUF8OC9vLOSaaPusg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzkhZkd0VEe9Z54uryzWrZRaJ9pOhS6HCdpN0g2eARIKQPuyZCG
	IkboZxDIfUj/+ZwQ05n/IaF6LXRjNo5V4FwpIxsLhe8B7M2au4w5dbodRthw4uI=
X-Gm-Gg: AfdE7ck8BUIy4+MYTFi4tLp/sDIP3tSej7AP5LhLhb9USn4vWxtdCzjiMOhe2HI6qyK
	f5wCFAOJeCGkczRufmDRji5byXHH7v2KY++Wgk/EJAHDWf2CepvNTNLkP+OIWtpsaCMiI7VBd90
	awOZ9mLIbD0fPraUkQtZPwAyMEMEaCXQMUX5yjrO7BEpVSQdEfus4J3VrNRrNC974PVARwWE8jO
	X8NMBsvLgPUuVTBXeUI47Ohf3mgsAwrX9dQki1Fv6h3bDP4qdN5sqWUVbiqJv0u6EEyFDhdJm49
	lYTjEOIonlGVYBrchSR/8x6VCO6azvOtM/HMnjXnfEoGGG/XplOk+dbMBhxgLjjPh26swwEpUrV
	WQfqb4q4zGZlMqTop9tIPxZRzwckzaog2ezubTnd+lkpSmcBvvotODzSdPLEJ2tWdfWF6TAdcpG
	VD0W6G362vohK8WN6ZYSLftsF5IUxX1YVcaU8I4I/773c51zIT8Jc=
X-Received: by 2002:a05:6a21:6cc9:b0:3bf:6237:4d46 with SMTP id adf61e73a8af0-3c3ad7ad65fmr11766169637.28.1784484225791;
        Sun, 19 Jul 2026 11:03:45 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009.. ([106.194.66.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3142a02b7f2sm27967645eec.13.2026.07.19.11.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 11:03:45 -0700 (PDT)
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
Subject: [PATCH 0/2] Add Apple T2 NHI device links
Date: Sun, 19 Jul 2026 14:03:02 -0400
Message-ID: <20260719180308.1398-1-atharvatiwarilinuxdev@gmail.com>
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

Atharva Tiwari (2):
  treewide: Add a flag to detect the Apple T2 chip
  thunderbolt: Add device links for Apple T2 NHI

 arch/x86/pci/fixup.c                          | 10 ++++
 drivers/thunderbolt/tb.c                      | 49 +++++++++++++++++++
 include/linux/platform_data/x86/apple.h       |  5 ++
 security/integrity/platform_certs/load_uefi.c | 38 +++-----------
 4 files changed, 72 insertions(+), 30 deletions(-)

-- 
2.43.0

