Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793383673;
	b=xlDWof4t7lsLK5bKlwffeeX0QoZN0HjDBtmY8mdCeP7HbsbuoX+mHb3ogHrVR0xlpXPV
	 3W12rAXj+etSKhAY8N67WMKceZR1HaOXQdGCpkQ6tPTy+Lrdbs6e6x2LabrzSh+UU8ERY
	 ji3njFB6H7iGmxJyzzJGVVbwyMhEqgMJQ2YRmXNII64ZMyB1Q52G6xqTvBtOMwQ7CVaMN
	 2JIqJqshEbfmk10Tu+igWdhO95L64W4bWnNrAe46UREz1OpXndPfi1l2FU8F0+45p5e6W
	 q4S8ANvhEVTz2xUoEYFW5Cg8FoGQ7+l+hu0TtWtz3fhmbHvn0aOquo9Ef3j0GYg5cCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793383673;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=evvNG/enEsu6DFtcrBynJtCLEoPdmLjZfYH8qwAdkEc=;
	b=rgVmow6oINwhjeMi1Y4C535PebefAudyvNepEVRHDQhr4hNvU3he6tqRL8HHOXleqwyT
	 KlNUqvC7h3Qy0YIgZ7fdZPy13pRd52FDLia628a8isVmunkVq+Ora9zmCmYjUuW31wqXJ
	 SMnLEPp+xeG7BvSqEwrALiRFtIeVSDPgL+dxdHawDng5ycUTMWqWVXwHjM11kkEfEFt3A
	 IMq9xL5wdGKmJxwM4Zv8zqKVUDSlMeIpphfhUFgVle3JuWaifEwPDrcyM3U9kWBlNWxDL
	 YV5W+6Z/acHQAdIDnm9LfC7vflmqHLuUocP25PWYHICBYUbciWBvZiRNTWDUpfJ6rZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzITDJlQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E53C606A31C;
	Fri, 30 Oct 2026 18:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nzITDJlQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768471F000C1;
	Fri, 30 Oct 2026 18:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793383671;
	bh=evvNG/enEsu6DFtcrBynJtCLEoPdmLjZfYH8qwAdkEc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nzITDJlQPR/RsSazopmvCxtil1bB0mz1NMoRSeJbP3bHuuKuoCKvUsEscz0yn5V0/
	 zSqkSjk+PLgQdJH3bNg8scw+tS/WbwXU7tkzKBrDh7Ow2ooHLQtyYAwzEcw7ptva21
	 cCZnwKCV8CNaZddLDAz72zvwvR1eok95F1yiCdWqwlZFmhQn2QzT7n0GQXnW9OSs1j
	 nnpzaWigHjOZGjvJ8Clas184TVU862FMu5xq+iY7QePSO0vgnG+vLnF/etICBRzM/d
	 PIS2bvUiL7heUjg32+HsK2cjfWpH3IdL5rAAJ2YwjOfA51uIgjErFKLxLlf65M1pU+
	 WR3H38TpkWhFw==
Message-ID: <sashiko-outbox-191392@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KEYS: request_key: enforce keyring restrictions on
 constructed keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anvik Loitongbam" <permissiontogallop@gmail.com>, keyrings@vger.kernel.org
Cc: "David Howells" <dhowells@redhat.com>, "Jarkko Sakkinen" <jarkko@kernel.org>, linux-security-module@vger.kernel.org
In-Reply-To: <20261030173930.40948-1-permissiontogallop@gmail.com>
References: <20261030173930.40948-1-permissiontogallop@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 18:07:51 +0000
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
- [High] KEYS: request_key_and_link() links uninstantiated key to restricte=
d keyring
--

commit 97697a25e3b571e267998f93eacf1015231cd118
Author: Anvik Loitongbam <permissiontogallop@gmail.com>

KEYS: request_key: enforce keyring restrictions on constructed keys

This commit defers linking a newly allocated key into a restricted destinat=
ion
keyring during key construction until the key has been instantiated and its
payload can be checked against the keyring's restriction.

> diff --git a/security/keys/request_key.c b/security/keys/request_key.c
> index fa2bb9f2f5381..a47e6a72ded89 100644
> --- a/security/keys/request_key.c
> +++ b/security/keys/request_key.c

[ ... ]

> @@ -446,15 +464,44 @@ static int construct_alloc_key(struct keyring_searc=
h_context *ctx,
>  	mutex_unlock(&key_construction_mutex);
>  	key =3D key_ref_to_ptr(key_ref);
>  	if (dest_keyring) {
> -		ret =3D __key_link_begin(dest_keyring, &key->index_key, &edit);
> -		if (ret < 0)
> -			goto link_alloc_failed_unlocked;
> -		ret =3D __key_link_check_live_key(dest_keyring, key);
> -		if (ret =3D=3D 0)
> -			__key_link(dest_keyring, key, &edit);
> -		__key_link_end(dest_keyring, &key->index_key, edit);
> -		if (ret < 0)
> +		/*
> +		 * The outer search checks Link permission on a key it finds.
> +		 * The second search must do the same; otherwise a key that
> +		 * appeared in the race window could be linked without the
> +		 * caller holding Link permission on it.
> +		 */
> +		ret =3D key_task_permission(key_ref, ctx->cred, KEY_NEED_LINK);
> +		if (ret < 0) {
> +			if (link_locked)
> +				__key_link_end(dest_keyring, &key->index_key,
> +					       NULL);
>  			goto link_check_failed;
> +		}
> +		if (*defer_link) {
> +			/*
> +			 * The key may still be under construction, in which
> +			 * case its payload cannot be checked yet.  Do not add
> +			 * a provisional link to a restricted keyring; only an
> +			 * already instantiated key can be checked here.
> +			 */
> +			if (!key_is_positive(key)) {
> +				ret =3D -EPERM;
> +				goto link_check_failed;
> +			}
> +			ret =3D key_link(dest_keyring, key);
> +			if (ret < 0)
> +				goto link_check_failed;

[Severity: High]
Can an uninstantiated key still be linked into a restricted keyring through
the outer search in request_key_and_link()?

In keyring_search_iterator(), only negative keys (state < 0) are skipped wh=
en
KEYRING_SEARCH_DO_STATE_CHECK is set, so search_process_keyrings_rcu() retu=
rns
keys that are still in KEY_IS_UNINSTANTIATED (0) state:

security/keys/keyring.c:keyring_search_iterator() {
    ...
	if (ctx->flags & KEYRING_SEARCH_DO_STATE_CHECK) {
		/* we set a different error code if we pass a negative key */
		if (state < 0) {
			ctx->result =3D ERR_PTR(state);
			kleave(" =3D %d [neg]", ctx->skipped_ret);
			goto skipped;
		}
	}

	/* Found */
	ctx->result =3D make_key_ref(key, ctx->possessed);
	kleave(" =3D 1 [found]");
	return 1;
}

If a task initiates a request_key() call targeting an unrestricted process
keyring (such as the session, process, or thread keyring),
construct_alloc_key() provisionally links the uninstantiated key into that
keyring while the /sbin/request-key upcall is running.

If another thread or helper then calls request_key() for the same key with a
restricted dest_keyring before instantiation completes, the outer
search_process_keyrings_rcu() in request_key_and_link() finds that
uninstantiated key and passes it straight to key_link() before
wait_for_key_construction() is reached:

security/keys/request_key.c:request_key_and_link() {
    ...
	rcu_read_lock();
	key_ref =3D search_process_keyrings_rcu(&ctx);
	rcu_read_unlock();

	if (!IS_ERR(key_ref)) {
		...
		key =3D key_ref_to_ptr(key_ref);
		if (dest_keyring) {
			ret =3D key_link(dest_keyring, key);
    ...
}

Because __key_link_check_restriction() in security/keys/keyring.c also does
not check key_is_positive(key) before passing &key->payload to
keyring->restrict_link->check(), doesn't this cause a few issues?

First, if dest_keyring uses a restriction callback that only validates
key->type and relies on key->type->instantiate() to verify the payload (such
as restrict_link_for_blacklist() in certs/blacklist.c), or if
restrict_link->check is NULL, key_link() will link the uninstantiated key i=
nto
the restricted keyring, and the helper can subsequently instantiate or
negatively instantiate the key with ringid 0, leaving an unverified or
negative key linked in the restricted keyring.

Second, if the helper is concurrently instantiating the key with ringid 0 in
__key_instantiate_and_link() (which holds key_construction_mutex, not
dest_keyring->sem), key->type->instantiate() populates key->payload before
mark_key_instantiated() executes smp_store_release(&key->state,
KEY_IS_POSITIVE). Calling key_link() without first checking
key_is_positive(key) (which provides the pairing smp_load_acquire(&key->sta=
te))
allows restrict_link->check() to read key->payload concurrently with
instantiate().

Third, in construct_alloc_key() itself, because the first thread drops
user->cons_lock before calling construct_key(), a second thread of the same
user racing on the same key with a restricted dest_keyring can find the
uninstantiated key via the inner search and enter key_already_present while
!key_is_positive(key) is still true, causing it to fail immediately with
-EPERM instead of waiting for construction and then linking.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030173930.4094=
8-1-permissiontogallop@gmail.com?part=3D1
