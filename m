Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795499674;
	b=IfaOgh2dCAAp7qXtP1Tq/I8pMwIhveNneg4Gv7jVhgB4t9IWZRo1dx95ypa20qSAOAYb
	 1xtXDKf5n2kYk8C+Wkzo2sUySruH+g2ne9iCKviErPuvvV63HzJVCX6DFrTVPq1LLUZE9
	 V/Azd8p5iPbBIam7IcGfwE1BwLb/7cW2I3nCjXvYIQp6hyeMu2OaOlqapmCbtTrpVpozr
	 Jkk2WPYAEHWf+j73zvjCJsytfgG5ygREQfDIKTzYrVudD4wjqNgkoUfyZgyYqFJvuse/h
	 mBLxvq87Jy8TQ6z1KSa+bSxRZBGMEgY2G5dkFXvkgp+lpU5A+GlwmYhTgY6o7wfUTAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795499674;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=w/OCfuP8icf+Oo8JyyjFpWEWzl9cfVUs7VhBaeHPUsA=;
	b=RytNORhMDzgMvgjV7t2WKuKZZX56YWyNA1qFRVistUNmpMa6X0SU9p93FvxpKF2gowJz
	 lgP0eZyoxVQrQBmT80udpYIyenVK50LnZFxRdX27iQSbwlAhiLuLnSDFiLKAgoe84E9J/
	 cyVlKvoI46KqJ//SZVFbV4bYlqcSruPP8FRYMzmxXaM57JrxPZTeUpO3+CUKr+a77K9it
	 oxDmxLu/zRntJ/Giod62DXYIFA754wB8o6fVB8qRFksrFYibV3t+RPkSjfWV38rrFladv
	 fDWjLQW/QFjYHZBdi3Cm1UaEmzfFuAwsRK6SEeVIBbm2g6EPnE/ZZ8BUbRQLsJVxMGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6n6cq18;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4755B606A31E;
	Tue, 24 Nov 2026 05:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I6n6cq18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0181F000C6;
	Tue, 24 Nov 2026 05:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795499673;
	bh=w/OCfuP8icf+Oo8JyyjFpWEWzl9cfVUs7VhBaeHPUsA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=I6n6cq18oaV4g/E5y4R0fTh7EEEhQ+9islAlfOGFOHE2/oqReRUL7s88FarKRrDwQ
	 M39qrXRhxZMpG7SRWMyOF9I29b0Vn6gUUm7xRCtpcZ7TpiwFWs5h6gmrd/YbnGcjBG
	 k9/gJh5HFucaRURJ+YtxPcB/z00//IOqIc6qFTHpMwA3ZMQvxUeA1ToEom8t68B/fg
	 yMU0X8qZMdQGIBVzj2NmV6cfKpKIRMQ5fOEgqbCB8Tz/XDrFGZtnTXCSOu5FWhW5zF
	 q74ZsAHsOctnjdBbJhJrnoG86lPz46g74XjqXLzxxQ0vuroidwVITjnylUow56xncn
	 ok0R+mmSgQqJw==
Message-ID: <sashiko-outbox-230565@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KEYS: Protect the instantiate method against type
 removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guicai Ma" <maguicai@kylinos.cn>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E
 . Hallyn" <serge@hallyn.com>
In-Reply-To: <20261124053303.940216-1-maguicai@kylinos.cn>
References: <20261124053303.940216-1-maguicai@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 05:54:33 +0000
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
- [High] KEYS: lock ordering inversion in key_instantiate_and_link()
- [Medium] KEYS: missing KEY_FLAG_DEAD check in
  key_instantiate_and_link()
- [Medium] KEYS: dangling module lockdep class key on key->sem after
  retyping
--

commit 5aa637683f50c613cd3d30c6ae75645d9241a024
Author: Guicai Ma <maguicai@kylinos.cn>

KEYS: Protect the instantiate method against type removal

This commit takes key->sem for reading across key_instantiate_and_link()
and checks for a non-NULL ->instantiate method to prevent racing with
key type unregistration and garbage collection.

> diff --git a/security/keys/key.c b/security/keys/key.c
> index a438c4508595d..1a2025220196e 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c

[ ... ]

> @@ -507,6 +509,20 @@ int key_instantiate_and_link(struct key *key,
>  	int ret;
> =20
>  	memset(&prep, 0, sizeof(prep));
> +
> +	/*
> +	 * A reference on the key does not pin the module that provides its
> +	 * type.  unregister_key_type() waits for the garbage collector to
> +	 * retype every remaining key of the type to key_type_dead, whose
> +	 * ->instantiate is NULL, so the type must not change from here to the
> +	 * instantiate call.
> +	 */
> +	down_read(&key->sem);

[Severity: High]
Does taking key->sem before __key_link_lock() and __key_instantiate_and_lin=
k()
introduce an ABBA lock ordering inversion with encrypted_instantiate()?

When a user or trusted key is instantiated, key_instantiate_and_link() now
holds key->sem (key_type_user.lock_class or key_type_trusted.lock_class)
before taking keyring->sem and key_construction_mutex.  Conversely, when an
encrypted key is instantiated, encrypted_instantiate() runs under
keyring->sem and key_construction_mutex and locks the master user or
trusted key's semaphore via request_master_key():

CPU0                              CPU1
----                              ----
down_read(&ukey->sem)
                                  mutex_lock(&key_construction_mutex)
mutex_lock(&key_construction_mutex)
                                  down_read(&ukey->sem)

 *** DEADLOCK ***

CPU0: key_instantiate_and_link() -> __key_instantiate_and_link()
CPU1: __key_instantiate_and_link() -> encrypted_instantiate() -> ... ->
      request_user_key()

Under CONFIG_PROVE_LOCKING this triggers a circular locking dependency
splat, and at runtime it can deadlock if a writer (such as key_update() or
key_set_timeout()) is queued on ukey->sem.

> +
> +	ret =3D -EOPNOTSUPP;
> +	if (!key->type->instantiate)
> +		goto out;

[Severity: Medium]
Should this also reject keys that have KEY_FLAG_DEAD set?

During unregister_key_type(), key_garbage_collector() runs three passes:
pass 1 sets KEY_FLAG_DEAD without taking key->sem or changing key->type,
pass 2 unlinks KEY_FLAG_DEAD keys from all keyrings without taking
key->sem, and only pass 3 takes down_write(&key->sem) and switches
key->type to &key_type_dead.

CPU0 (key_garbage_collector)      CPU1 (key_instantiate_and_link)
pass 1:
  set_bit(KEY_FLAG_DEAD, &key->flags)
pass 2:
  keyring_gc()
                                  down_read(&key->sem)
                                  /* key->type->instantiate is still valid =
*/
                                  __key_instantiate_and_link()
                                    __key_link(keyring, key, &_edit)
                                  up_read(&key->sem)
pass 3:
  down_write(&key->sem)
  key->type =3D &key_type_dead      <-- mutates index_key.type while linked
  up_write(&key->sem)

Because key->type aliases key->index_key.type in struct key, mutating it in
place while the key remains linked in keyring->keys corrupts the keyring's
assoc_array tree and leaves a dead key linked in the keyring.

> +
>  	prep.orig_description =3D key->description;
>  	prep.data =3D data;
>  	prep.datalen =3D datalen;
> @@ -515,17 +531,17 @@ int key_instantiate_and_link(struct key *key,
>  	if (key->type->preparse) {
>  		ret =3D key->type->preparse(&prep);
>  		if (ret < 0)
> -			goto error;
> +			goto out_free_preparse;
>  	}
> =20
>  	if (keyring) {
>  		ret =3D __key_link_lock(keyring, &key->index_key);
>  		if (ret < 0)
> -			goto error;
> +			goto out_free_preparse;
> =20
>  		ret =3D __key_link_begin(keyring, &key->index_key, &edit);
>  		if (ret < 0)
> -			goto error_link_end;
> +			goto out_link_end;
> =20
>  		if (keyring->restrict_link && keyring->restrict_link->check) {
>  			struct key_restriction *keyres =3D keyring->restrict_link;
> @@ -533,19 +549,22 @@ int key_instantiate_and_link(struct key *key,
>  			ret =3D keyres->check(keyring, key->type, &prep.payload,
>  					    keyres->key);
>  			if (ret < 0)
> -				goto error_link_end;
> +				goto out_link_end;
>  		}
>  	}
> =20
>  	ret =3D __key_instantiate_and_link(key, &prep, keyring, authkey, &edit);
> =20
> -error_link_end:
> +out_link_end:
>  	if (keyring)
>  		__key_link_end(keyring, &key->index_key, edit);
> =20
> -error:
> +out_free_preparse:
>  	if (key->type->preparse)
>  		key->type->free_preparse(&prep);
> +
> +out:
> +	up_read(&key->sem);

[Severity: Medium]
Can locking key->sem after a modular key type has been unloaded trigger a
lockdep unlock imbalance warning?

key_alloc() binds key->sem to &type->lock_class in the module's data
section, and key_garbage_collector() does not rebind key->sem to
&key_type_dead.lock_class when retyping the key in destroy_dead_key:

security/keys/gc.c:key_garbage_collector() {
	...
destroy_dead_key:
	down_write(&key->sem);
	key->type =3D &key_type_dead;
	if (key_gc_dead_keytype->destroy)
		key_gc_dead_keytype->destroy(key);
	memset(&key->payload, KEY_DESTROY, sizeof(key->payload));
	up_write(&key->sem);
}

Once the module is freed, lockdep_free_key_range() zaps &type->lock_class.
When KEYCTL_INSTANTIATE later runs on the still-referenced uninstantiated
key, down_read(&key->sem) sees the dangling key->sem.dep_map.key pointer in
__lock_acquire() -> register_lock_class(), which fails static_obj() and
returns NULL without recording the lock in current->held_locks, causing
up_read(&key->sem) to hit print_unlock_imbalance_bug().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124053303.9402=
16-1-maguicai@kylinos.cn?part=3D1
