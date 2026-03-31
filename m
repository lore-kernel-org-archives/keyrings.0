Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20243E1208
	for <keyrings@vger.kernel.org>; Tue, 31 Mar 2026 12:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959740; cv=none; b=W1T1DWGq9bVa6Q2ebadGq2/cZV6b4g+jTZtWy676Ugu6erFEWlwEcShIgdfhQBO2n28abaYKIGsOW47wSoLQT+G4aj4T6U5cp8hbEF3tHtJuORZW1RP0Yfxk/ANwYbTtfCOH45ENEnPbvjLCpLACYILaNFfEYM+fDlBXby8E+hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959740; c=relaxed/simple;
	bh=yBZY08O+PquoIPkc9X1R3mmq3ZSMTpZWXuFFS2nK6Eo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jn3dFilcuB1eXpH0mjBT163S5KQKp9ZKyniebZEP0KXs+xslz6hBRFUNJa7U5QzyExbcq1jfMrnVbUbxHYWbFc98FXk30+xKyXV4OYO1uVZy4xIfgyP+C0nLWnIo4kXLuaRfPbqiqxUSlHus4MlfUIvxp1s7EkNc7qMwuS84BFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hofufR+S; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hofufR+S"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so57341975e9.1
        for <keyrings@vger.kernel.org>; Tue, 31 Mar 2026 05:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774959738; x=1775564538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=R8DsriGRZc/vlEI1YAFmA+byoc1+oLgtee4dpAnNTZY=;
        b=hofufR+S07q6x1DJ2I8xz9+0B1SSTOonrLkb/h9bpmBT6HJ9HPOs5mDEqrHeq/2ibd
         NjMapTPg2SodMAl95Buz170U0GfjlOH7NvLM99frZOQZufKMgytrm4hlXRGxprnkWtAP
         xpTRZ7xLdBs5umnrwIhyqNJ6qETOqE3umtqvbpeBR0G4xhOs8IGYzYmkTU4wWZHENs7E
         eC5XXAYWIKcSk5AJmXlUGtuNUYNgoqZYgdP9IBgjvhjAXfjOKa5g+tKiYbukinNjvphz
         86hz4/rllTS6FmJM5BVA8easeT1Dd+/qh11sZJMZqOs4eLytugdnxGMA1D1MAUHlAQxB
         stXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774959738; x=1775564538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8DsriGRZc/vlEI1YAFmA+byoc1+oLgtee4dpAnNTZY=;
        b=hPn3ddP703eoc3uIW1qTW9dJQV4338Nxuly+WQxnYyWYYlFhxJ07Xw4MLVioiiZ5Zk
         JoBDiIpfSmqeBxPEWtL8px9oQagnWu8N/AFdnTi4WXziyy7IU4Xp8kBvWLy6PXOWV24u
         BDmnCCWNWhp5EAls+qky2nAga4SV+j0gr4P2tULBqNgVEbZm9eBIvaRKKnw+igsNGMFa
         RseBfWfoUwq0uemFV6VVrYF4EudNm4HGRKiuM1dxpVUzeH97o77WuRA+rgeycT8mknH8
         O0D3Bpcp7ED9bD/ReIevU3ZvY6qpYkfjs7oLrkiW3+0JFJH1ZAsbBROLLobyR3LxI6r+
         RqlA==
X-Forwarded-Encrypted: i=1; AJvYcCXTbiCK9LLlBnoIC/puiClzIaN4j7GM4fvZeS3eETZizXTR+FVKVqZ0GKT5HoAN1mw1Fl0Mb0t/ug==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6MyI0XpTxexJ+SmLfg6rI4OuqZeizK6g4zYmomnoAL6PG79uD
	+xpki+D/hsUSGGat0SE/OWMTAs6ebmvM954nY0hLxu4ugMea64WgPLWzX91EyoII0Q/iRQ==
X-Gm-Gg: ATEYQzwHMOxEvwfjJvLPKNIj20STcDQ3gof7guIcZx1jrC/eBtVo3CUaq4N3uzWd/+Y
	JbP2RsJWfNoZIcRoNhdw/ndUVbXBpGjFxhttZp2tHqwy5uyh7I3XoaohSvg28pLCCh1//JdJXFv
	tpiPvn05+PZAoVQ7gjD28E9VLB3sK5EL+svIWOVzudUZb2CAnc+zzaGUb0+vHggE6H/ftJw/2jW
	6gFy5Ao6j9wPjZ1n5fTCZaxd6pq65pe9uovsHjD+4H5U59m65lQ78Z1W5TOKkvbJrcaZg8hAl5e
	Qxnj/tnRIH27W+0ZfAbeDss+ahNCRrv2+UBILQ0Cu9mJYjCbRhyT+5wlBZ/QjDvCZbR5YbE4AvR
	Pu1GoNbYwx3ttSiU+jN4l0Ur1i1QaOUczIfYWhlcW0+2KbtYThnNiYxPtt9FOfdQPImabobLIQ+
	azDev1NQt7GjS17Y9eUAwUKdmb5ncdhJwiyU59YCUQwSBZawxHuHRq1ss=
X-Received: by 2002:a05:600c:83c3:b0:485:3428:774c with SMTP id 5b1f17b1804b1-48878281a4cmr56435855e9.4.1774959737714;
        Tue, 31 Mar 2026 05:22:17 -0700 (PDT)
Received: from nixos-office (195-23-151-163.net.novis.pt. [195.23.151.163])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887aecf6e6sm16977185e9.13.2026.03.31.05.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 05:22:17 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
From: Julian Braha <julianbraha@gmail.com>
To: dhowells@redhat.com,
	rusty@rustcorp.com.au
Cc: lukas@wunner.de,
	ignat@linux.win,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Julian Braha <julianbraha@gmail.com>
Subject: [PATCH] keys: cleanup dead code in Kconfig for FIPS_SIGNATURE_SELFTEST
Date: Tue, 31 Mar 2026 13:22:14 +0100
Message-ID: <20260331122214.103145-1-julianbraha@gmail.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is already an 'if ASYMMETRIC_KEY_TYPE' condition wrapping
FIPS_SIGNATURE_SELFTEST, making the 'depends on' statement a
duplicate dependency (dead code).

I propose leaving the outer 'if ASYMMETRIC_KEY_TYPE...endif' and removing
the individual 'depends on' statement.

This dead code was found by kconfirm, a static analysis tool for Kconfig.

Signed-off-by: Julian Braha <julianbraha@gmail.com>
---
 crypto/asymmetric_keys/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index e50bd9b3e27b..6a2f664046ef 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -95,7 +95,6 @@ config FIPS_SIGNATURE_SELFTEST
 	  verification code, using some built in data.  This is required
 	  for FIPS.
 	depends on KEYS
-	depends on ASYMMETRIC_KEY_TYPE
 	depends on PKCS7_MESSAGE_PARSER=X509_CERTIFICATE_PARSER
 	depends on X509_CERTIFICATE_PARSER
 	depends on CRYPTO_RSA
-- 
2.51.2

