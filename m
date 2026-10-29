Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793306009;
	b=mS7+ku9p15Zt+dHmrGkWddtFif2FqpCWkf+TAyPSIJqU21hlX9/ES/Qi+ARCX67bOBdJ
	 2fkmqGUImC4TUjFZtnxtY+CA7NiYy80S2uta39jF9vThCptF6V9pC5TJbgGvWPPaGvLLS
	 CKT1BaXhPNku2wuuUYzHlOE/he895SV5Sus3pneOR3xAtLhTUGAcbBpNpWvYszZKlHGP7
	 OPCgzJe/Dl8R/OU1qS61zdWoscPXIkmc+vBWh/Wl/oRULjITlCRLlQECfLNbhlZQ+1YGD
	 pephNRRplJDIyhr7i9pEiojdG3NlOXCkCtisAl8do9lFHrmrmm++3O7Gsx6jYEvirtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=1FwGxH5RamrY2sgTjs3EG6aOjMo9Ydi6StxHkJqw4Uo=;
	b=jSzusAtdxqgiqa5Emv2Cv38e0/9XFYjYKdk8hi2taqV+G5Ylut93qx2PdChRF/bt2kEF
	 XWyHyXA234DO4M5ejlUo7LICDvDXno5+73PVt7OtRsy16tQ17MfvhZ1nJ0PSo+59TuBFP
	 cMv5xC3tnkTXvxXRRvXO7t/89D7BoX/HsyFe4A7I5hJP7GoNxOS9zzyh+lq9usrHSfpou
	 dIcEN/+m7y+16Zwz8h5o+XDPrKWvhQsfB2Sczo+20/I+aev6qwXu7J47mRUS4muvCef7o
	 VJ5nCiVrVkoMAZqMT2ADPWHDK8j2FTRo5uiixDJiuJLA8M2P2TmZ5hZzgOR8Nd649Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jzUC4j+m;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ADF606A337
	for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 20:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60ADF606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jzUC4j+m
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-6d290b10a35so1268054eaf.2
        for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1793306008; x=1793910808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1FwGxH5RamrY2sgTjs3EG6aOjMo9Ydi6StxHkJqw4Uo=;
        b=jzUC4j+m5k1GWzE4M+MP1+7CZ24I8OTXJlA+L47TEmbE8YmDlulAMxTxxOUwWkdRHH
         ZA7UWCWY4UP0IpGp1AHTAIZ3biCBCS3Tm/hc1d7JYAYzBEUgymxOLRamDSR52NWY6yTV
         Nj/CqyTphrQl74nCEr4jlN0A5maoCINl7zvMB7W8X8TZfTkAJvS2G8HM3Jp5HF69ixuK
         k8K6KaBp15/F8ksjNkcHk9DTAxy2LvSV5923Kd0H2P6TbZ8q5agmTrdcmkY94F1z8Riv
         XkPjRnV7/c156Gl2EZ27Xh6M+m8MNab0eP3uNFZbUkpddrNb2ItyVbJgXuN7mAV+JTBo
         PHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793306008; x=1793910808;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1FwGxH5RamrY2sgTjs3EG6aOjMo9Ydi6StxHkJqw4Uo=;
        b=k15D1sF1w8ixqQ4IAokAtyqIH/rJahPgdcxLioul+Be8mcBzajgtHNwwXFpRn9aEET
         eLXEzDWEM9rxgjEXHAIMJb7yfZi1ZlejJEizr8ZOp8AFDjb8ak1QJIfGZbIyC3C42W1a
         aqiONLtLJ5y2uZeYVpbV83BHiL9pV04NB7Kp7s//1OwPEptwV0al7jqR3fkIBMI7v5vH
         3tnvzpA6u1d+/nwjOcxKfO2qoq/5OeCdJ2aHNaPF8bQKovJkOf0S3pQRrg/HKVYaOzN4
         OsOsjQZd3szHTqcDhTM9HmqrQcCHCSRCMK379liUdnHb9w3MLSA5tkgyqgCHuNA0yVbd
         jqVw==
X-Forwarded-Encrypted: i=1; AKwUvBy49spBYFqKvJ1mELePNzi0ekF8qxgf7dUeRCOKo6Cq3Q4xGSInlP2MIIVmVA2S9orq2mQsSGOjcA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKCJrz1WPRAQOLHzNBMfg22KGCGI0vxirXi6P3oQhuyaNw6/vUQ
	/WoHB7JwPdkx00riyrIbh9xu6lONleAYXlMYfbuPrJuo3TgbkoVO2QmCWeNmFQ8sDyS2
X-Gm-Gg: AYBFou0Cj2vkV5/baBA021f6tW96Vm2ZRVMLoFJ8VOXQ2yr4PguoBaULgOCAzWgueFE
	T1qOL+8GaZ2HOxvCTgwBuywrV75FAy83Yd/yzr6zSEC5907dPYAZ1O11tQfGHugcvxt7qVgnEl5
	MJ9JzE3/SJIOamx0plzcg2vvH7Mgu00Q+xZ/p8bC5dllcY/zZ876MbVmcY+bUCAyiPXGUX8GUeq
	lL7iIPR/fX4BE8lNktPm/yon3xiRf9soorC7RHboiBuoRBBzC49z6a4V8vAFgbzJWmAho8t+Fe9
	+Xlv+uUpHvGcPnUZtJ924Poqv2vv7l316y29P2fxZjpqabRkMJb1QtwqmVJlIeJI6bfrnwHP3A7
	mVra0AmKVn8MaWPcIweJLooWKhC1ScBcM0U/eXpacHYX2BdZK9MHDofeOK9Kz+VuAmfuEoG6yZL
	5ODWBIxkki6rWZKe2okSmvAI286V1bnLqAHDBk1CB1Povc2hLquXzIQcnES6osmQr/cwOwCD4l4
	ionaSfzEaukYweZLyGmBglm5YkWiKdmncQMt1LuZTAiWP2X7oK9Kx7lpPhC9xTtyCZzaWGz34K5
	iyxv2DKXgpOHAJwDJIeyGnH+
X-Received: by 2002:a05:6820:240b:b0:6dd:25a3:94dd with SMTP id 006d021491bc7-714f29beb56mr224819eaf.41.1793306008134;
        Thu, 29 Oct 2026 13:33:28 -0700 (PDT)
Received: from toolbx ([2600:6c8e:af00:4c:73ea:df46:8ccd:ac9f])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-714f2ce7c9csm260964eaf.5.2026.10.29.13.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 13:33:27 -0700 (PDT)
Date: Thu, 29 Oct 2026 15:33:25 -0500
From: Andrew Halaney <andrew@amutable.com>
To: manuelh@nvidia.com
Cc: Fan Wu <wufan@kernel.org>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Christian Brauner <brauner@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Luca Boccassi <luca.boccassi@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org
Subject: Re: [PATCH v2 1/3] ipe: add the .ipe policy keyring
Message-ID: <auOn9CzT_gku-5cH@toolbx>
References: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com>
 <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>

On Thu, Oct 29, 2026 at 12:30:38AM +0000, Manuel Huber via B4 Relay wrote:
> From: Manuel Huber <manuelh@nvidia.com>
> 
> Add a dedicated .ipe keyring for IPE policy signature verification.
> With this, userspace can provision its own keys into the keyring,
> then restrict it and activate it for IPE policy signature verification.
> 
> Gate creation of the keyring behind a new by-default disabled
> CONFIG_SECURITY_IPE_KEYRING Kconfig option. When created, the keyring
> is empty and writable. The keyring is used as a fallback after the
> existing policy trust sources only when it is created, non-empty, and
> restricted with restrict_link_reject.
> 
> This enables scenarios in which a trusted userspace component generates
> an IPE policy, and creates an ephemeral policy-signing key pair,
> provisions its public certificate, and restricts the IPE keyring during
> the early lifetime of a system. The trusted component can then sign the
> IPE policy, destroy the private key, and load and activate the policy.
> During that phase, the system is considered in a trusted state whereas
> the system transitions into a possibly untrusted state afterwards,
> running arbitrary user-provided applications. In such a scenario, the
> trusted userspace component could reside on a dm-verity protected
> rootfs disk, and applications would reside on additional dm-verity
> protected disks. The latter disks would be dynamically attached and
> their dm-verity root hashes and/or signatures not known a priori to
> launching the system.

Not trying to muddy the water here, but I stared / thought about this
a while and wonder if I'm missing something below...

With this Kconfig approach, aren't we now saying "if you want to use IPE,
and you want to ever use this feature, you need to make sure you seal that
keyring or else someone can replace the IPE policy!"? That seems rather
easy to foobar, and means to me at most kernels (i.e. distros) won't have
this enabled which limits how easy this is to use. I know Fan wanted this
behind some Kconfig to make it controlled by build time, but does it make
sense to keep the command line option as well to really make this opt-in
for users who have it enabled at build time? Otherwise you really are gonna
have to craft a special kernel in my mind.

Likewise, but more nitpicky, I'm not sure the restrict_link_reject
requirement buys much over the chain restriction. restrict_link_reject
stops new keys being added, but pkcs7_validate_trust() walks certs
embedded in the signature, so whoever holds the private key of any cert
in .ipe can sign a new leaf, embed it, and have a policy accepted anyway
I believe. Under both restrictions that basically means "holders of an
enrolled private key and whoever they delegate to". If the concern is a
restriction like key_or_keyring:<id> pointing at a writable keyring,
that seems like a provisioner bug rather than a reason to rule out the
chain restriction. Am I missing another reason for the stricter check?
I do realize this is rather pedantic in argument and doesn't have a place
in the use case described, but I'm wondering if a future use case will
want such a thing.

Thanks,
Andrew

