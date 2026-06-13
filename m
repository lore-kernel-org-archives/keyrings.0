Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11853E638C
	for <keyrings@vger.kernel.org>; Sat, 13 Jun 2026 13:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781355870; cv=none; b=vE4Lcf0WiQ8QRvDS/OfFe7FX8f/Uqpw+LbCKk7/fPs8sxZks8BToNpsBGb033wlKK3WqAVB4TWBk2kUtstltN69ScTxorImKKlBf9OLKxbicqu86pMVzK5psYzr4RWMdhNodeGicD9CKa6j9wPJUw1f9fI1XMiURVwLhQsAyFXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781355870; c=relaxed/simple;
	bh=8rdVy967/KIekFumWZJodjNYinOgWN/JZjf+3u7FmjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbZk62DmUIJKbClZDBfDZZ9FAjiXnSJc4oXf7Xu69ldjfHLLdhJfjf5dLBpBj8/vemDbWAggd3vzaA7+i0tHKui2ZR8kACeSyICulbMBg1wl7lTKHKk3ZibefXcQOuhHyAJ3kEEz8TaZNut02tTJRmS03U0CK3sO5TJFPJRQ0eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n8ID2Prw; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n8ID2Prw"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490be03d47bso18676875e9.0
        for <keyrings@vger.kernel.org>; Sat, 13 Jun 2026 06:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781355868; x=1781960668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MNHff3ZA1wnEWNCHL45Ie5KO3LOfvKjTR8zIU+k8sA0=;
        b=n8ID2PrwDMHD33lC0HfluqTgB3sNLcduK66hgkPgk4lz3G1OV3utNhHABA4/xzHoNg
         /Eju2lWceIX5YLnpV2IcDjvw0zlEFSUu8LLick6NRa2htEDsdTTREC/j1PsNGr87Cfu9
         JjBoskdoWPdv6jcu2TSMHmDHd0eLCzCqgX5drNOWuD3CgZRjDF0FsJQT7cAmv8nIsIDU
         6KHCDGrPry4mXvXlUKtp9bsXE7JTDSQjSeg5Y3jSasWoKwuRvt+JiXIihqFrNkmG9M/K
         mzBgeE0sBFZI5FXrA/v/s5urL3BOjqXlZ8Uqh2maEBPIpZbC7qt4rGEr/0d2DtaijB0Q
         mvIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781355868; x=1781960668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MNHff3ZA1wnEWNCHL45Ie5KO3LOfvKjTR8zIU+k8sA0=;
        b=qbaSBZqihXw6ZciPIgKlcuy4A19a6eYoYh7L7+PPZ1Eqk8bj69dJQBg7e4hB5XGy9w
         J3nhh6XwTtTeIi4duSANSq8r2xxlzxsJzJKqNfbawecUfcpJ8seZUlEOb1fukfxWMW4h
         Bni12bKsIzlaxlp0XnotOyd5U00nle8tmcINSHnWJAb90Ge0EkyCG33u/HkZBd8bYUnE
         YwSi1MgwtRbhaMAiQ8httcrQrkBeCnSPe5HDNgUtL8ucFEnKotopuOP4caN/XZPXw0dB
         rzzPHJTVuaL4cGxGnudmzs1xC/i+FTKCnytdZef7z2ntATASwUlp4Q9bMD2xSQOmNpfP
         NAIA==
X-Forwarded-Encrypted: i=1; AFNElJ9teTO+NpZ/qPTgW7o4GbB+0cL01LYj4dwb/g6dIfaoh/Tr1B0/j291eUPhfXpPf0R1+y6KceuTlA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwYl4Vu5uY3KfMNtL/EbAJSQkeGaliM3q8ewfUz+pBx4apvrUtp
	m4ap0bU7vRdHZoZTNEE4Q57vTlxw6YgLvLCZmuPkz+w8CGVMpBGh1vo=
X-Gm-Gg: Acq92OEG1uTH0jDe50pDqKtbh1byI9rtCkj/QMtMVzxi+aPT+1OKqhUAqw+PYg2Snxa
	ZrFLDptzIz6CmvKmxS5zJCA7oZtcEwdkWFoN7V4RwxAyuSmoEYEGCZpADOQzEfmTt14QMvS8dsk
	6ikhMDxWIUHgw1sx5WkgYf5J4SNHkTTm1hz5zbrOp0H/yd2+TOgTDgAC/rnYOcIAYlbYxuxGO1c
	zNlABg/gHs6Qxa7O8WeAQ4mMVibuRv1jrtx6eu9KaoVbs+5Rz2AERBjr6NxOudE2kmPv17HoYPl
	DDYTPvqo62GUXjqAxFJ/72bxaiHpiBGiEo2cBrXv86khfCk98jTh/US8rkzKSGnzrfQL5bITIdU
	V/UQAhTzcwny746/3ighXNTnITMkZDRWdb7baKyJjashd4lm0y5C+NCXif0lFrKoEdLNvaXrNND
	MM+PxPcpsjDiIMFHX8tCPJBNEScc3g4A6BA9V7xG5uiNukqR3sEOggMxHV8iOq16UgBeTT6LoTq
	SM9IAebDXjHLGN6x3LdlaRcXVDL/A==
X-Received: by 2002:a05:600d:8489:20b0:490:b724:507d with SMTP id 5b1f17b1804b1-490ec4cec11mr64189855e9.11.1781355867847;
        Sat, 13 Jun 2026 06:04:27 -0700 (PDT)
Received: from hp-ubuntu.. ([41.140.217.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492203c0801sm66259515e9.10.2026.06.13.06.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 06:04:27 -0700 (PDT)
From: Mohammed EL Kadiri <med08elkadiri@gmail.com>
To: jarkko@kernel.org,
	dhowells@redhat.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	kees@kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Mohammed EL Kadiri <med08elkadiri@gmail.com>
Subject: [PATCH 1/2] keys: request_key: replace BUG with return -EINVAL
Date: Sat, 13 Jun 2026 14:04:07 +0100
Message-ID: <20260613130408.13709-2-med08elkadiri@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260613130408.13709-1-med08elkadiri@gmail.com>
References: <20260613130408.13709-1-med08elkadiri@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace BUG() in construct_get_dest_keyring() default case
with return -EINVAL to handle the unimplemented group keyring
destination gracefully.

Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
---
 security/keys/request_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index a7673ad86d18..fa2bb9f2f538 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -332,7 +332,7 @@ static int construct_get_dest_keyring(struct key **_dest_keyring)
 
 		case KEY_REQKEY_DEFL_GROUP_KEYRING:
 		default:
-			BUG();
+			return -EINVAL;
 		}
 
 		/*
-- 
2.43.0

