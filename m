Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792767910;
	b=na96CYN+1os+FdN2gJwi/9u4Cz6sWEOESX8JoTMMq+LDBS0ZR4w9QINCBLKUZP50BRmU
	 EffSEyPmLkpixH7b/OPCqRh5KAOe1qR4mDUkbwHJ/7b0PoGlgEgxyp+FOmUkbB2u36/Vk
	 FyVjzkIB4DfPmPpjfODvTkK9OamO40rPmvYTQ3++zzeD5oLDMtWjh+bqTlDBFDxFodzwr
	 BG1ng7z9jxLdCzTF8OxKrLhfgQ671hTTsJiIllxzS7q0mkLicPbk+1vyORe4+vLxZJ7YZ
	 FXHDtkrXXVGACWXSFp1aTUI8HLpvXy5n70+ai0kx3zJaFYxggZScvBjR3bbK9Yf4WEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792767910;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition;
	bh=ZVcQPkNDOWQoPE4j6sKMTOGILAcsS100wFswAEPnnCE=;
	b=r8fOd2URlv2to3hGrZORCDWratWmeVzevtKgDRJ0vtPDeLiGxo5cuWKQY1CNFvTSwB13
	 H5DJJ609NYR/HrsPKFz4Vry3jrrGn6B9uImSUj9QCCPboI/j1lWMlf9BemtMoe5RMPCB/
	 PVpEHLewndKyqegQdmuLyFzT/guUTo6X+MSDVz26TtD7Fl/y1FUb27/FZEoytAr5iQW99
	 uOvmspI5ZMb6mf9JEkDrGgb/hj6+kMUaRhfKBjSWb7nyJYN1CHz+ox0yh4kRvC9Nk3Km8
	 8XkYMuNmwVi548HgOtzdDavgQDEkoFThsQjROIP8jLJDnyGmmF/eKVtlCgVuRRlCxuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kNbLw9QV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 54E1E606A31F;
	Fri, 23 Oct 2026 15:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kNbLw9QV
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3D28B1F031E4;
	Fri, 23 Oct 2026 15:05:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792767910;
	bh=ZVcQPkNDOWQoPE4j6sKMTOGILAcsS100wFswAEPnnCE=;
	h=Date:From:To:Cc:Subject;
	b=kNbLw9QVGkwIqha06HXuIE1qx3/sPWm3crthpNsEFtXABD1DX6jiGNzyyuojxxI3t
	 RvnosSeYYzfKNJ4JoS+yXRmah8LFp+x3M53TxYBtkYTdltgn9VX2BtG6RFjllDRHRy
	 wEPMhdGS1KCyBu/nFy2Hx2wLEmzzzV5ghQ3fABqGp57HIw2EhKzDo+d8ww939J8Ys5
	 q6De6EZoL89k+cLa6bcoecz0R7PR55yAcLK6g3aA3FE7dDw7yS0dxGTM6kUcKy//E+
	 R+kZcTus7SOt5ZVK91zkwnOGG4hqgsxVFKUp7xicFdZszcTh6sXeMKMGOpTtDb9sGn
	 i4coKAhD94K/Q==
Date: Fri, 23 Oct 2026 18:05:05 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER changes for v7.4-rc1
Message-ID: <att3oe9CYJjuykq0@kernel.org>
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

The following changes since commit 722658cac48a6ba49f5506fd74d010ad9dbb2f05:

  keys/trusted_keys: reuse TPM version in option handling (2026-10-20 18:15:40 +0300)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpm-v7.4-rc1

for you to fetch changes up to 836952696d0260cca1de6d3300cd8fcd5687fe67:

  tpm: reject duplicate PCR banks in tpm2_get_pcr_allocation (2026-10-21 13:20:58 +0300)

----------------------------------------------------------------
tpm: changes for v7.4-rc1

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
