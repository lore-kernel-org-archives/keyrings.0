Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990200;
	b=euVx1AKtf/gH8DLmD8G9j3PseqcOb6Fw5LbPjc0n326mbd0DbFBJxNGfM3nMGhfDS9bR
	 X9kai0L8oleEH9k3rJOJJjCExD2DjDcl4YMEANFLeu57J8ax3y+L8nJ28ykbZeMpdeWlW
	 BRmk2c8VTnN2bWMDM6pVtlR3LmCBRVEb9LZUc27NOadZPAh7Zupaxu1Bahxg3ExlUlEpG
	 9lpvELUxx27fAHH5VPeslykFOyS2GaCkW+kybsSEGAsGUoI3OaN9YtICLtFI26iO4ERbP
	 WVmt4YqTIaNRIM6aDSmcZAeeNedHd6bv0u0S8WRATBLSpWcE00943AJvonu7xoR4NZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990200;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UliTkuKSwijkprFnPvplR6mcOQUjgocutB6yCvWNZyo=;
	b=Bld+yNI3aVsCt3OBDR8V1lcQp7vI9Jlwt9N5hkm0fKe+OvNRGnWCHI9kLmouqQ5kI8ZA
	 4ew/wnUTZi/FkcTGmZcwO9YB3wc8Y5AsfbsOsAnhcOPqqCVOJcLohI6qgv9u8QeJlBRIG
	 QskJpPA0RYG58k52ReBLa/LgotNntJblZjIgk8fi7BMZacXrsniTTwf5xwqQewFyN+yTs
	 WZ8/6Em40tp2vtMGZfiE5O/X6mk7RbKNlcnspRKIZN2m81Q0TdNVGCfb6YjACSv18XISY
	 ba+0r/fMimxh79ZsQ39FwHEVhSTpz0Cboc5ZgXL64v/F8mOFArX/RyRRJScG3mOFpkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux.win;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159BF606D811
	for <keyrings@vger.kernel.org>; Fri,  6 Nov 2026 18:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 159BF606D811
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c450ab1483cso149149966b.3
        for <keyrings@vger.kernel.org>; Fri, 06 Nov 2026 10:36:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990198; x=1794594998;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UliTkuKSwijkprFnPvplR6mcOQUjgocutB6yCvWNZyo=;
        b=WeECOL2UOfXmzObaijYlG3kA4xxOoH9f+G/mYoU2sMi7gBngqbcc5iTSbEjYL2U/jF
         AG/6uqYQwuGvf14cPVGCbvJVVoSZdqtOXfi65q3KWpvFwfh2oAs+F+IAYQR0U981wABu
         WbrMToDAJin+G2vFBWThRc7aq53SW1dfjk6F1Xflz0t8ejm/9lRu8mUWKAuB1J5oy6yX
         j8FxXT1YcWcSt/r9Hsb9e/LPzsXQFvi5+Se0GHGNnFFkeBjp1IsEEKUnTWk4JE/K36hJ
         6RPHzEV2/XytHMflvEfEo04HvbllJsxtCYYXntjgYvTB1trAo/hyWAyLtbF30I3jl53w
         Np0w==
X-Forwarded-Encrypted: i=1; AKwUvBx4ftundik1tzJXBUSldCK28wueSFJ15Vuw+chRVGAy4xPSD3ylOk03CeNTKt0MOUFonZocCGxEuw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8MyJrK5VfvKHxMSpReatSoJsOF4VKa1dW63rfLHhBRqBGcPWq/
	xr43LTzDhNMZekQV/odP/+/W6RVsWeNBuh4jRbAgRDY7kgqYMByRpDM9sjVwvz6MWOI=
X-Gm-Gg: AYBFou222ax/JCEsOUcvNkYCA6GaFgY8njINidVPqsneyf+pxaDZnK/y51dVHIsqN7M
	cPtXzrpGkeESH9mELUbTTWorw7pF1CECucYYqz1bLCtzwAtBmm8CEfpBCmA+KJMXbG2YXQ/Vg1a
	HoacDbRNe3golsbcS/rkfcxSucp7Chy6m8Wg+e85ig+rTMFqbCxj8bbbiDXgqMbsS8XT/1UWTtv
	T24mu/EKiklVtLU/Q/tN0LI8jx1s2KBaUot6WPO0AOTHvDSDKME9fhHAA7z/xvxAyswOy9+YSQv
	p0bzix8HDHBkjFCGAUamdKEI/KaM8vod6PKIY45raSLBKgcsYUUyUlP3khwVq8zTqO1Uis8rLLp
	+GDEFbP+ehb90wuE7XM771NXBl0nu3XBkyJ/A5AR3yPxzkuoCO+Yq1KvvfX3/JmNLk/UzzCq9rb
	xQ1J4to3p6im3yQeO3tngZJ4uno8KsFz1MmA424tQUct4CuK73X9RTlWI+2+Hwxx4fRHMu+WR6+
	gWPUIl0Oyf37g13O+Zh9DH9KmNXUJV3cdjGItEIVdq/aHO6iWYSYWPDMVLecLWLOyVwYuOSW5XG
	ias0WRsEFrtr59EoZrE6bcgNgImXAOL8ux7zQu4S40LjGy0pXyydJMOiqhE=
X-Received: by 2002:a17:906:ef0a:b0:c4d:167d:dcee with SMTP id a640c23a62f3a-c4d353d0210mr282056866b.40.1793990198273;
        Fri, 06 Nov 2026 10:36:38 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d354ac21dsm98366666b.12.2026.11.06.10.36.38
        for <keyrings@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 10:36:38 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c450ab1483cso149148466b.3
        for <keyrings@vger.kernel.org>; Fri, 06 Nov 2026 10:36:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGpidbDORG3+IS4JPv+jCsxRWJnVGNkEbSeJvQfFvE8TEG/Eu14MzS8EodnOeeI6/r9n1Gve/+sDQ==@vger.kernel.org
X-Received: by 2002:a17:907:ea89:b0:c4c:bff4:200c with SMTP id
 a640c23a62f3a-c4d3531f031mr283547466b.32.1793989808075; Fri, 06 Nov 2026
 10:30:08 -0800 (PST)
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029232437.2581640-1-jarkko@kernel.org> <20261029232437.2581640-2-jarkko@kernel.org>
In-Reply-To: <20261029232437.2581640-2-jarkko@kernel.org>
From: Ignat Korchagin <ignat@linux.win>
Date: Fri, 6 Nov 2026 18:29:56 +0000
X-Gmail-Original-Message-ID: <CAOs+rJVNyJwqp4CR-d_T4GVjNMjgbaDL78_mZCVGGvN1xpd33w@mail.gmail.com>
X-Gm-Features: AclHuK8TGNjpH-aL7rdb3WJ8RwrdjoKcrJ52VddwbSIE-hld3YHoMNkMBO-NFbA
Message-ID: <CAOs+rJVNyJwqp4CR-d_T4GVjNMjgbaDL78_mZCVGGvN1xpd33w@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] KEYS: Introduce keyring_is_empty()
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, 
	Eric Biggers <ebiggers@kernel.org>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, 
	Mikulas Patocka <mpatocka@redhat.com>, Benjamin Marzinski <bmarzins@redhat.com>, 
	"Theodore Y. Ts'o" <tytso@mit.edu>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, 
	"open list:ASYMMETRIC KEYS" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:DEVICE-MAPPER (LVM)" <dm-devel@lists.linux.dev>, 
	"open list:FSVERITY: READ-ONLY FILE-BASED AUTHENTICITY PRO..." <fsverity@lists.linux.dev>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 11:25=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org=
> wrote:
>
> Introduce keyring_is_empty() in order to decouple for BPF, dm-verity and
> fs-verity how keyring internally manages the keys.
>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: Ignat Korchagin <ignat@linux.win>

> ---
>  drivers/md/dm-verity-verify-sig.c                      |  2 +-
>  fs/verity/signature.c                                  |  2 +-
>  include/linux/key.h                                    |  1 +
>  kernel/bpf/keys.c                                      |  2 +-
>  security/keys/keyring.c                                | 10 ++++++++++
>  .../selftests/dm-verity/test-dm-verity-keyring.sh      |  2 +-
>  6 files changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/md/dm-verity-verify-sig.c b/drivers/md/dm-verity-ver=
ify-sig.c
> index aadcf5e4a47c..cad21e9144ed 100644
> --- a/drivers/md/dm-verity-verify-sig.c
> +++ b/drivers/md/dm-verity-verify-sig.c
> @@ -153,7 +153,7 @@ int verity_verify_root_hash(const void *root_hash, si=
ze_t root_hash_len,
>         if (ret !=3D -ENOKEY && ret !=3D -EKEYREJECTED)
>                 return ret;
>
> -       if (dm_verity_keyring->keys.nr_leaves_on_tree &&
> +       if (!keyring_is_empty(dm_verity_keyring) &&
>             dm_verity_keyring->restrict_link)
>                 ret =3D verify_pkcs7_signature(root_hash, root_hash_len,
>                                              sig_data, sig_len,
> diff --git a/fs/verity/signature.c b/fs/verity/signature.c
> index 0302a4e506ec..890d33b9d812 100644
> --- a/fs/verity/signature.c
> +++ b/fs/verity/signature.c
> @@ -67,7 +67,7 @@ int fsverity_verify_signature(const struct fsverity_inf=
o *vi,
>                 return 0;
>         }
>
> -       if (fsverity_keyring->keys.nr_leaves_on_tree =3D=3D 0) {
> +       if (keyring_is_empty(fsverity_keyring)) {
>                 /*
>                  * The ".fs-verity" keyring is empty, due to builtin sign=
atures
>                  * being supported by the kernel but not actually being u=
sed.
> diff --git a/include/linux/key.h b/include/linux/key.h
> index c4486e938a06..20ca43f5eab1 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -439,6 +439,7 @@ extern int restrict_link_reject(struct key *keyring,
>                                 struct key *restriction_key);
>
>  extern int keyring_clear(struct key *keyring);
> +bool keyring_is_empty(const struct key *keyring);
>
>  extern key_ref_t keyring_search(key_ref_t keyring,
>                                 struct key_type *type,
> diff --git a/kernel/bpf/keys.c b/kernel/bpf/keys.c
> index bffc356839ac..24e0416abc99 100644
> --- a/kernel/bpf/keys.c
> +++ b/kernel/bpf/keys.c
> @@ -29,7 +29,7 @@ struct bpf_key *bpf_lookup_keyring(void)
>
>         if (!bpf_keyring)
>                 return NULL;
> -       if (!READ_ONCE(bpf_keyring->keys.nr_leaves_on_tree) ||
> +       if (keyring_is_empty(bpf_keyring) ||
>             !READ_ONCE(bpf_keyring->restrict_link))
>                 return NULL;
>
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 5281da9d5bf7..ac48d6204915 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -443,6 +443,16 @@ static void keyring_destroy(struct key *keyring)
>         assoc_array_destroy(&keyring->keys, &keyring_assoc_array_ops);
>  }
>
> +/**
> + * keyring_is_empty - Check whether a keyring is empty
> + * @keyring: The keyring to check.
> + */
> +bool keyring_is_empty(const struct key *keyring)
> +{
> +       return READ_ONCE(keyring->keys.nr_leaves_on_tree) =3D=3D 0;
> +}
> +EXPORT_SYMBOL(keyring_is_empty);
> +
>  /*
>   * Describe a keyring for /proc.
>   */
> diff --git a/tools/testing/selftests/dm-verity/test-dm-verity-keyring.sh =
b/tools/testing/selftests/dm-verity/test-dm-verity-keyring.sh
> index 1f9601ef22f8..792449d356cf 100755
> --- a/tools/testing/selftests/dm-verity/test-dm-verity-keyring.sh
> +++ b/tools/testing/selftests/dm-verity/test-dm-verity-keyring.sh
> @@ -746,7 +746,7 @@ test_keyring_inactive_when_empty() {
>      log_info "TEST: Verify dm-verity keyring is inactive when sealed emp=
ty"
>
>      # When keyring_unsealed=3D0, the keyring is sealed immediately while=
 empty
> -    # This means it should NOT be used for verification (nr_leaves_on_tr=
ee=3D0)
> +    # An empty keyring should NOT be used for verification.
>
>      log_info "Keyring state (should be empty and sealed):"
>      list_keyring_keys
> --
> 2.47.3
>
>
