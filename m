Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF381E5B70
	for <keyrings@vger.kernel.org>; Thu,  8 Oct 2026 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791477708; cv=none; b=a4IcNi3FmmkvLib0glXrNSKnRBaje/wo0HQLO2fdNrRnufMEjUgTkXOMa0G3XruDN+tjlEAlR8Fy1G6g463sVcoyHGG91v7EsD4RwifdFGbB6H0xcpCrEL543kEcJvFtJbxFNyFFh+cI/1qfLm4ad5b0YPZZ5Qg/ofyIz6edzhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791477708; c=relaxed/simple;
	bh=Nhe4QdZ05WxGERe/2m4l7C4Dh1nyoZLPP684bAXzbfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uccdiU/kB2A1d2I23YSq9adF77Zh1DFO3eQdKAgyGr7khM27Lh+Dbn7xf05CPYnVvNcSQrH+msM1yeGK+0NYFUpfLbTcMhayZtmO8nqsDHvRg+97yL3wbTg51AtfeL1td/Y/mdXyurYMUagbRCyyJShV6qRuYKx8IVzV10pgQ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jp/5jffO; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jp/5jffO"
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-4b28d7c729fso2976636b6e.0
        for <keyrings@vger.kernel.org>; Thu, 08 Oct 2026 09:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791477706; x=1792082506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FVRbwfsptP26mC4/pKVYDrVCO0uNaRNaX7O0Iiwj1nw=;
        b=jp/5jffOaeTYXhVeuysJCNsvzDtGyOYlFJhcY+Bm7r6HnciFlMSbanHdrk/pi3nlSd
         cqOUNtXMwUP27zjdcyIgysl8AnZ8J9tB9Z0CAoRzuorvdMNyB3mPuCplOaqeIotRUenC
         bWXiUGbx8SxZokVE7xN645+lHrf1GHSDX57oC/C2Ch3vXIutugO5E3dDzaIu+vt9YzOF
         F1Y6UcSZjFAkCuINHtIXSs2v/9/CF6tB/jf/xh3EM+xQ4UigaI5W3KPx5O9qoJv8FKA+
         eClx2at+ji1i3Qrq7M7hp5cInduF2HmV17mfPbDQA1HpAr4AckY2aOY1vUmN2r8p5XQw
         ajKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791477706; x=1792082506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FVRbwfsptP26mC4/pKVYDrVCO0uNaRNaX7O0Iiwj1nw=;
        b=eBEV9qqtty/CfWLyI1DJQMe4KQNPC27tanNnZdeNFJz2mmmr3+Aa+TNK1eAb5I8/Ty
         ewP734W2m4LEvu3chmSOEjaKS7ygI4aDyp1RLbQOEZo9rJMR3fAWDZZhoirg9AiZvMpr
         qIoVn16czrdU0wLk3dA8245j18XLAFx9sbH5oG+9d9XMODdFDHRnfckE+RV5/FFc2Psg
         48a/QKX1uMtrf75hP9e14QXxGVASsvEmAgh7YB92QL0569XWjpRTKbv/Wecx2vSRKpim
         IEFLMcOj9BKnMhkmHSIUf7eQfdhcpr3rKdwi31CesHePCaAmcDupsewobvSX5O4Pn+dO
         neAQ==
X-Gm-Message-State: AFuF++n4qnf3UtV/bdDpom54N15JVUkdWi32l4Z2HZw5UrWTZoq7KRM4
	L+aJ3wgIn1xe++rkqU2ZfzoWirC5ThcD6qj3MnU/z8MfNKHcvabghQEZ
X-Gm-Gg: AYBFou0jYo7R5UMhbQRDf56BB/+VnUswj0zXJsi5cS1fwCBGEQF9Rstdwt4awZEfc+z
	4srGVg9eU1H19BUQ0LNDikFwxwZOOAug9tt+kSDcubHO+OdAAPkmjtyPEPStpn0sqxvYmmOebcK
	qa8NVI0DdMMT+uRQ7fNrz5jhV5bcS52xXuZxUdMle4kpivPbCRgm+K66MoWRSmDSyLZ7oq08fte
	FqoalT6UDOcahPFmVgqoUpciIuSWBg9LHqUNjn15rEBBNpE+6kunJo/Utd9g6VcPclAS4IEJebO
	x4qNOagITawnkIGMwVEcb4WsOLX8quaShIT9g1qDsTEMLRsLdTwHz4M+GjY6qfs78hBH3vZ5lM1
	EOx0yqhsoeEBgMC2UFgIthTuzY6OPaJxrCiNtCG16vTb7B/X+x00eCN8kDu2uns7kosg1T1eLoo
	4AttcraHdyeohEU3jmopS0fqOToCwqDMGAGCbaWDjBVKLzDIPzlhdIPRqWVmITlNXT6en8jyZF2
	yFQUwJDnAbr
X-Received: by 2002:a05:6808:6716:b0:4c3:4e34:c69e with SMTP id 5614622812f47-4fc4249bb58mr5304050b6e.8.1791477705661;
        Thu, 08 Oct 2026 09:41:45 -0700 (PDT)
Received: from sheng2080.cmix.louisiana.edu ([130.70.15.5])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4fc484f6d10sm6310506b6e.3.2026.10.08.09.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 09:41:45 -0700 (PDT)
From: Leizhen Zhang <lzsx618@gmail.com>
To: dhowells@redhat.com,
	dwmw2@infradead.org,
	akpm@linux-foundation.org
Cc: keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] insert-sys-cert: fix use of uninitialized pointer with an empty System.map
Date: Thu,  8 Oct 2026 11:41:37 -0500
Message-Id: <20261008164137.3671294-1-lzsx618@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_symbol_from_map() only assigns n inside the loop that reads the
System.map file. If the file is empty, the loop body never runs and n is
then tested while uninitialized, as reported by MemorySanitizer.

Initialize n to NULL.

Fixes: c4c361059585 ("KEYS: Reserve an extra certificate symbol for inserting without recompiling")
Assisted-by: Claude:claude-opus-5-5 MSan
Signed-off-by: Leizhen Zhang <lzsx618@gmail.com>
---
v2:
 - Use my real name in the From and Signed-off-by lines. No code
   changes.

v1: https://lore.kernel.org/r/20261005104217.1788155-1-lzsx618@gmail.com

 scripts/insert-sys-cert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/insert-sys-cert.c b/scripts/insert-sys-cert.c
index 8902836c23..e0bf0afc1b 100644
--- a/scripts/insert-sys-cert.c
+++ b/scripts/insert-sys-cert.c
@@ -94,7 +94,7 @@ static void get_symbol_from_map(Elf_Ehdr *hdr, FILE *f, char *name,
 				struct sym *s)
 {
 	char l[LINE_SIZE];
-	char *w, *p, *n;
+	char *w, *p, *n = NULL;
 
 	s->size = 0;
 	s->address = 0;
-- 
2.34.1

