Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795453442;
	b=XFuCygZAkLIg5RJd3hvf5dy5blyXrLKYv6S5PQInYDlAJEsMEvrUuI3cqjH6LsykydjM
	 XnCpUyzRFeIVOl7IkZQQLiwCYOsHuCeOUDUCP2mMQCtqhafCiv+UN9Ya3nSJ2byuhi1tf
	 fqTVV+jvhk4R+LG9TYWKB9TCzeKsX5vf96JBX2T2l7JJbLdzFKgdSxHPMcJXsedvDlNqs
	 I/bAUgpt0/ddZ1WOAhcantGT5yU36HrEAcEwiKb31EvlFdB2aDvXuldO7o0H7ta2swt56
	 CyyEOIKfe0FfuROy30xwi2gDiau8FjAX77IqAOk5td+BqdYvJpasjZD7+Gc7OfnChsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795453442;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=e7mxqUiyOlGyHJ5w8cLM37Cd1He7fSSCDlbAZdGnzS8=;
	b=uKWiwdj2mDVa56DxIocr9ZPZlvf72EcYJLIXmZm5SR8pudf2uhlEWwTgrK7oCRCpec4r
	 fH1z5kjR5A1HSzj4nbQfvte9MEhqQ2aZVhAjJ4vel++RssE2wVqpeTMq7qEwGi+m9uE8D
	 JJExMZYupi895h5Z2l/KMMgKK89oTmaMvE4sX4ZRViB/sim60OfxmLcuMe2lTXyiNC84q
	 0a33ageT9Ey5NA9AU5p4nEUcSfNylVLn8o1tEgaRpCrMcOqXmVy895BHWDtfb6hbdWIQN
	 g/syUIiFGwfp9658KTkAgQldTrcb+kUQHrA3q24a/Cl8OZ7chC0VQedM1RjdYgGlkMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DMfok00V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE17606A31A;
	Mon, 23 Nov 2026 17:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DMfok00V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F1B1F000C0;
	Mon, 23 Nov 2026 17:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795453441;
	bh=e7mxqUiyOlGyHJ5w8cLM37Cd1He7fSSCDlbAZdGnzS8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DMfok00VEjPN/mEBsg4On04OqjLUYlXsRlf6+A/WSpxT18ATaKU3Xz2JWJhcyUKjF
	 U7bX70qzW9mSTvmXHsaWo7wUoPA1LPonlVRoCsXWYQXjV4vbnh+Roq0450Q/H905b9
	 Hss8BvEUwabifmSwZSGEpgBYfvW3gct6/j2Uh9dTP9baCCzva8DQME2spliY39YLgm
	 dGZrcvfUWvhu7Vf72z/qUHdD/V+KiArbduL8DQJxZBC78VL2qtrSoMK+6r2b7knXTe
	 aP7ldYJpeRcXIBdZGH0wagjh8DlWPaZs46TT36JZTqvi1Lnl9T0bux6AxdGGjp1dxZ
	 OgL+oBZc4iN0Q==
Message-ID: <sashiko-outbox-229703@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] keys: fix crash on big_key read or revoke after a
 failed update
Reply-To: sashiko-reviews@lists.linux.dev
To: "Henry Martin" <bsdhenrymartin@gmail.com>, dhowells@redhat.com, jarkko@kernel.org, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, Jason@zx2c4.com
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261123165443.4092852-1-bsdhenrymartin@gmail.com>
References: <20261123165443.4092852-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 17:04:00 +0000
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
- [Low] keys: inaccurate comment and changelog on quota handling in
  big_key_update()
--

commit 2c08313937317377d7723fd6ab0f42836903865d
Author: Henry Martin <bsdhenrymartin@gmail.com>

keys: fix crash on big_key read or revoke after a failed update

This commit changes big_key_update() to instantiate the new key payload
before releasing the old payload's path and data, and removes the prior
key_payload_reserve(key, prep->datalen) call.

> diff --git a/security/keys/big_key.c b/security/keys/big_key.c
> index 268f702df380e..3bf371f6c28d3 100644
> --- a/security/keys/big_key.c
> +++ b/security/keys/big_key.c
> @@ -193,16 +193,31 @@ void big_key_destroy(struct key *key)
>   */
>  int big_key_update(struct key *key, struct key_preparsed_payload *prep)
>  {
> +	struct big_key_payload old =3D { };
> +	bool positive =3D key_is_positive(key);
>  	int ret;
> =20
> -	ret =3D key_payload_reserve(key, prep->datalen);
> +	if (positive)
> +		old =3D *to_big_key_payload(key->payload);
> +
> +	/*
> +	 * The quota for a big_key payload is a fixed 16 bytes that was
> +	 * already reserved when the key was instantiated, so the instantiate
> +	 * below does not change the reservation of a positive key.  Do not
> +	 * release it first: a concurrent allocation could take the quota and
> +	 * make the instantiate fail after the old payload was destroyed.
> +	 */
> +	ret =3D generic_key_instantiate(key, prep);

[Severity: Low]
Are this comment and the commit message accurate about what altered the
quota reservation before generic_key_instantiate()?

big_key_destroy() only drops payload->path and payload->data and never
touches key quota.  What changed the reservation was the removed
key_payload_reserve(key, prep->datalen) call, which passed the raw payload
length prep->datalen instead of prep->quotalen (16 bytes).  When
prep->datalen < 16 (or when prep->datalen >=3D 65536 and truncates to an
unsigned short key->datalen < 16), key_payload_reserve() left key->datalen
below 16, causing the subsequent key_payload_reserve(key, prep->quotalen)
inside generic_key_instantiate() to charge 16 - key->datalen bytes and
potentially fail with -EDQUOT after big_key_destroy() had already run.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123165443.4092=
852-1-bsdhenrymartin@gmail.com?part=3D1
