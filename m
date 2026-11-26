Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795703520;
	b=JPicF3++r8oQPeHwotLolAs/unVvyEjCAwwDSaqkhViu+p30k9SMnrYnZ5wx2ubM4ilr
	 Ucna7w0l7uTxy2WcnzsoMBXNJhaA5WJwMyv5Q56+0cUfUlnNipwFmWhGw1CETqW76nM5J
	 fIiAX80tdT3pEsjbs0R5KNcTLTEfOD35d/ztisCkWEwYzBmYORYWwOnziAph9nsxhrZ9H
	 k5ZF8KyIfP9PZNrqUrUqPWLWvvTBKtyG+GKLumIOm4K+OX7gIlk3utPfG6dvueC2uhRWY
	 CTTZTAvhE6OXzAdpVNWMw1fjaVPp2lI1qAY8bIM+khVHCJJ4VOFmKaknUrHkOXgNhUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795703520;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=hbJvix+pEN3wYWsB9mjyNccyf1Am2M7XJBMuN4g3MLU=;
	b=vwoBmid4sdVAAcBkW3hPShutZhLieK5nul5JjNPoA60HhpVz3jGkAYxHyCiWtEUFDWja
	 Ya79F1XxM7qDLXs92NxpAJsBaCS/onVl688Uet5Xm+tNkafpL5UsxaXzrus/EpDVepvIi
	 Keeey2Nsvt7aJSIt5u4yY5opNWVRE5qoVT/MbQycUlDPaDH53fuKYNoI3G6vgPKwJg05J
	 /weomv09LJ89mePhw8H2QCIY6zbrnESrSUZ7fZXMRF8rlq+rgAqx0UyUvIBI34UcXwdZC
	 BGWomZfE/Xoe25eFbNfKJMXblasyAbSd7kg9MgJrHNrK652r3+/6v4KRmt1RxxzqqWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7bR497l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E045606A68B
	for <keyrings@vger.kernel.org>; Thu, 26 Nov 2026 14:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D7bR497l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6AB1F000C4;
	Thu, 26 Nov 2026 14:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703519;
	bh=hbJvix+pEN3wYWsB9mjyNccyf1Am2M7XJBMuN4g3MLU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D7bR497lt3X8xX/rFM9SpfPdHXGSYoDqdD0l5iZHsn0Aoq8CrSoQCIhbzlCN3pHx+
	 zOGPH17zRC4bdR10+Q1kMnWsPAEgmWMn8kAzolqYMJUaIBw3bl/XxQdEs3NeOUAuDK
	 pa0stz7Ih5SrTgFsvSmVL9L4SMwFI1m2SUWEWV7xd9T7FwGvNSH4DaZqIXuepY8vT3
	 K576v9lsDER40muwjsJC6/9Q/+HOeNAveVIJo3i3Dw/98Bkldspk83/6k4CsEw6A96
	 SYnCEaHssTdMdzuryqbwPwFQ6GFk0tG4OyA7o+MA43tBLhQD+punHM5MToEtDEQBlB
	 5B+EInT8UjPJA==
Message-ID: <sashiko-outbox-235712@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 14/14] nvme-auth: allow to update pre-provisioned
 keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hannes Reinecke" <hare@kernel.org>, "Keith Busch" <kbusch@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, "Hannes
 Reinecke" <hare@suse.de>, "Chaitanya Kulkarni" <kch@nvidia.com>, "Eric
 Biggers" <ebiggers@kernel.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Kees
 Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org, "Martin
 Belanger" <martin.nvme.dev@gmail.com>
In-Reply-To: <20261126-dhchap-keyring-v4-v7-14-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-14-ee438ffea527@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:31:58 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] nvme-auth: uninitialized old_key dereference in
  dhchap_*_secret_store()
- [High] nvme-keyring: .update callback added to psk instead of dhchap
  key_type
- [Medium] nvme-auth: wrong pre-populated key check in
  dhchap_*_secret_store()
--

commit 3ccb1f2ff3d815bafe5e4d68e5e266a56f5a6f51
Author: Hannes Reinecke <hare@kernel.org>

nvme-auth: allow to update pre-provisioned keys

This commit attempts to support rotating pre-provisioned DH-HMAC-CHAP keys
via keyctl update by adding a key_type .update callback and disallowing
sysfs key replacements for pre-populated controller keys.

> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> index bee64c592752a..ffabd37cd090d 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
> @@ -100,6 +100,7 @@ static struct key_type nvme_tls_psk_key_type =3D {
>  	.free_preparse  =3D user_free_preparse,
>  	.match_preparse =3D nvme_tls_psk_match_preparse,
>  	.instantiate    =3D generic_key_instantiate,
> +	.update         =3D user_update,
>  	.revoke         =3D user_revoke,
>  	.destroy        =3D user_destroy,
>  	.describe       =3D nvme_tls_psk_describe,

[Severity: High]
Was .update added to nvme_tls_psk_key_type instead of
nvme_dhchap_psk_key_type?  Because nvme_dhchap_psk_key_type still has no
.update callback, calling keyctl update on a dhchap key fails with
-EOPNOTSUPP.

> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 0ffea12fcfb6b..0eb68b3973a1e 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -887,9 +887,17 @@ static ssize_t dhchap_secret_store(struct device *de=
v,
>  		kfree_sensitive(dhchap_secret);
>  		return ret;
>  	}
> +	if (!generated &&
> +	    key_serial(old_key) !=3D key_serial(key)) {

[Severity: Medium]
Should this check !ctrl->host_key_generated under ctrl->dhchap_auth_mutex
instead of !generated (and similarly !ctrl->ctrl_key_generated in
dhchap_ctrl_secret_store())?

nvme_auth_extract_key() sets generated based on whether the newly written
sysfs input is a raw DHHC-1 secret or an existing key lookup, not whether
the controller's current key was pre-populated.  Writing a raw DHHC-1
secret sets generated =3D true, bypassing this check and overwriting a
pre-populated ctrl->host_key with a newly generated key, while writing a
pre-populated key identifier to a controller that currently uses a
generated key is rejected with -EPERM.

> +		dev_warn(ctrl->device, "cannot change pre-populated key %08x\n",
> +			 key_serial(old_key));
> +		key_put(key);
> +		kfree_sensitive(dhchap_secret);
> +		return -EPERM;
> +	}
>  	mutex_lock(&ctrl->dhchap_auth_mutex);
>  	old_key =3D ctrl->host_key;

[Severity: High]
Does key_serial(old_key) dereference an uninitialized old_key pointer in
both dhchap_secret_store() and dhchap_ctrl_secret_store()?

old_key is declared on the stack without an initializer and is only
assigned from ctrl->host_key (or ctrl->ctrl_key) after acquiring
ctrl->dhchap_auth_mutex below.  When writing a pre-populated key to sysfs
(generated =3D=3D false), key_serial(old_key) reads old_key->serial from the
uninitialized pointer, or returns 0 when CONFIG_INIT_STACK_ALL_ZERO=3Dy and
causes every re-authentication write to fail with -EPERM.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-dhchap-key=
ring-v4-v7-0-ee438ffea527@kernel.org?part=3D14
