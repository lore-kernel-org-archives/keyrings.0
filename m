Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53D321C173;
	Fri, 28 Aug 2026 01:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787881141; cv=none; b=FjE7TNuIX4i/ZA94A5/PWgfmX2SFQ7XQPHGofyJ76UnO/fgOwRR5ECQMAqwzsOLn+VxC327nbfTrWsvARcyJ4nLctt5R+hyqEJV67RZcxgYYN4WMNbplnElleBtat89xAmOXggfDS/ZIoycvHnk6FrdJ4rQ5Qzkj4LJsd+2zff4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787881141; c=relaxed/simple;
	bh=FsUxGIx6rhOio1Ml3/iSyvWPxqD1x/cB0gE+EMoBEkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X9jTOKj2fyHcNMU7eInjbjw0BA5saeUu82v9B4Efpwhzhd0RkS79oHzHAxW1LHNpjuf6wIan8a+rR1EuTj9S/8Y5U8Fs+qW8nD65pgZa9khw2PwTyN2K0WxlfZZlegJlKFNL+AEaqZEc5iWrOf8OZh8qxcvuWUss0KEC4aOOCJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j2natF7h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j2natF7h"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id AE6331F000E9;
	Fri, 28 Aug 2026 01:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787881139;
	bh=XYz3JLl4NNQqHv+orqcXrbJk0zL9In/+Nv7/8cOKk4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=j2natF7hluXDyv75RT37lZcFk2uDzz0YZmEzPyX9WqCpNc5rVwVdXiHvlF/NgAjZZ
	 rb0pNl4H9do5Jl8f+inrf4zxYNkEeX8dOyw6nao2ushDGGM0lnEmAjtoYTCEZh8QVP
	 A4FR/7PBX08uZy6sBUdgmAxGfqQXSBYTAoDnO3RjKlN7aH+bxEc6Q9+vqqAUn1W0fP
	 6/+1H2I5vIXIDb6HjAz0O3ECiRz8rra91XnoWuJ8HahqQtM/jJdvLhsYBC9th0SN9U
	 MRfTVAHaH8OKeTyuhMNUWtAeNusZ1OczWrJgcY/urRxd1AeGchLCu+ypLlEpoiIOdb
	 jY3er14GkCZRg==
Date: Fri, 28 Aug 2026 04:38:55 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, brauner@kernel.org, kpsingh@kernel.org,
	ast@kernel.org, john.fastabend@gmail.com, a.s.protopopov@gmail.com,
	bpf@vger.kernel.org, dhowells@redhat.com, keyrings@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 00/11] BPF keyring and signed loader ML-DSA
 support
Message-ID: <apDmr_33q2zz6YCd@kernel.org>
References: <20260825142530.1329706-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825142530.1329706-1-daniel@iogearbox.net>

On Tue, Aug 25, 2026 at 04:25:19PM +0200, Daniel Borkmann wrote:
> Add a dedicated BPF keyring which is integrated for BPF signing. It
> is modelled after the dm-verity keyring which was added in commit
> 033724b ("dm-verity: add dm-verity keyring") and which can eventually
> be used also via systemd through the same enrollment method as in
> dm-verity's case. It is selected with a new well-known keyring_id

I'm not interested where the code is derived; only what it *is*.

dm-verity would be better fit for e.g., corresponding patch.


> VERIFY_USE_BPF_KEYRING and gives an operator a place to enroll a
> BPF-only signing key at boot, specifically scoped to signed BPF
> program loading. Next, to demonstrate that BPF signing is algorithm
> agnostic, we add a few small tooling changes to support ML-DSA and
> integrate everything into BPF selftest for BPF CI to ensure nothing
> breaks with future changes. For more details, see individual commits.

Why do we want this? Motivation to add anything is missing.

> 
> v1 -> v2:
>   - Mainly addressing LLM feedback in docs, commit message and
>     selftests (BPF CI, sashiko)
>     - Fix reasoning on BPF_PROG_MAX_SIGNATURE_SIZE
>     - Add reasoning about bpftool MAX_SIG_SIZE change and pinning
>       the CMS digest to SHA-512
>     - Fix misc signing.rst phrasing
>     - Fix a potential NULL deref in bpf_keyring_lookup selftest code
>     - Add CONFIG_CRYPTO_SHA512=y to BPF selftest config
>     - Clean up key material on ML-DSA signed loader test failure
>     - Refactor duplicated bpf_attr setup for bpf keyring tests
>     - Fix wording in kernel-parameters.txt
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
>  .../admin-guide/kernel-parameters.txt         |  16 +
>  Documentation/bpf/signing.rst                 | 279 +++++++++--
>  include/linux/bpf.h                           |  13 +
>  include/linux/verification.h                  |  10 +
>  kernel/bpf/Makefile                           |   3 +
>  kernel/bpf/keys.c                             |  72 +++
>  kernel/bpf/verifier.c                         |  43 +-
>  tools/bpf/bpftool/main.h                      |   2 +-
>  tools/bpf/bpftool/sign.c                      |  22 +-
>  tools/testing/selftests/bpf/Makefile          |   2 +-
>  tools/testing/selftests/bpf/config            |   2 +
>  .../selftests/bpf/prog_tests/signed_loader.c  | 472 ++++++++++++++++--
>  .../bpf/prog_tests/verify_pkcs7_sig.c         |   4 +-
>  .../testing/selftests/bpf/verify_sig_setup.sh |  63 ++-
>  tools/testing/selftests/bpf/vmtest.sh         |  16 +-
>  15 files changed, 915 insertions(+), 104 deletions(-)
>  create mode 100644 kernel/bpf/keys.c
> 
> -- 
> 2.43.0
> 

BR, Jarkko

