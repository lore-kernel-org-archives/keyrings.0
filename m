Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703239;
	b=R0WhAXDa8OAZ1f821nL5V4jeTRm6dhm9OMbcauWmZU900EOFk9vgHPLqvLmEeD8vsU1j
	 l3GZP+4s4kF1wGezEmL+bhlHx6XnWJzXYkqwy4dzxQ7tskptXymgwKEgZ5F1dqQ9ed5YS
	 2OX7O1/a9Q79I2N7Yw38Xu1kF0yZUTuzeDibJAd1rwBxLb/iJJhcXk+kOaHGeMafe7BGn
	 R79VFPFhXSpK6If9N4+QpekBVJcD7H+X6AstV6wWTDpX4zcCyT+CPV82CdE5yLUnJmJd1
	 RJJ03PYZmbe0L9vfW9MkzFerkNFt7wASOJg1dpsN9DcKaGOq0m7nmq7Ewd05xVFCCNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703239;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bzF7X//bLpCBs6cSPuMmVlyG/tp4lZhnQW2bHEAVofk=;
	b=rcVvF5I/B7bXswMW98Ql2ML3F7TxVuMTt0BI2bFm5VmDljzcOMGghfwx4OgIXYIo+Pun
	 oeqb5P054hA30im9/L1VerRaCevP9azWVzAliahoxWgqCVVg7EkN3fuK2I0RJOob9Yp+p
	 eib5tVB5D7M3C+086wb/cOM+HLgPOHwRbbbW5IPugsaN+t8ptqFILgcgBGAn/M0MrKdXQ
	 coGgsqyL2C0BK7dXtB8FPF0o1EIhkpoKpkkjS7zybu+kN5cXjRmJM+rNz9vyQakLqXg29
	 wSBFLCA86ynolroANpFS+L0VUj+PevnDk029VmkIc0jVMtIeIrKWkUkxkPng3p67/4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fwwjUc+P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3AE9606A31C
	for <keyrings@vger.kernel.org>; Thu, 26 Nov 2026 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fwwjUc+P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1551D1F000C6;
	Thu, 26 Nov 2026 14:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703238;
	bh=bzF7X//bLpCBs6cSPuMmVlyG/tp4lZhnQW2bHEAVofk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fwwjUc+PVuYr/geKSH0AHq5B9/urxue/BLVB8QkSvGU8Fsr9D+O8r6mqnRQQ/ex8X
	 is8QH3eXo/pUnuW2Cpuzy2ZZOa8Y6YPvFUjsfr1mwJ/MzXAOqJuqXPSe5T1fnx+ALX
	 qFtsZaHWvHzHDebnz++fFZndVJVCl8TdAk0umCDVRub3O2AnkRF9bHdPRXGfrCToIw
	 kcmHAZFYrQurvYw2Jf7KvNpB/J2IAnrvScxZ8rw5Ci8J9ZTMW3CBZWzUJQVyFoqzYW
	 i8cUaBrGqvU3HefLF9Uug0djLsv3jAtk5ESDzMKNaF72wVBOQWdkkKOQ6O5S4Fn76M
	 F4a68JVB4YOFQ==
Message-ID: <sashiko-outbox-235701@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/14] nvme: allow to pass in key description as
 dhchap secret
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hannes Reinecke" <hare@kernel.org>, "Keith Busch" <kbusch@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, "Hannes
 Reinecke" <hare@suse.de>, "Chaitanya Kulkarni" <kch@nvidia.com>, "Eric
 Biggers" <ebiggers@kernel.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Kees
 Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org
In-Reply-To: <20261126-dhchap-keyring-v4-v7-9-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-9-ee438ffea527@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:27:17 +0000
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
- [High] nvme-auth: ERR_PTR dereference after key_lookup() in show and
  init helpers
- [Medium] nvmet-auth: wrong generated flag updated in
  nvmet_auth_update_key()
--

commit 23f2a5a7beef9101cd52fed1a3096af44469d991
Author: Hannes Reinecke <hare@kernel.org>

nvme: allow to pass in key description as dhchap secret

This commit updates nvme_auth_extract_key() to look up pre-populated
keys by description in addition to generating keys from raw secret data,
and tracks whether keys were auto-generated so pre-populated keys are
not revoked on teardown.

> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index ff0e8569d7067..54e79c8a7cae6 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -20,31 +20,38 @@
>  #include "nvmet.h"
> =20
>  static void nvmet_auth_update_key(struct nvmet_host *host, bool set_ctrl,
> -				  struct key *new_key)
> +				  struct key *new_key, bool new_generated)
>  {
>  	key_serial_t old_key_id =3D 0, new_key_id =3D key_serial(new_key);
>  	struct key *key =3D NULL;
> +	bool generated =3D false;
> =20
>  	if (set_ctrl) {
>  		if (host->dhchap_ctrl_key) {
>  			if (host->dhchap_ctrl_key =3D=3D new_key_id) {
> -				if (new_key)
> +				if (new_key && new_generated)
>  					key_revoke(new_key);
>  				return;
>  			}
>  			old_key_id =3D host->dhchap_ctrl_key;
> +			generated =3D host->dhchap_ctrl_key_generated;
> +			host->dhchap_ctrl_key_generated =3D false;
>  		}
>  		host->dhchap_ctrl_key =3D new_key_id;
> +		host->dhchap_key_generated =3D new_generated;

[Severity: Medium]
Should the set_ctrl branch update host->dhchap_ctrl_key_generated instead
of host->dhchap_key_generated?

As written, host->dhchap_ctrl_key_generated remains false, so
nvmet_host_dhchap_ctrl_key_show() prints the internal UUID description
instead of the secret for auto-generated controller keys and replacing or
clearing the controller key never revokes it.  At the same time, setting
or clearing the controller key overwrites host->dhchap_key_generated,
which can cause a pre-populated host key to be revoked or an
auto-generated host key to be leaked.

[ ... ]

> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configf=
s.c
> index f6bfda757f076..3defa3f948497 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -2248,13 +2248,15 @@ static ssize_t nvmet_host_dhchap_key_show(struct =
config_item *item,
>  		down_read(&key->sem);
>  		if (key_validate(key))
>  			ret =3D sprintf(page, "<invalidated>\n");
> -		else {
> +		else if (host->dhchap_key_generated) {
>  			ret =3D key->type->read(key, page, PAGE_SIZE);
>  			if (ret > 0) {
>  				page[ret] =3D '\n';
>  				ret++;
>  			}
> -		}
> +		} else
> +			ret =3D scnprintf(page, PAGE_SIZE,
> +					"%s\n", key->description);
>  		up_read(&key->sem);
>  		key_put(key);
>  	}

[Severity: High]
Can nvmet_host_dhchap_key_show() and nvmet_host_dhchap_ctrl_key_show()
dereference an error pointer when the key is unset or has been unlinked?

drivers/nvme/target/configfs.c:nvmet_host_dhchap_key_show() {
	down_read(&nvmet_config_sem);
	key =3D key_lookup(host->dhchap_key);
	if (!key) {
		page[0] =3D '\0';
		ret =3D 0;
	} else {
		down_read(&key->sem);
...
}

key_lookup() returns ERR_PTR(-ENOKEY) rather than NULL when a key serial
is not found (including when host->dhchap_key is 0), so the !key check
falls through to the else branch and dereferences ERR_PTR(-ENOKEY) in
down_read(&key->sem).  nvme_auth_init_ctrl() and nvmet_setup_auth() also
check !host_key and !ctrl_key instead of IS_ERR() after key_lookup(),
which can similarly oops if a pre-populated key was unlinked after option
or configfs parsing dropped its reference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-dhchap-key=
ring-v4-v7-0-ee438ffea527@kernel.org?part=3D9
