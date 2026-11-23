Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795469563;
	b=HkVfDwQR83TPQYBrif83J2ZMIVW8r/ljyfc5gA2U9cVzVD6+IipRuLeuJsx5GW5lZQE/
	 UGYwR28+mh153QDZT+206Yf9ff0eFSCtjsUxfHMUGmPFAl/vi4x7ql9NGVfVlBwQFt37q
	 PSeJlsTdoYTzlcBeGUHIBCUx7aTnOCU65SLf0EG986/BEaC4KlN4u1U7HbvhvbB0/lGsi
	 yuEH942exFOxkaWhhjLoWVuux28iSVZqistdcbSPhG46LQwm6uZlgiyrj8hqwehvBq0TI
	 o9649mfAZj3tqWK9xo7Do99oNaw/ThfGW+AEHsR/c5rAUBrgpFZmfWxleVxuv5cOKBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795469563;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Otij95+VYXMoOWI9Klbnj5m/hsBQBJVpERjyzPzaN4A=;
	b=36f4zhQE8dGTnGB6UCDM3lTFzKWxvZ7S43burYWZsEOoxVMPDTP9ftIHeZI8BRKnr1Yi
	 5DNscqClIXRfnz+0TIYbeqvuA0ofyfjhOebocwg9KFEE4ECAElVCNKCOMZpqMw30wnwiW
	 ym/8TR3OP7NzFEaYeSxwldyiH5FWoB0YNgulHfPJQMVzS1mIaAeyWoXn0bOPck0TnUC7A
	 GhIWuSRoDikIJ0lKD4e4TWEeWITKMZlCQgkI50maW49lzk9Vq9FDP39iHXKQknTQItEQD
	 Fv7P3MFaqbJnBUQkDaKvjHRLsnpFp8xfpdrRdcM846CMzrRO845CXqql743IquoXIRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KwNqsjzF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708B6606A31E;
	Mon, 23 Nov 2026 21:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KwNqsjzF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8E91F000CA;
	Mon, 23 Nov 2026 21:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795469563;
	bh=Otij95+VYXMoOWI9Klbnj5m/hsBQBJVpERjyzPzaN4A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KwNqsjzFkvLrYwOS3JTNsKA+Q8p6f3eM4SZEcjHzLnIYBC98kwdhODLzsvf6FKQTx
	 nfeB70BqKy0udnFZL3jip2yqjFsJe6CXKOk7JGKnqquiTEY51CSPku8VFLjRQsXKNm
	 l1AiPoMuxUHX/CHaBm8IXJu/u3gUnTohvppb4nJicTy+/2G0BTh1Mg/X0rT9ZJLGHy
	 cqfk+gAtIsCpXmXjwTkGdwlAiiIP2s06AiuGuWSVlF6Q7URSMX0lRGweNAcs6KDb1N
	 goyKR1roDQbX8VnCA+q4Nv+gE+UlhqoNF1GA+JYkNjxu4V+KPJERY8yOxbNJfBAcAM
	 Pk08guNvzDhHw==
Message-ID: <sashiko-outbox-230085@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] KEYS: Fix userspace buffer overflow in
 keyctl_pkey_e_d_s()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>, keyrings@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, "David Howells" <dhowells@redhat.com>, "Guicai
 Ma" <maguicai@kylinos.cn>, "James Morris" <jmorris@namei.org>, "Paul Moore" <paul@paul-moore.com>, "Serge
 E. Hallyn" <serge@hallyn.com>
In-Reply-To: <20261123211959.4102708-2-jarkko@kernel.org>
References: <20261123211959.4102708-1-jarkko@kernel.org>
 <20261123211959.4102708-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 21:32:42 +0000
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
- [High] KEYS: sensitive plaintext leaked to slab in keyctl_pkey_e_d_s()
  [1]
--

commit e1794f1dd0090bbea27485536c98f990c8a30f19
Author: Guicai Ma <maguicai@kylinos.cn>

KEYS: Fix userspace buffer overflow in keyctl_pkey_e_d_s()

This commit passes the caller's output buffer length back from
keyctl_pkey_params_get_2() to keyctl_pkey_e_d_s() and returns -EOVERFLOW if
the operation output exceeds it before copying to userspace.

> diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> index e7121523b9c9a..b5f82804b5ad1 100644
> --- a/security/keys/keyctl_pkey.c
> +++ b/security/keys/keyctl_pkey.c
[ ... ]
> @@ -310,6 +315,10 @@ long keyctl_pkey_e_d_s(int op,
>  	if (ret < 0)
>  		goto error_out;
> =20
> +	if (ret > user_out_len) {
> +		ret =3D -EOVERFLOW;
> +		goto error_out;
> +	}
>  	if (copy_to_user(_out, out, ret) !=3D 0)
>  		ret =3D -EFAULT;

[Severity: High]
This problem wasn't introduced by this patch, but should the error_out and
error_in paths in keyctl_pkey_e_d_s() use kfree_sensitive() instead of
kfree() [1]?

security/keys/keyctl_pkey.c:keyctl_pkey_e_d_s() {
	...
error_out:
	kfree(out);
error_in:
	kfree(in);
	...
}

Because in and out hold plaintext or other cryptographic payloads for
KEYCTL_PKEY_ENCRYPT, KEYCTL_PKEY_DECRYPT, and KEYCTL_PKEY_SIGN, freeing
them with kfree() leaves sensitive material in the slab cache.

[1] https://sashiko.dev/#/bug/linux-4199b169-0b8d-4055-9a71-6b5b79e38eb3

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123211959.4102=
708-1-jarkko@kernel.org?part=3D1
