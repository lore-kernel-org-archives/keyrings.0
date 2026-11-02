Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622776;
	b=aibjv47CiCnQvnE6a0f22kzF9fVdLxLGSEaEkfOKc4PwHOJNOOxc5U7ydNLp+5h5Tmbm
	 PhQJUfBxJyGOBvmoYS20X6GrWFyRoWv24JCuLqTDAkma9dg6T3fj45kLTgAxQcXHZcu/b
	 SKSoMsNSrHCE5MmUBxqTGilgCQhVuyjByomiMO2+XuyS/TPZHoi8HjgqWmUCr9Bf8+s9Y
	 eAdTh0zmykjwZEasvT/+nHIk7YoR3RtJYkicDDQU/enppiBnZs4E020EEmzUy0NOSa9Iy
	 2a/BUfWtqG0JNMKegL4yLadFdJUMqdzx6qPpdYniYcks26a3kcjbq1+xpncOclCOWlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622776;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DIdk7DzURrNX9GZQcDmly77A+mdvHLOyQp+ak9tboms=;
	b=tevXbBnowWbWNQqLqOg29OK/3y4YdFmG96Q6csdxQsHyo2o8lGUp0aoqo4/rN87R94GZ
	 +JMvAfEy+NDaCgGICTrLpZ5OfAmMlHH9QFh/XPTQyEa+NZBKFBEWc3vNQm6Bp+qgwFj13
	 RXKYqB/G3k54yesFhNp0a2XT+7URPGbyjVmA8xLkB7VEF8Xnzj4WW8kIOv4FF+f1ozXme
	 g87ZEGjmAMlRleRDOvr4wC5WQblDlE9Jt3Vlhj0v9yRhSbVgYuECj4hWgl5gxuMBGyqwe
	 E7XMSUUqeiutzsiwtKrsp+CyqUkv7LZdNwmVinP0rBf+Ounx29ASBBjliJPw4WLdykA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W/wScyaM";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692D160A2613;
	Mon,  2 Nov 2026 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W/wScyaM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901321F00A1A;
	Mon,  2 Nov 2026 12:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622776;
	bh=DIdk7DzURrNX9GZQcDmly77A+mdvHLOyQp+ak9tboms=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W/wScyaMdRqkqwbsndWlsmXPIFlMIiX3KtU+ErRjvlYDCqB8xAtAtmVDNpJYfpWgS
	 RIhO9F0aw6+/rrP4ZY1tRTftZj6E15rJkcg4YI3tNZzBL/g5Vplzkg5mXoQek0VBvR
	 cYQjqYO44Uv63d6Q6YZwqNwPoVpr7nFZ9Od9susyPYdUb1rP5Uj+wGK1I0shVIdlb4
	 sHSRjWbtXa2Tmtm2b8R05hPt5fPbNRpmeGUtW/cJpGkbjYPKd/z26+JbpgWWW2Rr2V
	 w3bjWOxqrBQMdexVBF0CTjXm5ltmuJxVITCkJcGLzhc0/NXbVGIXu7oj0WP65KcHQX
	 5q5Uhrd6zapxQ==
Message-ID: <sashiko-outbox-193418@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/4] KEYS: Pin the backing module for struct
 key_type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "David Howells" <dhowells@redhat.com>
Cc: "Eric Biggers" <ebiggers@kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>, "Eric
 Snowberg" <eric.snowberg@oracle.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 =?utf-8?b?b3BlbiBsaXN0OktFWVMvS0VZUklOR1M=?= <keyrings@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261102121518.1197453-3-jarkko@kernel.org>
References: <20261102121518.1197453-1-jarkko@kernel.org>
 <20261102121518.1197453-3-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:32:55 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] KEYS: self-pinning module reference cycle in key_alloc()
--

commit 8793dbc22dd9f6067e0bfcfa9c4b1b437edcf052
Author: Jarkko Sakkinen <jarkko@kernel.org>

KEYS: Pin the backing module for struct key_type

This commit adds an owner field populated with THIS_MODULE to struct key_ty=
pe
when registering a key type. It pins the module in key_alloc() and
keyring_restrict(), releasing the reference in key_gc_unused_keys() and
keyring_destroy().

> diff --git a/security/keys/key.c b/security/keys/key.c
> index e88548f1a7040..9f1f08fcbe863 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -7,6 +7,7 @@
> =20
>  #include <linux/export.h>
>  #include <linux/init.h>
> +#include <linux/module.h>
>  #include <linux/poison.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> @@ -234,19 +235,24 @@ struct key *key_alloc(struct key_type *type, const =
char *desc,
> =20
>  	key =3D ERR_PTR(-EINVAL);
>  	if (!desc || !*desc)
> -		goto error;
> +		goto out;
> +
> +	if (!try_module_get(type->owner)) {
> +		key =3D ERR_PTR(-ENOENT);
> +		goto out;
> +	}

[Severity: High]
Does pinning type->owner in key_alloc() until key_gc_unused_keys() create a
self-pinning reference cycle for modular key types that cache keys in their
own internal keyrings?

With register_key_type() setting ktype->owner to THIS_MODULE:

include/linux/key-type.h:
#define register_key_type(ktype) __register_key_type(ktype, THIS_MODULE)

every allocated key of that type holds a module reference on its owning
module until the key's reference count drops to zero and it is garbage
collected in key_gc_unused_keys().

However, several loadable modules allocate an internal keyring during module
initialization, link keys of their own key_type into that keyring during
normal operation, and only revoke and release that keyring in their module
exit path:

drivers/nvme/common/keyring.c:nvme_keyring_exit() {
	unregister_key_type(&nvme_tls_psk_key_type);
	key_revoke(nvme_keyring);
	key_put(nvme_keyring);
}

fs/nfs/nfs4idmap.c:nfs_idmap_quit() {
	key_revoke(id_resolver_cache->thread_keyring);
	unregister_key_type(&key_type_id_resolver);
	unregister_key_type(&key_type_id_resolver_legacy);
	put_cred(id_resolver_cache);
}

fs/smb/client/cifsacl.c:exit_cifs_idmap() {
	key_revoke(root_cred->thread_keyring);
	unregister_key_type(&cifs_idmap_key_type);
	put_cred(root_cred);
	cifs_dbg(FYI, "Unregistered %s key type\n", cifs_idmap_key_type.name);
}

net/dns_resolver/dns_key.c:exit_dns_resolver() {
	key_revoke(dns_resolver_cache->thread_keyring);
	unregister_key_type(&key_type_dns_resolver);
	put_cred(dns_resolver_cache);
}

Once any key is linked into one of these internal module keyrings (or added
by userspace via add_key() to a session or user keyring), the key holds a
reference on the module while the module's keyring holds a reference on the
key. Won't this prevent the module reference count from ever reaching zero,
making it impossible to unload these modules unless all cached keys expire =
or
are manually evicted first?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102121518.1197=
453-1-jarkko@kernel.org?part=3D2
