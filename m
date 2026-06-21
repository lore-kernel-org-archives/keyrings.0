Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A471340D595;
	Sun, 21 Jun 2026 01:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782005034; cv=none; b=YrFcYoXNc1gzAsV6jGBRLi7O3JQuHI12fWIFp2IeebbCPKtVY5E9wDpPwmtu5fru4vt8syBZUm14rvMVv5/2foyLVs06YFAkz3fkDYFA/BhTHHvz4FJra0Oo89pUqWmJJxVPmMgDvoZITaancNDabNv6pgHG6C2PCPUg4pXsNd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782005034; c=relaxed/simple;
	bh=RjR4V0FnbOzKHuVxmkc0X1qrF+6v0IgALUMrcpOeJHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOAu9UxN3Y6ZI63bcDSAoOZWPiGyvxJyl8uz7Bxi4yO6LNlJhO3le6dnYCrkAsdu7s4w5yh9FaUXNJpl8EhZymjROed5oUsPUs2ghOmZIJIVRUAdu38EBLsACavsP6kmo9hqY2RO2QKy+P70ePIDDCxexqgWM4a/q2Me0PUVyzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGqSKorz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGqSKorz"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 996091F000E9;
	Sun, 21 Jun 2026 01:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782005033;
	bh=PikqGyKLwsErDbc1EGIJzx1OfeDbs2tT2lKzEWxMkr0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GGqSKorzx9WRnj7GcACPYJ6aCD65TI7O8WonzD742DSEK+DozFA/qdEN7HU61SUTk
	 fUy+gT4G6bO8RyjQfsDL4yDJpvjoFLQr6szeCOIuLIdla7W9BL3zfXglILo7sSqKrq
	 kP+GAPEcN4Z0z/42XTaCttILwpxHcTv8FnTJSwfxb3Uz2WMw5cP0LFlfJxsUAlnpu7
	 59ZGqcvbEjaNfETXKNcRzYx4dnJ7zL1QSIBdEoHeRS/vYCbsbC8QrKfkbZkUpKQ9+4
	 tQs9eR1kOWPTrZRmzdIG7FTGvurbaY6mGbCmrF+8c21sBZdGlYZAYmJVuHPWdNSNcK
	 Vz0VCd73x4dtA==
Date: Sun, 21 Jun 2026 04:23:49 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: for-next-tpm-7.2-rc1
Message-ID: <ajc9JcxcH8eGqxbX@kernel.org>
References: <ajboiUkyqgZxHpZS@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajboiUkyqgZxHpZS@kernel.org>

Oh crap, sorry.

I'll resend with new tag for-next-tpm-7.2-rc1-2.

Discard.

BR, Jarkko

On Sat, Jun 20, 2026 at 10:22:49PM +0300, Jarkko Sakkinen wrote:
> The following changes since commit 0e0611827f3349d0a2ac121c023a6d3260dcecdb:
> 
>   Merge tag 'pull-fixes' of gitolite.kernel.org:pub/scm/linux/kernel/git/viro/vfs (2026-06-15 15:53:57 +0530)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-tpm-7.2-rc1
> 
> for you to fetch changes up to 67c53887ebcd425f0003e7068de12eab511f80a9:
> 
>   tpm: fix event_size output in tpm1_binary_bios_measurements_show (2026-06-15 15:19:45 +0300)
> 
> ----------------------------------------------------------------
> Hi,
> 
> Please, pull. This pull request contains only bug fixes.
> 
> BR, Jarkko
> 
> ----------------------------------------------------------------
> Baoli Zhang (1):
>       tpm: restore timeout for key creation commands
> 
> David Laight (1):
>       keys: Replace strcpy(derived_buf, "AUTH_KEY") with strscpy(..., HASH_SIZE)
> 
> David Windsor (1):
>       tpm: svsm: constify tpm_chip_ops
> 
> Eric Biggers (1):
>       KEYS: encrypted: Remove unnecessary selection of CRYPTO_RNG
> 
> Gui-Dong Han (1):
>       KEYS: Use acquire when reading state in keyring search
> 
> Gunnar Kudrjavets (1):
>       tpm: Initialize name_size_alg for non-NULL name in tpm_buf_append_name()
> 
> Jarkko Sakkinen (3):
>       KEYS: fix overflow in keyctl_pkey_params_get_2()
>       KEYS: trusted: Debugging as a feature
>       tpm: tpm_tis_spi: Use wait_woken() in wait_for_tmp_stat()
> 
> Jim Broadus (2):
>       tpm: tpm_tis: store entire did_vid
>       tpm: tpm_tis: Add settle time for some TPMs
> 
> Len Bao (1):
>       keys/trusted_keys: mark 'migratable' as __ro_after_init
> 
> Michael Bommarito (1):
>       tpm: tpm2-sessions: wait for async KPP completion in tpm_buf_append_salt
> 
> Mohammed EL Kadiri (3):
>       keys: prevent slab cache merging for key_jar
>       keys: request_key: replace BUG with return -EINVAL
>       keys: keyctl_pkey: replace BUG with return -EOPNOTSUPP
> 
> Rafael J. Wysocki (1):
>       tpm_crb: Check ACPI_COMPANION() against NULL during probe
> 
> Shaomin Chen (1):
>       keys: Pin request_key_auth payload in instantiate paths
> 
> Thorsten Blum (2):
>       keys: use kmalloc_flex in user_preparse
>       tpm: fix event_size output in tpm1_binary_bios_measurements_show
> 
> Yeoreum Yun (1):
>       tpm: tpm_crb_ffa: revert defered_probed when tpm_crb_ffa is built-in
> 
>  Documentation/admin-guide/kernel-parameters.txt | 16 +++++++
>  drivers/char/tpm/eventlog/tpm1.c                |  4 +-
>  drivers/char/tpm/tpm2-cmd.c                     |  6 +--
>  drivers/char/tpm/tpm2-sessions.c                | 56 ++++++++++++++++------
>  drivers/char/tpm/tpm_crb.c                      |  6 ++-
>  drivers/char/tpm/tpm_crb_ffa.c                  | 18 ++-----
>  drivers/char/tpm/tpm_svsm.c                     |  2 +-
>  drivers/char/tpm/tpm_tis_core.c                 | 63 ++++++++++++++++---------
>  drivers/char/tpm/tpm_tis_core.h                 |  3 +-
>  include/keys/request_key_auth-type.h            |  2 +
>  include/keys/trusted-type.h                     | 21 +++++----
>  security/keys/Kconfig                           |  1 -
>  security/keys/encrypted-keys/encrypted.c        |  4 +-
>  security/keys/internal.h                        |  2 +
>  security/keys/key.c                             |  2 +-
>  security/keys/keyctl.c                          | 24 +++++++---
>  security/keys/keyctl_pkey.c                     | 14 ++++--
>  security/keys/keyring.c                         |  2 +-
>  security/keys/request_key.c                     |  2 +-
>  security/keys/request_key_auth.c                | 33 ++++++++++++-
>  security/keys/trusted-keys/Kconfig              | 23 +++++++++
>  security/keys/trusted-keys/trusted_caam.c       |  7 ++-
>  security/keys/trusted-keys/trusted_core.c       |  8 +++-
>  security/keys/trusted-keys/trusted_tpm1.c       | 44 +++++++++--------
>  security/keys/user_defined.c                    |  2 +-
>  25 files changed, 256 insertions(+), 109 deletions(-)

