Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AE318027;
	Fri, 19 Jun 2026 00:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830157; cv=none; b=uZdImt2kejslrwT+qGaCPnGYBBh6MxmsH5wCr2mxzxV9JoUF+D9R9vvw+Cek0a9CePRANH6vMBh5Xxe7U8/JEGSmKHTP5RB+8TlTN57GmpsRrF3vmaeN1jd3zk0vj9beczNTPgZb/amuCx4zlaz8KNVeCRcu6W5dmFsLu3cRMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830157; c=relaxed/simple;
	bh=JyAomStINDVfyMVVCAPe1b5C3KBfpX8vov0s5syAmmM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bUx99xKCBwH1ablp/UbbwEVqc8BsLDM/SAQ9TavYFxitxiyLcFX1e8H69gXhOAi2SQhCwl2i8cnnzml/jklZBS8zv2HXGNByLoMxjXOlKxXRsv4jRfqRhHIjNoE9vfZ1xWM/YSlde3zSVKrRO4dk2fzmFknNU9/Z5La8trBm3XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5Rl7f5p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5Rl7f5p"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 21F381F00A3A;
	Fri, 19 Jun 2026 00:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830155;
	bh=jWI0bVhPLot8f8yvSpHryEKdcf3Ewcb9aMv6CE4i7ZA=;
	h=Date:From:To:Cc:Subject;
	b=D5Rl7f5pqiIn2CA8LV5zEca1+xUy0/LAuK2wnN5SDF/wQAxiKiGRz65r1s1lsG5qf
	 raZQrcil5d9JIlFdnJmGsb9n4CmX6UusZmMKQVpLW7czewaRP/Gg1RO5Le62I2OKQd
	 3yDl7ie5PcxZrDrm9GuYZAQzkYbVZphlIcbYlmspfPm7SeBK3PGJ2RrOyRQ/3A94b/
	 5KZDUrAcvHVj6w8Z+YWVh5v+vxbo59g/1hs4IQnrEb+XUltgkG/cdcv85DhAhWenUu
	 m0axSEPWSsFUO3PVhN/irUpmvwjmFKiJu3LlteayP7sHRps0zgEeiD2OQgBGSTu987
	 uKJ1/H0n6/ygQ==
Date: Fri, 19 Jun 2026 03:49:12 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: for-next-keys-7.2-rc1
Message-ID: <ajSSCDRWgINwlDT1@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

OOPS please ignore I'll resend this!

Wrong template apologies.

BR, Jarkko

On Fri, Jun 19, 2026 at 12:47:08AM +0000, jarkko@kernel.org wrote:
> The following changes since commit 0e0611827f3349d0a2ac121c023a6d3260dcecdb:
> 
>   Merge tag 'pull-fixes' of gitolite.kernel.org:pub/scm/linux/kernel/git/viro/vfs (2026-06-15 15:53:57 +0530)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-keys-7.2-rc1
> 
> for you to fetch changes up to 1b9524250996b1f2f49833a1b2ae21c34e486f85:
> 
>   keys: keyctl_pkey: replace BUG with return -EOPNOTSUPP (2026-06-15 15:19:13 +0300)
> 
> ----------------------------------------------------------------
> Hi
> 
> Please, pull. This pull request contains only fixes.
> 
> BR, Jarkko
> 
> ----------------------------------------------------------------
> David Laight (1):
>       keys: Replace strcpy(derived_buf, "AUTH_KEY") with strscpy(..., HASH_SIZE)
> 
> Eric Biggers (1):
>       KEYS: encrypted: Remove unnecessary selection of CRYPTO_RNG
> 
> Gui-Dong Han (1):
>       KEYS: Use acquire when reading state in keyring search
> 
> Jarkko Sakkinen (2):
>       KEYS: fix overflow in keyctl_pkey_params_get_2()
>       KEYS: trusted: Debugging as a feature
> 
> Len Bao (1):
>       keys/trusted_keys: mark 'migratable' as __ro_after_init
> 
> Mohammed EL Kadiri (3):
>       keys: prevent slab cache merging for key_jar
>       keys: request_key: replace BUG with return -EINVAL
>       keys: keyctl_pkey: replace BUG with return -EOPNOTSUPP
> 
> Shaomin Chen (1):
>       keys: Pin request_key_auth payload in instantiate paths
> 
> Thorsten Blum (1):
>       keys: use kmalloc_flex in user_preparse
> 
>  Documentation/admin-guide/kernel-parameters.txt | 16 +++++++++
>  include/keys/request_key_auth-type.h            |  2 ++
>  include/keys/trusted-type.h                     | 21 +++++++-----
>  security/keys/Kconfig                           |  1 -
>  security/keys/encrypted-keys/encrypted.c        |  4 +--
>  security/keys/internal.h                        |  2 ++
>  security/keys/key.c                             |  2 +-
>  security/keys/keyctl.c                          | 24 ++++++++++----
>  security/keys/keyctl_pkey.c                     | 14 ++++++--
>  security/keys/keyring.c                         |  2 +-
>  security/keys/request_key.c                     |  2 +-
>  security/keys/request_key_auth.c                | 33 +++++++++++++++++--
>  security/keys/trusted-keys/Kconfig              | 23 +++++++++++++
>  security/keys/trusted-keys/trusted_caam.c       |  7 ++--
>  security/keys/trusted-keys/trusted_core.c       |  8 ++++-
>  security/keys/trusted-keys/trusted_tpm1.c       | 44 ++++++++++++++-----------
>  security/keys/user_defined.c                    |  2 +-
>  17 files changed, 158 insertions(+), 49 deletions(-)
