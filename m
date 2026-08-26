Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7D845199A;
	Wed, 26 Aug 2026 17:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766112; cv=none; b=HRC5ZJ5qYx6y3G3o3i35Q5i8xpHIRuwtCAZ+4WWFzfkmDC8xlf7vTdxSFIc5HsGjBjTqjpvdRDqauttDeASFCqd+6H4llrN2QbtgdOSffeTKGs+nY64HZU6k0e4+G5ubUy2sgRcNogOhxmXxh3o+kaMEVMnh1aTVIBHKH/k8SDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766112; c=relaxed/simple;
	bh=a/3R/Dj1LmqJmD3qKZXJKOUxszG7RNd2RydGXkt85IY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=lODOAuUgZDYuJk0wiqYamg23oADzJST2ZLLaYGgZeg//49stwz24lunOpZ2osBDe0trt7yjTBDKd2lPH+a07weyfp+ik/FPDdy3f/Z50uorNtGhDAADOdbG5B10gJilLP3kxT0PyZSq2A1y3FCaiiCL2B5Lyxw7qdBA/+sSRHZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U7yQgZFR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U7yQgZFR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 368D41F00A3D;
	Wed, 26 Aug 2026 17:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787766099;
	bh=eFTNa1aZbNVp5hW+crBm+7SofhwVhoqs0gkfGUSu+OI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=U7yQgZFR0LDRXYs9GM1o0ELzJNAi4Chy2M893XRtVjz7Qh+B4aRIfaH+km8erBDkb
	 +gh0wh5rpL3cV4YvVHBGF52YkpOIB7bd/dgQ86RMBTxntDiCik/AjctFgWlBbNPTo6
	 /DT9l8cHuKJJ7z/4hKjfGWzQPMezZmbLBJXwtnhrmXipGT2vR0SvhCygNCuoarPHHV
	 fW4wD8pChIwunCAq8tkFnEqX5hAlRUhNkhdTdqjQFcGJ77LVE8sgt7z3D88NKiCiBB
	 mvaE5wK3rxCa/ZO6w4YSLqMqgcg6vOGR5KDsKSND7s8w/ZxosJ0rWwLBhR5BqHgYrw
	 WyxQcZViAx79g==
Content-Type: multipart/mixed; boundary="===============6760614280075682483=="
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8c8bf9c60046d0083683c9ae55b8b2730774fa42b55a5601bce0ccaeb6c5d94f@mail.kernel.org>
In-Reply-To: <20260826164136.1400997-12-daniel@iogearbox.net>
References: <20260826164136.1400997-12-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v3 11/11] Documentation/bpf: Document the bpf keyring and improve examples
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: brauner@kernel.org,kpsingh@kernel.org,ast@kernel.org,john.fastabend@gmail.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,dhowells@redhat.com,jarkko@kernel.org,keyrings@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Aug 2026 17:41:39 +0000 (UTC)

--===============6760614280075682483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/bpf/signing.rst b/Documentation/bpf/signing.rst
> index e73eaaebd8b15..9ea24dad5e9f9 100644
> --- a/Documentation/bpf/signing.rst
> +++ b/Documentation/bpf/signing.rst

[ ... ]

> @@ -254,21 +254,25 @@ returned. Only after the program has fully loaded, at the next hook
>  (``security_bpf_prog()``), does ``BPF_SIG_VERIFIED`` carry its full meaning:
>  validly signed *and* fully verified.
>
> -A more realistic admission policy than "is it signed at all": accept programs
> -signed by a system keyring, accept a user-keyring signature only if the
> -key/keyring it was verified against is on an explicit allowlist, and emit a
> -tamper-evident record of every decision so that even denied attempts are
> -auditable. (Illustrative - error checking elided.)
> +A more realistic admission policy than "is it signed at all": base trust in
> +the bpf keyring, accept a staging signature only while the key/keyring the
> +program was verified against is on an explicit allowlist, and emit a tamper-
> +evident record of every decision so that even denied attempts are auditable.
> +(illustrative - error checking elided.)
>
>  .. code-block:: c
>
> -    /* Serials of user keys/keyrings we additionally trust. */
> +    /*
> +     * Serials of caller-supplied keyrings we are willing to stage. Empty
> +     * on a system that has committed to the bpf keyring, where the kernel
> +     * refuses them anyway.
> +     */
>      struct {
>              __uint(type, BPF_MAP_TYPE_HASH);
>              __type(key, __s32);             /* keyring_serial */
>              __type(value, __u8);
>              __uint(max_entries, 64);
> -    } trusted_user_keys SEC(".maps");
> +    } staging_keys SEC(".maps");
>
>      /* Audit stream consumed by a userspace logger. */
>      struct {
> @@ -291,11 +295,19 @@ auditable. (Illustrative - error checking elided.)
>              if (kernel)
>                      return 0;                       /* trust in-kernel loads */
>
> -            if (verdict != BPF_SIG_VERIFIED)
> +            if (verdict != BPF_SIG_VERIFIED) {
>                      ret = -EPERM;                   /* must be validly signed */
> -            else if (ktype == BPF_SIG_KEYRING_USER &&
> -                     !bpf_map_lookup_elem(&trusted_user_keys, &serial))
> -                    ret = -EPERM;                   /* key/keyring not allowlisted */
> +            } else switch (ktype) {
> +            case BPF_SIG_KEYRING_BUILTIN:
> +            case BPF_SIG_KEYRING_BPF:
> +                    break;
> +            case BPF_SIG_KEYRING_USER:
> +                    if (!bpf_map_lookup_elem(&staging_keys, &serial))
> +                            ret = -EPERM;
> +                    break;
> +            default:
> +                    ret = -EPERM;                   /* keyring not in policy */
> +            }

Does this switch statement match what the surrounding prose describes?

Before the change the example accepted all three system keyrings (builtin,
secondary, platform), matching its prose ("accept programs signed by a
system keyring"). The new switch accepts only BPF_SIG_KEYRING_BUILTIN and
BPF_SIG_KEYRING_BPF, so BPF_SIG_KEYRING_SECONDARY and BPF_SIG_KEYRING_PLATFORM
now fall through to the default case and are denied with -EPERM.

The intro text (line 257) says only "base trust in the bpf keyring, accept a
staging signature only while the key/keyring ... is on an explicit
allowlist", but does not mention that the builtin keyring is also accepted,
nor that secondary and platform are refused. The rest of the document groups
the three system keyrings together as trustworthy: "The system keyrings stay
selectable" and "a policy must never treat BPF_SIG_KEYRING_USER as equivalent
to the bpf or system keyrings".

Should the prose clarify which system keyrings this policy accepts and why
secondary/platform are excluded, or should the switch list
BPF_SIG_KEYRING_SECONDARY and BPF_SIG_KEYRING_PLATFORM alongside BUILTIN?

[ ... ]

> @@ -454,12 +630,36 @@ reconstructs - and also computes ``excl_prog_hash`` as the digest of the loader
>  instructions so the metadata map can be bound to the loader. The signature and
>  hash are embedded in the generated header; the certificate is used only for
> -signing and is not included. Loading the skeleton performs the
> -create/populate/freeze/load sequence described above.
> +signing and is not included.
> +
> +Loading
> +-------
> +
> +The generated skeleton exposes ``keyring_id``, which selects the keyring the
> +kernel verifies against. Set it between open and load; loading then performs
> +the create/populate/freeze/load sequence described above::
>
> -At runtime the trusted public key must be present in the chosen keyring (for
> -example added to the session keyring, or built into the kernel's builtin trusted
> -keyring) for verification to succeed.
> +    struct obj *skel = obj__open();
> +
> +    skel->keyring_id = KEY_SPEC_BPF_KEYRING;
> +    err = obj__load(skel);
> +
> +For the staging case the same object is loaded against a keyring the caller
> +populated itself, which only works on a system that has not set
> +``bpf.keyring_unsealed=1``::
> +
> +    /*
> +     * Staging only: this keyring is under the loader's own control and
> +     * carries no trust of its own. See "Caller-supplied keyrings are for
> +     * staging".
> +     */
> +    key_id = add_key("asymmetric", "", der, der_sz, KEY_SPEC_SESSION_KEYRING);
> +    skel->keyring_id = KEY_SPEC_SESSION_KEYRING;
> +    err = obj__load(skel);

[ ... ]

> @@ -436,16 +579,49 @@ Two fields are recorded in ``prog->aux->sig`` for an LSM to inspect:
>     - ``VERIFY_USE_PLATFORM_KEYRING``
>       - ``BPF_SIG_KEYRING_PLATFORM``
>       - ``0``
> -   * - other (a user/session key serial)
> +   * - ``KEY_SPEC_BPF_KEYRING``
> +     - ``BPF_SIG_KEYRING_BPF``
> +     - ``0``
> +   * - other (a caller-supplied key serial)
>       - ``BPF_SIG_KEYRING_USER``
>       - serial of the resolved key/keyring
>
> -Producing a signed object
> -==========================
> +Producing and loading a signed object
> +=====================================
> +
> +Generating a signing key
> +------------------------
> +
> +Signing is algorithm agnostic: the algorithm comes from the X.509 certificate
> +and the PKCS#7 ``SignerInfo``. Anything the X.509 and PKCS#7 parsers understand
> +works with no BPF-side change. Both examples below read the certificate request
> +config from ``x509.genkey``, for which ``certs/x509.genkey`` serves as a
> +template (see Documentation/admin-guide/module-signing.rst). RSA::
> +
> +    openssl req -new -nodes -utf8 -sha256 -days 36500 -batch -x509 \
> +            -config x509.genkey -outform PEM \
> +            -out signing_key.pem -keyout signing_key.pem
> +    openssl x509 -in signing_key.pem -outform der -out signing_key.der
> +
> +ML-DSA-87 (FIPS-204), which needs openssl 3.5 or later and ``CONFIG_CRYPTO_MLDSA``
> +in the kernel. Note the absence of a digest option: ML-DSA hashes the message
> +itself and openssl rejects an explicit digest for it::
> +
> +    openssl req -new -nodes -utf8 -days 36500 -batch -x509 \
> +            -newkey ML-DSA-87 -config x509.genkey -outform PEM \
> +            -out signing_key.pem -keyout signing_key.pem
> +    openssl x509 -in signing_key.pem -outform der -out signing_key.der

Is the claim that "openssl rejects an explicit digest for it" correct?

OpenSSL silently ignores the digest for ML-DSA rather than rejecting it.
In apps/lib/apps.c do_sign_init(), when EVP_PKEY_get_default_digest_name()
returns 2 (UNDEF), the digest is forced to NULL. This was verified directly:

  $ openssl req -new -nodes -utf8 -sha256 -days 1 -batch -x509 \
        -newkey ML-DSA-87 -config t.genkey -outform PEM \
        -out m.pem -keyout m.pem
  (exit 0; resulting cert: 'Signature Algorithm: ML-DSA-87')

The in-tree module signing build corroborates this: certs/Makefile's
cmd_gen_key passes '-$(CONFIG_MODULE_SIG_HASH)' unconditionally, including
for ml-dsa-87, and that build succeeds. Omitting the digest is correct and
clearer, but the stated reason is misleading.

The same incorrect justification appears in the comment above genkey_mldsa()
in tools/testing/selftests/bpf/verify_sig_setup.sh (added in 3eb252cf73a48).

Should both be reworded to say that openssl ignores an explicit digest for
ML-DSA, rather than stating it rejects one?

> +
> +``bpftool`` handles the following internally: openssl before 4.0 cannot combine
> +ML-DSA with ``CMS_NOATTR``, so it falls back to signedAttrs, where only SHA-512
> +is permitted. This mirrors what module signing does as well.

Is the CONFIG_CRYPTO_MLDSA requirement complete?

The stated kernel requirement lists only CONFIG_CRYPTO_MLDSA, but
CONFIG_CRYPTO_SHA512 is needed as well. Because bpftool falls back to
signedAttrs with EVP_sha512() on openssl < 4.0, the kernel side verifies the
messageDigest attribute through pkcs7_digest() -> crypto_alloc_shash() with
hash_algo == "sha512".

CONFIG_CRYPTO_MLDSA selects only CRYPTO_SIG and CRYPTO_LIB_MLDSA (which
selects CRYPTO_LIB_SHA3), never CRYPTO_SHA512. A kernel built with
CONFIG_CRYPTO_MLDSA=y but CONFIG_CRYPTO_SHA512=n will fail such loads.

The same series adds both symbols to tools/testing/selftests/bpf/config in
3eb252cf73a48:

    +CONFIG_CRYPTO_MLDSA=y
    +CONFIG_CRYPTO_SHA512=y

Should the documentation list CONFIG_CRYPTO_SHA512 alongside
CONFIG_CRYPTO_MLDSA?



---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32991355707
--===============6760614280075682483==--
