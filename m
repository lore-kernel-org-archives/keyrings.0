Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB35B39524E
	for <keyrings@vger.kernel.org>; Sat, 17 Oct 2026 21:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792271124; cv=none; b=c2fctgEhi04ko9Ui7GPdY3rgipuCTM7pC6Sh81uCMcdHgXMDi/HXfZGN9cK1kwc/cKHcQMLRcTLjFjXpeOoAAIb7Q0ElJ3BHdWx2nKT7Yz2v3fc5Vyj2CFdIGMZvD+Px1sIH/89/+Dy5YqnchtKcEZjY2Jx68xqnkrqjb+UcLgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792271124; c=relaxed/simple;
	bh=eGw2YuVzGCEWEFpz7eCjB80XmNGsACc8knr9wmw9b0s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u5qJpGGzeU1ox9ffNhCs32NmLhxTpyRDsH1f+l5lrg2a0OqSmpu5FZlkR+CXT+9Cs5X55b2AxJPLZQ6lflaItevs5wTK6PH3sgnbPXYynnqNAKwjE8kQYDU6C5ubll1ZbNEopWIjL2n+YXS3bXPsyW+Z2IUspXpGmDo+LgBdrng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M23F6Qbf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M23F6Qbf"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so7496985e9.1
        for <keyrings@vger.kernel.org>; Sat, 17 Oct 2026 14:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792271121; x=1792875921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=E2w+v6VTOfFscSyBhyB3vO7STl8TgCqdyv6t5/3oCTY=;
        b=M23F6QbfqBVXu8ZNx6wUUBb0NIQDs+ny89ey/7/BK/LaB3oaw1aOR6gABPLvs8rYLc
         EWCiMamx5IVvwzBaHi9MVSfv5T1ZCIfeNiE7sA5QbaM2cuVP/SHYqLvTPtHgJR0ZDmfi
         kEboKpNSSrSeL6gVgg2tT8IqZmqU2+ZmLKAfUm/yEn72727H4kEnOuZEeotrprjTt1Ub
         75uM+Letz1q7lcU8UT4R1zbctu9JY0iO6fioZpOdPOy21ZiWta4HBMN2JXxQ3sLSslGV
         8xHk6OlB9nqvKnMMH7rqaGUdaDsMVJXiM2PaIUekt3lQvVLXr0aggP6K+BGRzkur5IjM
         wcCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792271121; x=1792875921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=E2w+v6VTOfFscSyBhyB3vO7STl8TgCqdyv6t5/3oCTY=;
        b=VgTx1lp0GQbpzeSsZAscSuoZ3sAi7/dCW+g9ksx3eY+Y0X3QzRMiuwMYXc76InI73B
         QMJXA+pig1TqwQsuIxdTH8r6YAtGhYGx72vnqTtu863VPEQ2qRoo5eOuyRsucV/CIwiF
         lVt1Xcp9NIChho3zGMZCrh51ILUEitni/9SuMMhxegeCJh5lOkpyEIE1w0+1SidyIj8k
         pal1pRR7PqKO3cHP2bDEbEE7vKWVlIILKhWospc00DyOZG+RfWk2G1AOoiiMf1OTHoCa
         Pa3Jww9SqNK/RKV+0Uhoots8gobVPMN7+pQjW9xA0cyJR+X1j7BjxtooMlNzD5JwyF72
         /4IA==
X-Gm-Message-State: AFq9FYJ3GNRkECg/mV2btUl1m8HYIm9X/1cS1/2laDrmqcfWaW0Yrj+8
	e21ypuHO+lZGZnluNIXWaHhjUNgGLgKPaixtcQb5beloxhXDaOaAAvSdGJB3yhLDk0Ewl5Gokew
	=
X-Gm-Gg: AYBFou1DuhV8a8yHIA7+9yRCFBceu83VpmjghLJtWS18W9ZMMbXQ58ADFhS5JW24ICZ
	zL96yrC3wwxCtGFDgdbAyLGV9vFAZfFGajXuxg90putgsAAIvt4yI5TAncUPaTbT3kTApvvsqmE
	5Z9AP4tC2YuOGvjP/qzUVhdePhCtNt5c+3WSvxM+np8DV9898HiWSgcZgRo9iGQVZoIoBW65Bzu
	M9W4W8UUuWFurgVr+ZA0/oh8zP4Sgbin0RXW+uecwKup65rP47IQ87TraaOW15gezdBdBIBOA2t
	1Fco+8rR/mqXlZewWkoxGgx2KDy8+zBfnl6mt+fOZVV5BU8Rt6mDGFcLKRoXyqdrr7FELtMDVuH
	zek5D9ke6iMW9mMLEV7XFEh958vYlWct2PMM+EO2VoUbwaTSERgJrd8YVB6SQP80IXo/50YrZ4A
	LOrQ4pw+jlxbIUyvjczDk12OuDRnWhEeGM5zz5knvpFkRK3WePpfbZb171euQ64tzcE2phyl8Bb
	VYAefKT
X-Received: by 2002:a05:600c:8b25:b0:49f:fe39:5bc8 with SMTP id 5b1f17b1804b1-4a1d75f987dmr101048615e9.12.1792271120770;
        Sat, 17 Oct 2026 14:05:20 -0700 (PDT)
Received: from fedora.domain.name ([217.218.152.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1cca26dc8sm109085575e9.3.2026.10.17.14.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 14:05:20 -0700 (PDT)
From: m-amirpour <ampr.mhd@gmail.com>
To: keyrings@vger.kernel.org
Cc: dhowells@redhat.com,
	lukas@wunner.de,
	ignat@linux.win,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
Subject: [PATCH] crypto: asymmetric_keys: Fix PKCS#7 selftest error reporting
Date: Sun, 18 Oct 2026 00:35:13 +0330
Message-ID: <20261017210513.135540-1-ampr.mhd@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>

pkcs7_parse_message() returns an error pointer on failure, but the
selftest prints ret, which still contains the result of the previous
x509_load_certificate_list() call.

Print the parser's error pointer with %pe so that a failure reports
the actual parsing error.

Signed-off-by: Muhammad Mahdi Amirpour <ampr.mhd@gmail.com>
---
 crypto/asymmetric_keys/selftest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/selftest.c b/crypto/asymmetric_keys/selftest.c
index 98dc5cdfdeb..42857b02258 100644
--- a/crypto/asymmetric_keys/selftest.c
+++ b/crypto/asymmetric_keys/selftest.c
@@ -41,7 +41,7 @@ void fips_signature_selftest(const char *name,
 
 	pkcs7 = pkcs7_parse_message(sig, sig_len);
 	if (IS_ERR(pkcs7))
-		panic("Certs %s selftest: pkcs7_parse_message() = %d\n", name, ret);
+		panic("Certs %s selftest: pkcs7_parse_message() = %pe\n", name, pkcs7);
 
 	pkcs7_supply_detached_data(pkcs7, data, data_len);
 
-- 
2.55.0

