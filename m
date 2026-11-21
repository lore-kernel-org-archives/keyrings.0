Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795266311;
	b=A0QIbgw6+rMAkZ5N4n1nFQIbgIy/ML+Cehd7OrE6Fvx8vE7EQY0aqowMwpiiGKxy2o5w
	 i3RRUB/0ltWrvw1i8iUPvwFP7GaCoP6lTfXWdZ4rnrLJM1MiNMdFqPJHRLrQp13SXKKS+
	 1aVSz/SN9O8e7YGgxptmDBks5r3hyjfIEiWRh2KCaWcia6F6bJv7iXaO71Aa3pBMI+HlF
	 BDXCFRNZqa8+2Gi5Qu7AfqpLZotQpk3GKBsFN83JqpnwkMw2FyHp8grhyhIZVZqUu8OEN
	 MEIG5xkcqAk1Ndik9rdfeNGAoM0pKz5vwBkoImo5EeiA05n3L99ZN5EI0sZrwkqmNYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795266311;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FVRnIT/Sx4fMHsPEkuBWIaeZWq8qAxpy+xdI77JClQQ=;
	b=USHy3tkJkQU5XCtBJ3pcec9Pekga4mFhT8qS+Yn34ys495q0Ouk2/PYvNf6jQNWMxw2T
	 mVHCt6V+gMGQGFYDV55iWX+F/5BjZx2XpMWJH8/GEdojfAOR8pyM0h5eJDYw2nc0nW1Ua
	 nvM4DhiCZZgk50w0gtuOBdvjdaMpYsAev+4ptBkqpFmVrZdVY+FpFqwjfqOMuCp/zBQJN
	 ltjb8qnvb7+9ztv4iulrA0aRpvcX2EsEaZucMDk1BGmpDcaKJb1c4EuabD7UF++Q65FJg
	 Nq557A2TxnlwAW+KTrHKZYwdxDb8VtzHAUzOmMgXuHM8E+RJnTVtygoKdkK1dkXJp0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="L4S1VL/Y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0E0606A320;
	Sat, 21 Nov 2026 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=L4S1VL/Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57CA1F000C4;
	Sat, 21 Nov 2026 13:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795266311;
	bh=FVRnIT/Sx4fMHsPEkuBWIaeZWq8qAxpy+xdI77JClQQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L4S1VL/Y9d2whmK1VuCi6kH93cN5/RviV9/1DXGdaPN61vIqArQttw3lLUFSBBGJy
	 blp/E00mKNX6HMQ5TY0TrIxDCx0kakWEr9Q7OeK3UOe5k4DCGsQ5YyCwWtXt3qNM3v
	 Zh/EczsZUrk+QmdIx/OFY+LBmrCaDiGrJ8CijJgoMyLlYJffqe14JsV9akxK62bZ6/
	 sjOvW+CaQoM0eP1BBcx67i0+LaP+bNPswruS36egxEC65exBBjUd5/LSifO4HkaZL/
	 CF8BjQyTMoVx4TNw1Er3kd2S90TkPxYW5yiXlL7ZUubVgsu1Vy3ojNllusmOzg/Eaw
	 eAPh3O8clvf7Q==
Message-ID: <sashiko-outbox-227038@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KEYS: protect construct_key type dereference with
 key semaphore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tristan Madani" <tristmd@gmail.com>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>
Cc: "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, "Tristan
 Madani" <tristan@talencesecurity.com>
In-Reply-To: <20261121125039.2532663-1-tristmd@gmail.com>
References: <20261121125039.2532663-1-tristmd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 13:05:10 +0000
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
- [High] KEYS: deadlock in construct_key() holding key->sem across
  actor() call
--

commit 89caf57fd1a6b94038c074beb5c384911f131253
Author: Tristan Madani <tristan@talencesecurity.com>

KEYS: protect construct_key type dereference with key semaphore

This commit acquires key->sem for reading around the key->type->request_key
lookup and actor() invocation in construct_key().

> diff --git a/security/keys/request_key.c b/security/keys/request_key.c
> index fa2bb9f2f5381..afc9df61506b9 100644
> --- a/security/keys/request_key.c
> +++ b/security/keys/request_key.c
> @@ -241,10 +241,12 @@ static int construct_key(struct key *key, const voi=
d *callout_info,
> =20
>  	/* Make the call */
>  	actor =3D call_sbin_request_key;
> +	down_read(&key->sem);
>  	if (key->type->request_key)
>  		actor =3D key->type->request_key;
> =20
>  	ret =3D actor(authkey, aux);
> +	up_read(&key->sem);
> =20
>  	/* check that the actor called complete_request_key() prior to
>  	 * returning an error */

[Severity: High]
Can holding key->sem across actor() deadlock against the /sbin/request-key
userspace helper?

For key types without a custom ->request_key method, actor() is
call_sbin_request_key(), which calls call_usermodehelper_keys(...,
UMH_WAIT_PROC) and blocks until the userspace helper exits.  Standard
helpers (such as key.dns_resolver, nfsidmap, and cifs.upcall) invoke
keyctl(KEYCTL_SET_TIMEOUT) on the key under construction before exiting,
which keyctl_set_timeout() explicitly permits via KEY_LOOKUP_PARTIAL and
KEY_AUTHTOKEN_OVERRIDE:

Requesting task                   /sbin/request-key helper
---------------                   ------------------------
construct_key()
  down_read(&key->sem)
  call_sbin_request_key()
    call_usermodehelper_keys(..., UMH_WAIT_PROC)
                                  keyctl_set_timeout()
                                    key_set_timeout()
                                      down_write(&key->sem)  <-- blocks
  up_read(&key->sem)

 *** DEADLOCK ***

keyctl_setperm_key() and keyctl_chown_key() likewise look up keys under
construction with KEY_LOOKUP_PARTIAL and take down_write(&key->sem).

Also, taking key->sem in construct_key() does not protect in-kernel
request_key() callers against concurrent unregister_key_type(): the sole
caller request_key_and_link() requires struct key_type *type to remain
registered across the call and dereferences type without key->sem both
before construct_key() (type->match_preparse and key_alloc()) and after it
returns (type->match_free).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121125039.2532=
663-1-tristmd@gmail.com?part=3D1
