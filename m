Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794144756;
	b=i3dl7CcxmZ8tyNHiCYthVFoBE6TFw4/eUUF4GwtC8+54Lwj/GW5UODgArvfSqkoWELbU
	 uNaIsSe3riyWv50af1UW/BgHVrZcv7jsIWTw1GPGOxpBQvk1bycxYZdEzbFxhNYSqLykW
	 yIOdwWgYezSvEKKJmDb03wuKVoQTD3I194egKJj9qbBZaB+KubZ0fQKHtgpNCpisfne+0
	 cmpuQyRNfMBhTIMKs0iuI/oIbf/UNx9aZHH7a7rc0wRnKo7CSdINDa0Jeq2M9+P8pg/V3
	 4DECXgG949MJjwPUsSvdjRS+CTZzC8+5JJ90ZyadFJeeZVYaQRL/Slo7hhABrSdqT/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794144756;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AzWaOvxASjZ2VbLng5CfdtXccCCf/vmBBS0ZjxIzoHU=;
	b=2H4QUr41n7scI+wTL7k6Hmk/HnGLwkd20y4mC9DskMhSDyaM4CGrSskeYQaRjV6f6RzY
	 iI3XVG/d3qbgAfxzNs3a+eqya6uVwqyNFCMFqC+B1k6lVvPNSK47+u84upjbp+EFY7ctL
	 A1IdsXEdXoA8BNtA1yPq/DpvKbKWbeTGVNbAMBZUc16evr+uR/mD1Ksk+Mtpc1WNlZyVu
	 VUHsIx8SNP8xJcFTB/TuO84iQoi3ccP71Brc3JuIN5Yvq1eNdWJsplLOofcefb4LCenUp
	 ig9C7MzVG6kHJ1rqG7+uKqGbpyVeqYwW5r7Jm/qyeYWBTG4Imcocw0jSH/0L7gzwpZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YYUfnHrQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C136606A31C;
	Sun,  8 Nov 2026 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YYUfnHrQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA8C1F0089F;
	Sun,  8 Nov 2026 13:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794144756;
	bh=AzWaOvxASjZ2VbLng5CfdtXccCCf/vmBBS0ZjxIzoHU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YYUfnHrQ0XltOD+RniCM/6QiHkpkbsRRaezIp4SR8LG9kFeqBJAoqrgH/aEAMmymK
	 OXB5enheo2zSvRZvRisPZLMtLThCt0k5k4toHZblS3GXTJnEyO8TEfOtGAWjszWNuV
	 5v67n334yoRp4z2Rii0u1XffqBozU3cHQr3xcXvpEQ6w05S2DGo//G4AiCf7VbS+Oc
	 YRe71VRcpHfHeCBEv8IXaMXN2UN1nkpxF9k+AVCEkQ1FMXw0Mje/0XOaL4MdDOJaTN
	 vWivwvv1WGkwpDHS1bZKdkbyqftLQvTKr32mrJci6wyrGdBq8fpQ1g8wKq0XM/OXRL
	 cwnNwbvRsgM8Q==
Message-ID: <sashiko-outbox-203780@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] KEYS: Protect pkey method checks against type
 removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuansheng Yang" <0xbeac@gmail.com>, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: "David Howells" <dhowells@redhat.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
In-Reply-To: <20261108131417.77287-1-0xbeac@gmail.com>
References: <au3fT5HMq7IF-M3e@kernel.org>
 <20261108131417.77287-1-0xbeac@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 13:32:35 +0000
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
- [Medium] KEYS: unlocked key->type dereferences in keyctl_pkey method
  checks
--

commit 0ed416869e71a7b6cc7a35c0985435f3666b373b
Author: Yuansheng Yang <0xbeac@gmail.com>

KEYS: Protect pkey method checks against type removal

This commit takes key->sem for reading around the four asymmetric key
method calls in security/keys/keyctl_pkey.c and re-checks the method
pointer under the lock to prevent races with key type unregistration.

> diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> index 15b6bf6399b59..0ea6f2790e9de 100644
> --- a/security/keys/keyctl_pkey.c
> +++ b/security/keys/keyctl_pkey.c

[ ... ]

> @@ -305,31 +332,41 @@ long keyctl_pkey_verify(const struct keyctl_pkey_pa=
rams __user *_params,
>  	ret =3D keyctl_pkey_params_get_2(_params, _info, KEYCTL_PKEY_VERIFY,
>  				       &params);
>  	if (ret < 0)
> -		goto error_params;
> +		goto out_free_params;
> =20
>  	ret =3D -EOPNOTSUPP;
>  	if (!params.key->type->asym_verify_signature)
> -		goto error_params;
> +		goto out_free_params;

[Severity: Medium]
Can the remaining unlocked checks of key->type still fault on freed module
memory when a key type module is unloaded?

Checking key->type->asym_verify_signature here (and the corresponding
unlocked checks of key->type->asym_eds_op in keyctl_pkey_e_d_s() and
key->type->asym_query in keyctl_pkey_params_get()) reads key->type and
then dereferences the struct key_type in module memory without holding
key->sem:

CPU0                                  CPU1
keyctl_pkey_verify()
  reg =3D params.key->type
                                      unregister_key_type()
                                        ...
                                        down_write(&key->sem)
                                        key->type =3D &key_type_dead
                                        up_write(&key->sem)
                                      free_module()
  if (!reg->asym_verify_signature)  <-- use-after-free

security/keys/keyctl_pkey.c:keyctl_pkey_params_get() {
	...
	key_ref =3D lookup_user_key(id, 0, KEY_NEED_SEARCH);
	if (IS_ERR(key_ref))
		return PTR_ERR(key_ref);
	params->key =3D key_ref_to_ptr(key_ref);

	if (!params->key->type->asym_query)
		return -EOPNOTSUPP;

	return 0;
}

Both callers of keyctl_pkey_params_get() immediately take key->sem and
re-check asym_query before doing anything else, so the unlocked check in
keyctl_pkey_params_get() can be dropped, and the early asym_eds_op and
asym_verify_signature checks can be performed under key->sem inside
keyctl_pkey_params_get_2() while still returning -EOPNOTSUPP before
memdup_user().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108131417.7728=
7-1-0xbeac@gmail.com?part=3D1
