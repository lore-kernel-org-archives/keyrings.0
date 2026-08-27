Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085763CA486;
	Thu, 27 Aug 2026 21:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787864513; cv=none; b=A6/XZ8OpZH/AlFDUEDHKnrDFvikKwatie54ekBiwOTF09W8mEOc18Tk4gOya9NRfoeqC9VQ03psjj9vXEFvs/yW+a0nxIEsRgAn6cq6JeP0tOsYHLV6D1/1xsAO/JNUS1y6uc0MSVOQk6dD9A82ohxOXXZN6KyTmxzeX5AyVaBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787864513; c=relaxed/simple;
	bh=z7g2QR/6D7EsZU71dJHbAnqAlfmfQGRRSVBKM3W0Zho=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SNfa4nYNKTepOsfsEzDNGn+0syPXx9iUMk+hsajnvbytn2v96hpd8ZX3JSMOB0ZwPY+KC8O4LGf0QrUR85xV/mlaAy5mIESJb4UY9Fv6Kn9m06LsquQ9RWwhM3SsIVbwQl9oWiagUsqJv0xrgK+Pg391UDda2j0G1KuxoY5gdS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnGTbrfD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnGTbrfD"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 048FC1F000E9;
	Thu, 27 Aug 2026 21:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787864511;
	bh=wk8NtGvLNqSJDyy9AbjGsCvf7C2Ow3jcgzXTkEjtS2A=;
	h=Date:From:To:Cc:Subject;
	b=MnGTbrfD/rAlVfeCdf9DaMBRUbgll9qUblqEqHr0KP0A9Z+KYWjKg+hNetSy7qAbo
	 yBe4qrTcCAjbI6zeH6q8O4zQEqAY2TE9d95C80tRhOTRILbeQVZlTauevNPdKqL2fp
	 A5peZdBalZl0XZxQUqpewHAmr2MRdo56hdR3jpvWYQIjUoejNYN3XhTeEoJs8B67um
	 n0VO5scXUo0atl5A5sW+/p4f4MHt7mmJ12BWKS2Reb55Pcs7fMl5Dl/QwBvU2Tr0LC
	 IHgmD8HoplA1A9JkiUvfUwF78pA45MndevFk/JXjA27VwXYEzWrVAhZwiBjZQWGh3f
	 b/Qx9ENTe8UVQ==
Date: Fri, 28 Aug 2026 00:01:47 +0300
From: jarkko@kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	trenchboot-devel@googlegroups.com,
	Ross Philipson <ross.philipson@gmail.com>, x86@kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER: for-next-tpm-7.3
Message-ID: <apCluywYWo97vyYr@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 66498c75b4f8017f62d720d9b59675bdf3abce91:

  Merge tag 'dmaengine-7.3-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine (2026-08-24 12:21:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-tpm-7.3

for you to fetch changes up to 55ba91d4c54ab31ee8387bae40e799de467f8269:

  tpm-buf: Add TPM buffer support header for standalone reuse (2026-08-25 18:13:37 +0300)

----------------------------------------------------------------
Hi,

I had to think a lot how to put this into few paragraphs.  I hope this will
makes sense to you and I'm not too confusing.

The bulk of this pull request are Ross Philipson's TPM enablers for the
Trenchboot patch series.  The commits expose TPM constants, and decouple
and improve robustness of tpm_buf a bit in order to implement a minimal
early TPM driver.

Early boot code will call either SKINIT on AMD or GETSEC[SENTER] on Intel
before jumping into kernel's entry point.  They re-initalize TPM PCRs but
leave up to the early boot code measure initrd, boot_params and Trenchboot
associated metadata.

The motivation here is just that we would want in future iterations of the
series put our full focus to the x86 part of the review, and call it a day
as per TPM changes.  Further, even if Trenchboot turned out to be empty
lottery the worst possible outcome for TPM driver is that things get
cleaned up a bit.

BR, Jarkko

----------------------------------------------------------------
Alec Brown (1):
      tpm: Remove main TPM header from TPM event log header

Jarkko Sakkinen (3):
      tpm-buf: Merge TPM_BUF_BOUNDARY_ERROR and TPM_BUF_OVERFLOW
      tpm-buf: Remove chip parameter from tpm_buf_append_handle()
      tpm-buf: Memory-safe allocations

Karl Mehltretter (1):
      tpm: atmel: depend on X86

Li Jun (1):
      tpm: tpm_tis_spi: fix nodef CR50 tpm_tis_spi_resume is null

Myeonghun Pak (1):
      tpm: tpm_i2c_nuvoton: disable IRQ on wait timeout

Pan Chuang (1):
      tpm: Remove redundant dev_err()

Ross Philipson (6):
      tpm: Initial step to reorganize TPM public headers
      tpm: Move TPM1 specific definitions to the command header
      tpm: Move TPM2 specific definitions to the command header
      tpm: Move TPM common base definitions to the command header
      tpm: Move platform specific definitions to the new PTP header
      tpm-buf: Add TPM buffer support header for standalone reuse

Ruoyu Wang (2):
      tpm: st33zp24: Return zero on status read failure
      tpm: st33zp24: Validate locality read result

 drivers/char/tpm/Kconfig                  |   3 +-
 drivers/char/tpm/st33zp24/st33zp24.c      |  13 +-
 drivers/char/tpm/tpm-buf.c                | 145 +++++----
 drivers/char/tpm/tpm-sysfs.c              |  26 +-
 drivers/char/tpm/tpm.h                    | 180 -----------
 drivers/char/tpm/tpm1-cmd.c               | 180 +++++------
 drivers/char/tpm/tpm2-cmd.c               | 321 ++++++++----------
 drivers/char/tpm/tpm2-sessions.c          | 164 +++++-----
 drivers/char/tpm/tpm2-space.c             |  57 ++--
 drivers/char/tpm/tpm_i2c_nuvoton.c        |   8 +-
 drivers/char/tpm/tpm_tis_core.h           |  64 +---
 drivers/char/tpm/tpm_tis_i2c_cr50.c       |   4 +-
 drivers/char/tpm/tpm_tis_spi.h            |   8 +-
 drivers/char/tpm/tpm_vtpm_proxy.c         |  30 +-
 include/keys/trusted_tpm.h                |   1 -
 include/linux/tpm.h                       | 230 +------------
 include/linux/tpm_buf.h                   |  60 ++++
 include/linux/tpm_command.h               | 518 +++++++++++++++++++++++++++++-
 include/linux/tpm_eventlog.h              |   2 +-
 include/linux/tpm_ptp.h                   | 133 ++++++++
 security/keys/trusted-keys/trusted_tpm1.c |  45 ++-
 security/keys/trusted-keys/trusted_tpm2.c | 166 +++++-----
 22 files changed, 1255 insertions(+), 1103 deletions(-)
 create mode 100644 include/linux/tpm_buf.h
 create mode 100644 include/linux/tpm_ptp.h
