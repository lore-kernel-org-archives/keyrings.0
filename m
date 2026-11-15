Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794745963;
	b=wTsYkoGi8fa7bu9GIyePByPNfMvckUTA8emkEt5yXJgTPLSp+bAqN5ClBwXWG200yYus
	 howMYYLWADRV+F0eV1zqnu0bXBQNiIyHqj9urqbCsSCRRYFJgD9HIRcTGwqLIUWkWM5xV
	 LolkoSIowTqRpmf/KzgxjvCrOVaIGmxDc62PKP9rYzkwKT50UR/FCVxFhe+LMOdXicl+J
	 LUfTUrfelduYLosh3HKIoPyCdmZeScOpyAeA9urltlTcbFoQh2sVa+R7LNGPYoweMITtr
	 On5MtewqAbJ4JSqQqij8v12oV1N3KUJBlE+bDN4yf6bpW1IFXPa480BfukiqkXSuzpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794745963;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BoyuYZJrCH4F52kAS+ocUQCncpq2Fkh/6+OyK2MNx6c=;
	b=N45gzKgAxXoWqKO1bIDH9fMoFMw1rNMoXnEoKv8lRnxo0b7UXeEzxQsGocJtuh3F1YO/
	 g+fqRhwCR6HrjdJTFxkLp2j7SWmUC03QdltKDzyz/ZKVBsh0IcSH945BKPClmrKL0fv+z
	 gpJo9eo28WMkmgV6LhREy4NvrYPsSZDJbef+AspJvOaNMWe5Q0J+1ejyVB3I8P52JciLj
	 xePP6YyXlZYCYXP/GPFGlYW3YPRK5OhDs4AJyWYxXMAJLRkQ91cKYjJgWOg+5ehjECSjB
	 wQrgPOrwp/cYYMuNuFLZSjGXi1MFJyj9Y20w9zzewJWW2+JvpfduwEwR0ulEVzDGWkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1P6m0zF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72119606A31F;
	Sun, 15 Nov 2026 12:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h1P6m0zF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A051A1F000C4;
	Sun, 15 Nov 2026 12:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794745963;
	bh=BoyuYZJrCH4F52kAS+ocUQCncpq2Fkh/6+OyK2MNx6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h1P6m0zFeWinm0620xO3sHh/njmM0fy4/WSVSKbBG24Y4kkZj/5uSkjYIolnvVp+R
	 DJKnvF8n3Bl4jHeYW/MPIEv/rt8ZOcTmDOSwwxHGBWqfHGNvPg2VOvsKY958/MhXku
	 DCK+EMMB7MngfMcVSzl5EF5nIO1kZUXvmfxGEUwtJvNQm5Rzy/OalPP2lcfEbXHH+H
	 YQQzQIhtt54mQhsX6EcFntPCAOoc6j2gQwOn/cH4EkVL3qGvkVFUesmKrj8eh8hSsn
	 kvXkHGFHrgFhT/M4rNAQBWaLhiqhNsaVKKu1fgSSyD5k6iQ9ZB9bo5nqbiYPyxgfxq
	 QhaRUl3Wt4t+g==
Message-ID: <sashiko-outbox-215498@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] keys: serialise instantiation against keyctl_chown_key
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sinan Turunc" <enscrpt@pm.me>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>
Cc: paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261115121722.206-1-enscrpt@pm.me>
References: <20261115121722.206-1-enscrpt@pm.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 12:32:42 +0000
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
- [Medium] keys: lockdep cycle via key->sem subclass 1 in
  __key_instantiate_and_link()
- [Low] keys: unresolvable Fixes trailer commit SHA 1da177e4c3f4
--

commit 63d8e840b5009e3c4507a5b0e1379f0f635dfd4b
Author: Sinan Turunc <enscrpt@pm.me>

> keys: serialise instantiation against keyctl_chown_key
>
> keyctl_chown_key() replaces key->user under key->sem, but the
> instantiation path reads key->user without it: __key_instantiate_and_link=
()
> and key_reject_and_link() bump key->user->nikeys under
> key_construction_mutex only, and key_payload_reserve(), called from the
> type's instantiate op, reads key->user once for spin_lock_irqsave() and
> again for spin_unlock_irqrestore().
>
> A chown of an under-construction key that lands between those two reads
> locks the old owner's quota spinlock and unlocks the new owner's.  The
> paravirt unlock slow path reports the unheld unlock and the old lock is
> never released, so the next quota operation on that uid spins with
> interrupts disabled:
>
>   pvqspinlock: lock 0xffff88800f94dc38 has corrupted value 0x0!
>   WARNING: CPU: 2 PID: 215 at kernel/locking/qspinlock_paravirt.h:504 __p=
v_queued_spin_unlock_slowpath+0x1dc/0x2e0
>   Call Trace:
>    _raw_spin_unlock_irqrestore+0xe/0x30
>    key_payload_reserve+0x230/0x300
>    generic_key_instantiate+0x47/0x230
>    __key_instantiate_and_link+0xbd/0x310
>    key_instantiate_and_link+0x3f0/0x490
>    keyctl_instantiate_key_common+0x246/0x410
>
> The same unsynchronised read lets the instantiator touch the old
> key_user after the chown has dropped the last reference to it.
>
> Hold key->sem for write across the instantiate op and the owner-record
> updates so that instantiation and chown serialise on the lock that
> already protects key->user.  key->sem nests inside key_construction_mutex
> and the destination keyring's semaphore here; nothing takes the
> construction mutex under a key's semaphore.  The acquisition is
> annotated as nested because a keyring instantiated into a keyring shares
> the destination's lock class; the key under construction cannot be a
> destination itself, so no cycle exists.
>
> Reproducer: a request_key() helper that chowns the target key between
> two uids from one thread while instantiating it from another, as root.
> Triggers within tens of milliseconds on 6.12.104 and on mainline.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sinan Turunc <enscrpt@pm.me>

[Severity: Low]
The commit sha in the Fixes: trailer cannot be resolved in the repository
(it points to the initial git import).

> diff --git a/security/keys/key.c b/security/keys/key.c
> index a438c4508595d..afcf9fe04fb24 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -440,7 +440,13 @@ static int __key_instantiate_and_link(struct key *ke=
y,
> =20
>  	mutex_lock(&key_construction_mutex);
> =20
> -	/* can't instantiate twice */
> +	/* can't instantiate twice; key->sem keeps key->user stable against
> +	 * keyctl_chown_key() for the instantiate op and the quota update.
> +	 * Nested: the caller may hold the destination keyring's sem and the
> +	 * key under construction may be a keyring too, but it cannot be
> +	 * anyone's destination yet, so there is no cycle.
> +	 */
> +	down_write_nested(&key->sem, 1);

[Severity: Medium]
Does using subclass 1 for key->sem in __key_instantiate_and_link() and
key_reject_and_link() trigger a lockdep circular dependency report against
__key_move_lock()?

All keyrings share &key_type_keyring.lock_class.  When instantiating a
keyring into a destination keyring, __key_link_lock() takes the destination
keyring->sem (subclass 0) and then keyring_serialise_link_lock before
__key_instantiate_and_link() takes key->sem at subclass 1.  Moving a
keyring via key_move() -> __key_move_lock() takes the second keyring's
semaphore at subclass 1 before taking keyring_serialise_link_lock:

CPU0                                  CPU1
----                                  ----
down_write(&keyring->sem)
mutex_lock(&keyring_serialise_link_lock)
                                      down_write(&l_keyring->sem)
                                      down_write_nested(&u_keyring->sem, 1)
                                      mutex_lock(&keyring_serialise_link_lo=
ck)
mutex_lock(&key_construction_mutex)
down_write_nested(&key->sem, 1)

 *** DEADLOCK ***

CPU0: key_instantiate_and_link() -> __key_link_lock() /
      __key_instantiate_and_link()
CPU1: keyctl_keyring_move() -> key_move() -> __key_move_lock()

Although an uninstantiated keyring cannot be looked up by
keyctl_keyring_move() at runtime, reusing subclass 1 here inverts the
lockdep order between (&key_type_keyring.lock_class, 1) and
keyring_serialise_link_lock.  Using a distinct subclass (such as 2) for
key->sem in __key_instantiate_and_link() and key_reject_and_link() would
avoid the collision.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261115121722.206-=
1-enscrpt@pm.me?part=3D1
