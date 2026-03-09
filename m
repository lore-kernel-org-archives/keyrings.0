Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C872F0685
	for <keyrings@vger.kernel.org>; Mon,  9 Mar 2026 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773077708; cv=none; b=BpilL8YuGu6v6LlbvflKco095d3SlSDHB0xctonWwbjPtlRxXrL75gMMusbaPn8ogr+f0gdf06yTjsNqxyOlbeUHTehC43PRCdyUaFZH6eCbGsT7ywObZRNtU+FRvkpM89956J0vMV8WIkGCY4GFk22VYKPOLpz8E1a+UvDJ2pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773077708; c=relaxed/simple;
	bh=xxWlkG7hfT8JbQBeR3KYqtMRWw+T8l04P54TH1pcZ5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qUGXrBOsCcqRV+HBZiZ2QuboF+gMmWFdB1ibx0VLckuUZ99s6lg10GS0Fk9gSfDVkUI8G3Wj3vaNWASG+s9T31bqR3/KJBUFmhb2zpONA0Kcr+f9JCqe7gj6c9o7L45u83RKUy6mD9YU9IEAsm/wENiY4lj9L13U2f+2FcEEM/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=W2AtOi0e; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="W2AtOi0e"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4853aec185aso11810145e9.1
        for <keyrings@vger.kernel.org>; Mon, 09 Mar 2026 10:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1773077702; x=1773682502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J6bRQRZp+NSuLQEA4zsCW8v0b5lP2R+6l0eeYBSAqEg=;
        b=W2AtOi0eRv2k3xgJ2jWcsM7zYu+sIOySQz/Co9akgWEdethO3WA7dLFMCLzO2jRTw5
         Bo+qCvZc54HX5B1Zh+Zp5iNr2DeMz4ULsn6mcLyMzyLVibiZcrH1HMs6Uv+KnowCd766
         9wfn3JHkcrtMobnSZpdaqfYV98FcdCgkScFljKICm2taZnhjZQI8iXVqBq6x2Fx0NPRb
         BlB03qolL/qFrkZOyrG9WEK/9O869IbaGR9viO1nRC6fMHmzovN3yOdYMtaTyBmeENDO
         iBuiISjvcGE6B2Dhio8FuenyKLOmHfZon7kgU2lVqBHJxC681xIMttUieAGndwv/Q9kt
         +ZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773077702; x=1773682502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J6bRQRZp+NSuLQEA4zsCW8v0b5lP2R+6l0eeYBSAqEg=;
        b=ql5uQVz43EDlfOX8tZCveas9yo1Ji83UAcv8l03YInj8I32JNxkPoBVvcIHkbWH3SR
         CPbdgrW+R4dTU9T9sLjORV8F7WcYKfYltzAMrYD/MC7VcRSDVJ2jf21K0oqv/BdZuzGC
         EbTZRDHZDA8vFGXKdHhqn+Jepxj+3L9ng6zYoNTFJSTcS4GluzYpIsjlq3fSwgeJDbHg
         +oJNnCCiLNMTfrs4bMJ350DTpurt+AnkeH1nnPs5HMJ5oRQ9+vxdm/T4UxKa1OHmtrdY
         FnA+mEkFvjH2aaotmM2KVYQ+NRoa7vYUCJXZp6NEVBKWTJpmTugBxPy4j7U83WKZ0fUs
         4MUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIcEzVv4xrIdeVFzomXNhXVIDjqxwXOc50iyCCI1vVFCdwVghJ82e1z9sSHskoXLizFSRNp8G+RQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsErTID9gstiIeCijdM1sumSLPl5/VaX468KVksixel4sCjdro
	YgxqcikOTRO9LVtZyvYCkr8EHvzg8sBc846HtH25GwstnKYU7YRtyY59NSoU0jqvofCkRMEhl1J
	2L5d31wPi5A==
X-Gm-Gg: ATEYQzx9Mk7VI6KJUxD+U35+fHI6bD9jgEe1WB1WC875j/sNtCPeizJAPPA2wDrbcAo
	mj0qSom5uXsVwV+u3L8DKR4lnXg/MCMrTWJCHD1xE2qvkRvPKQNfwDD4QqIj+YFGhnPuWNZFk36
	5jBG9KPKHjez/vFP7vOIyDoN2rUCX1in+FCIGqdHMliDHCkP4K1mk0S0+0voNn7p/P3eJb9b8sK
	IOI7Sq/153BhOJGoBHV//T8DpoLZFm2gwWPGwhynhyYEGfrSO//3WeQkXNSSE1F4JfaWdcxk2Hg
	l/DOF5pUERsEbMQnumCGyAW303Tb7Qbb3nBfHDvlZ35j6dZZnLJocd7w6n+zHg/+gzVTX3EPw2s
	hqPaXVOiwqT4ky63/KiG50wDf801uSbentS+qOMXkBeSp2xLwowzxwVc1kTwVmL3ACumRjmFbfG
	VUNj9STgRqxA==
X-Received: by 2002:a05:600c:3b92:b0:485:3dfc:57a with SMTP id 5b1f17b1804b1-4853dfc07d7mr49051935e9.32.1773077702411;
        Mon, 09 Mar 2026 10:35:02 -0700 (PDT)
Received: from PF7QT03RWQ ([2a09:bac5:372b:26d2::3de:1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8da01sm29590088f8f.1.2026.03.09.10.35.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Mar 2026 10:35:01 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ignat Korchagin <ignat@linux.win>,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH] MAINTAINERS: update email address for Ignat Korchagin
Date: Mon,  9 Mar 2026 17:34:45 +0000
Message-ID: <20260309173445.71393-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since I'm moving from Cloudflare update my email address in the
MAINTAINERS file and add an entry to .mailmap so nothing gets lost.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 .mailmap    | 1 +
 MAINTAINERS | 8 ++++----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/.mailmap b/.mailmap
index 5ac7074c455f..013bce631ffc 100644
--- a/.mailmap
+++ b/.mailmap
@@ -327,6 +327,7 @@ Henrik Rydberg <rydberg@bitmath.org>
 Herbert Xu <herbert@gondor.apana.org.au>
 Huacai Chen <chenhuacai@kernel.org> <chenhc@lemote.com>
 Huacai Chen <chenhuacai@kernel.org> <chenhuacai@loongson.cn>
+Ignat Korchagin <ignat@linux.win> <ignat@cloudflare.com>
 Ike Panhc <ikepanhc@gmail.com> <ike.pan@canonical.com>
 J. Bruce Fields <bfields@fieldses.org> <bfields@redhat.com>
 J. Bruce Fields <bfields@fieldses.org> <bfields@citi.umich.edu>
diff --git a/MAINTAINERS b/MAINTAINERS
index 77fdfcb55f06..4f4b894bb328 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4022,7 +4022,7 @@ F:	drivers/hwmon/asus_wmi_sensors.c
 ASYMMETRIC KEYS
 M:	David Howells <dhowells@redhat.com>
 M:	Lukas Wunner <lukas@wunner.de>
-M:	Ignat Korchagin <ignat@cloudflare.com>
+M:	Ignat Korchagin <ignat@linux.win>
 L:	keyrings@vger.kernel.org
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
@@ -4035,7 +4035,7 @@ F:	include/linux/verification.h
 
 ASYMMETRIC KEYS - ECDSA
 M:	Lukas Wunner <lukas@wunner.de>
-M:	Ignat Korchagin <ignat@cloudflare.com>
+M:	Ignat Korchagin <ignat@linux.win>
 R:	Stefan Berger <stefanb@linux.ibm.com>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
@@ -4045,14 +4045,14 @@ F:	include/crypto/ecc*
 
 ASYMMETRIC KEYS - GOST
 M:	Lukas Wunner <lukas@wunner.de>
-M:	Ignat Korchagin <ignat@cloudflare.com>
+M:	Ignat Korchagin <ignat@linux.win>
 L:	linux-crypto@vger.kernel.org
 S:	Odd fixes
 F:	crypto/ecrdsa*
 
 ASYMMETRIC KEYS - RSA
 M:	Lukas Wunner <lukas@wunner.de>
-M:	Ignat Korchagin <ignat@cloudflare.com>
+M:	Ignat Korchagin <ignat@linux.win>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	crypto/rsa*
-- 
2.53.0

