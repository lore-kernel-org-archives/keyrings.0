Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AFB364E96
	for <keyrings@vger.kernel.org>; Mon, 24 Aug 2026 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584733; cv=pass; b=qUADugporngMU7MJ7GkpiHrmHrCu3QhWJjNxCdOmAHbj6ChBODGyzJhrlWnFahLG7CTxZ5KID7BPqQFajLFjgJby4CwY8KxEiHSk8nbRDzDqd9hT/Dph0u7sLslVdZEFbs+yFBsSGR1VFfdUGk9X9umfOJ3lComk5l9/E211+3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584733; c=relaxed/simple;
	bh=BcIjz0TwFTjpzBBWL7usC6KhzrrYdTOn3cvUnb4jHYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QEO7QT3U8/CmJeLgO0rgQRLx+p41cZeqK0A9bLHSG7k86Al8jjiMR0dLbBmlTw3RhPvsn7+Z1D6DNq+t/pQzpU7tBWmuZbHhXwHPgk9Gmkk7z+zk1b/UOFk7ikiEiagHYZW/voP2mIB6H5TiHfMn2fa4exanFJR/bao96PmLe94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DmC7Tzi/; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DmC7Tzi/"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38101f85591so3817471a91.1
        for <keyrings@vger.kernel.org>; Mon, 24 Aug 2026 08:18:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787584732; cv=none;
        d=google.com; s=arc-20260327;
        b=KBN6qltkOXy33HsbRZP8MQuSYVq+hIWVA5LkiKcVpTzIpBkUNNz2/l0ngady66efb1
         ezu3x7Di3CpjnbXBC7K7hWoHw9uWgkM02QxYJNAajo4lYebh2q/fkjB87T051ADPPjgm
         UDxRakHIIQplaz3BkPWH41sgyr9RxSKYPgZvUrXgNUc515a2dyeZ2J4j2amuflZv/3zu
         JgjqZNZ2zuZYgP0v2riOozHcY96uUTNTcfOaZT63d5GMo7Z8oKW5rb3robPRFlOuPYUv
         icuF6fr6qv8rho/3omiK1ql0EMs4pK/Ile3D/f57eNCD0+4RT299vHcEMSPBcjdCfvzb
         XvxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gqb137FAD3j5AecU+kBp3iNtBsHjhinz7tGtlFwvT1g=;
        fh=d9YlQ8dYbk5E0nZaJ4hg9Tp4So1D2rej1tGz/3qnkRc=;
        b=eCruC0Zw+UrZOoXRYpvOYavN+4i8DvX8Dsn5MXX0IAkILVhTmfcMIxeB3qpUyZmfR5
         WXVCUa5/98EAoIBUNspcyEfFPdqDBvguTKslQvdABgXk44V1IZHntEEZqCZzOfMrLDOT
         5FuRZagjpr/7ZyYtPRBkIYu/wNREhcqJ8g0HgwRouBC+xTiOFD5SdJWLnLGA7pgFH+eZ
         NGoh8FrL95jfpNDZv0UD23EEh81XtdkSTOtJvaIyX6eEymZPf75egEEmjha1Y+1bW7wW
         /RtUIdsolbC5/EsiI60QNg5ULwMxmvpQplIllAFCidk+RuXpxdVAr39R01Lu6AXkOkpe
         TX7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787584732; x=1788189532; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gqb137FAD3j5AecU+kBp3iNtBsHjhinz7tGtlFwvT1g=;
        b=DmC7Tzi/pqA1ivkYiKhm4VJ4/+FkXwv8qpNPqPOlpvZ74P/sl1t4Jy139gOQtY7RDL
         uCFU6cklEI2Wa8Da28cf23dyMILTvIsn/wpMAnXxGmno8vtwhs6u/M1xhuZxk3k2SoZ/
         T/h9/o4RecRGw8/QtDe2LUHD8itb3b0S60pdFlegWxNwg1ez9/80pCrynu/pl7XJkyGZ
         UVua9hBtiy/wX1d4smdlv6AmBCREEMGj3IlPxGb0sY5tzyzCSQqMzSyhkKn7ywRta0ZZ
         Geest7hN3h6VoGYE38PRxrdsZzIKfxTBWlu8EZNnNeumFvSrTXwLVBNWobINQswcq7sy
         astA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787584732; x=1788189532;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gqb137FAD3j5AecU+kBp3iNtBsHjhinz7tGtlFwvT1g=;
        b=fSGgUGggTp5WQ19YFBIX5EoVbThEL0VDjSGCo6tniVTwrFh9nwsHzBHsomRZv2heMN
         pGgTD1z7DJbbjLXnUByACSUdGDfNl9BU/wpANQ+AUCe76OskagFXXRl+zh6mjat4W7nL
         Q6FRv4BHukPGm7AYqZOHLSSI+RR8lDfWRuGLl3x0OYgpRCemdgGzTqmBiKy3gbxLEwJa
         +2/foQZj+nfqzCGdo2iZwKWbdAnceyt/H5va4rN+LvJLalMynfNUUYFyXI2gSIw9a+Ny
         oG11O89ELLbDYAXk2YH15VlTh2A6oKRMyij2PE3n/+mXHnPhmOFR+YYHLdDN/0txG+ug
         Ne7g==
X-Forwarded-Encrypted: i=1; AHgh+Ro/R1EDLMrKcSql4+WPfIrTED9EpTnGFyZFTxATzRQfLJAvCAIdokM4bHgYwMsth0XxRCRgxGFZ5w==@vger.kernel.org
X-Gm-Message-State: AFuF++kGWAUXegg23TZUpi8/t+vJ++f0nf+6kKYKzShGByv4wuDM2bv5
	YixDaJMMwNMiMgZ1ctiMu07IulgHUhPSz4/GIniOUvUsofnBdVrQ8eoJEWoYKorQFrGHv/PHkb7
	7wfODeqcb4hYDHmWcDEjpyHlGhKn7CBoUHpHk4yAI
X-Gm-Gg: AR+sD10FACrdswD6nAm/nCdvccJi3I59I8XHE2R/rNCGxwgF4XO+jQJIhRT2Lybixx1
	u4jbhu2nyAohXMkqso3XQGK/PpTXiMfakplsszHujLLBYBJxW7BiY2woYIRTucCsaEuWkwLvkQ2
	I2X6XzOWA2z4Ez7U6wyfkKCG7/0kmBCCAPxb8gweFOfUXoAq74t7BehgSMyx9ZVTU3b9X70janE
	7as6fROiXGfCnt6loonl74ue5HicSDAyQFoOstFbJTaZiMMOKbF8XItFlNwH7b5w9ZcBJT8Fgxm
	7t9fvL2tBOITUfhU+HlNNUqXMAArfyFgu3Y5lJT9iZFf
X-Received: by 2002:a17:90b:4aca:b0:390:84db:888e with SMTP id
 98e67ed59e1d1-395c50b3dd6mr21407866a91.7.1787584731573; Mon, 24 Aug 2026
 08:18:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821214111.1120748-1-daniel@iogearbox.net>
In-Reply-To: <20260821214111.1120748-1-daniel@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 24 Aug 2026 11:18:39 -0400
X-Gm-Features: AcwNN1WWEwc8Nxt5gv5xsgwSa3ey-6k014cKfPpsLJfAMhEvNSlS6jEnRNiPYeM
Message-ID: <CAHC9VhQb9-zR-W5acwACe=bH0VvmwPEAyGvsJNG5VyVxEVhtJg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/11] BPF keyring and signed loader ML-DSA support
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org, 
	memxor@gmail.com, brauner@kernel.org, kpsingh@kernel.org, ast@kernel.org, 
	john.fastabend@gmail.com, a.s.protopopov@gmail.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 5:41=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
>
> Add a dedicated BPF keyring which is integrated for BPF signing. It
> is modelled after the dm-verity keyring which was added in commit
> 033724b ("dm-verity: add dm-verity keyring") and which can eventually
> be used also via systemd through the same enrollment method as in
> dm-verity's case. It is selected with a new well-known keyring_id
> VERIFY_USE_BPF_KEYRING and gives an operator a place to enroll a
> BPF-only signing key at boot, specifically scoped to signed BPF
> program loading. Next, to demonstrate that BPF signing is algorithm
> agnostic, we add a few small tooling changes to support ML-DSA and
> integrate everything into BPF selftest for BPF CI to ensure nothing
> breaks with future changes. For more details, see individual commits.
>
> Daniel Borkmann (11):
>   bpf: Add a bpf keyring for program signature validation
>   bpf: Refuse caller-supplied keyrings when the bpf one is active
>   bpf: Raise the bound on a program's signature size
>   bpftool: Support ML-DSA program signing
>   selftests/bpf: Add a test for the sealed bpf keyring
>   selftests/bpf: Rebuild signed lskels when signing key changes
>   selftests/bpf: Rename the verify_sig_setup.sh setup into setup-rsa
>   selftests/bpf: Add an end-to-end ML-DSA signed loader test
>   selftests/bpf: Allow appending to guest kernel cmdline in vmtest.sh
>   selftests/bpf: Add tests for bpf keyring in signed loader
>   Documentation/bpf: Document the bpf keyring and improve examples
>
>  .../admin-guide/kernel-parameters.txt         |  15 +
>  Documentation/bpf/signing.rst                 | 274 +++++++--
>  include/linux/bpf.h                           |  13 +
>  include/linux/verification.h                  |  10 +
>  kernel/bpf/Makefile                           |   3 +
>  kernel/bpf/keys.c                             |  72 +++
>  kernel/bpf/verifier.c                         |  42 +-
>  tools/bpf/bpftool/main.h                      |   2 +-
>  tools/bpf/bpftool/sign.c                      |  22 +-
>  tools/testing/selftests/bpf/Makefile          |   2 +-
>  tools/testing/selftests/bpf/config            |   1 +
>  .../selftests/bpf/prog_tests/signed_loader.c  | 518 +++++++++++++++++-
>  .../bpf/prog_tests/verify_pkcs7_sig.c         |   4 +-
>  .../testing/selftests/bpf/verify_sig_setup.sh |  63 ++-
>  tools/testing/selftests/bpf/vmtest.sh         |  16 +-
>  15 files changed, 974 insertions(+), 83 deletions(-)
>  create mode 100644 kernel/bpf/keys.c

CC'ing the keyring folks for obvious reasons.  A lore link to the full
thread can be found below:

https://lore.kernel.org/all/20260821214111.1120748-1-daniel@iogearbox.net

--=20
paul-moore.com
