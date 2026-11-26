Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703371;
	b=ogFR+Y0+jHq60tSZ/O9amZTyl/Xythc5wQX43CA68HMAVLDWKyLXDPzpNcHdH0RHk5I0
	 ENf4J6fbamvMNqmz3lWS+AAVq1f8vYSxC7FCgukorIGAhHs2Yf8l1VHPlnw67jxMlICQR
	 qmHxTCeAezx67V8OORXZ6qh6oKX/i5UoudbgQTYhpbMomiVfuBzP8Ra9kV3PzSYBb4JjC
	 VFaJJ2hFoR88unGn3HRq6T18OU19qGFP5hmTssraQ2qViNTah6a6wDm9OXaR8jpyOE7Zo
	 2Nu5CMhfmHpNPbS74GED1Q00NKCTzV6LjZSEgfKQY6rmxL2z2i2z1rO9HNLiDN9VO1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703371;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lz6cIcsw2k0QrPuEE92qwSf/Xd928aDxunt/Z51hxWg=;
	b=j4vZi/ybgn2EODljVM7rfbiVhOnqZ6N3i2trrvXpIVxAGRBTpDfo+S3OBkc0zlxSj/47
	 BDESnIzuVDlGAeAbVMhOg3qvBVevJMTwpBJZg8cBYAaPdbREEorCgLDCERWMAFNSHbesH
	 KT3RAAQ9VFKWkU4rb9LpSLF6vlQlMILvBI7QBcUkwIBWY5inaMJJSdopgxQlcp993aCjN
	 QTnufF1A4uenC6YHF4ylrRPNVzsUtfdXLDLWv91Dh1tAyQXDWEfz/54tjI/w1w7Nzx6Cf
	 cv5V2Pew4ysohQ8OrGUsH7uc5vMXMCQs9PpXCRQ+9YjFzH7hqTXyHBezorZb6YhyPiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Am5N+2L1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE1D606A321
	for <keyrings@vger.kernel.org>; Thu, 26 Nov 2026 14:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Am5N+2L1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672891F000C4;
	Thu, 26 Nov 2026 14:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703371;
	bh=lz6cIcsw2k0QrPuEE92qwSf/Xd928aDxunt/Z51hxWg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Am5N+2L1Aan2DKv4AvuJiDRfoybl9OvmQrB+dOeBDezB+uIkQ3j/uKmS2b29x1gC2
	 mzgJ8DUr2fyeCu5sbvhLJeETyJgdtDuTObAJKJSxzOG5WTKJGzzPzcvBIal7ex7Vxs
	 XfEeCCmhJsw+pxkdrLhaylgVpywv1SXBfXQibFUXg/l6D7WirhqNizWj6nakgYnwho
	 JMKF6Hwyokdnl4lnScYviyR9oeVmvm4eXLXPNoVjT52cVgzX4MDWD49Ttag43L2tCF
	 HIchI2Hfz+ibkcMdlRuJHr33J9S3ewV0DoKBv4lCD4B0UhW3k6CenZD2PEkMfZhgAn
	 SlNmyVj59GXzQ==
Message-ID: <sashiko-outbox-235706@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/14] nvme: parse dhchap keys during option parsing
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hannes Reinecke" <hare@kernel.org>, "Keith Busch" <kbusch@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, "Hannes
 Reinecke" <hare@suse.de>, "Chaitanya Kulkarni" <kch@nvidia.com>, "Eric
 Biggers" <ebiggers@kernel.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Kees
 Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org
In-Reply-To: <20261126-dhchap-keyring-v4-v7-7-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-7-ee438ffea527@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:29:29 +0000
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
- [High] nvme-auth: ERR_PTR dereference on key_lookup() in
  nvme_auth_init_ctrl()
--

commit 0df67db2f376340a8318c48ba959e7e18c9db8b6
Author: Hannes Reinecke <hare@kernel.org>

nvme: parse dhchap keys during option parsing

This commit creates DH-HMAC-CHAP keys during fabrics option parsing,
stores their key serials in struct nvmf_ctrl_options, and adds
dhchap_key and dhchap_ctrl_key sysfs attributes.

> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index d6abdb4f1e21c..285aa1c71f102 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
[ ... ]
> @@ -1028,38 +1023,100 @@ static void nvme_ctrl_auth_work(struct work_stru=
ct *work)
[ ... ]
>  int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>  {
>  	struct nvme_dhchap_queue_context *chap;
> +	struct key *host_key, *ctrl_key =3D NULL;
>  	int i, ret;
> =20
>  	mutex_init(&ctrl->dhchap_auth_mutex);
>  	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
>  	if (!ctrl->opts)
>  		return 0;
> -	ctrl->host_key =3D nvme_auth_extract_key(ctrl->opts->dhchap_secret,
> -				strlen(ctrl->opts->dhchap_secret));
> -	if (IS_ERR(ctrl->host_key)) {
> -		ret =3D PTR_ERR(ctrl->host_key);
> -		ctrl->host_key =3D NULL;
> -		return ret;
> +	if (!ctrl->opts->dhchap_key) {
> +		nvme_auth_clear_host_key(ctrl);
> +		nvme_auth_clear_ctrl_key(ctrl);
> +		return 0;
>  	}
> =20
> -	ctrl->ctrl_key =3D nvme_auth_extract_key(ctrl->opts->dhchap_ctrl_secret,
> -				strlen(ctrl->opts->dhchap_ctrl_secret));
> -	if (IS_ERR(ctrl->ctrl_key)) {
> -		ret =3D PTR_ERR(ctrl->ctrl_key);
> -		ctrl->ctrl_key =3D NULL;
> -		goto err_free_dhchap_secret;
> +	host_key =3D key_lookup(ctrl->opts->dhchap_key);
> +	if (!host_key) {
> +		pr_warn("dhchap host key %08x not present\n",
> +			ctrl->opts->dhchap_key);
> +		return -ENOKEY;
> +	}
> +	down_read(&host_key->sem);
> +	ret =3D key_validate(host_key);
> +	up_read(&host_key->sem);
> +	if (ret) {
> +		pr_warn("dhchap host key %08x invalidated\n",
> +			key_serial(host_key));
> +		key_put(host_key);
> +		return -ENOKEY;
>  	}
> =20
> -	if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
> -		return 0;
> +	if (ctrl->opts->dhchap_ctrl_key) {
> +		ctrl_key =3D key_lookup(ctrl->opts->dhchap_ctrl_key);
> +		if (!ctrl_key) {
> +			pr_warn("dhchap ctrl key %08x not present\n",
> +				ctrl->opts->dhchap_ctrl_key);
> +			key_put(host_key);
> +			return -ENOKEY;
> +		}
> +		down_read(&ctrl_key->sem);

[Severity: High]
Should host_key and ctrl_key be checked with IS_ERR() rather than for
NULL after key_lookup()?  key_lookup() returns ERR_PTR(-ENOKEY) when a
key serial is not found, so if either key is removed before
nvme_auth_init_ctrl() runs, down_read() will dereference an error
pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-dhchap-key=
ring-v4-v7-0-ee438ffea527@kernel.org?part=3D7
