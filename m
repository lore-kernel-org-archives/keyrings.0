Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795142197;
	b=AMJVTKP2n/Cfg4Fvi941xhMK5jgGmF+6um0PZS9Ko+0ISOJPahfL6qAxAAxsGOGFSFR9
	 OFcLZ1SyJkznYUYJo5tLZmVhZtvw90XoCv9Pq/UC5EEK/945uDuUqSrcgG/v/K+ZaQLC0
	 n0OByZRkBPBnjYpwtgBtmsTVCezYqd2I73jVnWdDMS90Zg8nRBb6jN91nhX0pZalM1Skg
	 t1OPn3EthHj+yMwO3i6KoSwsW6edd89iv+9UsVFh5hR70VJCwXM6wU7WGurkJ/POWoV57
	 7q/vcPncaXQgShlA8etkV1cRHqrzNkCYVip4XPpeMMrRUEIj+SxoJvfzbhHZwI7+BQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795142197;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PCnFkSkImsEmBbHnJFfPGtEMMmugbuMVDng24j/AWqI=;
	b=zZFGw97sbJdgrd84xDxP3/qP7ja4FdMvc6692wSEPFyJhIK4xKKLH+224oS3PcI2xXY/
	 7yqwIs7NQcOufngB+BvXGT1fDgy8V/AFrBPHpsE/TuzlAw7UvC8tu4deEpqs05rDaImrf
	 syy6k/QJpr4yccAktxKSrA+fkPFR3NBTIk6heoHizxu+pR2dwKxWj4b+vV8tRSeJIz6Zd
	 IHcxSJ8TBiv98toryKL8KgKK3k9fzRgK7LU4YkMt1OENFRjk0BrVBQ+1JyACtopFMP33j
	 iD1RYn3KxQujqoy7zliykMaLETPWWbkcsju1zHVN3J1Y2Sdfjn/jW0aZEkxhj7OWOmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBhyt2v5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E16606A320;
	Fri, 20 Nov 2026 02:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aBhyt2v5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D5C1F000C4;
	Fri, 20 Nov 2026 02:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795142197;
	bh=PCnFkSkImsEmBbHnJFfPGtEMMmugbuMVDng24j/AWqI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aBhyt2v5JvsXGn1h8uWVHO886SeCjCtaaBrOUOgZWfVzdt07uqe49n7sRSFPMViAO
	 QSPqkcQg5q/BnREk3pM2uHAXHIBRVlHencmZIGVPtgOWxKJjLf50mZFGTgG6lJx2ID
	 yXxGCcEEupL6Dc75YHcMNWNr9GXKZS7mvdk7VD7rOWRKUj6hh6gzINcVH+j53ahfR9
	 JQlmTIefRLU5+ECYD25Noe42oyAkaAt7xpNWeUsNPmAA8lFetTVzuUVlf1Vij7dXeO
	 AnFbZFZlPfucY2DELmbrt1BOu6GYPw6SyjP0BEKgyJa1orT/ISkOrRpd0UeIJILGOR
	 DaZt/G54qVXDQ==
Message-ID: <sashiko-outbox-224374@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] KEYS: fix userspace buffer overflow in
 keyctl_pkey_e_d_s()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Guicai Ma" <maguicai@kylinos.cn>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>
Cc: "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge
 E . Hallyn" <serge@hallyn.com>, "Florian Bauckholt" <florian.bauckholt@cispa.de>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261120022447.789625-1-maguicai@kylinos.cn>
References: <20261120022447.789625-1-maguicai@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 02:36:36 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] KEYS: in2_len overwritten with max_sig_size in
  keyctl_pkey_params_get_2() [1]
--

commit a87f672b96b4f7c3b4eabf969b369139c77f96be
Author: Guicai Ma <maguicai@kylinos.cn>

KEYS: fix userspace buffer overflow in keyctl_pkey_e_d_s()

This commit passes the caller-supplied uparams.out_len back from
keyctl_pkey_params_get_2() to keyctl_pkey_e_d_s() and returns -EOVERFLOW if
the operation output exceeds the userspace buffer size.

> diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> index e7121523b9c9a..b5f82804b5ad1 100644
> --- a/security/keys/keyctl_pkey.c
> +++ b/security/keys/keyctl_pkey.c
> @@ -113,7 +113,8 @@ static int keyctl_pkey_params_get(key_serial_t id,
>  static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __us=
er *_params,
>  				    const char __user *_info,
>  				    int op,
> -				    struct kernel_pkey_params *params)
> +				    struct kernel_pkey_params *params,
> +				    u32 *user_out_len)
>  {
>  	struct keyctl_pkey_params uparams;
>  	struct kernel_pkey_query info;
> @@ -183,6 +184,8 @@ static int keyctl_pkey_params_get_2(const struct keyc=
tl_pkey_params __user *_par
>  	}
> =20
>  	params->in_len  =3D uparams.in_len;
> +	if (user_out_len)
> +		*user_out_len =3D uparams.out_len;
> =20
>  	switch (op) {
>  	case KEYCTL_PKEY_VERIFY:

[Severity: High]
This problem wasn't introduced by this patch, but in the
KEYCTL_PKEY_VERIFY case just above this hunk, commit cb481e59ea6c ("KEYS:
fix overflow in keyctl_pkey_params_get_2()") also overwrote params->out_len
(which aliases params->in2_len in struct kernel_pkey_params) with
info.max_sig_size instead of preserving uparams.in2_len [1]:

security/keys/keyctl_pkey.c:keyctl_pkey_params_get_2() {
	...
	case KEYCTL_PKEY_VERIFY:
		if (uparams.in_len  > info.max_data_size ||
		    uparams.in2_len > info.max_sig_size) {
			ret =3D -EINVAL;
			goto out_up_key_sem;
		}

		params->out_len =3D info.max_sig_size;
		break;
	...
}

When keyctl_pkey_verify() verifies a variable-length signature shorter than
info.max_sig_size (such as an ASN.1 DER-encoded ECDSA signature), does
memdup_user(_in2, params.in2_len) read past the end of the userspace _in2
buffer and either fail with -EFAULT or pass trailing garbage bytes to
asym_verify_signature()?

Should KEYCTL_PKEY_VERIFY set params->in2_len =3D uparams.in2_len instead?

[1] https://sashiko.dev/#/bug/linux-dd9ad2ca-a846-4d0d-89d6-aa262ffd40f1

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120022447.7896=
25-1-maguicai@kylinos.cn?part=3D1
