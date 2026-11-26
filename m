Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703450;
	b=Gb5eA+lMse/qYjn7QfIWSxYEiixRmwj3orpqhNaq9cZSmYDDZ14YGF61PqMTW4WbVEPD
	 JBRJ5uzug0zuNUt76gM2ZuA7joajfQK1sDxFdYZ6ZzWQSSMLe6YYGhLdzb7xr85RPZrIo
	 4q+J44gQo1Jm6MoJSfoYZNbOugndYzEC+HFprfFypSMwJL1mIhiswiBtCRmPFAyf8qNns
	 OpjNpHK4ErKNxqpY7+hwWa32j3dtT7hBXuhffm06fWtYyBt4kjC4K/PF1jQEiV2fTNl8g
	 VVSgyX5jb7QZHgcJspyJ0o8GQgxV/80CTa1WCgiM2ls9M9lxraulcLgzG+ZE2OU+rpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703450;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P9wshFdtYcyCOkhncepQ/tnlZC/sU0rmaigBNw3t2p4=;
	b=SlvK70EWCXrJB243sKZcuv2pC1VrAn20mqQcYkpRuRwuQJJSXzXkKdVgq2W9Jg9F5HyB
	 CuX/cjzNTofsQwdz4rC8ES1oSQ6CqoYXandNNEJI+GwG1fiUPaY2578vDZTZaXVmcR9v8
	 sny4WjHoXv6shwbQSyDnE3S5vd3Lpx6/fcDKl/674wrxsVwVGVk+zYhJ+HVobzFkxbiH6
	 NMIeKsoxkBYuybJtMZiIQG2+uVyOsIivZZBPHbFS4zxkdMxGaIsSBX60kR7N9z1icu+vk
	 iT/47RH9grGp5HiPpDVvIeJE8ug3FyV6Zi2pREFXx7jZJeIwOTsC2nu15Mo/j7YGbrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZroeW6+o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85723606A6A6
	for <keyrings@vger.kernel.org>; Thu, 26 Nov 2026 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZroeW6+o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5507D1F000ED;
	Thu, 26 Nov 2026 14:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703450;
	bh=P9wshFdtYcyCOkhncepQ/tnlZC/sU0rmaigBNw3t2p4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZroeW6+onBOTxwaE8tFS29BaIHC9syuHqhwFEHJC6HDxo8VE1QhnClFC3taEToUfp
	 eiuyJCGkrofjBnMkkMMOG6grPSN0VcCE8BH4eY+kZW3Ky9jYAmfHtciPAj205oPBzY
	 i9NPwCrMIbB6ELexL+Pr794OcJZX2xwwzgfoME729HRCGNXwXaJsDmmNq3eIfn0xbJ
	 tQTb1kquek/D9/nUWjiy1vBrV/3f1QdNIh6VDOezwwH/v8+9AP7G3zRUutmdOxMTZv
	 FA3PP4bSOz2SNVaFYIdK4ZrlTMkzeSfd3yw3Zvy970OI3C6wy0NpKtYPGV0nLfELMp
	 8rpYIFGAv3mtg==
Message-ID: <sashiko-outbox-235710@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/14] nvme-auth: link pre-provisioned keys into
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
In-Reply-To: <20261126-dhchap-keyring-v4-v7-13-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-13-ee438ffea527@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:30:48 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] nvme-auth: nvme_keyring_unlink() removes shared or .nvme
  pre-provisioned keys
- [Medium] nvmet-auth: nvmet_auth_update_key() mutates host state before
  linking key
- [Medium] nvmet-auth: nvmet_auth_update_key() sets wrong generated flag
  for ctrl key
- [Low] nvmet-auth: nvmet_auth_update_key() logs new_key serial on
  unlink failure
--

commit 03391c2ce04bdc0cd535d7de4d681251fe291e19
Author: Hannes Reinecke <hare@kernel.org>

nvme-auth: link pre-provisioned keys into .nvme keyring

This commit links pre-provisioned DH-HMAC-CHAP keys into the .nvme keyring
when parsed on the host or set on the target, and unlinks them when the
options or host keys are cleared or replaced.

> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 12a30ed16f9ef..e7f51474ab5e1 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c

[ ... ]

> @@ -1346,23 +1366,27 @@ void nvmf_free_options(struct nvmf_ctrl_options *=
opts)
>  	struct key *key;
> =20
>  	nvmf_host_put(opts->host);
> -	if (opts->dhchap_key &&
> -	    opts->dhchap_key_generated) {
> +	if (opts->dhchap_key) {
>  		key =3D key_lookup(opts->dhchap_key);
>  		if (!IS_ERR(key)) {
> -			pr_debug("revoke dhchap host key %08x\n",
> -				 opts->dhchap_key);
> -			key_revoke(key);
> +			if (opts->dhchap_key_generated) {
> +				pr_debug("revoke dhchap host key %08x\n",
> +					 opts->dhchap_key);
> +				key_revoke(key);
> +			} else
> +				nvme_keyring_unlink(key);
>  			key_put(key);
>  		}
>  	}

[Severity: High]
Does nvme_keyring_unlink() remove a pre-provisioned key that originally
lived in the .nvme keyring or is shared across multiple controllers?

Keyring links are indexed by key type and description rather than
reference-counted, so key_link() replaces an existing link in .nvme in
place and key_unlink() deletes that sole link.  A pre-provisioned key
placed directly in .nvme (as required when looking up keys by description
via nvme_dhchap_psk_lookup()) is removed from .nvme as soon as the first
controller disconnects or fails to connect, and a key from another keyring
that is shared across controllers or target hosts is unlinked from .nvme
while other users still depend on it.

[ ... ]

> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index 54e79c8a7cae6..04a9177ffa1f4 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -19,19 +19,20 @@
> =20
>  #include "nvmet.h"
> =20
> -static void nvmet_auth_update_key(struct nvmet_host *host, bool set_ctrl,
> +static int nvmet_auth_update_key(struct nvmet_host *host, bool set_ctrl,
>  				  struct key *new_key, bool new_generated)
>  {
>  	key_serial_t old_key_id =3D 0, new_key_id =3D key_serial(new_key);
>  	struct key *key =3D NULL;
>  	bool generated =3D false;
> +	int ret;
> =20
>  	if (set_ctrl) {
>  		if (host->dhchap_ctrl_key) {
>  			if (host->dhchap_ctrl_key =3D=3D new_key_id) {
>  				if (new_key && new_generated)
>  					key_revoke(new_key);
> -				return;
> +				return 0;
>  			}
>  			old_key_id =3D host->dhchap_ctrl_key;
>  			generated =3D host->dhchap_ctrl_key_generated;
> @@ -44,7 +45,7 @@ static void nvmet_auth_update_key(struct nvmet_host *ho=
st, bool set_ctrl,

[Severity: Medium]
In the set_ctrl branch of nvmet_auth_update_key(), does
"host->dhchap_key_generated =3D new_generated" right after
"host->dhchap_ctrl_key =3D new_key_id" overwrite the host key's flag instead
of host->dhchap_ctrl_key_generated?

That leaves host->dhchap_ctrl_key_generated false so generated controller
keys are unlinked instead of revoked, while clobbering
host->dhchap_key_generated so a pre-provisioned host key can be revoked by
key_revoke() when later replaced or cleared.

>  			if (host->dhchap_key =3D=3D new_key_id) {
>  				if (new_key && new_generated)
>  					key_revoke(new_key);
> -				return;
> +				return 0;
>  			}
>  			old_key_id =3D host->dhchap_key;
>  			generated =3D host->dhchap_key_generated;
> @@ -53,18 +54,37 @@ static void nvmet_auth_update_key(struct nvmet_host *=
host, bool set_ctrl,
>  		host->dhchap_key =3D new_key_id;
>  		host->dhchap_key_generated =3D new_generated;
>  	}
> +	if (new_key && !new_generated) {
> +		ret =3D nvme_keyring_link(new_key);
> +		if (ret < 0) {
> +			pr_warn("%s: failed to link %s key %08x\n",
> +				__func__, set_ctrl ? "ctrl" : "host",
> +				key_serial(new_key));
> +			return ret;
> +		}
> +	}

[Severity: Medium]
If nvme_keyring_link(new_key) fails here, does this early return leave
host->dhchap_key or host->dhchap_ctrl_key updated to new_key_id while
leaking old_key_id?

Because the host fields are overwritten before linking new_key, an error
from nvme_keyring_link() skips revoking or unlinking old_key_id and leaves
the unlinked new_key_id installed on host.

> +
>  	if (!old_key_id)
> -		return;
> +		return 0;
> =20
>  	key =3D key_lookup(old_key_id);
>  	if (IS_ERR(key))
> -		return;
> +		return PTR_ERR(key);
>  	if (generated) {
>  		pr_debug("%s: revoke %s key %08x\n", __func__,
>  			 set_ctrl ? "ctrl" : "host", key_serial(key));
>  		key_revoke(key);
> +		ret =3D 0;
> +	} else {
> +		ret =3D nvme_keyring_unlink(key);
> +		if (ret < 0) {
> +			pr_warn("%s: failed to unlink %s key %08x\n",
> +				__func__, set_ctrl ? "ctrl" : "host",
> +				key_serial(new_key));
> +		}
>  	}

[Severity: Low]
Should this pr_warn() log key_serial(key) instead of key_serial(new_key)
when unlinking the old key fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-dhchap-key=
ring-v4-v7-0-ee438ffea527@kernel.org?part=3D13
