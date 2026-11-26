Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703165;
	b=2Cb4lrIF/jcpSVXORTnvK3dvKXsug1whKeNdJhptG+2bvUtheFkgi4sS3IO4loRcKSOl
	 1NAQoNXdzQ88Zeo/uOcEVtFPILzGmkinWapVgO4cCp11fLMF/pehxOBGbPY0GOMuc2FU5
	 sVDZGElocoF548GBZumuVlwGXOroEtRtFLPOAo6U6tgkw7Rl8u7Fk9wmBylm0gptTPaj8
	 CwgcyJns3F2Toa4CBYexNFvforDozAUK1HerHVD8+HP/X74viVfQ6crLS3JK21hNGp/kj
	 3kl3sQJfLA6Jl5iYeAZ6Q45AEX0g/KX/qNOGNToh4bxVUggb3z6ZpY9H7JWOokmntdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703165;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w2FnkjsorPqnWEbAhKKiOQtC7SO28lR3c0NUHkdn6z0=;
	b=e4LaG1fxjJNxkhYlKIaGtcrGToyOcXwPGxmMnh6HJl1lndkF8m/zblDDXqZfb6GyNcpS
	 Vl4Ce34ZYSEv4oRVzY9J4RWgaq6I8HgCrYB/x5LlLl96u6RWObmbnfX1zQ8nD5XzTYqw9
	 Ugr8zOHr7YncSBprrUUSOVgK/eGxRF6mUaKIhbw+m5OUF5djXNLv53TweUB2payZTSinL
	 Tq7+n61XSvU8PaefensFzW55L0l5EfshMXM68pVR2sFMCRu4chUP6sdnlPbwykpvSxlou
	 HjgrLHGPbBfuFroy52XMh5Fr2mytGTpwgAhTB0qM5zVXSulKGlQwoP0YHTDl1ptPXzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8aeXAjz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27793606A31E
	for <keyrings@vger.kernel.org>; Thu, 26 Nov 2026 14:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h8aeXAjz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4684F1F000C0;
	Thu, 26 Nov 2026 14:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703165;
	bh=w2FnkjsorPqnWEbAhKKiOQtC7SO28lR3c0NUHkdn6z0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h8aeXAjzFqE4ciymvXEicFjQdJV6tw6b7dPLGGF+BoyhToZUubqjuBqoQMBeSPcXs
	 xqOAytULhFRcZ5cOrqkXf8EBIlGUTh2G6BghNfXBPaXtqcofVGhgvJn8jByuBunwmS
	 f5Y7MPf0oc3jL6sXJp2vPwe4IZ1+L1S0G7lW1O6APMnV5rlIxVj0t3MYrlltVliPcI
	 Atql9HovTqhYlw6vujJXZnlhHLML1hIgrsNGJiNupX+l+mQgeSlYrlTnJOtuTfVCAm
	 iVSRywqGGTQHSh6Exjk+eBwXHa9WBl+GS2IiQYl2WLa59fUTjHqS4bEC+RIKgXhZMs
	 Xd49GoQH9opdA==
Message-ID: <sashiko-outbox-235696@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/14] nvme-auth: allow to specify the key by key
 serial
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hannes Reinecke" <hare@kernel.org>, "Keith Busch" <kbusch@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, "Hannes
 Reinecke" <hare@suse.de>, "Chaitanya Kulkarni" <kch@nvidia.com>, "Eric
 Biggers" <ebiggers@kernel.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Kees
 Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org
In-Reply-To: <20261126-dhchap-keyring-v4-v7-10-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-10-ee438ffea527@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:26:03 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] nvme-auth: missing key type validation in
  nvme_auth_extract_key()
- [Low] nvme-auth: key_serial truncation to key_serial_t in
  nvme_auth_extract_key()
--

commit 7d31006b6164c1d407e94a069e4daf6dec180cf1
Author: Hannes Reinecke <hare@kernel.org>

nvme-auth: allow to specify the key by key serial

This commit updates nvme_auth_extract_key() to parse a numeric key serial
and look up the key via key_lookup() before falling back to key description
lookup or key generation.

> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index 15e72fe8868af..e336c698437dc 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -148,7 +148,7 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
>   * @generated: indicate whether a key has been generated
>   *
>   * Extracts or generates a key from @input.
> - * @input can either be a key description or raw key data; in
> + * @input can be a key serial, a key description or raw key data; in
>   * the latter case a key is generated from @input and
>   * @generated is set to 'true'.
>   *
> @@ -158,7 +158,18 @@ struct key *nvme_auth_extract_key(const char *input,=
 size_t input_len,
>  				  bool *generated)
>  {
>  	struct key *key;
> -
> +	unsigned long key_serial;
> +	int err;
> +
> +	/* Check if @input is a key serial */
> +	err =3D kstrtoul(input, 0, &key_serial);
> +	if (!err) {
> +		key =3D key_lookup(key_serial);

[Severity: Low]
Can kstrtoul() silently truncate 64-bit values when key_serial is passed to
key_lookup()?  key_serial_t is int32_t and valid serials are positive, so a
numeric string larger than INT_MAX on 64-bit platforms is narrowed to its
lower 32 bits instead of being rejected.  Parsing with kstrtos32() and
checking key_serial > 0 would avoid this.

> +		if (!IS_ERR(key)) {
> +			*generated =3D false;
> +			return key;
> +		}
> +	}

[Severity: High]
Can key_lookup() return a key that is not a positively instantiated
nvme_dhchap_psk_key_type key?

Unlike nvme_dhchap_psk_lookup(), key_lookup() searches the global serial
tree without checking key->type or instantiation state.  When
nvme_auth_transform_key() later runs, it unconditionally calls user_read()
and nvme_dhchap_psk_hash(), which read key->payload.rcu_data0 as a struct
user_key_payload and access 6 bytes past upayload->datalen:

drivers/nvme/common/keyring.c:nvme_dhchap_psk_hash() {
	...
	upayload =3D user_key_payload_locked(key);
	hmac =3D upayload->data[upayload->datalen + 5];
	return hmac;
}

Passing the serial of an uninstantiated key, a keyring, or another key type
(such as user, logon, or NVMe TLS PSK, where user_preparse() only allocates
upayload->datalen bytes) causes a NULL pointer dereference, type confusion,
or a 6-byte slab out-of-bounds read.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-dhchap-key=
ring-v4-v7-0-ee438ffea527@kernel.org?part=3D10
