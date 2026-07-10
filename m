Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7922D2495
	for <keyrings@vger.kernel.org>; Fri, 10 Jul 2026 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704657; cv=none; b=Nx92jNi988vXeEJWjoh/IX7TWlwwQaTfY584Fqopmrl4bKuAgLQpesdSlmYkMbLhKu0Fzt2cQmhyCrQeqHyvpapmr/YgNBZr6iX9euP0Yk30Ol4JuxBSGS7m7Vl3ydM7cKEeJOtCugIvRoE6G1W2M2xsN2p0Eslto9koSJUpJLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704657; c=relaxed/simple;
	bh=/zr/axeNwzLqEpCzeT7RCY5ork8kdfWaV4dpnfgpoUA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VqPzrH+fB5IxCkEc2D7+U95oeHJBh3mkdSB8bbORhl1tmwCKkvk4vx2Y0ovoJ3E+bWOWgTQq2CXwODSV1w4GijuNgIhgr46RTW+COsIgWZIi9w9RBQRqNcYAVEu5Hj+dM8Vwin9BOh1EnLsZvECXNkzwOfQLTOrFyhxYffWQIzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=X//9bYaz; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="X//9bYaz"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15ee037bc0so176883166b.3
        for <keyrings@vger.kernel.org>; Fri, 10 Jul 2026 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1783704653; x=1784309453; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FDzbfwt6aO87HJ10PJGzFsqUnWfHCYvGtQuDgYNPfq8=;
        b=X//9bYazY/Sk5fPbuMt43gH64Z0F8FVF9sovzdNXtVxpgABocpDgCFcomece/RcANi
         wia8xA+9JcoKBEW5cZhMmpmk0BToLhv8PuBtnXJojCavKFec8aGOferHKkM27RxktVQw
         JJPnqwFkRr/hSyWa/YR3yQ40XBcXgOfK6/5xpn3sPAJhbypP4H2aHSWqSzAJSu/gcL1M
         vDLag6jO98hybCqv8wF86BFv1Qy51v/LuuW4+kJlfCIcvauQl1FvOshiUTXnRAdFw6hz
         hz6p7vrvBy/p0PDSc+7iDR3SV/QA9t8qbflWsIZbZACsSDMoYqOlFfszikoYsx4sxZoP
         n6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783704653; x=1784309453;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FDzbfwt6aO87HJ10PJGzFsqUnWfHCYvGtQuDgYNPfq8=;
        b=cbREkzXaD54RWhzNlLz7DT1rpmUGqJxcOkC5g7GzeqKuG6YcW2e+5nCIFGfqGwocYR
         M/OiuaETUi/UXYlkHHHcg75K5U2eFr4nMxsNFg/kCJwVBHNPNirF677oHdCfLDiCSMK9
         mbclmeNuIjBiqFFlnLGhpGMHKuesFlJNVSS3qqeJ7FBDDeaqVw+QcnOSYmhBG/e485LD
         CPzVEm4Vt20UCfxT+N4zwg+r8vPbii853WCt7oIKRO+BCVGZ8C5OH7Ll3AO9FRTqM5Sb
         //F2ITiBJmJ/GCDcgl26Y10OI9r0/AAW42qCd7uBOGocqRUQ1mNGJFGb5fQsFcus5dOJ
         XlWQ==
X-Forwarded-Encrypted: i=1; AHgh+RpzU1ouWb5yE6p+WpitmoVsGN50BZrEMjoKjxFktr+wd+1R7qFjEKhf/VqUDiuPO2F2T9aaPT8CZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxjYAjmRL4JMPLDtSUzbqtPofmKC+2CPH9PDOGXGeG8UI2DxmUn
	fL6YR/ZSzyrH3CODkd4vSw8GKqoq7ZpoVRoauf2eel8230LAYCpA7nVC
X-Gm-Gg: AfdE7ckCCOZgspBVuVmH5At04XAWBn1i/oaPtbR5yfV/C+EiKlv7/N/BMob41tKlYpl
	5xq7QzLMX6rZeSjNiuL5BPhk78kB9RSLOyZM0VJRq20xAgTbeOUofw5zSyErRcngBJICru8Ff2C
	Q2LYYB1NOGfmaNgqOSCXkDVCos7vyC4e7pc0B7yKryUzZtoUde7LuhxC650aXKLKbr/msCjGJou
	Tt8sVtgKQaToI+hFl7j+WL6aOw5jT0LFPv4Rrgnfhuv/4YZ5VIQnV5miBE80vVGFQ12PfnqhyIR
	IllKo7lU1XAMW8a9dCZaKE3yo15nxXfzhrE9TnbjU6jB0oYKGRUFsfUf70T8CEuG3+iWqBqXYES
	AQVAvAMzjP5dJDCRyCNsXNLmaGhPqHUBmeyZFPjGzW83R6Z6vvlwodejmWhkxQk/6iEsK0ZXb4U
	UZXPG7C7pjfgIoM+UcnrI1Di8c92Jsy43h/Ewanxs7
X-Received: by 2002:a17:907:1c24:b0:c12:9a2b:4838 with SMTP id a640c23a62f3a-c15ce034468mr606117866b.26.1783704653049;
        Fri, 10 Jul 2026 10:30:53 -0700 (PDT)
Received: from fudgebox (k10193.upc-k.chello.nl. [62.108.10.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15dfda815dsm326168966b.36.2026.07.10.10.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 10:30:52 -0700 (PDT)
Date: Fri, 10 Jul 2026 19:30:50 +0200
From: "David C.C.M. Gall" <david.ccm.gall@googlemail.com>
To: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@linux.win>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org
Subject: [PATCH] crypto: pkcs7_verify: use constant-time comparison for
 digest and signature verification
Message-ID: <alEsSl8i1_FpoU0f@fudgebox>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Replace memcmp() with crypto_memneq() for cryptographic digest and
signature comparisons to prevent timing side-channel attacks.

crypto/asymmetric_keys/pkcs7_verify.c: PKCS#7 message digest comparison
during signature verification passes argument pkcs7 and attached
signatures to pkcs7_digest via pkcs7_verify_one. pkcs7_digest utilized
memcmp which could leak valid prefix length for attached signatures via
timing side-channel.

Assisted-by: gregkh_clanker_t1000
Signed-off-by: David C.C.M. Gall <david.ccm.gall@googlemail.com>
---
 crypto/asymmetric_keys/pkcs7_verify.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 474e2c1ae21b..28953e53177b 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -13,6 +13,7 @@
 #include <linux/asn1.h>
 #include <crypto/hash.h>
 #include <crypto/hash_info.h>
+#include <crypto/utils.h>
 #include <crypto/public_key.h>
 #include "pkcs7_parser.h"
 
@@ -93,8 +94,8 @@ static int pkcs7_digest(struct pkcs7_message *pkcs7,
 			goto error;
 		}
 
-		if (memcmp(sig->m, sinfo->msgdigest,
-			   sinfo->msgdigest_len) != 0) {
+		if (crypto_memneq(sig->m, sinfo->msgdigest,
+				  sinfo->msgdigest_len)) {
 			pr_warn("Sig %u: Message digest doesn't match\n",
 				sinfo->index);
 			ret = -EKEYREJECTED;
-- 
2.43.0

