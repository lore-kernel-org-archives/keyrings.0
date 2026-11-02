Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622912;
	b=qs/xUcQGatgkZUFzV6JS/fBvhKVaW29hfSsjff/E+51PTy4YZSQN5oSjkUWEb10FoILQ
	 1E/MN4K/JnXNjXB21roBQI8c5N6mdD3D5GJv61wpOEQc7VfJNY/kyDTv/MAQkLgK6v5Os
	 QUx83BtISoB3uD7StBz3s4b5YoocKW0CnOrM0889mL2Bf63bX6UUuUoYCvT8o4G5DqmeA
	 jEwotYfuphTYGdGQDGoqPXxe3azBWjeylsZryhlxJ3T2DAD1Qr/zt3kvCsUr67yb6oOTr
	 itTTCUZ2XGKoDXXmZo5sNqCaiILeBhk9nTHnggcGXVEZoMMiJPHkxjsMhhP2Mx4JgsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622912;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=v4WOSCD0iPjOATV8EMu5vDOE0L/stdHRcGpXHqdAamg=;
	b=PozfkgYmcKH5vSRH0g4KU/aMVsElI3EEbEezg+/TieRGQnZkrwtwNyHaeC4WvT2rXGpG
	 aNyGTDByCX+QbMWDCHPAOIh2fatt0drNV7wOnKnXFM3fE5iEvtB2xGvztW9siRZHk7Fia
	 6P1mqEvNeih2j4+5LNpIUyiQzdUUeUKNjSugHRwBbnqnuNGlZqSR7flTXhTgrUVzwZwIu
	 cvxtsdkyKze7cVcx5PqLYWYDcX9x9HRsbJdguHAOyqjYbAp/LdAA1Z92nBWfSq5ge5zx/
	 gk0UbIxkWvh3xoFndn6S2SzZpBokxyws5JIad+9J5f3Vw1LIv9Av7D1kGz2FOaJfkaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQClLpYO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6CA606A327;
	Mon,  2 Nov 2026 12:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQClLpYO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78A61F00A1A;
	Mon,  2 Nov 2026 12:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622911;
	bh=v4WOSCD0iPjOATV8EMu5vDOE0L/stdHRcGpXHqdAamg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fQClLpYOBfPx4cSIEga3STRcxXVIQTo7IDDy/5S0euvZrXLBJl8Tp2VsYjnLZJnhA
	 owIZCNsqC61a1RchuZZlQcpWCwxWnz+lfoJvv3J3um6bo3faubxjUoSYACVtbZxAYX
	 +w9xmhMYmRZDasEIB5SOsuLkJNuRhpCVhTdzaEEUsPbyyBLE4uvCs7MK83dpCloru8
	 GiQofhWGf5bLWV18pLn8uNsMnIylAQA1dEupHl9kw7bT1Lttd7yBjW5ZR6yGff8Ibc
	 44nFDijrzFU/YKCO6DRGts13AAqCxlGiVCa3T0yC3i8AqQHo/OguMLNhz9BMH4YKZn
	 AfZlAnjRhvpIQ==
Message-ID: <sashiko-outbox-193425@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 3/4] KEYS: Remove key_type_dead
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "David Howells" <dhowells@redhat.com>
Cc: "Eric Biggers" <ebiggers@kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>, "Eric
 Snowberg" <eric.snowberg@oracle.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OktFWVMvS0VZUklOR1M=?= <keyrings@vger.kernel.org>
In-Reply-To: <20261102121518.1197453-4-jarkko@kernel.org>
References: <20261102121518.1197453-1-jarkko@kernel.org>
 <20261102121518.1197453-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:35:10 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] KEYS: unregister_key_type() leaves live keys active for runtime ca=
llers
- [High] KEYS: UAF in unregister_key_type() when module_init fails after re=
gistration
--

commit 5a5ac1aac59bbfa4e21a7a0f1fe3391d7d6ec2c7
Author: Jarkko Sakkinen <jarkko@kernel.org>

KEYS: Remove key_type_dead

This commit removes key_type_dead, key_gc_keytype(), and
keyring_restriction_gc(), assuming that pinning the key type's owning module
while keys or restrictions exist prevents unregister_key_type() from being
called while keys of that type are alive.

> diff --git a/security/keys/key.c b/security/keys/key.c
> index 9f1f08fcbe863..c0efb87b6705d 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -1279,18 +1279,14 @@ EXPORT_SYMBOL(__register_key_type);
>   * unregister_key_type - Unregister a type of key.
>   * @ktype: The key type.
>   *
> - * Unregister a key type and mark all the extant keys of this type as de=
ad.
> - * Those keys of this type are then destroyed to get rid of their payloa=
ds and
> - * they and their links will be garbage collected as soon as possible.
> + * Unregister a key type.
>   */
>  void unregister_key_type(struct key_type *ktype)
>  {
>  	down_write(&key_types_sem);
>  	list_del_init(&ktype->link);
> -	downgrade_write(&key_types_sem);
> -	key_gc_keytype(ktype);
>  	pr_notice("Key type %s unregistered\n", ktype->name);
> -	up_read(&key_types_sem);
> +	up_write(&key_types_sem);
>  }

[Severity: High]
What happens when unregister_key_type() is called at runtime from a device
driver removal callback or error recovery path rather than module unload?

Pinning ktype->owner in key_alloc() and keyring_restrict() prevents
delete_module() from running module_exit, but it does not stop runtime calls
to unregister_key_type() while the module remains loaded or when the key ty=
pe
is built-in.

For example, in security/keys/trusted-keys/trusted_tee.c, when the parent
driver unbinds and optee_remove_common() -> optee_unregister_devices() ->
device_unregister() invokes trusted_key_remove(), it unregisters
key_type_trusted and immediately frees pvt_data.ctx:

security/keys/trusted-keys/trusted_tee.c:trusted_key_remove() {
	unregister_key_type(&key_type_trusted);
	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
	tee_client_close_context(pvt_data.ctx);
}

Without key_gc_keytype() marking extant keys dead, unlinking them, destroyi=
ng
their payloads via trusted_destroy(), and retyping them to key_type_dead,
existing trusted keys remain active. If userspace subsequently updates or
instantiates one of those keys via keyctl_update_key() or
keyctl_instantiate_key(), trusted_update() or trusted_instantiate() calls i=
nto
trusted_tee_seal(), trusted_tee_unseal(), or trusted_tee_get_random() and
dereferences the freed pvt_data.ctx and pvt_data.dev:

security/keys/trusted-keys/trusted_tee.c:trusted_tee_seal() {
	reg_shm =3D tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
					      sizeof(p->key) + sizeof(p->blob));
	if (IS_ERR(reg_shm)) {
		dev_err(pvt_data.dev, "shm register failed\n");
		return PTR_ERR(reg_shm);
	}
}

Similarly, in arch/s390/kernel/cert_store.c, where key_type_cert_store_key =
is
built-in (owner is null), a runtime certificate store refresh via
create_cs_keyring() -> cleanup_cs_keys() relies on unregister_key_type() to
force-reap and destroy extant cert_store_key keys when per-key invalidation
fails before re-registering key_type_cert_store_key:

arch/s390/kernel/cert_store.c:cleanup_cs_keys() {
	if (invalidate_keyring_keys(cs_keyring))
		unregister_key_type(&key_type_cert_store_key);
}

In both paths, if register_key_type() is later called again on the same sta=
tic
struct key_type (in create_cs_keyring() or trusted_key_probe()) while keys
from the previous registration are still alive, __register_key_type() will
also zero ktype->lock_class while live keys still have key->sem registered
with lockdep using &ktype->lock_class:

security/keys/key.c:__register_key_type() {
	ktype->owner =3D owner;
	memset(&ktype->lock_class, 0, sizeof(ktype->lock_class));
}

Doesn't unregister_key_type() still need to reap and retype extant keys so
runtime callers cannot leave live keys referencing freed driver resources or
active lockdep classes?

[Severity: High]
Could removing key_gc_keytype() and keyring_restriction_gc() from
unregister_key_type() also cause a use-after-free when a module's init
function fails after calling register_key_type()?

Several loadable modules register key types before performing subsequent
fallible initialization steps and call unregister_key_type() on their init
error unwind path, such as af_rxrpc_init() in net/rxrpc/af_rxrpc.c,
turris_signing_key_init() in drivers/platform/cznic/turris-signing-key.c,
init_nfs_fs() in fs/nfs/inode.c, nfs_idmap_init() in fs/nfs/nfs4idmap.c,
init_cifs() in fs/smb/client/cifsfs.c, and init_ceph_lib() in
net/ceph/ceph_common.c:

drivers/platform/cznic/turris-signing-key.c:turris_signing_key_init() {
	if (IS_ERR(turris_signing_keyring)) {
		pr_err("Cannot allocate Turris keyring\n");

		unregister_key_type(&turris_signing_key_type);

		return PTR_ERR(turris_signing_keyring);
	}
}

While mod->init() is running in do_init_module() in kernel/module/main.c,
module_is_live(mod) is true, so try_module_get(type->owner) in key_alloc() =
and
keyring_restrict() succeeds as soon as register_key_type() publishes the key
type. If a concurrent task allocates a key or restricts a keyring with that
key type and a later step in mod->init() fails, the error path calls
unregister_key_type() and do_init_module() unconditionally frees the module
regardless of its reference count:

kernel/module/main.c:do_init_module() {
fail:
	/* Try to protect us from buggy refcounters. */
	mod->state =3D MODULE_STATE_GOING;
	synchronize_rcu();
	module_put(mod);
	blocking_notifier_call_chain(&module_notify_list,
				     MODULE_STATE_GOING, mod);
	klp_module_going(mod);
	ftrace_release_mod(mod);
	free_module(mod);
}

Previously, key_gc_keytype() synchronously destroyed key payloads, retyped
those keys to key_type_dead, and cleared keyring restrictions via
keyring_restriction_gc() before unregister_key_type() returned. Without that
cleanup, won't surviving keys and restrictions retain dangling pointers into
freed module memory when later accessed or garbage-collected in
key_gc_unused_keys() in security/keys/gc.c and keyring_destroy() in
security/keys/keyring.c:

security/keys/gc.c:key_gc_unused_keys() {
		struct key *key =3D
			list_entry(keys->next, struct key, graveyard_link);
		struct module *owner =3D key->type->owner;
		short state =3D key->state;
		...
		if (state =3D=3D KEY_IS_POSITIVE && key->type->destroy)
			key->type->destroy(key);
		...
		module_put(owner);
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102121518.1197=
453-1-jarkko@kernel.org?part=3D3
