Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703053;
	b=elEemJyRIivVEIannVxGYAZ9wSavybALDm/IxZw7RplLo5O4V7T/vQMaLf0nTjsEpz+L
	 PQTpFuGQosh3mCGvPKi1Yqmp/e81D7DJXKMFBmPODQbITAc0Qi/jyeTma06IvVgkdSk8X
	 aElKSYdr2ucpOypJ9N9gDBkUhuzdfRzoYmdFi1SK2sJDqAmY8trOuWS8B/SER70mLmYge
	 34L2DmIasKe7VUhUMQreBJqG9EcsDr7JNr8K16APC6EsSTy9g3JcdSUbEETR6Q/PQipt4
	 03wSDVTrF1JheV4KXZ/ftIqUBMcbOYGgdqoHrDGyRkgPi603xwLOP2bTEGF6c3LKNfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703053;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ELd8tvho0iixPbNE585XdbmTXRHCl1PopYl7eINemuo=;
	b=iCzZ4ZFU1uwY46F8AWDi98nHKYQwPDTMt9aMY8nQEpY8wIFUXKNMLRFvTOY94aBKZ+kS
	 /jw2yewn03yUA2a941vGej2hGt0d9uAZIfz9aL5pN+Mv4GMU0jRCRrd+6I42oPO6r0h59
	 ObYxxfTgoztmNX6BDiLRI6+Rq4Du4cSy86y51E3HGF7QICFGoAo/hJtSWjdK/HLwEU1ww
	 0RUixPF+uK6ql6+Eva6ebq2592Jkz8sa/cel0p37Gg8Wpji+52i8Uhlq9qqLqk+lVzp/V
	 3zezo42EFMyaCZssplVoMKWh4mlE/b1IzwLtRAqBRWDlygNmywt3GspAf15jMqQhWVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcXPS1eu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B026D606A31C
	for <keyrings@vger.kernel.org>; Thu, 26 Nov 2026 14:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kcXPS1eu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D98C1F000D4;
	Thu, 26 Nov 2026 14:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703052;
	bh=ELd8tvho0iixPbNE585XdbmTXRHCl1PopYl7eINemuo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kcXPS1euTrkLzkM80lSEZkuwBG6+VnwTzbdn6G2DGApCw4gNZi72GqsU3QImKNImN
	 SI8c6pkDUHBci/UZ4g4CiokwTPGW/Xye1hxvoF6iA9PktbcT9Is4RbuKQsbk+OxGQW
	 mra1CX94QAiSJzvcl/C3WAu834khE5hlftUxJRNQwwX3nFFAXYYkAKJDqre9UQ4hAQ
	 CKk1f2nccEAWSh3FySoJpsJdoNq8bEPvIB/58H5N6HfiW3CNtdPnswTtqd/weBfQT2
	 T5mHftPoWkh4d0q4t2Y8v3f/+wPxfWh6X3KYrUdEp8yhoy5y6vNNlm4tcqNdXHcmAt
	 96cp4wio9cF3A==
Message-ID: <sashiko-outbox-235695@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 05/14] nvme-keyring: link addtional keyring into
 .nvme keyring
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hannes Reinecke" <hare@kernel.org>, "Keith Busch" <kbusch@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, "Hannes
 Reinecke" <hare@suse.de>, "Chaitanya Kulkarni" <kch@nvidia.com>, "Eric
 Biggers" <ebiggers@kernel.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Kees
 Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org
In-Reply-To: <20261126-dhchap-keyring-v4-v7-5-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-5-ee438ffea527@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:24:11 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [High] nvme-fabrics: NULL deref and key leak linking opts->keyring in
  nvmf_parse_options()
- [High] nvme-keyring: broken !CONFIG_NVME_KEYRING stubs in
  include/linux/nvme-keyring.h
- [High] nvme-keyring: non-recursive keyring_search() in
  nvme_tls_psk_lookup() skips linked keyrings
- [High] nvme-tcp: nvme_tcp_start_tls() still passes opts->keyring
  instead of .nvme to tlshd
- [Medium] nvme-fabrics: unrefcounted keyring link/unlink breaks shared
  keyrings and triggers WARN_ON
- [Low] nvme: unreachable default keyring fallback in tls_keyring_show()
- [Low] nvme-keyring: stale @keyring reference in nvme_tls_psk_refresh()
  kernel-doc
--

commit baf89e86a63698b34af74abf311ec9f03c1d91b9
Author: Hannes Reinecke <hare@kernel.org>

nvme-keyring: link addtional keyring into .nvme keyring

This commit links any user-specified keyring into the default .nvme keyring
for the lifetime of the controller options and updates TLS PSK lookup and
refresh helpers to operate directly on the .nvme keyring.

> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> index 373f51e1032a4..0fc6b4825c2dd 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
[ ... ]
> @@ -104,12 +120,8 @@ static struct key *nvme_tls_psk_lookup(struct key *k=
eyring,
>  	snprintf(identity, identity_len, "NVMe%u%c%02u %s %s",
>  		 psk_ver, generated ? 'G' : 'R', hmac, hostnqn, subnqn);
> =20
> -	if (!keyring)
> -		keyring =3D nvme_keyring;
> -	keyring_id =3D key_serial(keyring);
> -	pr_debug("keyring %x lookup tls psk '%s'\n",
> -		 keyring_id, identity);
> -	keyref =3D keyring_search(make_key_ref(keyring, true),
> +	pr_debug("lookup tls psk '%s'\n", identity);
> +	keyref =3D keyring_search(make_key_ref(nvme_keyring, true),
>  				&nvme_tls_psk_key_type,
>  				identity, false);

[Severity: High]
Should keyring_search() pass recurse =3D true here?  With recurse =3D false,
KEYRING_SEARCH_RECURSE is not set, so keyring_search() only checks the
top-level nvme_keyring and never descends into keyrings linked via
nvme_keyring_link(), causing nvme_tls_psk_default() lookups for keys in
linked keyrings to fail with -ENOKEY.

>  	if (IS_ERR(keyref)) {
> @@ -125,7 +137,6 @@ static struct key *nvme_tls_psk_lookup(struct key *ke=
yring,
> =20
>  /**
>   * nvme_tls_psk_refresh - Refresh TLS PSK
> - * @keyring: Keyring holding the TLS PSK
>   * @hostnqn: Host NQN to use
>   * @subnqn: Subsystem NQN to use
>   * @hmac_id: Hash function identifier

[Severity: Low]
This isn't a bug, but the kernel-doc body just below this hunk still says
"in the keyring given by @keyring" after the @keyring parameter was
removed.

[ ... ]
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 295e0a9533c89..06399c0754053 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -726,8 +726,7 @@ static int nvme_auth_secure_concat(struct nvme_ctrl *=
ctrl,
>  		goto out_free_digest;
>  	}
> =20
> -	tls_key =3D nvme_tls_psk_refresh(ctrl->opts->keyring,
> -				       ctrl->opts->host->nqn,
> +	tls_key =3D nvme_tls_psk_refresh(ctrl->opts->host->nqn,
>  				       ctrl->opts->subsysnqn, chap->hash_id,
>  				       tls_psk, psk_len, digest);
>  	if (IS_ERR(tls_key)) {

[Severity: High]
When secure concatenation is used with a custom keyring,
nvme_tls_psk_refresh() now inserts the generated PSK into the default .nvme
keyring, but doesn't nvme_tcp_start_tls() still pass nctrl->opts->keyring
to tlshd?

drivers/nvme/host/tcp.c:nvme_tcp_start_tls() {
	...
	key_serial_t keyring =3D nvme_keyring_id();
	...
	if (nctrl->opts->keyring)
		keyring =3D key_serial(nctrl->opts->keyring);
	args.ta_keyring =3D keyring;
	...
}

Because nctrl->opts->keyring is linked beneath .nvme and not the other way
around, tlshd searches nctrl->opts->keyring instead of .nvme and fails to
find the generated PSK.

> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 5ed91557f0706..6a918d72d14c5 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -995,7 +995,11 @@ static int nvmf_parse_options(struct nvmf_ctrl_optio=
ns *opts,
>  				ret =3D PTR_ERR(key);
>  				goto out;
>  			}
> -			key_put(opts->keyring);
> +			ret =3D nvme_keyring_link(opts->keyring);
> +			if (ret) {
> +				key_put(key);
> +				goto out;
> +			}
>  			opts->keyring =3D key;
>  			break;

[Severity: High]
Does nvme_keyring_link(opts->keyring) pass NULL on the first keyring=3D
option instead of linking the newly parsed key?  key_link() immediately
dereferences its key argument via key_check(key) and &key->index_key,
causing a NULL pointer dereference oops when connecting with keyring=3D.

Also, if keyring=3D is specified more than once in the option string,
overwriting opts->keyring without unlinking and calling key_put() on the
previous opts->keyring leaks the earlier keyring reference and link.

> @@ -1296,7 +1300,12 @@ static int nvmf_check_allowed_opts(struct nvmf_ctr=
l_options *opts,
>  void nvmf_free_options(struct nvmf_ctrl_options *opts)
>  {
>  	nvmf_host_put(opts->host);
> -	key_put(opts->keyring);
> +	if (opts->keyring) {
> +		int ret =3D nvme_keyring_unlink(opts->keyring);
> +
> +		WARN_ON(ret);
> +		key_put(opts->keyring);
> +	}
>  	key_put(opts->tls_key);

[Severity: Medium]
What happens if two controllers (or an active controller and a failed
connection attempt) specify the same keyring?  key_link() only maintains a
single link to a given key in nvme_keyring rather than a reference count,
so freeing the first controller unlinks the keyring from .nvme while the
second controller still uses it, and freeing the second controller fails
with -ENOENT and triggers WARN_ON(ret).

> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 35f871e3e0c0a..c1375f23a97f6 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
[ ... ]
> @@ -1069,6 +1070,8 @@ static ssize_t tls_keyring_show(struct device *dev,
>  	struct nvme_ctrl *ctrl =3D dev_get_drvdata(dev);
>  	struct key *keyring =3D ctrl->opts->keyring;
> =20
> +	if (!keyring)
> +		return sysfs_emit(buf, "%s\n", nvme_keyring_name());
>  	return sysfs_emit(buf, "%s\n", keyring->description);
>  }
>  static DEVICE_ATTR_RO(tls_keyring);

[Severity: Low]
Is this !keyring branch reachable?  nvme_tls_attrs_are_visible() still
hides dev_attr_tls_keyring when !ctrl->opts->keyring:

drivers/nvme/host/sysfs.c:nvme_tls_attrs_are_visible() {
	...
	if (a =3D=3D &dev_attr_tls_keyring.attr &&
	    !ctrl->opts->keyring)
		return 0;
	...
}

> diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
> index ab8971afa9734..680eb93088d48 100644
> --- a/include/linux/nvme-keyring.h
> +++ b/include/linux/nvme-keyring.h
> @@ -10,20 +10,22 @@
> =20
>  #if IS_ENABLED(CONFIG_NVME_KEYRING)
> =20
> -struct key *nvme_tls_psk_refresh(struct key *keyring,
> -		const char *hostnqn, const char *subnqn, u8 hmac_id,
> -		u8 *data, size_t data_len, const char *digest);
> -key_serial_t nvme_tls_psk_default(struct key *keyring,
> -		const char *hostnqn, const char *subnqn);
> +struct key *nvme_tls_psk_refresh(const char *hostnqn, const char *subnqn,
> +		u8 hmac_id, u8 *data, size_t data_len, const char *digest);
> +key_serial_t nvme_tls_psk_default(const char *hostnqn, const char *subnq=
n);
> =20
>  key_serial_t nvme_keyring_id(void);
> +const char *nvme_keyring_name(void);
> +int nvme_keyring_link(struct key *keyring);
> +int nvme_keyring_unlink(struct key *keyring);
>  struct key *nvme_tls_key_lookup(key_serial_t key_id);
> +
>  #else
>  static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
> -		const char *hostnqn, char *subnqn, u8 hmac_id,
> +		const char *hostnqn, const char *subnqn, u8 hmac_id,
>  		u8 *data, size_t data_len, const char *digest)
>  {
> -	return ERR_PTR(-ENOTSUPP);
> +	return ERR_PTR(-EOPNOTSUPP);
>  }
>  static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
>  		const char *hostnqn, const char *subnqn)
> @@ -34,9 +36,21 @@ static inline key_serial_t nvme_keyring_id(void)
>  {
>  	return 0;
>  }
> +static const char *nvme_keyring_name(void)
> +{
> +	return NULL;
> +}
> +static int nvme_keyring_link(struct key *keyring)
> +{
> +	return 0;
> +}
> +int nvme_keyring_unlink(struct key *keyring)
> +{
> +	return 0;
> +}

[Severity: High]
Does the !CONFIG_NVME_KEYRING build fail here?

The nvme_tls_psk_refresh() and nvme_tls_psk_default() stubs still take
struct key *keyring as their first argument, breaking compilation of
callers like nvme_tcp_alloc_admin_queue() when CONFIG_NVME_KEYRING is
disabled.  In addition, nvme_keyring_unlink() is missing "static inline"
(causing multiple-definition link errors across translation units including
this header), and nvme_keyring_name() and nvme_keyring_link() are missing
"inline" (triggering unused-function warnings).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-dhchap-key=
ring-v4-v7-0-ee438ffea527@kernel.org?part=3D5
