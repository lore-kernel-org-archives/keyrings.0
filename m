Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8370478868
	for <keyrings@vger.kernel.org>; Mon,  5 Oct 2026 10:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196950; cv=none; b=DwQpqDzcqtBO2VoCnP9tXzv5lowUufrR5cf16buREXjfkej6+xC9ZVWGCj2HGy3JFGGrQIrBo5JelZWBJXmIyaZANtsJLAVLKLdIZ5w5b8YWI/jhtKRNAVQydMLfejMZIM1UK171u60yQ8y0YXsfSEW+xKFc6uBBZvxHBVPeCkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196950; c=relaxed/simple;
	bh=g3WAI0eivk5jo8bQtBDps6JicY1tctt8M31bkXXsQ4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ERIhMExH3YfdCLnHx68kmZrkS/vDECnv4St7iwss0XgQJcL4qFdfApMMXxVrz3Z4FeXiZGk0vRZ6YImm7qovYz4yP3lIXxgtvD9lwdmtMGz8DInryEdaMyk5K6Jk/RVu6OpcA2bw9UhHz06FmH0mc5K75ozSK2rWB+wyIaq9f1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=akdQVgWx; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="akdQVgWx"
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6d7a9e2eb24so1052938eaf.1
        for <keyrings@vger.kernel.org>; Mon, 05 Oct 2026 03:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791196947; x=1791801747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=H2kHfNSeYaeYMrgsze1G9NeSnG7fHB8VySZBNT3TbR4=;
        b=akdQVgWx/CJ0AU79VgOTv6VmPHyQR+iVp5BxmzPanpnUgltYlP1xorXw41bPrmEfEU
         515KVkmpk524ZgqfwdLzJkRPNZ/gsjj+deS65Lk3kCGVHTbd81w0hlpOXKFj6aAFUKIJ
         O/4D4u2EyEgYr2Ja9NCYDhwrcQTWvFFRs73ol1y5imy+yVXleAvSsmpiQgasrBzVWmwl
         +IFm6cYugGsIXAadK82hNCs1finHfWOt23YCPXyhQ9HWb32V5NG3duzkYYd5R07lX+AR
         aaIHsBCAek+kgxgF7oM+A6UbiQt+HyM+n0y63EFgaP1gRi39laa/fv4+7NZa8HlmGL+I
         2ePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791196947; x=1791801747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=H2kHfNSeYaeYMrgsze1G9NeSnG7fHB8VySZBNT3TbR4=;
        b=YR0ooxFFtzTO1NyiMfP7u1jjz5FBLSHxGh2/jxpg5tKplBBAQ+lR+HXLXin00k1aa0
         LiXDGUKgKcOrvQcipatKhMrnrimlWTaXvsinfwnprog40m0aoOaznBhDXoYPKg0/mb8P
         b8ePaohWZAvsoCKJudNlOfi6RZNIaZc9d0/elV/igC2Qu2vV9zcVzPGI0j6+ukCKri9l
         Ph19/j98IJDdvYk//4e+GTJMtiPGIGyRVigo26p2gr/13rA0H9CXdGQ2eNYvSd5pmT6v
         U0q+Pj+hVh3prMDpNqOlG9IrDi1a2UOKiU7wF/27Ws3nqntcX0QvHEg9I0y02H+PO2Tv
         t+yg==
X-Gm-Message-State: AFuF++m1DPpEWmj0xO/f273BlLiUybUg/pC9eSeEnXqpUs5PwWz/Lc7i
	/9TMdZu4bhJXyG1h5CHvMqoI4zgbvVJ6Axs3TSlauoOmWBBic+5zoASG
X-Gm-Gg: AYBFou1aeTOp+a+wi84JdikhTlACHpDEmlSQ/V5yovSCNDbsaNMzDzc48NvP6J2A/34
	PmsTsZj5Yuw49mqvGMWHHmaDfijS1CrWWex4fQ11pxD8vgqgKSajre9OOdmZ+cvTNM1HqAsg+u7
	iDgr53RnXpw4u5lRgnYv8zqxSmikJ4SfWUgxTZlsshQoFntlSBL6PKNXt5eLxFhv2y69DXq28TN
	zCqjuKywRW34Qi+gxAGRICo8UZaWKPWQmWQHjFWYTpTelrG0cl/CLX/5Q06AICVb1lnRxPgk/YG
	SyRfbzd94jR25ifWiDlWbA9b1GdYoYn0Gy+Nju4bWbue5wz6K86vkPjQtUnvp4H50Zyi+SI0Yew
	tHgwXBFaNkJUKd6L17o1fiTcV6SsXSBULF0fKnaSEyyX/mqXRQ0RWAGaewOiTCUagIIfc7EBeit
	MZp2vgEa93lySjPNrSkezZYNsdYNM5WbiWGahSX44LT+IA0Doownu4R9cV3RKWAFchsYQcb7hfN
	yRARRalVI+x
X-Received: by 2002:a05:6820:2204:b0:6c1:ad08:a4d2 with SMTP id 006d021491bc7-6e09f2322eamr5598948eaf.67.1791196947700;
        Mon, 05 Oct 2026 03:42:27 -0700 (PDT)
Received: from sheng2080.cmix.louisiana.edu ([130.70.15.5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8227a16aaadsm11375915a34.18.2026.10.05.03.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 03:42:26 -0700 (PDT)
From: lzhan011 <lzsx618@gmail.com>
To: dhowells@redhat.com,
	dwmw2@infradead.org
Cc: keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] insert-sys-cert: fix use of uninitialized pointer with an empty System.map
Date: Mon,  5 Oct 2026 05:42:17 -0500
Message-Id: <20261005104217.1788155-1-lzsx618@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: lzhan011 <zhangleizhen645@gmail.com>

get_symbol_from_map() only assigns n inside the loop that reads the
System.map file. If the file is empty, the loop body never runs and n is
then tested while uninitialized, as reported by MemorySanitizer.

Initialize n to NULL.

Fixes: c4c361059585 ("KEYS: Reserve an extra certificate symbol for inserting without recompiling")
Assisted-by: Claude:claude-opus-5-5 MSan
Signed-off-by: lzhan011 <zhangleizhen645@gmail.com>
---
 scripts/insert-sys-cert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/insert-sys-cert.c b/scripts/insert-sys-cert.c
index 8902836c2..e0bf0afc1 100644
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

