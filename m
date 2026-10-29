Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793235003;
	b=iNbCATU4I+2vKT3R8t8LL40MO1Mchi37+kx1SP/5iBEqQTn3TSfrPsO73QoY2o5YTyLb
	 vRd/0UUcXbu//PhjZ6IZx0g4Qmrf3PY9Fr7sdNgc2sA3mfo0dGMHXPC8s8ixrZoSbc4QZ
	 B03e2Ullqa7mPJP6LWJIHN5eA2ksrWV+pWIeRhFRrjLMWkLBdyri0EUcKyZA8/zL0C62G
	 OKoyEiSBNKjvomQwd0MEL2o7jG/lKrXTrurTRsddoCKiITA8sNEMpx2z4OoNe16hZBeI1
	 a/f/ISv9Ga0/JyWjlycyFBT7P3OkTJkdKscWU02+865+B5KGgOC7MHcpZulM3mySTHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793235003;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9ctWfCaikZBDGwBDGZ92QONpbazh9MI/L9SBN/1BcH0=;
	b=xkcgI1QBy0+DsxSnW/OUbmkJn50KmqzyVqgecs0qWZh2GFmSNudidg5rEQi+V2fOsprk
	 cjBzP5P5OtyaDGmOl+PX3HPyCGym0ofHiOnXEoHPNBQT82WM8ZMgtl4t3STnic+15+gUA
	 yigDcEL8fjGV2ga3cwLfs8WdJ3aD3uwJ2idrFnG+t4h/ipBvmfwtSCfJ2aD+nJ3ZakiJ0
	 wyyS0gabc4pcqGRZX7YQw3vRVRA1OL1nCvl/ftzKAR7bLA2MxSt1EjYmRu9HP7Jedrzy7
	 rsLryFVc4GwbqFdSYZWT4MNtu51pbrWkmwr4DYE1i4HUIuwmKnuskpkMIOul4fhCpxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLuf2ql1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69330606A31A;
	Thu, 29 Oct 2026 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fLuf2ql1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503D01F031E5;
	Thu, 29 Oct 2026 00:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793235003;
	bh=9ctWfCaikZBDGwBDGZ92QONpbazh9MI/L9SBN/1BcH0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fLuf2ql1SXVYJMRtj8ZG8+jRqsezkB8gsszBJAgKL2XwG5cR6pi7Lso2HmRr0EC0B
	 QWIcOdBgbXKrO8LhmXYnOExLTGgG7XejY8HVD+56S2+XFXYPIKxz5EgJKkAMLKUiA3
	 tYkv88wAmMt3tbS9U1qLSZJ1soralOR0VFSPIwAhHIbu9mZ370PFygDuI+ffCeJFX/
	 XOFbSr3IJ7s1xi46/FHDUjCTnY57/eVqwH8UnlWa2fudq0As9BuR3IqAxV+G5jUR9v
	 eUQjmHZWY6ucmwyRNm6K+YjoEt5dzNB4tOuyz6BifVxwlnciP+xHsl2607nHTx10Mz
	 Ky9kQK2xDVPmg==
Message-ID: <sashiko-outbox-188577@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] keys: add KEY_SPEC_IPE_KEYRING
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manuel Huber" <manuelh@nvidia.com>, "Fan Wu" <wufan@kernel.org>, "David
 Howells" <dhowells@redhat.com>, "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: "Christian Brauner" <brauner@kernel.org>, "Andrew Halaney" <andrew@amutable.com>, "Paul
 Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Luca Boccassi" <luca.boccassi@gmail.com>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, kexec@lists.infradead.org
In-Reply-To: <20261029-b4-ipe-keyring-rfc-v2-2-77727b205844@nvidia.com>
References: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com>
 <20261029-b4-ipe-keyring-rfc-v2-2-77727b205844@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 00:50:01 +0000
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
- [Medium] keys: KEY_SPEC_IPE_KEYRING uses -12 assuming nonexistent keyring=
 IDs
--

commit 44da1efd13cdd5eb92238870e4d4626fe42f170e
Author: Manuel Huber <manuelh@nvidia.com>

keys: add KEY_SPEC_IPE_KEYRING

This commit adds the KEY_SPEC_IPE_KEYRING (-12) special key ID so that
userspace can directly reference the .ipe keyring via lookup_user_key()
without resolving it through process keyrings or /proc/keys.

>     keys: add KEY_SPEC_IPE_KEYRING
>    =20
>     The BPF, dm-verity, and fs-verity keyrings have well-known IDs which
>     allow userspace to directly address them. This commit follows the same
>     pattern for the .ipe keyring.
>    =20
>     This provides a direct interface independent of resolving %:.ipe thro=
ugh
>     process keyrings and /proc/keys.
>    =20
>     Signed-off-by: Manuel Huber <manuelh@nvidia.com>
>=20
> diff --git a/Documentation/security/keys/core.rst b/Documentation/securit=
y/keys/core.rst
> index 326b8a9738289..64b37817a3356 100644
> --- a/Documentation/security/keys/core.rst
> +++ b/Documentation/security/keys/core.rst
> @@ -373,6 +373,18 @@ process making the call::
>  	KEY_SPEC_REQKEY_AUTH_KEY	-7	assumed request_key()
>  						  authorisation key
> =20
> +There are also values that refer to a specific kernel keyring rather tha=
n to
> +anything belonging to the caller.  These well-known IDs allow userspace =
to
> +name kernel keyrings directly even when they are not linked into a proce=
ss
> +keyring::
> +
> +	CONSTANT			VALUE	KEY REFERENCED
> +	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +	KEY_SPEC_IPE_KEYRING		-12	the ".ipe" keyring
> +
> +The availability of a subsystem keyring depends on its kernel configurat=
ion.
> +Looking up an unavailable keyring returns ``ENOKEY``.
> +
> =20
>  The main syscalls are:
> =20

[ ... ]

> diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
> index 4c8884eea8084..e42fca286b156 100644
> --- a/include/uapi/linux/keyctl.h
> +++ b/include/uapi/linux/keyctl.h
> @@ -24,6 +24,7 @@
>  #define KEY_SPEC_GROUP_KEYRING		-6	/* - key ID for GID-specific keyring =
*/
>  #define KEY_SPEC_REQKEY_AUTH_KEY	-7	/* - key ID for assumed request_key =
auth key */
>  #define KEY_SPEC_REQUESTOR_KEYRING	-8	/* - key ID for request_key() dest=
 keyring */
> +#define KEY_SPEC_IPE_KEYRING		-12	/* - key ID for the .ipe keyring */

[Severity: Medium]
The commit message states that the BPF, dm-verity, and fs-verity keyrings
have well-known IDs, and defines KEY_SPEC_IPE_KEYRING as -12 immediately
after KEY_SPEC_REQUESTOR_KEYRING (-8) in include/uapi/linux/keyctl.h.

However, in the kernel tree, none of the BPF, dm-verity, or fs-verity
keyrings have KEY_SPEC_* IDs in include/uapi/linux/keyctl.h,
Documentation/security/keys/core.rst, or lookup_user_key() in
security/keys/process_keys.c.

This leaves an unexplained gap (-9 through -11) in the UAPI numbering and
makes KEY_SPEC_IPE_KEYRING (-12) the sole entry in the kernel keyring table
in Documentation/security/keys/core.rst.

Was this patch based on an unmerged series that assigned -9, -10, and -11 to
those keyrings, and should the numbering and commit description be adjusted
to match the current tree?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-b4-ipe-key=
ring-rfc-v2-0-77727b205844@nvidia.com?part=3D2
