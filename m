Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795256338;
	b=mFO3FXUKPw4y/QoR2wFvY8jTQ0ff+f9gba+04qjFG4FNRGI/8/GpzU5Z85AJqdm3GR6X
	 hPT3ybGHiVAk+SrUNpc+oNGAQo1W1vVByP55PKB8zCdGUk5cdK4kBjXVBQQDDL/D9QKrO
	 B885eOgAI+w0O3/ZFtyT5nk7uafm8CC+OaYpETzkzly5YTSCnfUjVpua2ykjE91KcmF7+
	 4iWVg1nJpfr7rgMprBomg3Fth/Bb+D60sLIGLJq/Dk+zOqOUyma7A8ODMYPqPUQEchIUL
	 1pLl9nmHeUMlxMvu85DjIIIpWqL4OeuJsgoF8bFzaOH4PrZuiCNioTLC+E1cMQqB9rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795256338;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=dzaf2Z9uO/Z26dmJHQt/rzIG6OfXFllTIg41OzeeRLo=;
	b=HxQk/79gq0Cn1JDptFYSGPyJzcN+7qOTRhiI3sVIXJuh4rjFIcqHHtmVWA7hSDpPVB2j
	 UuUzkEmomebtI57nD3pm+lVMBPKOKbock4WR4LexjtQGruy7/XXvjTCQs+uBVtkoasSKR
	 rGG5LwwpvaHJOFnzm00Ml6frBDQdsnNmjV3P3ajnaSzBXJU9VyIzTns8d+SFM+sluf8lw
	 S3K/vGkJtcDDK8oIH7wvMziVhOSC87A/4Tz5nH5sntsUucr2XS2xCkEQK2dNQE+y8mcR6
	 BCczEao9TvrFdW25iFwUuv0f/9a9B6O5eZdQLCO1rHH1CydtZMfxnwdOjOJngh3DxaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I7SAFHvG;
	arc=none smtp.remote-ip=209.85.210.172
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B8C606A325
	for <keyrings@vger.kernel.org>; Sat, 21 Nov 2026 10:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3B8C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I7SAFHvG
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so876986b3a.2
        for <keyrings@vger.kernel.org>; Sat, 21 Nov 2026 02:18:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795256337; x=1795861137; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dzaf2Z9uO/Z26dmJHQt/rzIG6OfXFllTIg41OzeeRLo=;
        b=I7SAFHvGEVCBm0J5+m2y3jr0xvZhrbLgb4JRfF5d3AbR4l4CiID2rJ89wQRPDk+qLQ
         sbfn/BHHtEHxluv7Oiy01POHFJHNfub1xMCy9gqy3cNW/p1yHeeamx02bImhk9EmdlfP
         mYolBA5Z2JOA++5xz640eA6IYLpaP8IGf98w8WCs7s/ZVI4NYEksZ5A+/mtSZURniLIW
         2qHV+msb0HIo0O0wLdQ6Fc0l2XHKnWptHD+bIzDbTheHAyVUpe/vopLup81FlXNrQ/Hc
         9YbijY8H8HakzFA+TxSKVEhce6qnA6g3cymuYVuyN8kataqFn7drgaB7aX4LYWoe9QBd
         qpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795256337; x=1795861137;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dzaf2Z9uO/Z26dmJHQt/rzIG6OfXFllTIg41OzeeRLo=;
        b=C3UbDDK8p9NckKz4fqa+DJio4u624NqDTzv1tMnkhLP/PSpARR+8aUbAtP7Dx6KYVJ
         +hW4B3FufghPrM2y5WCuIG3LsvAKIWPuAje+K1u2/t0Jl7PJziOqtCbptCQRwSYrLa4F
         XlCES3guORoUtSvPGOjMxbDocvj9kMkfMK55qp2hqYsATgyTAZEkID1lf2FS02YelFky
         gGKHrofiVqnHvifk3vOTULjOKnO5y2roBb+PSVWD3YfJqZ1Y2oeCZ9Gy9i7Uvk9RzjMZ
         qk3S1DAmaKDLrWy+JEuepJKO1nXGnr0AvQ+hsrdHYk74xHdmN5zvEdPopl+yQeOkysVa
         U9Ug==
X-Forwarded-Encrypted: i=1; AL+hErHDkzg3Kxh63OTrAV9Q0V4ktBsQoqdMiiHIGbA/hLEbS0pkqOpoDan5TCRgnYuKidJGaQTkniGIpA==@vger.kernel.org
X-Gm-Message-State: APuU4Z95J7EaRnw5VdnCBcTQb0n7XazuIF2i6+tr9ZxAj+ooMYIg07It
	sKJz7fk9xSDwsh1qCAafPCiWSR6LWVkb/MWbV5kMH034bezpGKQFKcGp
X-Gm-Gg: AZFdTZdJozW1OYH6vBSt0AnVdP7WcdlCdqBgRl9ZE05NXU8OwZEmXdE8aJFX6QXnVeK
	5d6XAwKq5+H70JacWwjewNlqOgvl/m0d4sMAIaIVku9EQnppcZ+sjowbew/a/hK2lZsOfA8k9A/
	MTxJvHst4i2osQNUviYMCPKTgVcW/OMkCVVc21Jh5RisKLtAltkJzy4ZpV7StxseXsl4Fv7OAS0
	+OpjE0nF/xWv1/TJPh55X+wYs3H5bvSjcwzv1bFJFB0x1Qa4Dqwhfo4xdKBhcogHjQy/w7z74Lh
	R0Ua1DmVf8Lau6gVLQMRH1ENUeI1XoAb+690QXTh7M28ryVMvw49wqNAbc/72BWxE03BhTGcePY
	GpN/HlQY/fvg3ITgbgvPcnM9mhvk16N3AwNcjBAGvc/HujPcsurS6CHM8B8QZjLWFycCQxNpe9L
	AsoNNddMtlhkQfTFWaB4gGNZMPj0p2PZY0GX41gipNLIouHdsDyAgwDUYWnnfQAVi1zxyI80eT8
	QfzIDJl7tuvwdBcVH/aGGIzFVSYm3liMbK/R7ydb1ktTljnEWcJdHCgaQCnYUPwW+uaLTFtVri8
	4NlY/WXHlpPIzs6Nnt4o+eZP7P/aCDLUNNJRxRXWtMlTZPUXeTsz1fumjNvhEQ5Q3j3F+/VMSrc
	ljAh45v9NLbc6RAYAEEvOvh77HBPGEw==
X-Received: by 2002:a05:6a00:2da7:b0:898:e7e7:c0df with SMTP id d2e1a72fcca58-8c87cf2ad15mr4832985b3a.45.1795256336951;
        Sat, 21 Nov 2026 02:18:56 -0800 (PST)
Received: from reply.eml (awork078078.netvigator.com. [203.198.250.78])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077bff6sm2701360b3a.3.2026.11.21.02.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 02:18:55 -0800 (PST)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: Ignat Korchagin <ignat@linux.win>
Cc: linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
 David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Rusty Russell <rusty@rustcorp.com.au>, stable@vger.kernel.org,
 Vega <vega@nebusec.ai>, Ren Wei <weir@nebusec.ai>, xuyq21@lenovo.com
Subject:
 Re: [PATCH v4] KEYS: Account for asymmetric key payload data in the quota
Date: Sat, 21 Nov 2026 18:18:41 +0800
Message-ID: <20261121181841.58673-reply-xuyuqiabc@gmail.com>
In-Reply-To:
 <CAOs+rJWf5JEMD7UC-4YS2ayAX5f2SUgr5s9DCwmWXExBhqaEJA@mail.gmail.com>
References: <20261026024840.23482-1-xuyuqiabc@gmail.com>
 <CAOs+rJWf5JEMD7UC-4YS2ayAX5f2SUgr5s9DCwmWXExBhqaEJA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Ignat,

Thanks for the review.

> SInce we touch PKCS8 as well, missing a relevant "Fixes:"

You are right. v5 adds:

Fixes: 3c58b2362ba8 ("KEYS: Implement PKCS#8 RSA Private Key parser [ver #2]")

> While today indeed only the asymmetric keys hit this I wonder if the
> fix is better to be in key_payload_reserve(). Something like a fail if
> key->quotelen + delta > USHRT_MAX. That fixes all current and future
> key types.

Agreed. v5 adds that guard to key_payload_reserve(), so every key type is
covered. The asymmetric parsers still charge the actual retained payload
and keep their early rejection before the payload is installed.

The common check also covers keyring link accounting and big_key
updates, which use the same field: a charge that would exceed USHRT_MAX
bytes now fails instead of wrapping the counter.

v5 is now sent as a separate patch.

Thanks,
Yuqi

