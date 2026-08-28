Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9CAB3BE628;
	Fri, 28 Aug 2026 18:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787943209; cv=none; b=szmh7pnxkR1u0CMT5HyAiptNgyW8vhKy3s1MOis1/qBdHj9ndqGZrBV2yL5cbq+PazxhQBxtPvJPIs9XXbJPjbFuBYDOQfR2tyq20NBuVD0majFKS6qIhKUg/VuCitCUsYYGeFSW69fMmt0P4QTgaE7/WRI5W6OCjCoXSTM8g98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787943209; c=relaxed/simple;
	bh=9jj1L8MIX6Qq8W2qoUdMczHcV5gERhAWIKafH6L3GzU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FkDndpQbQFhV7BwVeyg6ctEndvW3bvPfhrImXVHXg9n92FADmVVG7/gpnyAHnrb2f/nzTDXqoBRmS75OegqptxA7xXYYg1jQd9NVWAyVJrZSCJ5jC/DtxbEdnohPO53z+MnBbt+QR+9EXdCxIFADOQUf8m5WOr7mVDXdF1fIFUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g/N5KNO4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g/N5KNO4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7301F000E9;
	Fri, 28 Aug 2026 18:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787943204;
	bh=UAqvwyvjl7VFgeaT1/gjADd0h2ViI1EgS2P5EhLNciY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=g/N5KNO4YnGcOdAFMhekzoNu+wv8optAEMPOvmFng/BsxqSTeJUpBOpB2VsKpXAgA
	 JvQJ8KKV2FqqYSvgP2XgXazgqUp/gAoA7AvTj4FIaLpKOBWRTN08XwUgz2qYbxCK7B
	 /Aguo8yAUdryVn/Fb3p7+vgLUOKLhrLH7rlqYSl/nl+ZoCTMUpWvbI/ebnJ7vyVTYx
	 rlqfaOQKbysOzHMTTSE2bRm+PwKxlLgTwYk6wBavMFvLS8oBgq/73VBM4E8s0XyHcw
	 Jzk0H7ijabaOS7cq69+7IVoRy1L4go4y4sL+3Duj7V6e++y2jUxKl/fbOqTFQeIBmj
	 FgqvFAGFDYWeQ==
Content-Type: multipart/mixed; boundary="===============8607742515944764930=="
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0c93d89a0a7b4886a250fe76ab7a8114ab25d74800796ce17c584fa4e9316890@mail.kernel.org>
In-Reply-To: <20260828175227.1537793-12-daniel@iogearbox.net>
References: <20260828175227.1537793-12-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v4 11/11] Documentation/bpf: Document the bpf keyring and improve examples
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: brauner@kernel.org,kpsingh@kernel.org,ast@kernel.org,john.fastabend@gmail.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,dhowells@redhat.com,jarkko@kernel.org,keyrings@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 28 Aug 2026 18:53:24 +0000 (UTC)

--===============8607742515944764930==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/bpf/signing.rst b/Documentation/bpf/signing.rst
> index e73eaaebd8b15..27fdad3df96f1 100644
> --- a/Documentation/bpf/signing.rst
> +++ b/Documentation/bpf/signing.rst
> @@ -254,21 +254,24 @@ returned. Only after the program has fully loaded, at the next hook
>  (``security_bpf_prog()``), does ``BPF_SIG_VERIFIED`` carry its full meaning:
>  validly signed *and* fully verified.
>
> -A more realistic admission policy than "is it signed at all": accept programs
> -signed by a system keyring, accept a user-keyring signature only if the
> -key/keyring it was verified against is on an explicit allowlist, and emit a
> -tamper-evident record of every decision so that even denied attempts are
> -auditable. (Illustrative - error checking elided.)
> +A more realistic admission policy than "is it signed at all": base trust in
> +the bpf keyring or an explicit allowlist of a caller-supplied staging key/
                                                                             ^^
> +keyring, and emit a record of every decision including denied attempts.

Does this line break leave "key/" at the end of a line? This is body text
in an RST paragraph, so the soft line break renders as whitespace and the
output would read "staging key/ keyring" with a stray space. Rewrapping so
"key/keyring" stays on one line should fix it.

> +(Illustrative - error checking elided.)

[ ... ]

> @@ -390,33 +406,158 @@ Keyrings
>  ========
>
>  ``keyring_id`` selects the trusted keyring the PKCS#7 signature is verified
> -against. The well-known ids ``0`` (builtin), ``VERIFY_USE_SECONDARY_KEYRING``
> -and ``VERIFY_USE_PLATFORM_KEYRING`` select the corresponding system keyrings;
> -any other value is treated as the serial of a user/session key or keyring.
> -The keyring is looked up first, before the signature bytes are examined, so a
> -signature naming a non-existent keyring is rejected up front, and a failed
> -verification aborts the load - so a program that loads successfully with a
> -signature always has consistent keyring fields recorded.
> +against. Four values are well-known; anything else is resolved as a caller-
> +supplied key or keyring, named either by its serial or by one of the other
> +``KEY_SPEC_*`` ids:

[ ... ]

> +Provisioning
> +~~~~~~~~~~~~
> +
> +The keyring is created during ``late_initcall`` and is **sealed empty** by
> +default: it carries a reject-all restriction, so no key can ever be added and
> +``KEY_SPEC_BPF_KEYRING`` fails with ``-ENOKEY`` for the whole boot.

Can the phrasing here be tightened? When the keyring is sealed,
bpf_keyring_init() still publishes it, so lookup_user_key() resolves the
special id fine.

Looking at security/keys/process_keys.c:

    case KEY_SPEC_BPF_KEYRING:
            key = bpf_keyring;
            if (!key)
                    goto error;
            __key_get(key);
            key_ref = make_key_ref(key, 0);
            break;

What actually returns -ENOKEY is a program load naming the keyring:
bpf_lookup_keyring() returns NULL because nr_leaves_on_tree is 0, and
the verifier turns that into -ENOKEY. Two paragraphs later the doc uses
the precise wording ("a load naming it fails with -ENOKEY"); would the
same phrasing work here?

[ ... ]

> +What remains is ``KEY_POS_SEARCH`` for the in-kernel search during verification,
> +plus ``KEY_USR_VIEW`` and ``KEY_USR_READ`` so the keyring stays visible in
> +``/proc/keys``. ``KEY_SPEC_BPF_KEYRING`` names the keyring but conveys no rights

Is KEY_USR_READ attributed to the right facility? /proc/keys visibility
is gated only by KEY_NEED_VIEW in security/keys/proc.c:

    rc = key_task_permission(key_ref, ctx.cred, KEY_NEED_VIEW);
    if (rc < 0)
            return 0;

KEY_NEED_READ is what KEYCTL_READ requires in security/keys/keyctl.c,
which is the "keyctl show" step the same section recommends. So the mask
0x08030000 is correct, but would it read more clearly as "KEY_USR_VIEW so
the keyring stays visible in /proc/keys, and KEY_USR_READ so keyctl show
can still list it"?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33197746599
--===============8607742515944764930==--
