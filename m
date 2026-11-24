Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556960;
	b=0Setfg49ZjniFsXKFEE8EFOKE5Pf0h7flm3vRfNvuYVBRut7Dn6gi6yC7J6y91BmI5JB
	 SWcUJvRmfbB7zaxhZ8zb9RMBDPnfsbsgwY1D6Hd3skl4oboPsqART5Dswaiv2rqxPV/zy
	 jIw/Byt8tYRuT43MmNxMFcDxOYUPQxM41Ox/ZKDYB2mBqv+goUvDgrcaTt4K0Njo7m6nQ
	 J2yB9//CCgGoySGuwWC5ywR8i0zASfgszQkP0BcwZNa9FnsQY23x5dSj3JP+ksVIwdZcj
	 XP3FNi8EhveFkL7yIV2dwh2E01YFeu/VPHrpEjEZ3hcrBB5pRP3GGNQal/DKyiZaaEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556960;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5ZFwwLa4pIKwpitlZLxI3A2hpDYDh/gQeIqS04XfyHY=;
	b=GMloJtUCj7icbOqkh524Xekjz4H4faImLa+JeAB+GpdNHFpxDntkXaWnTPbuGirWSogY
	 7+aI3PWX8cc+htgI5/olnuRYLNOi002ig/XXWGcK8uH3BM3RHmRzqNau7yuaKdt8eDZHk
	 +2C0ugnb3NlMR+jYEMMcUSaxtM8A1R2GP3UtCyb7XwbBso+x9b82UR/nn7Xepuc5C3u2m
	 sGNlntKnHjo3FG4fzczW9UwLaEFxMVrzJn4HNE6g5DfHfnlF9nPr45pSr14RVtC99+xld
	 A9cx1tGUreK+tMhiDy8ozLgXCpThBSphEGCZlXU9jDF+nPUCh73USFT0WadlmV+kB0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jOcSaLvM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688E9606A323;
	Tue, 24 Nov 2026 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jOcSaLvM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ABA81F000C4;
	Tue, 24 Nov 2026 21:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795556959;
	bh=5ZFwwLa4pIKwpitlZLxI3A2hpDYDh/gQeIqS04XfyHY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jOcSaLvMVrKphCHbBuXFk0Gl5za9h/1FbVSktVZV+bZBsO72TW8hnPs9gdhHZY0x9
	 vm7DxuyKIVTFU/1kMi7pK8eqA9EvFlilkrimama46Jy8yRTmADI3kX4jE5QQ+AHZmE
	 /24/ySBIgHhp7UhfuriSwF8L6CmUfp3f9Oj+9nHIzOnKMtuzvTR2mX8mhRJ6ikWkoo
	 Escbdyr3c6GkpA8LCkF9K6dh6TVsHSeg8OMVueYB6oOH42oMJtU9xc+MTO2kdeBKfo
	 STQxRNjAr1wGTqUAJPUd/WeR13+KvsmsFsdVwT4Uw8Wlk3mp/v+MSDMDesxoqc8+8t
	 nRIT8LwqiiQvg==
Message-ID: <sashiko-outbox-232064@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] KEYS: protect construct_key type dereference with
 key semaphore
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tristan Madani" <tristmd@gmail.com>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>
Cc: "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, "Tristan
 Madani" <tristan@talencesecurity.com>
In-Reply-To: <20261124214125.3198541-1-tristmd@gmail.com>
References: <20261124214125.3198541-1-tristmd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 21:49:18 +0000
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
- [Medium] keys: releasing key->sem before actor() in construct_key()
  defeats protection
--

commit 9d2b5e770f320f3d569ad3450cb1b85673517461
Author: Tristan Madani <tristan@talencesecurity.com>

KEYS: protect construct_key type dereference with key semaphore

This commit takes key->sem for reading around the key->type->request_key
lookup in construct_key() and releases it before invoking actor().

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

[Severity: Medium]
Does holding key->sem only across the key->type->request_key pointer load
provide the protection against concurrent type unregistration that the
commit message describes?

In commit 925c84e3cc21 ("keys: Protect the read method check against type
removal"), __keyctl_read_key() holds key->sem across key_validate(key), the
key->type->read check, and the key->type->read() call itself.  Here,
up_read(&key->sem) runs before actor(authkey, aux), so if
key_garbage_collector() could race with construct_key(), it could acquire
down_write(&key->sem), retype the key to key_type_dead, and let
unregister_key_type() complete right after up_read(&key->sem) and before
actor() runs.  And if the key were retyped to key_type_dead before
down_read(&key->sem), key_type_dead.request_key is NULL and KEY_FLAG_DEAD
is not checked, so construct_key() would fall back to
call_sbin_request_key on a dead key.

More broadly, construct_key() is only reached through
request_key_and_link(), whose callers already pin the key_type for the
entire operation (__do_sys_request_key() holds key_types_sem via
key_type_lookup(), and request_key_and_link() itself dereferences
type->match_preparse before and type->match_free after construct_key()
without key->sem).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124214125.3198=
541-1-tristmd@gmail.com?part=3D1
