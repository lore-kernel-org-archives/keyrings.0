Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703413;
	b=jxjNh7kJM7EyBNpdXTlQJXOw/0JNUW3ce/MywpueLroPBsH5O02DVHcYYhqMhxBknMpn
	 Kh5NAtrhjrE0Ys69lyYYDR2MQ6DfQoqpmGeYeEo+pikjJgeufNdk09IgbYrQeWwcoOQiE
	 yvCOuGlO1Pw6bLVKuPAU99ofrzT+B2dwbpwUlID/wUL2MdRO5oXSizVAiY6p3KOxmtqhI
	 XkopC8pSk4IV+ug8Qha/6HTQ0OSNRy4ZyfDjCYMCcEMt9QgLEULNA5vm+SbS5cS0twmi7
	 0HENzfNk09jzlrHV6OCT4d6lVJeQsNHw5aNQDsehtdJ+1wwC1QpJacc1+ulZCRxUjew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703413;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XUgYcggpYfbzGJ6Hqiliic8gspbuU8Xf5yoxhcaS0GM=;
	b=LxWirRiFbiVa+QHU7FmDZZAtawSRhDH5M8Op9nVlZ05qUaG2fbkbjkz56sjQlpfXuES3
	 V8IjAz0W92iB3PTDJAAZuggF7EO90jwmAEQRJlTYZE4k/1vNp+BfrKDy+OEUHtP2Tr6oe
	 lv+Uv0+jGJFoAmSsCjoAEI7EQdMd+XG2maHdjiy8x2Im+oX8PIMhgtJdl04TkdImB4V0o
	 RuB9z8k+wPrPDiGeusIyPWUc9Ivt7WNh+DK8oIz/vHq38XLX7+eYAV6tCL5YErIzq8TVv
	 mIuGJYe8gG8O3wZQMQCNCDgtiSsPN7BwgE2M4OSaOrZ3zEQcUTbxJtgTvNMZJ9oqiNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QY7Mobx3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA1A606A6A7
	for <keyrings@vger.kernel.org>; Thu, 26 Nov 2026 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QY7Mobx3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F9E1F000D0;
	Thu, 26 Nov 2026 14:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703413;
	bh=XUgYcggpYfbzGJ6Hqiliic8gspbuU8Xf5yoxhcaS0GM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QY7Mobx3bsO+XGOzfAsxJoqqAdRkV6FPT9wHTpZieKlZBueq+15IJoW4WUQjQhjuy
	 FlW7QJKylgJBNXZdGCogglDdWzejtxjDw3xoWKOwEu4qUvpU+5HsSZUnqGTmyfI0mg
	 PpeurywTrmofSajEsxaNfzH6b3Z5Yy9u/Q0vFfEmn5htNtUezgbWGpg0dPDkWP1BzF
	 OMj+BqwDdePibDLmmKKPGtsVHcWeJ5DEmniDDkTvREXh9ptv9IYI+24d6VfUQZJtn7
	 8CA1DNd4jSO76YY+brECgRXTLL8wSEeP7zR9LqkArFJRywOc1Yme/M3ULyG0nAIo5E
	 gFmSOWivnRTkg==
Message-ID: <sashiko-outbox-235707@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/14] nvmet-auth: parse dhchap key from configfs
 attribute
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hannes Reinecke" <hare@kernel.org>, "Keith Busch" <kbusch@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, "Hannes
 Reinecke" <hare@suse.de>, "Chaitanya Kulkarni" <kch@nvidia.com>, "Eric
 Biggers" <ebiggers@kernel.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Kees
 Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org
In-Reply-To: <20261126-dhchap-keyring-v4-v7-8-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-8-ee438ffea527@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:30:12 +0000
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
- [High] nvmet-auth: ERR_PTR dereference in key_lookup() callers
--

commit b41d5ff16da6a60366fa816c551dfd75334950eb
Author: Hannes Reinecke <hare@kernel.org>

nvmet-auth: parse dhchap key from configfs attribute

This commit converts the nvmet DH-HMAC-CHAP configfs attributes to store
key serial numbers in struct nvmet_host and look up the keys via
key_lookup() when needed.

> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index e1d92f5455219..ff0e8569d7067 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c

[ ... ]

> @@ -186,22 +212,45 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct=
 nvmet_sq *sq, bool reset)
>  		goto out_unlock;
>  	}
> =20
> -	if (!host->dhchap_secret) {
> +	if (!host->dhchap_key) {
>  		pr_debug("No authentication provided\n");
>  		goto out_unlock;
>  	}
> =20
> -	host_key =3D nvme_auth_extract_key(host->dhchap_secret,
> -					 strlen(host->dhchap_secret));
> -	if (IS_ERR(host_key)) {
> +	host_key =3D key_lookup(host->dhchap_key);
> +	if (!host_key) {
> +		pr_warn("%s: host key %08x not found\n",
> +			__func__, host->dhchap_key);
>  		ret =3D NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
>  		goto out_unlock;
>  	}
> -	if (host->dhchap_ctrl_secret) {
> -		ctrl_key =3D nvme_auth_extract_key(host->dhchap_ctrl_secret,
> -						 strlen(host->dhchap_ctrl_secret));
> -		if (IS_ERR(ctrl_key)) {
> +	down_read(&host_key->sem);
> +	ret =3D key_validate(host_key);
> +	up_read(&host_key->sem);
> +	if (ret) {
> +		pr_warn("host key %08x invalidated\n",
> +			host->dhchap_key);
> +		key_put(host_key);
> +		ret =3D NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
> +		goto out_unlock;
> +	}
> +	if (host->dhchap_ctrl_key) {
> +		ctrl_key =3D key_lookup(host->dhchap_ctrl_key);
> +		if (!ctrl_key) {
> +			pr_warn("%s: ctrl key %08x not found\n",
> +				__func__, host->dhchap_ctrl_key);
> +			key_put(host_key);
> +			ret =3D NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
> +			goto out_unlock;
> +		}
> +		down_read(&ctrl_key->sem);
> =20
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c
> index ff3a8d74de599..f6bfda757f076 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c

[ ... ]

> @@ -2234,15 +2235,29 @@ static struct config_group nvmet_ports_group;
>  static ssize_t nvmet_host_dhchap_key_show(struct config_item *item,
>  		char *page)
>  {
> -	char *dhchap_secret;
> +	struct nvmet_host *host =3D to_host(item);
> +	struct key *key;
>  	ssize_t ret;
> =20
>  	down_read(&nvmet_config_sem);
> -	dhchap_secret =3D to_host(item)->dhchap_secret;
> -	if (!dhchap_secret)
> -		ret =3D sprintf(page, "\n");
> -	else
> -		ret =3D sprintf(page, "%s\n", dhchap_secret);
> +	key =3D key_lookup(host->dhchap_key);
> +	if (!key) {
> +		page[0] =3D '\0';
> +		ret =3D 0;
> +	} else {
> +		down_read(&key->sem);

[ ... ]

> @@ -2267,15 +2292,29 @@ CONFIGFS_ATTR(nvmet_host_, dhchap_key);
>  static ssize_t nvmet_host_dhchap_ctrl_key_show(struct config_item *item,
>  		char *page)
>  {
> -	char *dhchap_secret =3D to_host(item)->dhchap_ctrl_secret;
> +	struct nvmet_host *host =3D to_host(item);
> +	struct key *key;
>  	ssize_t ret;
> =20
>  	down_read(&nvmet_config_sem);
> -	dhchap_secret =3D to_host(item)->dhchap_ctrl_secret;
> -	if (!dhchap_secret)
> -		ret =3D sprintf(page, "\n");
> -	else
> -		ret =3D sprintf(page, "%s\n", dhchap_secret);
> +	key =3D key_lookup(host->dhchap_ctrl_key);
> +	if (!key) {
> +		page[0] =3D '\0';
> +		ret =3D 0;
> +	} else {
> +		down_read(&key->sem);

[Severity: High]
Should the key_lookup() checks in nvmet_setup_auth(),
nvmet_host_dhchap_key_show(), and nvmet_host_dhchap_ctrl_key_show() use
IS_ERR() instead of testing for NULL?

key_lookup() returns ERR_PTR(-ENOKEY) when a key serial is not found
(including when dhchap_key or dhchap_ctrl_key is 0 because no key is
configured).  Checking !key lets ERR_PTR(-ENOKEY) through and crashes at
down_read(&key->sem) when reading the configfs attributes on a host
without a key configured or when a key is not found during
authentication setup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-dhchap-key=
ring-v4-v7-0-ee438ffea527@kernel.org?part=3D8
