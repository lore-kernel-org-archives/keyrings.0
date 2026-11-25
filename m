Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795578493;
	b=0ZQB/KncYAJELn06wgk3tKWb/d0+czYA1voAhPUnnTCxbfVNZSnr5vPtL5/RdaRE5jmU
	 hOakWQJpjHAyGmZG727WU3OvzBdifljMRZwNzQIcI7xcn8LWrgVrQLL0NfeJlTE02Uy+Q
	 4wun6o7oIAf6Vj11eUsLBmSiAob6WgourK+Qm4CAKLfo7QFhFphM3maO/m5vzNtgbC+Eb
	 ChYiN2ChqOPAx+xd2mqtdYxHAe43kxGzBWZ60aV6avNNrKc5YiTX41gWLEGWQpyWRDppp
	 ZLBQdvRxQUKfh2nG1sBTF0XXjAgBtcENKEO/WINSmB1R6e7x9zPFmTxTM+ohRie+YgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795578493;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sZlWG8KSf2B+qIgxeb2zRTtQXe9bgyjzLBrTYGtF4uk=;
	b=eHWCFLw0klz4I/l/kl9MUsTpdPRXDkMXMkS/SO21LH3aGSnMsT+VpsHTxWrolYnc8Od5
	 3fuYjiOV6G8sOX7ilougoK17rHMdPObtxFJgBEBpyO1hOZ0XAJ0EcVV7LqrvQ1W7+f8j2
	 pw4b/GRQqtqk7nu62n5WQAXTAGGBwcG+CPB5mfPr5mJ8E4V8nfvHlluuoG1/9oJ5rWuu9
	 hiiHWM5535GlNUTlB9OrkZgGDOMC3oX/wlUW6gi5skCp6tCnD0I1rodT/yAZKTVrGm2if
	 4FYWVWFE1P7pNMO9F37DQP1BYs7PoFmcN4qB1jkAzsDU8rz82JjouzlHAQPqtfxQBxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNMPybs3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA19606A31E;
	Wed, 25 Nov 2026 03:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNMPybs3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49521F000CA;
	Wed, 25 Nov 2026 03:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795578493;
	bh=sZlWG8KSf2B+qIgxeb2zRTtQXe9bgyjzLBrTYGtF4uk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HNMPybs3vlV7QUoUHcVAMGojAqYzSo31dYi8v3MtaLoWbLvdCFsV5aClPt44eeafj
	 22X4DNrBOudc2fcWozuvNowa6xacI9rFZN5wDEByuVnv7lTFrprwwVfDsRhiU2XKev
	 UTtWwuWkuF2rroc/F4KGFOKpDNs009uf2IFKbLm6LOJNirFIPjrJkZDsgzTRBXcoml
	 q7cQ5cxUYoW5uDWv/QAmBdAxpdMdgpOy5FAsiQ/zfzuSL6bMmHWwYs/Ko0DKd7/nxe
	 5SMT6mivRLSv1mRYYcwGRpRXI3B4hI2hib6meMn8wNJgJ5eKazCXzsk/woQUotOouP
	 M3LXaE9f30Uvg==
Message-ID: <sashiko-outbox-232506@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] KEYS: Protect key instantiation and rejection
 against type removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guicai Ma" <maguicai@kylinos.cn>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>
Cc: "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge
 E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261125032605.1327954-1-maguicai@kylinos.cn>
References: <20261124091243.1019217-1-maguicai@kylinos.cn>
 <20261125032605.1327954-1-maguicai@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 03:48:12 +0000
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
- [Medium] KEYS: key_reject_and_link() locks key->sem with freed modular
  lockdep class
--

commit c70f356b6ccdc592f27c6c5e32e3b0a02a265eb1
Author: Guicai Ma <maguicai@kylinos.cn>

KEYS: Protect key instantiation and rejection against type removal

This commit guards key_instantiate_and_link() and key_reject_and_link()
with key_type_srcu and a KEY_FLAG_DEAD check, and waits with
synchronize_srcu(&key_type_srcu) after pass 1 of key_garbage_collector()
marks dead keys.

> diff --git a/security/keys/key.c b/security/keys/key.c
> index df31d1024340e..7f346e87a818c 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c

[ ... ]

> @@ -591,22 +619,42 @@ int key_reject_and_link(struct key *key,
>  	awaken =3D 0;
>  	ret =3D -EBUSY;
> =20
> +	/*
> +	 * Hold key_type_srcu across linking into @keyring and
> +	 * key_set_expiry() (which reads key->type->flags).  If the key is
> +	 * already marked dead, skip linking and expiry but still complete
> +	 * negative instantiation so waiters are woken and @authkey is
> +	 * invalidated.
> +	 */
> +	srcu_idx =3D srcu_read_lock(&key_type_srcu);
> +	dead =3D test_bit(KEY_FLAG_DEAD, &key->flags);
> +
>  	if (keyring) {
> -		link_ret =3D __key_link_lock(keyring, &key->index_key);
> -		if (link_ret =3D=3D 0) {
> -			/*
> -			 * Check the restriction under the keyring semaphore.
> -			 * keyring_restrict() installs it while holding the
> -			 * semaphore, so testing it beforehand races with a
> -			 * concurrent restriction install.
> -			 */
> -			if (keyring->restrict_link) {
> -				__key_link_end(keyring, &key->index_key, edit);
> -				return -EPERM;
> +		if (dead) {
> +			link_ret =3D -EKEYREVOKED;
> +		} else {
> +			link_ret =3D __key_link_lock(keyring, &key->index_key);
> +			if (link_ret =3D=3D 0) {
> +				/*
> +				 * Check the restriction under the keyring
> +				 * semaphore. keyring_restrict() installs it
> +				 * while holding the semaphore, so testing it
> +				 * beforehand races with a concurrent
> +				 * restriction install.
> +				 */
> +				if (keyring->restrict_link) {
> +					__key_link_end(keyring, &key->index_key,
> +						       edit);
> +					ret =3D -EPERM;
> +					goto out;
> +				}
> +				link_ret =3D __key_link_begin(keyring,
> +							    &key->index_key,
> +							    &edit);
> +				if (link_ret < 0)
> +					__key_link_end(keyring, &key->index_key,
> +						       edit);
>  			}
> -			link_ret =3D __key_link_begin(keyring, &key->index_key, &edit);
> -			if (link_ret < 0)
> -				__key_link_end(keyring, &key->index_key, edit);
>  		}
>  	}
> =20
> @@ -619,7 +667,8 @@ int key_reject_and_link(struct key *key,
>  		atomic_inc(&key->user->nikeys);
>  		mark_key_instantiated(key, -error);
>  		notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
> -		key_set_expiry(key, ktime_get_real_seconds() + timeout);
> +		if (!dead)
> +			key_set_expiry(key, ktime_get_real_seconds() + timeout);

[Severity: Medium]
When dead is true, does key_reject_and_link() still lock key->sem after
the modular key type's lockdep class has been freed?

If GC pass 1 already set KEY_FLAG_DEAD before key_reject_and_link()
entered srcu_read_lock(&key_type_srcu), pass 1's synchronize_srcu() does
not wait for this call.  Pass 3 retypes key->type to &key_type_dead
without resetting key->sem's lockdep class away from &type->lock_class:

security/keys/gc.c:key_garbage_collector() {
    ...
destroy_dead_key:
	spin_unlock(&key_serial_lock);
	kdebug("destroy key %d", key->serial);
	down_write(&key->sem);
	key->type =3D &key_type_dead;
	if (key_gc_dead_keytype->destroy)
		key_gc_dead_keytype->destroy(key);
	memset(&key->payload, KEY_DESTROY, sizeof(key->payload));
	up_write(&key->sem);
    ...
}

Once unregister_key_type() returns and the module unloads,
complete_request_key() -> key_negate_and_link() -> key_reject_and_link()
(invoked after key_instantiate_and_link() returns -EKEYREVOKED, or via
keyctl_reject_key()) still runs down_write_nested(&key->sem, 2).  With
CONFIG_LOCKDEP enabled, looking up subclass 2 on the freed
&type->lock_class fails in register_lock_class(), and the paired
up_write(&key->sem) triggers an unlock imbalance warning and disables
lockdep.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125032605.1327=
954-1-maguicai@kylinos.cn?part=3D1
