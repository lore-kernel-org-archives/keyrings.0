Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808317;
	b=BNlpDw3E+4X8rkg8EYlrCaRLJZzniZBUCJL5WAooWPbyOc8vVAWGWSHZhAKHAPQYtsw6
	 dE4QSkmvzHsGE26NfZr44eqcQAXIJXbwihSY24A33Ugvn2pHNj0al6O1IWynpB9ki/qlH
	 bUDbVu2yoKqiXTXS0PJgV1wn6daYbyJfRVZX6YuhXH5WMFpYl94/+B66y8CgYdwaiOM8l
	 pZVGp9QLlNLkQ/uMZKbmu2cpcqqwnHgzoFhe4Hqbnk4v08Yk0H9bbt0VT4nSq3vdAZJ2q
	 XnOsfOEyp8LmGsEP1Afb6MiT5mOFxyNRAx7rSZ7yj9+zhz7QIloexu44wHscDZX8XGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808317;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8tAhjUC1sN1NfqvNuWp5ZIfz98OM+/jpe+TE94GU4Qc=;
	b=kopLf5pA87yDTe6jPb3IAUn6kWzrDEmAI5b33NaBA6F1rqk9xxC6BIFzxSd9NBFNrLDo
	 HMpLtmthTgkd5RQckVOer+4FRDPqZeezwpb1vOAd71kJRmsLHC6Np9FVFFBU5ooZM7DjZ
	 3z7LnOc2GMBd2HNBk1sBN0XzE6iqulJnhnl7z0zwz/ERouiFC6QEH6QpKk1M/VTfEPCAu
	 4ExpTUqxZjlOBLjE+2jZz0oFQbqUklsK7THa/Ha/hFarNmyNJBydJNSflHSqkdRxC0SNB
	 bBXIqEDAmJU9s69MLsf5GvKlu6LOW+AAPVuxdHzQyTD/7g1Qea9y8bjmzIfMIZ8JLyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEIP77aY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C16C606A31C
	for <keyrings@vger.kernel.org>; Mon, 16 Nov 2026 05:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEIP77aY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7AE01F000C4;
	Mon, 16 Nov 2026 05:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808316;
	bh=8tAhjUC1sN1NfqvNuWp5ZIfz98OM+/jpe+TE94GU4Qc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aEIP77aYuwFRJLVvyTRGuaRYPoIGLEV1qaWW3Gid6Tjf4txHWA1cAGZ1fYzsXZdOU
	 dyfgvq+H92gV/jpHzrgdS+hTWBTMcPjXiokXSlrXi/x1o49s0APjl0Q/vSxgHcyOQn
	 tfxukppvN4WbHe+BaAjz5/78ywwsFWQidd92DuMQsRDPH+AWY/sOLCMsy6GQbXBey3
	 EmcmIEWn/6NWVleoKcozNXVaKzIkMff6pkn2C4O3zl9yHmAW5ZiFEO3rgTX9QpBk7J
	 HmyrqR9RQ/KP0EGTAbJDqEglb0NSh9zRfJ1SQ3ratYUxmDT4hbMQRkncXhAXNs+i6S
	 NFFCrhDm0iWSQ==
Message-ID: <sashiko-outbox-216230@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] lib/assoc_array: add KUnit test suite
Reply-To: sashiko-reviews@lists.linux.dev
To: "William Chuang" <founder@logarcheon.com>, akpm@linux-foundation.org
Cc: dhowells@redhat.com, keyrings@vger.kernel.org
In-Reply-To: <20261116054112.39078-2-founder@logarcheon.com>
References: <20261116054112.39078-1-founder@logarcheon.com>
 <20261116054112.39078-2-founder@logarcheon.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 05:51:56 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] lib/assoc_array: unexported symbols break modular
  ASSOC_ARRAY_KUNIT_TEST=3Dm build
--

commit 07438606f16e23d96f51f8a13d17b392d4d4bc67
Author: William Chuang <founder@logarcheon.com>

lib/assoc_array: add KUnit test suite

This commit adds a KUnit test suite for the generic associative array in
lib/assoc_array.c, testing insertion, replacement, deletion, clearance,
iteration, and garbage collection against an expected model.

> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 1dac2674a9838..157f350eee5dc 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2856,6 +2856,23 @@ config SYSCTL_KUNIT_TEST
> =20
>  	  If unsure, say N.
> =20
> +config ASSOC_ARRAY_KUNIT_TEST
> +	tristate "KUnit test for the generic associative array" if !KUNIT_ALL_T=
ESTS
> +	depends on KUNIT
> +	select ASSOCIATIVE_ARRAY
> +	default KUNIT_ALL_TESTS

[Severity: Medium]
Does building with CONFIG_ASSOC_ARRAY_KUNIT_TEST=3Dm (such as under
allmodconfig) fail at modpost?

CONFIG_ASSOCIATIVE_ARRAY is a bool option that compiles lib/assoc_array.o
into vmlinux, and lib/assoc_array.c does not export any of the
assoc_array_*() functions with EXPORT_SYMBOL().  Either
ASSOC_ARRAY_KUNIT_TEST needs to be bool with "depends on KUNIT=3Dy", or the
assoc_array_*() functions need to be exported.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116054112.3907=
8-1-founder@logarcheon.com?part=3D1
