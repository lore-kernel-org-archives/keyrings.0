Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768263;
	b=uLr9YZrNx/UCSCpp3OR0dInST+KeRo9aj7rmoBbFRAxh7FFA5XJ2ApUkhERsP3z8HIiI
	 y1ZIsxoTiAoV6u+A9r4JAsOm4c1+THOspGpmXGV94BSXoESaYqmLZXYRXJ78dK+J3uc8+
	 4AtjResqhlEaXFWCfgiJmupVtAvy1PULVL76Z0I5rQOWFGFB4nSW6Qsjc7TeTmvVx2+bU
	 onCmXvqIG3A3eslbKrrsiAHO2f3XpM0wFfrHqScCQ1PK+2GNlaAx6BG/GkZUXfI0ri8tb
	 xPzPl6J5mmCFbWruP1yRXd2aSkHAW5L9WN1+S18ONzwM2USzwPapfjQcFchIy/tAwlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768263;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=3+WQ0vFe8PFoEegizIZvWZvxVwr2mmrxpKdHrPmQ0og=;
	b=kYJ7+RPNYXhYzgDgLi/Yyd/FObLqU9RIgFliziVj/soun+9lZkNYIXgyr+FKjzJm9HWS
	 kChJbCplJ0neg/k0+tmmpbm2Kn4VrJ+Znk94Rs8rFkbq9SiAGLeEOesfUNOac57FLsMO+
	 9QBLS7ndEypR1q1/AICO06qczwd3Y/pho900X+E+HyLq/RFilGKT7oHVmZlldJhQsqi70
	 wwozMjp3dnFbCvRYYMLaLj70vX84LWWfOAG1Fdu42RYZtlrQXhKFJmkcI/hVmsg7gwtv9
	 UbvgjgHfKDX2W0L+LAO4nl3YWy3JjvBxg26BzZavRMSN08qL9aAMLqIym2VO2xc/05Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AEQd98zo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E23D8606A333;
	Fri, 23 Oct 2026 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AEQd98zo
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B7A721F01825;
	Fri, 23 Oct 2026 15:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792768262;
	bh=3+WQ0vFe8PFoEegizIZvWZvxVwr2mmrxpKdHrPmQ0og=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AEQd98zoq1m/mLrXeZRCTofT0TTNsunxr/HwGMk6bxiVuCr4NJqwe2ptxdO4hhzG4
	 nxSlpnmHeTnzg67jZFoc3+zq4InZXAY+ILn+Gc9IXski0IWTpAO4qOVjq812MQgShv
	 6FwevuLaY248GcgWKSoMs/3eSvk1eVuMyei4Yp7B3SrJR+NlAXFKXD+oKarY2fMPem
	 FaXWCT09PaE4Wa38D+RXC4Td5mCv7jxCOz/sKBXR5A1oue1iMfmY11kRo2/0foDaG4
	 h7z11ZpiBDNtzpQDYK4MdQzl5xFgYZEGtwTMWvfLwnUeyZo9X6iQUFUDuti+q/e5Fq
	 kHMrSZ1icwS+A==
Date: Fri, 23 Oct 2026 18:10:57 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] TPM DEVICE DRIVER changes for v7.4-rc1
Message-ID: <att5AavVNVhfD5qd@kernel.org>
References: <att3oe9CYJjuykq0@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <att3oe9CYJjuykq0@kernel.org>

On Fri, Oct 23, 2026 at 06:05:05PM +0300, Jarkko Sakkinen wrote:
> The following changes since commit 722658cac48a6ba49f5506fd74d010ad9dbb2f05:
> 
>   keys/trusted_keys: reuse TPM version in option handling (2026-10-20 18:15:40 +0300)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpm-v7.4-rc1
> 
> for you to fetch changes up to 836952696d0260cca1de6d3300cd8fcd5687fe67:
> 
>   tpm: reject duplicate PCR banks in tpm2_get_pcr_allocation (2026-10-21 13:20:58 +0300)
> 
> ----------------------------------------------------------------
> tpm: changes for v7.4-rc1
> 
> FEATURES AND IMPROVEMENTS
> =========================
> 
> - tpm_crb behaviour was improved by putting the chip into an idle state for
>   each transmission. This improves firmware behavior as the kernel now
>   better cancels its state as if it had never touched it in the first
>   place.
> - One spurious (but harmless) wmb() was dropped from tpm_pm_resume().
> - tpm_tis_i2c now requests the optional reset control and deasserts it
>   before communicating with the TPM.
> - SIMPLE_DEV_PM_OPS was replaced with DEFINE_SIMPLE_DEV_PM_OPS across the
>   whole driver stack.
> 
> BUGS
> ====
> 
> - tpm2_probe() misinterpreted a transport error on TPM2_GetCapability
>   as the chip not being probed, and the chip was detected as a TPM 1 chip.
>   This can happen in reality only in the extremely rare case of bus
>   corruption. Despite the odds, a fix was landed, as it is still
>   technically a legit bug fix.
> - It is not really worth the time and energy to go into details as tpm_nsc
>   is a somewhat legacy driver, but one null pointer dereference bug and
>   another causing use-after-free were fixed.
> - read() of /dev/tpm{,rm}0 with zero size caused a pending response to be
>   consumed. This was fixed simply by an immediate return.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> ----------------------------------------------------------------
> Alexander Sverdlin (1):
>       tpm: tpm2_probe: propagate transport errors
> 
> Li Jun (2):
>       char: tpm: Use SIMPLE_DEV_PM_OPS for ibmvtpm power management
>       tpm: use DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr()
> 
> Mario Limonciello (1):
>       tpm: Call cmd_ready/go_idle for each command transmission
> 
> Pei Xiao (3):
>       tpm: tpm_nsc: fix NULL pointer dereference on init failure
>       tpm: tpm_nsc: stop using the cleanup callback as dev.release
>       tpm: fix zero-length read discarding the pending response
> 
> Richard Lyu (1):
>       tpm: Remove ineffective wmb() from tpm_pm_resume()
> 
> Stefano Radaelli (1):
>       tpm: tis_i2c: Deassert optional reset line before probing
> 
> Yuqi Xu (1):
>       tpm: reject duplicate PCR banks in tpm2_get_pcr_allocation
> 
>  drivers/char/tpm/tpm-chip.c          | 24 ------------------------
>  drivers/char/tpm/tpm-dev-common.c    |  3 +++
>  drivers/char/tpm/tpm-interface.c     | 28 ++++++++++++++++++++++------
>  drivers/char/tpm/tpm2-cmd.c          | 21 ++++++++++++++++++++-
>  drivers/char/tpm/tpm_atmel.c         |  4 ++--
>  drivers/char/tpm/tpm_i2c_atmel.c     |  4 ++--
>  drivers/char/tpm/tpm_i2c_infineon.c  |  4 ++--
>  drivers/char/tpm/tpm_i2c_nuvoton.c   |  4 ++--
>  drivers/char/tpm/tpm_ibmvtpm.c       |  5 +----
>  drivers/char/tpm/tpm_infineon.c      |  7 +++----
>  drivers/char/tpm/tpm_nsc.c           | 12 ++++++++----
>  drivers/char/tpm/tpm_tis.c           |  4 ++--
>  drivers/char/tpm/tpm_tis_core.h      |  2 --
>  drivers/char/tpm/tpm_tis_i2c.c       | 16 ++++++++++++++--
>  drivers/char/tpm/tpm_tis_i2c_cr50.c  |  4 ++--
>  drivers/char/tpm/tpm_tis_spi_main.c  |  4 ++--
>  drivers/char/tpm/tpm_tis_synquacer.c |  4 ++--
>  17 files changed, 87 insertions(+), 63 deletions(-)
> 

My templates are a bit out-of-sync, thus the divergence in subject
lines. I'm working on my pull request scripts, and address this while at
it so that subjects, tags etc. have same stuff in the same format. Just
started distract me when I realized this after looking at what went to
lore so though to mention.

Br, Jarkko
