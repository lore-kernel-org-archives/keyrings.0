Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795261139;
	b=4CGInVX+oOBrcCJ3/CSOT2V2+t4xHzekluOPCZR6iG+gA7yW2+qTsTNyNl5CyjveI7dN
	 IN2cbzbh2Zhaa7u/8NUFJgrMqCuPVsKnNzDEkcsaokGvj9bI+NF6jxDZWHD9/C+FY0+E/
	 chHLQLV+BHbbc+Blvbv6L6dlbei1aKc5evZfsnHu+SWSzRJin9kQnxEF0DOSnvjqkL+BJ
	 QYxIhQr4M0RQoDiKfT2FcOXb/6ySluH7gWQONjQWmTjuabTxLoIy7dsOn8e0SS9N6JhTQ
	 enZoTWzi09oswIwot3M3WdhRIHi5Cf6X2LLA/5qF/I6lZOf9Xyuz/351SJSpgV4O24g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795261139;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=W0upvXqa7or4lPm5XtXKHg+w7H9ANI37IpGvWi9dNkE=;
	b=lnJokW+w7ZfV7ePVhcJzxJnJNde+8WdACwqy02YHjSl8mwxeRB2CJkx8lTdcOqxpLf6Y
	 /soDZHJPEYru/2jYxsCvK5xy6MKZH+k8XMkBrRWG0LlgtUb6fIElLja42XT8D5meWhBZS
	 EuWHmP2LltWmIWUA6JJGXiceCD8kyZp8TcBsgPD6t66e5fnyCexFJkHQEP+A8W1ELMP9W
	 lFYok+eKfPxdCWg9uTZNUmmZNpVwWgIuYHK7YYxrd89NUy6QyeGDEAUJuLRXI/KKsjXIp
	 nR8KvGxW6o1KziBhFzniVm/b6qZ2IaaihNqCkyK9R9eB2UznO6LNvArSKET2FYJ8eYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AhZ9b8+s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B2B606A320;
	Sat, 21 Nov 2026 11:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AhZ9b8+s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384251F000C6;
	Sat, 21 Nov 2026 11:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795261138;
	bh=W0upvXqa7or4lPm5XtXKHg+w7H9ANI37IpGvWi9dNkE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AhZ9b8+s2mDwq0zzFZoz2MlxR4XAqdYduBKngG5zhlBiCOV3U1621TjYUXY6+wPNM
	 UmObrbgKS7EIPvKk+dXsxTbK+JKNqL6Hni400XsjYSLDuKzFN4MRF1tbAVi6XgJCX6
	 etkEzALVOEd1jZmqLeSBB4PtI+HNsKppJS77k2XXVtGjhnfFk38atiOGRR7tXQYyx4
	 Pf/omYbJ9eaCoSbcUlTvRSnbPo36GH+CLtwTrCJXtxRRJ3L142D5+DsoDz/lXrYumi
	 eN7P8mTWruOkdmvBCPzFT7T0K/rxpvD6x8sjTqnsDzd1YTBVqaAxIYFKlnIRc/i0da
	 ISwv13c6Hx9dg==
Message-ID: <sashiko-outbox-226983@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KEYS: protect construct_key type dereference with key
 semaphore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tristan Madani" <tristmd@gmail.com>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>
Cc: "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge
 E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, "Tristan
 Madani" <tristan@talencesecurity.com>
In-Reply-To: <20261121112853.2175119-1-tristmd@gmail.com>
References: <20261121112853.2175119-1-tristmd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Nov 2026 11:38:57 +0000
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
- [Medium] KEYS: ineffective key->sem locking around request_key read in
  construct_key()
--

commit ac4e3e194cb3618952a6681a5209a4099b22f9f6
Author: Tristan Madani <tristan@talencesecurity.com>

KEYS: protect construct_key type dereference with key semaphore

This commit takes key->sem for reading around the key->type->request_key
lookup in construct_key().

> diff --git a/security/keys/request_key.c b/security/keys/request_key.c
> index fa2bb9f2f5381..7e9fe4796319c 100644
> --- a/security/keys/request_key.c
> +++ b/security/keys/request_key.c
> @@ -241,8 +241,10 @@ static int construct_key(struct key *key, const void=
 *callout_info,
> =20
>  	/* Make the call */
>  	actor =3D call_sbin_request_key;
> +	down_read(&key->sem);
>  	if (key->type->request_key)
>  		actor =3D key->type->request_key;
> +	up_read(&key->sem);
> =20
>  	ret =3D actor(authkey, aux);
> =20

[Severity: Medium]
Does taking key->sem only while reading key->type->request_key actually
protect the actor(authkey, aux) call from module unload, or can a
concurrent type removal happen here at all?

Unlike 925c84e3cc21 ("KEYS: Protect the read method check against type
removal"), 51bcd09b9ffc ("KEYS: Protect the update method check against
type removal") and bab48a104447 ("KEYS: Protect the pkey method checks
against type removal"), which hold key->sem across the method execution,
construct_key() drops key->sem before calling actor(authkey, aux).  If
unregister_key_type() could run concurrently, key_garbage_collector()
could take down_write(&key->sem) right after up_read(&key->sem), retype
 the key to key_type_dead, and allow the module text to be freed before
actor(authkey, aux) runs.

More importantly, construct_key() is only reached via
request_key_and_link(struct key_type *type, ...), which already requires
the key type to stay registered across the entire call and accesses
type->match_preparse before construct_key() and type->match_free after
it without key->sem:

security/keys/request_key.c:request_key_and_link() {
    ...
		key =3D construct_key_and_link(&ctx, callout_info, callout_len,
					     aux, dest_keyring, flags);
	}

error_free:
	if (type->match_free)
		type->match_free(&ctx.match_data);
    ...
}

On the sys_request_key() syscall path, key_type_lookup() holds
key_types_sem for reading across request_key_and_link() until
key_type_put(), blocking unregister_key_type() before key_gc_keytype()
can start, while in-kernel callers pass struct key_type * directly and
must keep the type registered for the duration of the request.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261121112853.2175=
119-1-tristmd@gmail.com?part=3D1
