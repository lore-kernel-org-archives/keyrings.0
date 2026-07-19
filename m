Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD442D8767
	for <keyrings@vger.kernel.org>; Sun, 19 Jul 2026 16:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784480000; cv=none; b=IJNlY6izfhzMYEM2vSRuWvtJZ+2/nt1A6nZ6jWzjPeq0esJn9qpHqFoRT10XkhZfA363s4+wtcc0bKlvW++7fMTzEntG245FYKrJNYJSG/Tphzv1lZKGTu5nh7a1pUA9DM4WmpI1XSy24ktonVBoJNKu70FXtZUuw5dahe151b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784480000; c=relaxed/simple;
	bh=Z5GzkoAz0nGDfRtrY1Cn2rqvYSCd7wMbPvCYLzE8iU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WyHV4pcGGpVdqGb11ShYO9ItfRh2ijMsTT+rK5LEdMgJNY4/vKn9hgSW+92EOVqx5yrwWH4SJTCljoLlp1JIwfoz95rMS8u89gHDODz8jHp4EIef+6fA79T+A7ybbQDwDl7pF4kFcdMxeyLMouiViSgh7W7Fysy2EeOT+/cF3Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at; spf=pass smtp.mailfrom=sigma-star.at; dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b=V72NGd7z; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sigma-star.at
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sigma-star.at header.i=@sigma-star.at header.b="V72NGd7z"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-47f785467faso51477f8f.2
        for <keyrings@vger.kernel.org>; Sun, 19 Jul 2026 09:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1784479995; x=1785084795; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2cfOrYYvQsZ9Hw2NXoKQcyg+nWVJU2ZR97R73jIRalI=;
        b=V72NGd7zoOJLLON6tK2vtvVRWC9X9aMRiCZz37wghSGzhyQXKsTOzgSntrALDPsnwc
         x05be6k1JtNm/Ez8T2cXaydmkjevbo4uFz301Cp0mSv6PQueOxVZ5gCCU3lF4LfQa5qj
         X8vR0uXXPV3cVWALuvwtZDjUN9uV02DNqYQloxAGQkZaPj53eKBKxLRtB8jl9/gReDqD
         tTkWH6EAUXIyrjpDeYNfUo3WuO1nzsZEdxwjpP9EbUKxiGS9jxBbypBTLzH7i2rf1VNU
         gJO4SjvojPecpoKML4N67mBHjSybtOUPLCLVQSYD2916T5Dk1HXQGVHVAX25TkOuCGiS
         C/ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784479995; x=1785084795;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2cfOrYYvQsZ9Hw2NXoKQcyg+nWVJU2ZR97R73jIRalI=;
        b=LjciW3Y8jELrwVZ15ehVZwYB3vld5AHk8af8bdK4aaZ3BRqpd1KTrCK1QFhMu2ducX
         6hKryEThQLOxryd5EzLsgR4ek/mgxaOz+3UhkiDVDEoLi44MtPcDe29dpJGOvV6YY55x
         DAvNDUILMCmBFBp7WmVnc7YE5S7/eVxsrRKeZAoamB/HanVaZJtMdsgj6K4pYrR86fXy
         VMy6wbGm5MaacnBu+BnNLpEj9K22M5ae4yA2jOshAMt1FHBYoT+1z09vxeE+ZpinIDZL
         ywEwrbOBaLDrrdn4eAahojrrn92JdLc7ahHbYhLh4509Eq/39zP9nPxxAhmJ8NscOIZ8
         wpZg==
X-Gm-Message-State: AOJu0YwjM4EmtjgCx0rqy4w9WumDEBm5T0oOgOIB9Qam5s7FAlKe+eK3
	+2qO9JV0lUPnLbQDLy/uaAsxJG46PehQJ4dQN5KSbx0ytEvv9dzHtwmEhChyG3cjKHjUuStRmI+
	tIUi+
X-Gm-Gg: AfdE7cmW+APayxv/DeXDJrwvO7BU4tiuzdDI8oUbMPlLD/lWXI67Ixk7wtf8mLlmjaJ
	UMcLlZECp0VpIFryRvWuX1QcGi9CqUg9ah44UOBe4EkOXYXTUSrTattKHzkF9Kt1TJBvEJ2wCRc
	IyFEE1Yzf2KsAqbEsXZ5yJIX+/l7/mBT2JRhahlbQ/YUZd5TRCQ0j74xWT3llj9Qb6FAuy55kUB
	g9DfkFlS8dztGQ5CFP9uYTBe+mXoTmMSEZMG6bHgr3xUP42Vd0nIGGaE1cRQe9MN/O/tXFd7AkQ
	LHIeIIQBFMprmQGEDUP97jX8M1tmZ+N7D9nKc0Z4ZJ/n2VHd/99GhrQRWIeUV8e+tp//+NT/AoC
	V8b65y8uGlX39CNHyBlmUMKB84J0PAUiqB4DviAfrTalNUTGWWhUnr/Mka1SHstJWXA4wRaJ+DX
	kycRtA7Tr35PMjsW9PO20SUDIpj7GEGh5dnGgMFTAcnZY=
X-Received: by 2002:a05:6000:2c02:b0:47f:757e:fa88 with SMTP id ffacd0b85a97d-47f757efc0amr2291842f8f.30.1784479995546;
        Sun, 19 Jul 2026 09:53:15 -0700 (PDT)
Received: from somecomputer (85-127-105-26.dsl.dynamic.surfer.at. [85.127.105.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f63ee0086sm24150457f8f.30.2026.07.19.09.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 09:53:15 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
 upstream@sigma-star.at
Cc: Fabrice Derepas <fabrice.derepas@canonical.com>, david@sigma-star.at,
 upstream+dcp@sigma-star.at, jarkko@kernel.org, zohar@linux.ibm.com,
 dhowells@redhat.com, Fabrice Derepas <fabrice.derepas@canonical.com>
Subject:
 Re: [PATCH v2] KEYS: trusted: dcp: fix key_len validation and calc_blob_len()
 return type
Date: Sun, 19 Jul 2026 18:53:14 +0200
Message-ID: <3761945.KsABhTYbVQ@nailgun>
In-Reply-To: <20260719163939.3624767-1-fabrice.derepas@canonical.com>
References:
 <alv7LVoTQJOMyk2J@kernel.org>
 <20260719163939.3624767-1-fabrice.derepas@canonical.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Sonntag, 19. Juli 2026 18:39 'Fabrice Derepas' via upstream wrote:
> Two correctness and type-hygiene issues exist in the DCP trusted keys
> implementation.
>=20
> First, trusted_dcp_unseal() reads p->key_len from a user-supplied blob
> without checking if it exceeds MAX_KEY_SIZE.  If a crafted blob provides
> a payload_len larger than 128, the subsequent do_aead_crypto() call
> writes past the end of the p->key array into the adjacent p->blob
> buffer within the same struct trusted_key_payload -- the caller's own
> input, not unrelated kernel memory.  While not exploitable, this
> violates strict array bounds and triggers static analyzers.  Fix this by =
adding a validation check against
> MIN_KEY_SIZE and MAX_KEY_SIZE immediately after reading the length,
> matching the checks already done in trusted_core.c.
>=20
> Second, calc_blob_len() calculates a sum in size_t that truncates to
> unsigned int on 64-bit platforms.  Because the DCP hardware is only
> present on 32-bit i.MX SoC platforms, size_t and unsigned int are
> functionally equivalent in production, making this truncation harmless in
> practice.  Nevertheless, updating the return type to size_t (and
> subsequently updating 'blen' in the seal/unseal paths) resolves
> type-narrowing warnings and improves overall code hygiene.
>=20
> Fixes: 2e8a0f40a39c ("KEYS: trusted: Introduce NXP DCP-backed trusted key=
s")
> Signed-off-by: Fabrice Derepas <fabrice.derepas@canonical.com>

Reviewed-by: Richard Weinberger <richard@nod.at>

Thanks,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y


