Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703599;
	b=vB1/zCc8t2q8upUTUybPI+dYNV2keG+ecXa/icASaPE0aqvTqdoANU4nTpOQBljNcm8Y
	 9ImgsHxpJFchuXI8zishRCPlM0xqF3akw8AmJZeGgPWgeot7CrBgwiNWChe2GYYF+z68v
	 oDtiasFCBSRpknS08K6UMNgk+KHXzT0kxoKRO8+MvrBeenWjxvAk52CCmcUJUleW1qngO
	 heFbHL/bbeSuWgQyfY7Oh6hAiUB/e5EgpPTBXcB5T3sEz071PK90fsFf637EEDH4l37tW
	 Gc2gZU26Nf7L4kVb9RIYoDIVyZyfsMNI/XUdNLAF/o3fAlgvb6yp8/Jc2WOoXHdmRAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703599;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nde5jzcPFgbGFr4Ku39uM0negQLS7OUJRj8MnAeskMo=;
	b=sf8dJ8kIWYUVHuqY+ETHalv1Z7SSBJhAj6ZOln//FgPZSpa6V/J7lQIzP+HG/PicSxgg
	 L0h6rhuJKJ2LcOpXXoxvVxTK/iKGkcLZzkzexGaTFTX2eGrpr1jpK0gwGtD9/fR4ZSW/8
	 gpOjPrMTyTQVRR1wZLDKwskJTMIAXSyFsmX600K0SmEwCWTC7hIhfySqNLWz5ImDnit/I
	 cLtrcl55vpZ93xNuAuHy/DjG0hmvI2epg+xytvERRinpplkRgkIO19+vCihHz4eG8tZZn
	 LvXihy8MWM3WEuxS2NqNrztNVtqvWIAGP2ILRFYMwePLNQChC8jBcYuRBHczZQekKYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VkOkj3al;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EEB606A693
	for <keyrings@vger.kernel.org>; Thu, 26 Nov 2026 14:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VkOkj3al
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3F61F000C4;
	Thu, 26 Nov 2026 14:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703599;
	bh=nde5jzcPFgbGFr4Ku39uM0negQLS7OUJRj8MnAeskMo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VkOkj3al2PB5jc4KWLJzAixxYDd+yXVAA4GYSjfD+CE1UNi5vAM804wiaFbuuJ9ug
	 SAUnWq8Ce2Q9XHgbhYEZYXdvI/VCMpi1wG78S7o/zwrx/c6fCk7+gP3d4EaHcYAIQ7
	 UD9cS17KMX2E4D5z7Rrd/xqRnZRo7BFder+HrGWbTUnZowlxVwRibA6T36BfAJYZf/
	 vWY/6zZBKpYHATn0WdN39bLoXVCei68TloUKnBZ727TBSjy+9Fk3akr0suF8RwK07w
	 dBYF/16YCgKytmBx+Ktz7Wos0Bg/fhfGNN6W7LciXZZDzJhDpsJejxC5ngwzrSY3f9
	 aJ/4G5ItQccUA==
Message-ID: <sashiko-outbox-235725@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 06/14] nvme-auth: switch to use 'struct key'
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hannes Reinecke" <hare@kernel.org>, "Keith Busch" <kbusch@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, "Hannes
 Reinecke" <hare@suse.de>, "Chaitanya Kulkarni" <kch@nvidia.com>, "Eric
 Biggers" <ebiggers@kernel.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Kees
 Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org
In-Reply-To: <20261126-dhchap-keyring-v4-v7-6-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-6-ee438ffea527@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:33:18 +0000
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
- [Medium] nvme-keyring: nvme_dhchap_psk_create() overwrites
  key_create() error codes
--

commit d2027ac3b70964c8a70b1644b2224565f8d1e622
Author: Hannes Reinecke <hare@kernel.org>

nvme-auth: switch to use 'struct key'

This commit replaces struct nvme_dhchap_key with the kernel keyring's
struct key using the "dhchap" key type for storing and transforming
DH-HMAC-CHAP keys.

> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> index 0fc6b4825c2dd..dc0a4fb9296f1 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
> @@ -464,6 +464,91 @@ static struct key_type nvme_dhchap_psk_key_type =3D {
>  	.read           =3D nvme_dhchap_psk_read,
>  };
> =20
> +/**
> + * nvme_dhchap_psk_create - Create DH-HMAC-CHAP key
> + * @data: Key data
> + * @data_len: Length of @data
> + *
> + * Creates a new DH-HMAC-CHAP key with a random UUID as the key identity.
> + * Returns the new key or an error pointer on failure.
> + */
> +struct key *nvme_dhchap_psk_create(const char *data, size_t data_len)
> +{
> +	key_perm_t keyperm =3D
> +		KEY_POS_SEARCH | KEY_POS_VIEW | KEY_POS_READ |
> +		KEY_POS_WRITE | KEY_POS_LINK | KEY_POS_SETATTR |
> +		KEY_USR_SEARCH | KEY_USR_VIEW | KEY_USR_READ;
> +	char *identity;
> +	key_ref_t keyref;
> +	struct key *key;
> +	uuid_t key_uuid;
> +
> +	if (data =3D=3D NULL || !data_len)
> +		return ERR_PTR(-EINVAL);
> +
> +	generate_random_uuid(key_uuid.b);
> +	identity =3D kasprintf(GFP_KERNEL, "%pU", &key_uuid);
> +	if (!identity)
> +		return ERR_PTR(-ENOMEM);
> +
> +	pr_debug("generate dhchap psk '%s'\n", identity);
> +	keyref =3D key_create(make_key_ref(nvme_keyring, true),
> +			    "dhchap", identity, data, data_len,
> +			    keyperm, KEY_ALLOC_NOT_IN_QUOTA |
> +			    KEY_ALLOC_BUILT_IN |
> +			    KEY_ALLOC_BYPASS_RESTRICTION);
> +	if (IS_ERR(keyref)) {
> +		pr_warn("refresh dhchap psk '%s' failed, error %ld\n",
> +			identity, PTR_ERR(keyref));
> +		kfree(identity);
> +		return ERR_PTR(-ENOKEY);
> +	}

[Severity: Medium]
Should this return ERR_CAST(keyref) instead of ERR_PTR(-ENOKEY)?

When key_create() fails in nvme_dhchap_psk_preparse(), such as returning
-EINVAL for a malformed secret or -EKEYREJECTED for a CRC mismatch,
discarding PTR_ERR(keyref) causes nvme_auth_extract_key() callers like
dhchap_secret_store() to report -ENOKEY to userspace instead of the
underlying error code.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-dhchap-key=
ring-v4-v7-0-ee438ffea527@kernel.org?part=3D6
