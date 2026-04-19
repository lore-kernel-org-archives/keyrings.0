Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0646118BC3D;
	Sun, 19 Apr 2026 12:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776602332; cv=none; b=eyUuEQ9LVT/xaLj0VtVbjv+0IsGwPkaplynFpxUSbGzcaVTA8yuvf2DZLkA6jvezoOi9REsg+2s699qnH+oG2DlBUUWwnCuYlOoHWrRvHxCWX/edjxzVACVO4Yy8DuokBu8iedYQlSyjRekyVUmywab9n/DYCnkqVSWU9V+74DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776602332; c=relaxed/simple;
	bh=kbbbmBOzimS7USWiqfOjMMfXl0aAStRYXstWAfJc1z4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SnYRsm0z5Y5TmWM8QAE0H+OldQbHsSSVF44tODVWFxbOc3K+SNZ5sv5ohSmDK9z1Y/Z6VnUlFnmX847BzQ88Q8H5rmFXB5kscQfG3cnegQwRI0Z5sVaQ8xlMZ5x5DTanQHdIMmTsGEQvGC/k69ujBt2oJabYjcCH/pLI1KN1a24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQMVuc4q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQMVuc4q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46767C2BCAF;
	Sun, 19 Apr 2026 12:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776602331;
	bh=kbbbmBOzimS7USWiqfOjMMfXl0aAStRYXstWAfJc1z4=;
	h=Date:From:To:Cc:Subject:From;
	b=LQMVuc4q1mHlN1B3EKSwvvAG1iP3PgheAfwzBoQ0D0J6geRE4cTdTb89Yuc5zaXl/
	 Nte6wYs2Mmq+gIpXUAiAqM8OFI5L4DCfB4AcrNu3A9+5smQqSbVqX2qPfLf2RwjY8S
	 cSbvdlFIguo3gObrtqsaUX8RXg5TIyuqXyIK+ADZMLeiNZt7q8x/RmO0N4Ii6vFuDA
	 D7zrCwH8u+TygUEXL48J74ah8bUQl7aT18q0dRPTjdc4C6stt2OiceuvgoseytZ8G/
	 54UZOH9wNbFbjsT4+RSwTTDWd6bPDqzMdZZeUxgsySNqJBX9KhJQszYDGO/fbqi9Ps
	 l0RhIcJiJb/LQ==
Date: Sun, 19 Apr 2026 15:38:48 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER: tpmdd-next-7.1-rc1
Message-ID: <aeTM2CO_mlNYViFU@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit faeab166167f5787719eb8683661fd41a3bb1514:

  Merge tag 'pinctrl-v7.1-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl (2026-04-18 16:59:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-7.1-rc1

for you to fetch changes up to 038c2344756c76b2363e820519ca09fb0fc17a53:

  tpm: tpm_tis: stop transmit if retries are exhausted (2026-04-19 15:35:23 +0300)

----------------------------------------------------------------
Hi

This pull request contains accumulated bug fixes for TPM driver.

BR, Jarkko

----------------------------------------------------------------
Arnd Bergmann (1):
      tpm: avoid -Wunused-but-set-variable

Ethan Luna (1):
      tpm: i2c: atmel: fix block comment formatting

Gunnar Kudrjavets (3):
      tpm: Fix auth session leak in tpm2_get_random() error path
      tpm2-sessions: Fix missing tpm_buf_destroy() in tpm2_read_public()
      tpm: Use kfree_sensitive() to free auth session in tpm_dev_release()

Jacqueline Wong (2):
      tpm: tpm_tis: add error logging for data transfer
      tpm: tpm_tis: stop transmit if retries are exhausted

Krzysztof Kozlowski (1):
      tpm: Make tcpci_pm_ops variable static const

Rafael J. Wysocki (1):
      tpm_crb: Convert ACPI driver to a platform one

 drivers/char/tpm/tpm-chip.c      |  2 +-
 drivers/char/tpm/tpm2-cmd.c      |  8 +++-----
 drivers/char/tpm/tpm2-sessions.c |  5 ++++-
 drivers/char/tpm/tpm_crb.c       | 35 ++++++++++++++++-------------------
 drivers/char/tpm/tpm_i2c_atmel.c | 34 +++++++++++++++++++++++-----------
 drivers/char/tpm/tpm_tis_core.c  | 11 ++++++++++-
 include/linux/tpm_eventlog.h     |  9 +++++++--
 7 files changed, 64 insertions(+), 40 deletions(-)
