Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986854;
	b=CsPzQGucPE/KUyRZuIXV6RJcxUtx0tbr0l12k/rpdFL40VMrapLEPlHAHNJfuOEVoZe+
	 lhpFlEDbF3oi7AydthVMoWu2Qvfu41pt7Aa63I55GwnJSscFjxJJjW1TeQDttAHNNFabL
	 WpwnaulnLGai+YM7lPPiBRkyTaAeTBvcr2Mq4EPlAFpFTcZogQ5sswyi9QRfG0npNq7op
	 d3CrytHWd3LyoAEnidWPnItOLnfZNelB/c/JmBS4LM+AWKfwRU8o3bsKk1dg0RCmIzaxQ
	 /n8m+frrwM63LoPS6kuF+DzekmciF2EL54AjOO9DhdQLVict38pQD4TBHav3rI1mpdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986854;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=fZ3CTPqrhyLlUC2D0g4YaXtJrWiOUGcKzUjdNYbjmUs=;
	b=wl1UDGK+FuxRrESes7sXUpS8KsFCVYLR7MoMVqp3RuLfDug4rMktX0t+tspcbxUm5fZ2
	 xgQlD0RabghVu6vlEsCPiVkb0gNxELoCD/XaMWEW1zCUV0TDXQxXYwavbC6TZTSvZkDvR
	 eG1f9m9DtJEVDkGm5xS5RBzYDynU3h3eG72sKnLguodqBeDG7mmlpv5IfzdgLbnzWFDPX
	 d7tHin4LiAFd2ohho5vo3XY9T+YiLW4tavsNN0kvKl4wae73k8qn8Z9VpxmET3s6yhPYQ
	 2oBXAjUOvGfK9sNeUX+HgN2Y1tWic05gMlgpXiGFgK0f1q2cr9NwCagn5a+IkxhDmrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lzUO1YVd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E51606A326
	for <keyrings@vger.kernel.org>; Fri,  6 Nov 2026 17:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lzUO1YVd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29351F008A1;
	Fri,  6 Nov 2026 17:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793986853;
	bh=fZ3CTPqrhyLlUC2D0g4YaXtJrWiOUGcKzUjdNYbjmUs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lzUO1YVdB7q1+gw4iQaEfIk+x7eCHKKL+XXBGhchGxgKwZFLbDPiZdSWrQhF0KaNA
	 BtPL6J6MHIPTErt0BYmmuqSBa4kso+hXUtQ5ymRwbNoTaV0mi/zujHbnnN4WcpXD7p
	 QOpPu8M67qpqermkP/qLWy5UTzDfYRZizlvRLSuCItPBqMQOmH9rTtFqYn2ggNi4Im
	 vgFcsjCGnlYoZStwkQSi01zlgxbfWxHWMJvwvx1b2R4kIfMPt+VCp+sAHI5czA5dDo
	 nMMMywkeLyuCKLPQBBDn1Y7QRwB0n2R+29KRptKUtW7LuMaNaRgl+HMF5DRFtrrilB
	 Wod+ur+Um3GcQ==
Message-ID: <sashiko-outbox-201958@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] certs: blacklist: define skid: entries and add
 is_key_blacklisted()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mimi Zohar" <zohar@linux.ibm.com>
Cc: "Jarkko Sakkinen" <jarkko@kernel.org>, "David Howells" <dhowells@redhat.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, =?utf-8?b?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, keyrings@vger.kernel.org
In-Reply-To: <20261106173149.707244-2-zohar@linux.ibm.com>
References: <20261106173149.707244-1-zohar@linux.ibm.com>
 <20261106173149.707244-2-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 17:40:52 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] certs: ignored keyring_search() errors in
  is_hash_blacklisted() [1]
--

commit 82f0c39aa99cf26118fffcb57200171e393b838c
Author: Mimi Zohar <zohar@linux.ibm.com>

certs: blacklist: define skid: entries and add is_key_blacklisted()

This commit defines a "skid:<hex>" blacklist entry type for Subject Key
Identifiers and adds is_key_blacklisted() to look up an asymmetric key's
SKID in the system blacklist keyring.

> diff --git a/certs/blacklist.c b/certs/blacklist.c
> index fa561c12eabfe..9158bd9f9fc90 100644
> --- a/certs/blacklist.c
> +++ b/certs/blacklist.c

[ ... ]

> @@ -244,6 +243,40 @@ int is_hash_blacklisted(const u8 *hash, size_t hash_=
len,
>  }
>  EXPORT_SYMBOL_GPL(is_hash_blacklisted);
> =20
> +#ifdef CONFIG_ASYMMETRIC_KEY_TYPE
> +/**
> + * is_key_blacklisted - Determine if a key is blacklisted by its SKID
> + * @key: The key to be checked, e.g. a trust anchor found in a keyring
> + *
> + * Unlike a "tbs:" entry, which is only compared against certificates be=
ing
> + * added or presented in a chain, this checks a key that is already load=
ed, so
> + * that keys that cannot be unlinked from their keyring can still be rev=
oked.
> + * The identifier is taken from the key itself, not from the caller.
> + *
> + * Returns -EKEYREJECTED if the key's Subject Key Identifier is blacklis=
ted,
> + * 0 if it is not (or the key has no SKID), or another negative error.
> + */
> +int is_key_blacklisted(const struct key *key)
> +{
> +	const struct asymmetric_key_ids *kids;
> +	const struct asymmetric_key_id *skid;
> +
> +	if (!key || key->type !=3D &key_type_asymmetric)
> +		return 0;
> +
> +	kids =3D asymmetric_key_ids(key);
> +	if (!kids)
> +		return 0;
> +
> +	skid =3D kids->id[1];
> +	if (!skid || !skid->len)
> +		return 0;
> +
> +	return is_hash_blacklisted(skid->data, skid->len, BLACKLIST_HASH_SKID);
> +}
> +EXPORT_SYMBOL_GPL(is_key_blacklisted);
> +#endif

[Severity: Critical]
This problem wasn't introduced by this patch, but can is_hash_blacklisted()
fail open when keyring_search() returns an error pointer [1]?

certs/blacklist.c:is_hash_blacklisted() {
	...
	kref =3D keyring_search(make_key_ref(blacklist_keyring, true),
			      &key_type_blacklist, buffer, false);
	if (!IS_ERR(kref)) {
		key_ref_put(kref);
		ret =3D -EKEYREJECTED;
	}

	kfree(buffer);
	return ret;
}

keyring_search() checks KEY_NEED_SEARCH against current_cred() on
blacklist_keyring and any matching blacklist key.  If a confined task's LSM
policy denies search permission and keyring_search() returns
ERR_PTR(-EACCES), is_hash_blacklisted() discards the error and returns 0,
allowing blacklisted keys, certificates, or binaries to pass verification.

[1] https://sashiko.dev/#/bug/linux-151043b5-dceb-4214-adc8-c004531dcb8d

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106173149.7072=
44-1-zohar@linux.ibm.com?part=3D1
