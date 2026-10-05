Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879B841A4E8
	for <keyrings@vger.kernel.org>; Mon,  5 Oct 2026 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190646; cv=none; b=t9efxcy0YO7yqYPAe4Wu6luL23zNcDUgcaQCjsUT5z31/4HUUqbowUWbB/JeQ0mb+G1AH83eBpmlyu1BIiDFUKO7X+GW2FXkkbqyb2c6TUZVTX7VV/Mm1jph8rH3IA4gevB7aZ/kaYXmIM1GxgObQBRVxuEvE1NoREZY2rx/klI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190646; c=relaxed/simple;
	bh=NHLrGDj2AVwfF29rehwcpxT52670+b9rM0oZXGtXMcs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=epzkyDnJU7/IDBOhhQPNS2rU2/fIEKwPUF2g5tU1O5/Se8uVQG7N/nkms+jCLp8TeKQvYU8KLN/Jj+2ImpYyvNWSor1Mdro+g1Uqj8kp+ct1WlrpoQSwVS57CO5/WGUC5yHRP6zDzGeSZCGCLaYto4dFboQGn45x0V3XFXiRwzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9/wYM+H; arc=none smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9/wYM+H"
Received: by mail-oo2-f40.google.com with SMTP id 46e09a7af769-822f7e70796so1554876a34.3
        for <keyrings@vger.kernel.org>; Mon, 05 Oct 2026 01:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791190643; x=1791795443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ls09vRpVyxcWEXhPUqAPY03MSrTBdQPEwSBcpvvkVHs=;
        b=K9/wYM+HeXiKQ0XinP+S/BkRm+0BcHkU+UWTIUS9LO80gQ5hY1uGt8R4RJgVVbBQ/l
         joarE1zB5hDB0P0RFGJrKISPBua/vPXLYpVI8aPBCBxCEbK2ZiDG70IGpck5ZCyP/6eN
         Ar/0N9Lnmb0opAzDE3sIqKSUN1LNuxEHcqZ2hB8zh0e2ovADzlqZ0X69kzSMCrRhSXGC
         +F7ysx42iI+zVUrVZowHRGiU3Z0u/ReIT9olm11b9CGbcYPYRFJt/AuK85679Y2EPI/s
         UGDGBVGgN3uA2nPQO/Awol1xnlVuLzUbKeUrIdCi3mbfAKLl21d3Wyqik7bLycNIbeCR
         3RKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791190643; x=1791795443;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ls09vRpVyxcWEXhPUqAPY03MSrTBdQPEwSBcpvvkVHs=;
        b=UTqbXHSdB6lEjzOBhpk7QA6G+PtHla+BGdiPD/g1xcD2Rx3NUY5sIoB9Fomd8O2v/0
         4lJCqSpZqgw4TxiBjxSym4fbYZQO3SedTDzhqTUtUbe9xN2iYlBxgZQPhm/Np2GdCmL7
         iiZLTEmMJjEcGZYBvua9ltDxjsC1hWlFb5sKyI60qS6Whw21+nD/Ef2+i1Ee+ywcgkNV
         8uguNyGU+StrPt2OqoJnbw4YIBUaCE6/XgrDQlymW1NwAFJLMH/F+Yy5cfXBnMBoPZLD
         ML8cLOPL/w+rV/D/fWaV8WMqJ04t8zvTXZkM0HNurDFruXUQ5YZ/QxL0i8PWW5/10BmE
         /1Zw==
X-Gm-Message-State: AFuF++nuqPDopVJk9CJPT0ol/HJaKKHXkZThO+bWsuwKHndWUzBfIdFi
	lq2ed6CulUnGxm4h/1qIKnWyitp2YRFGffiPJEMRVpN3o0aXwyAEKABV
X-Gm-Gg: AYBFou0oxF7FM/BS3gJucXEzDfHTcP0j2BHPjbmuJYC9qCmCIcbtHwgwdZh6wYT3TDc
	+AAH0NaIjFpgSB2TVCM1PkMfv02RbfyE0yK8xV0kNp1eU/ngpwyAnRKhSyNsKnC1EPqzbwIzbV+
	D18N0Vc+uz0Oan6usONsOih9gkhDwRmTbzRIFPUozSZi714cauJRiXhJ7tTkUFyonHEZzyHgbxo
	BWDwjhcmbZDQ6jpNViI0xAj3vQopYCWbhxE43KWbKoiVJ033QD6L4jcgrTo84sgPXUYEuIRj7GV
	YUen1+gDJ4a6pBWOnd5r5bNhbztWkN+BKlDqtx8C7FYBXrRTYSJldm6+d/6d+gXb+02Cpl6GtRr
	B4qO/s0z964FDB95zX5+NyQTBmLPqku5H5im1uSYMcCV6cvjEzvgHrgEFLvd0iNcPl934OpSHwr
	rbXIQxfLJ02//ZzHkMy5dPXNqZazDsE+nphLsm/kH25yJQgaEJglDpYNuhZyzlfm8WzZLPo9E2G
	IKejVLx3ikm
X-Received: by 2002:a05:6830:442a:b0:80c:d34f:5f5f with SMTP id 46e09a7af769-8228327c070mr11933612a34.24.1791190643359;
        Mon, 05 Oct 2026 01:57:23 -0700 (PDT)
Received: from sheng2080.cmix.louisiana.edu ([130.70.15.5])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8227aa6cdf1sm11808006a34.26.2026.10.05.01.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 01:57:22 -0700 (PDT)
From: lzhan011 <lzsx618@gmail.com>
To: dhowells@redhat.com,
	akpm@linux-foundation.org
Cc: keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] asn1_compiler: fix heap overflows on small or token-dense grammars
Date: Mon,  5 Oct 2026 03:57:07 -0500
Message-Id: <20261005085707.872193-1-lzsx618@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tokenise() allocates (len / 2) tokens on the assumption that there are
never more tokens than half the number of input characters. That doesn't
hold: single-character tokens may be adjacent, so "{}" yields two tokens
from two bytes while only one slot is allocated, and a 1-byte grammar
gets a zero-sized array. The tokeniser then writes past the end of the
heap buffer:

  AddressSanitizer: heap-buffer-overflow
  WRITE of size 2 ... in tokenise scripts/asn1_compiler.c:407

Every token consumes at least one character, so size the array by the
input length instead. Allocate one extra, zeroed slot as well, since
build_type_list() points the stop-marker type at token_list[nr_tokens].

Additionally, build_type_list() iterates with "n < nr_tokens - 1" where
nr_tokens is unsigned. A grammar that contains no tokens (for example a
file holding only a comment) makes this underflow and read far beyond
token_list:

  AddressSanitizer: heap-buffer-overflow
  READ of size 1 ... in build_type_list scripts/asn1_compiler.c:753

Use "n + 1 < nr_tokens" instead, so that such input is rejected with the
existing "No defined types" error.

The generated output for all in-tree .asn1 grammars is unchanged.

Found by fuzzing asn1_compiler built with ASan/UBSan.

Reproducers:
  printf '{}' > a.asn1 && scripts/asn1_compiler a.asn1 a.c a.h
  printf -- '-- x\n' > b.asn1 && scripts/asn1_compiler b.asn1 b.c b.h

Fixes: 4520c6a49af8 ("X.509: Add simple ASN.1 grammar compiler")
Assisted-by: Claude:claude-opus-5-5 ASan UBSan
Signed-off-by: lzhan011 <lzsx618@gmail.com>
---
 scripts/asn1_compiler.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/asn1_compiler.c b/scripts/asn1_compiler.c
index 4c3f64506..1ae89637d 100644
--- a/scripts/asn1_compiler.c
+++ b/scripts/asn1_compiler.c
@@ -349,10 +349,10 @@ static void tokenise(char *buffer, char *end)
 	char *line, *nl, *start, *p, *q;
 	unsigned tix, lineno;
 
-	/* Assume we're going to have half as many tokens as we have
-	 * characters
+	/* Every token consumes at least one character, so we can't have
+	 * more tokens than we have characters
 	 */
-	token_list = tokens = calloc((end - buffer) / 2, sizeof(struct token));
+	token_list = tokens = calloc(end - buffer + 1, sizeof(struct token));
 	if (!tokens) {
 		perror(NULL);
 		exit(1);
@@ -749,7 +749,7 @@ static void build_type_list(void)
 	unsigned nr, t, n;
 
 	nr = 0;
-	for (n = 0; n < nr_tokens - 1; n++)
+	for (n = 0; n + 1 < nr_tokens; n++)
 		if (token_list[n + 0].token_type == TOKEN_TYPE_NAME &&
 		    token_list[n + 1].token_type == TOKEN_ASSIGNMENT)
 			nr++;
@@ -773,7 +773,7 @@ static void build_type_list(void)
 
 	t = 0;
 	types[t].flags |= TYPE_BEGIN;
-	for (n = 0; n < nr_tokens - 1; n++) {
+	for (n = 0; n + 1 < nr_tokens; n++) {
 		if (token_list[n + 0].token_type == TOKEN_TYPE_NAME &&
 		    token_list[n + 1].token_type == TOKEN_ASSIGNMENT) {
 			types[t].name = &token_list[n];
-- 
2.34.1

