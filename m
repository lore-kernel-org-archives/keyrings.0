Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777776;
	b=cocSV9vBc+pGanioWfEMuv/FRcZPDR4kLRqFbMUDAgg0VKDTDWqoqPqR/5ohIDpQAPfR
	 a1x4l1c36PfoJB7ELO0MIlI+xQXr7u4//wi38OUiOnO/8FrM9O6ftsaLGaM9u7xg7uKhn
	 qu5AkTWdMRUiEVNBhvejXhdkdLJq6wL54Gej37TIQbzdWnea1jGJwUjpGpLFSy/l5qZdQ
	 sPff+IVMgNN5QhfgKxvmqBBBP6iXxHKHUIIz4yL/69NACaSXYHS8PrlVLD5B51ozILQBX
	 IUWOmAeyBzbDgBasFcqLVFKsSmqMRhwqlmzHoONmn7+0pRLzqBHqnaVbOojIMfhl4uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777776;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=33tWk6OCF2KeTpoJqlGGB7ThoHd5/cgrTclvZjwIIdU=;
	b=ZgYjrpixQ3JGAe6ccVHwUV1w8ZfnPUaiy/Y2CmTREdhxxmOLnrNa0gLUu4l98zkTPsv6
	 vsBfBBqTdM70+Jg74DisVKjPV+FL9AL1UzXkdocznwhhI4ZZ/JZ7Oq2jEvWTOXv5Yx/ta
	 0U6gDIIDaHYqekEyAXjB31Q4LZXSuIk0Rg8J/Xh4Wgye5fMHt/2OX2yYmoTIDAfXANH8e
	 OPHlKvOvZrw0FTBCp/GIvFCzKC0yGmfuPGtwdyTv74zbry5AMAdMkTDO6lymFdCGQPCtB
	 Q0jq5ncwwTDeCRpGd2IVcewFtcJbws47dyq1l1Bg5oDPYnIq5JgZpjuBJWQqQ7kEffA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YIQuMMxK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 68461606A31B;
	Fri, 23 Oct 2026 17:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YIQuMMxK
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6D9541F01825;
	Fri, 23 Oct 2026 17:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792777776;
	bh=33tWk6OCF2KeTpoJqlGGB7ThoHd5/cgrTclvZjwIIdU=;
	h=Date:From:To:Cc:Subject;
	b=YIQuMMxKCB9t8Y8MYu7N+SuJ+J1La+t+z1hpD5c0tRz1C/d2cQPAJYiM2MozadDok
	 DXck5DFXbDr/DQxAG8TqoBehJw6tiF7L8a8siG6Y/EJBSDjjrHi+YshXn7AcLfTA+f
	 YLSp8fGL1veYw4QdRN/HZ+Nx7IUB0pMrBmEn3/7lY6xOlnhU3xAbxM6rJK2QPmAjgM
	 AXsbd2X+eIILNxpCnrNvtjWYEoXD+u10YRJMwAWmhCq6YxsG5SZAgN/6TS6TtaEnXW
	 wjGN1b2OreAOcRKfl8kmaWzpxPTo9BMvGJmDq94qjrefLHgrMzPCT8dkNyfCFTGq+M
	 0+b/oK5O3pESQ==
Date: Fri, 23 Oct 2026 20:49:31 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER changes for v7.4-rc1
Message-ID: <atueK3rp8d95-Uaj@kernel.org>
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

I double-checked that this is now in-sync with linux-next.

I'll address this issue permanently by implementing linux-next
validation to my script that prepares the PR, as that would
have prevented this from happening.

The following changes since commit a1c2b1da93f5f612aa7a33190c4900c98e51f6da:

  Merge tag 'for-linus-tsm' of https://github.com/jgunthorpe/linux (2026-10-22 10:41:18 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpm-v7.4-rc1-rebased

for you to fetch changes up to 071aa806f00cf2948ce8082102d5f64515f53215:

  tpm: reject duplicate PCR banks in tpm2_get_pcr_allocation (2026-10-23 00:59:21 +0300)

----------------------------------------------------------------
[GIT PULL] TPM DEVICE DRIVER changes for v7.4-rc1

I had to revise my pull request because it came out with a stale tag.
Apologies for that. While at it I refined my scripts to not have coherency
issues.

All the content remains the same with no changes but I noticed one entry
missing from the list in the next section, so I added that.

FEATURES AND IMPROVEMENTS
=========================

- tpm_crb behaviour was improved by putting the chip into an idle state for
  each transmission. This improves firmware behavior as the kernel now
  better cancels its state as if it had never touched it in the first
  place.
- One spurious (but harmless) wmb() was dropped from tpm_pm_resume().
- tpm_tis_i2c now requests the optional reset control and deasserts it
  before communicating with the TPM.
- SIMPLE_DEV_PM_OPS was replaced with DEFINE_SIMPLE_DEV_PM_OPS across the
  whole driver stack.
- Validate during driver initialization that no duplicate banks are
  received. It's unlikely corruption but since it happening would
  cause oops I decided to retain it as a sanity check.

BUGS
====

- tpm2_probe() misinterpreted a transport error on TPM2_GetCapability
  as the chip not being probed, and the chip was detected as a TPM 1 chip.
  This can happen in reality only in the extremely rare case of bus
  corruption. Despite the odds, a fix was landed, as it is still
  technically a legit bug fix.
- It is not really worth the time and energy to go into details as tpm_nsc
  is a somewhat legacy driver, but one null pointer dereference bug and
  another causing use-after-free were fixed.
- read() of /dev/tpm{,rm}0 with zero size caused a pending response to be
  consumed. This was fixed simply by an immediate return.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

----------------------------------------------------------------
Alexander Sverdlin (1):
      tpm: tpm2_probe: propagate transport errors

Li Jun (2):
      char: tpm: Use SIMPLE_DEV_PM_OPS for ibmvtpm power management
      tpm: use DEFINE_SIMPLE_DEV_PM_OPS and pm_sleep_ptr()

Mario Limonciello (1):
      tpm: Call cmd_ready/go_idle for each command transmission

Pei Xiao (3):
      tpm: tpm_nsc: fix NULL pointer dereference on init failure
      tpm: tpm_nsc: stop using the cleanup callback as dev.release
      tpm: fix zero-length read discarding the pending response

Richard Lyu (1):
      tpm: Remove ineffective wmb() from tpm_pm_resume()

Stefano Radaelli (1):
      tpm: tis_i2c: Deassert optional reset line before probing

Yuqi Xu (1):
      tpm: reject duplicate PCR banks in tpm2_get_pcr_allocation

 drivers/char/tpm/tpm-chip.c          | 24 ------------------------
 drivers/char/tpm/tpm-dev-common.c    |  3 +++
 drivers/char/tpm/tpm-interface.c     | 28 ++++++++++++++++++++++------
 drivers/char/tpm/tpm2-cmd.c          | 21 ++++++++++++++++++++-
 drivers/char/tpm/tpm_atmel.c         |  4 ++--
 drivers/char/tpm/tpm_i2c_atmel.c     |  4 ++--
 drivers/char/tpm/tpm_i2c_infineon.c  |  4 ++--
 drivers/char/tpm/tpm_i2c_nuvoton.c   |  4 ++--
 drivers/char/tpm/tpm_ibmvtpm.c       |  5 +----
 drivers/char/tpm/tpm_infineon.c      |  7 +++----
 drivers/char/tpm/tpm_nsc.c           | 12 ++++++++----
 drivers/char/tpm/tpm_tis.c           |  4 ++--
 drivers/char/tpm/tpm_tis_core.h      |  2 --
 drivers/char/tpm/tpm_tis_i2c.c       | 16 ++++++++++++++--
 drivers/char/tpm/tpm_tis_i2c_cr50.c  |  4 ++--
 drivers/char/tpm/tpm_tis_spi_main.c  |  4 ++--
 drivers/char/tpm/tpm_tis_synquacer.c |  4 ++--
 17 files changed, 87 insertions(+), 63 deletions(-)
