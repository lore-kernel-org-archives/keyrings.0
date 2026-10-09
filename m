Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C25D470E96
	for <keyrings@vger.kernel.org>; Fri,  9 Oct 2026 10:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541163; cv=none; b=UjbBMoRPIkDF0T1sTbbwA7SWMvJSjILdZ5ltdSg7wq6lQuKGphzg164WM61we5GuFrbloWlJ1WArchkzZWLL7KEASfzICQacgcMbO3Ljs5JVcpCCunHQ3ihHUzVgtnvu5XNKJ4tDflRtI0KFnL8Fj9nHbFdcWJmYL68RUDqgiGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541163; c=relaxed/simple;
	bh=8cixHCL/2G57Wkvwabe/1EbioTWhZ4LSnUxA9fXVA8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHePyrcGNEDYC2publObGErJvmlQgS0HSZKy15z5ZufDWnmN6XLjZinMJ+tpldvEQh+aziZU3s+KZG7TdCKQu6c/8CmaAspHT0eR1CW7tm6HMBCoagIvBYLxhiBeiv1RMDTxXPgDUMNK1ys/cblI2LquQIrwFQzwtobEwgaeg/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=egicon.com; spf=pass smtp.mailfrom=egicon.com; dkim=pass (2048-bit key) header.d=egicon.com header.i=@egicon.com header.b=gcRZOpTZ; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=egicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=egicon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=egicon.com header.i=@egicon.com header.b="gcRZOpTZ"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49d0da752ffso56816845e9.3
        for <keyrings@vger.kernel.org>; Fri, 09 Oct 2026 03:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=egicon.com; s=google; t=1791541160; x=1792145960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DyGMCGtg5FlToMVE2JvbolYvVP9QNvtBAQgSJYZkupU=;
        b=gcRZOpTZQRnq7KftafRspcKUcpIE7d1urCKBPfBg6us2NE2ho640JeccDJuog7NYfw
         52zhsKEl5v+YKRJSy4c3oAJG6ADtfruoGyaxbpJIgc5/soLq1Xn7NHDtfjBhCpsIErJO
         mdxbuS4uZJPx4qajHRXCtbvWxRqIf5HRFReL9G8ZD8Ae8xuNooAwcRG2absuzxT8jTm9
         3PTJZtILvsNTCqJNOFrh1RzP79JGyTExTX8/GXGF9erHve8S2jNiSo1NJeuFA2OXeUna
         6FReyAqFf9L8U27BNCTmO9PxX6JGjat0pMveoHjYWlkIlvXnyIzJbMA1nMDUDd9Q8pG3
         G/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791541160; x=1792145960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=DyGMCGtg5FlToMVE2JvbolYvVP9QNvtBAQgSJYZkupU=;
        b=hKNZrG9HaYxka7FDZlruIwO3WygcHS3L0wEhScjTbAoVeidPz6REqJN+pkIfqg/40v
         3QtpdMcGkhoMziHLnfdSs3ZF0DRMDTkZuVUZgULNCgINHfyhDVpGfDgObWoTBbPsn/92
         PdZXnFCT4zmTf4aqMvpMjJ1cZemPoAwODG+ksfFX7a+wQKGaL+DcEZvE0pBp9vK6HvdF
         w4IgvTP/rmQMH1YCHvxRibxnxdvVaKMMsN7sXsQ3jpzL/L3Ug4/r81suVjBH0P7qrgmK
         Xy9nv6NW/jGh3aMQonV9ioFXwcBtp4nl7of+baATD/vhtgKHgTC3/WJr0s9yJ8181NBq
         RksQ==
X-Gm-Message-State: AFuF++moZcp7m0MbaDnyYTxkq91JRChALwf9u9euB62yIVbLBfTcb2C2
	0wxZ14YoLuvVFlyqBel1pbP8cyF2Of48vinD0G58tPQXZAd4xuJPNgCQ2tsXxcffHSoPYwG3n3q
	imXA=
X-Gm-Gg: AYBFou3MudR3rwLgblzHQar0fhOYUslWu9CNcEnPgCSEIlw9TzM4vE720JWpfkznxLZ
	j4vJncEXjZL+thO6vZTYCoDXM2HiKmu1dlpxqdXTwYMSt97yMQ69ukW2OyT/2wzWWRUkwFnZaBF
	3FnXd0mwdh8O4TwBWUMCdtHJ0jW0tB8o7Wk0O073YbBWsPVKkb1BfP+9Snojf4aFZ/Xrm5HiLiD
	sDDkDFxc3z1MWUAKSEo7wDbtFP/1I/nYhVDZD2bFmbuK1sjypBKCkaMlYUmhjPJJFdQcx/zl1QV
	Mi23wRnFerYNUuTrXUgTbQjvlq25VRVqJ8cjPGotuufJr/3JSD5MaEDO1Qhcwu27+uq8lmXNNrz
	V8ZgeyOApZQ9vKAI/DFrlfBhhd+v093GJasolgPuW3hbsttP218QuUWQUfncv/b1hGPIHecmo/l
	boerYKgZC40U7Sr+T257J37dtZS+5tef8As2zqMpoIw4BPAnNwb/jDwCa37gEE8TYhnEvdALgIy
	IhSySQ3zB8RsYeulGg6uj3SvMpXSumQMelqITvWIARydoY+D77n3y5tuCtPz7jOvw==
X-Received: by 2002:a05:600c:19ca:b0:49d:10d6:fd55 with SMTP id 5b1f17b1804b1-4a18e4487b5mr26368395e9.1.1791541160293;
        Fri, 09 Oct 2026 03:19:20 -0700 (PDT)
Received: from xpsmax.egicon.com ([37.179.95.159])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9acf12bsm3189363f8f.46.2026.10.09.03.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:19:20 -0700 (PDT)
From: Massimiliano Marretta <massimiliano.marretta@egicon.com>
To: David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>
Cc: keyrings@vger.kernel.org,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Massimiliano Marretta <massimiliano.marretta@egicon.com>
Subject: [PATCH 2/2] kbuild: sign modules in bulk when the signing key is on PKCS#11
Date: Fri,  9 Oct 2026 12:19:15 +0200
Message-ID: <20261009101915.495734-3-massimiliano.marretta@egicon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009101915.495734-1-massimiliano.marretta@egicon.com>
References: <20261009101915.495734-1-massimiliano.marretta@egicon.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_MODULE_SIG_KEY contains a PKCS#11 URI, each module is
currently signed by a separate invocation of scripts/sign-file.
This is inefficient because every invocation pays the fixed cost
of initializing the PKCS#11 token, verifying the PIN and setting
up the session, which can take tens of seconds per module.

Use the newly added '-b' option of scripts/sign-file to sign all
modules in a single invocation when the signing key is provided
as a PKCS#11 URI. Modules are installed first, then signed in
bulk in a dedicated target that runs before depmod.

When the signing key is a PEM file, the classic per-module signing
path is kept unchanged, since the bulk mode provides no benefit
in that case.

Measured on a build with 50 modules and the key stored on a
SmartCard-HSM:
  - before: ~24 minutes
  - after:  ~3 min 17 s

Signed-off-by: Massimiliano Marretta <massimiliano.marretta@egicon.com>
---
 scripts/Makefile.modinst | 43 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 9ba45e5b32b1..e7894d195e7d 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -101,34 +101,63 @@ endif
 #
 ifeq ($(filter pkcs11:%, $(CONFIG_MODULE_SIG_KEY)),)
 sig-key := $(if $(wildcard $(CONFIG_MODULE_SIG_KEY)),,$(objtree)/)$(CONFIG_MODULE_SIG_KEY)
+sign-bulk :=
 else
 sig-key := $(CONFIG_MODULE_SIG_KEY)
+# Signing via a PKCS#11 URI is much faster in bulk mode, as the
+# per-invocation initialization cost of the token is high.
+sign-bulk := 1
 endif
+
 quiet_cmd_sign = SIGN    $@
       cmd_sign = $(objtree)/scripts/sign-file $(CONFIG_MODULE_SIG_HASH) "$(sig-key)" $(objtree)/certs/signing_key.x509 $@ \
                  $(if $(KBUILD_EXTMOD),|| true)
 
+quiet_cmd_bulk_sign = BULK SIGN
+      cmd_bulk_sign = $(objtree)/scripts/sign-file -b $(CONFIG_MODULE_SIG_HASH) "$(sig-key)" $(objtree)/certs/signing_key.x509 $(modules) \
+                     $(if $(KBUILD_EXTMOD),|| true)
+
 ifeq ($(sign-only),)
 
 # During modules_install, modules are signed only when CONFIG_MODULE_SIG_ALL=y.
 ifndef CONFIG_MODULE_SIG_ALL
 quiet_cmd_sign :=
       cmd_sign := :
+quiet_cmd_bulk_sign :=
+      cmd_bulk_sign := :
 endif
 
 # Create necessary directories
 $(foreach dir, $(sort $(dir $(install-y))), $(shell mkdir -p $(dir)))
 
+ifeq ($(sign-bulk),)
+
 $(dst)/%.ko: %.ko FORCE
 	$(call cmd,install)
 	$(call cmd,strip)
 	$(call cmd,sign)
 
+else
+
+$(dst)/%.ko: %.ko FORCE
+	$(call cmd,install)
+	$(call cmd,strip)
+
+PHONY += bulk-sign-modules
+bulk-sign-modules: $(install-y)
+	$(call cmd,bulk_sign)
+
+__modinst: bulk-sign-modules
+
+BULK_SIGN_DEP := bulk-sign-modules
+
+endif
+
 ifdef CONFIG_MODULES
 __modinst: depmod
 
 PHONY += depmod
-depmod: $(install-y)
+depmod: $(install-y) $(BULK_SIGN_DEP)
 	$(call cmd,depmod)
 
 quiet_cmd_depmod = DEPMOD  $(MODLIB)
@@ -137,9 +166,21 @@ endif
 
 else
 
+ifeq ($(sign-bulk),)
+
 $(dst)/%.ko: FORCE
 	$(call cmd,sign)
 
+else
+
+PHONY += bulk-sign-modules
+bulk-sign-modules: $(install-y)
+	$(call cmd,bulk_sign)
+
+__modinst: bulk-sign-modules
+
+endif
+
 endif
 
 #
-- 
2.43.0

