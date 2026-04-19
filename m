Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D2C22578D;
	Sun, 19 Apr 2026 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776602065; cv=none; b=g46iUTcRUHytadFRaK/lXkldPHbiTWU7Ikeinyw9kDwFe/BX6qln8doE1L5KIK9dRdgI6boyLNEWSlJWqZYDFcUD55+3ynKzT4y0T4S0RKDX9bwjbn8g6ajiVO76J6VLbqE1STlXuLSqeKhRJfGBD/xsOw6z4HcRO9jqLCVjgAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776602065; c=relaxed/simple;
	bh=07q3DFZkPKKyPBCWMzl/ekvXtnWQ2w3JToiHgy0TPW0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=O6GUsctccSieqRUfMKD3nNx4CyByx6zcWiv+79hUKCobAK/Uti9olyZjkV5FEQB6x6DsCSOkveUt3xQ30bZaAAZjJokVNirjaSJ47hFmQ5m3YxEwbrhq68hzkDrpKyVd4XrObdvUrPcGvG7ea8uGhYUQoMoEEcNPN3EziD1wJOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsGNviiP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsGNviiP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616AEC2BCAF;
	Sun, 19 Apr 2026 12:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776602064;
	bh=07q3DFZkPKKyPBCWMzl/ekvXtnWQ2w3JToiHgy0TPW0=;
	h=Date:From:To:Cc:Subject:From;
	b=OsGNviiP0+tn1hoXqbeQDtMWR3Tn8QPbcNqynrM17LfQuKH8jTcjKmQNb8yEc9Ztm
	 5prbPa7NE3fNdqf1X6+ZGzy+On/gKunFAYmWnpzxEjYD6GjS+MiQmmqtGl02K5oil2
	 zqzw31NthH0vMPLCcbJtBJQqhBThbsz3gJUP5RokD5nCc2lpuy9/HTi/tUG5GH5nZ3
	 PjjWkkeUBBGjT7z5QIYsvlI9SPZf4YljcE6T9E1fNM6jragfr+OwIdmnmYlG6UuxFL
	 1y9+1SO3tC7qsPXSeq8T1ZiSMivKIiAakaV5i/4wmUXq7A2VFCrgkZiQQTDA6WMeby
	 Rzbtx3iT+fFpQ==
Date: Sun, 19 Apr 2026 15:34:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [GIT PULL] KEYS: keys-next-7.1-rc1
Message-ID: <aeTLzOgblMZRnDvF@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: aerc

The following changes since commit faeab166167f5787719eb8683661fd41a3bb1514:

  Merge tag 'pinctrl-v7.1-1' of git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl (2026-04-18 16:59:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-next-7.1-rc1

for you to fetch changes up to 4fb4ce024d06a0b31ab6cdd17ab8cb6aff851067:

  KEYS: trusted: Debugging as a feature (2026-04-19 15:17:03 +0300)

----------------------------------------------------------------
Hi

This pull request mainly sanitizes debug traces in trusted keys to
proper kconfig flags, and makes the whole feature overall a bit safer
by putting it under kernel command-line parameter and setting up a
convention to only use debug level traces.

BR, Jarkko

----------------------------------------------------------------
Eric Biggers (1):
      KEYS: encrypted: Remove unnecessary selection of CRYPTO_RNG

Jarkko Sakkinen (1):
      KEYS: trusted: Debugging as a feature

 Documentation/admin-guide/kernel-parameters.txt | 16 +++++++++
 include/keys/trusted-type.h                     | 21 +++++++-----
 security/keys/Kconfig                           |  1 -
 security/keys/trusted-keys/Kconfig              | 23 +++++++++++++
 security/keys/trusted-keys/trusted_caam.c       |  7 ++--
 security/keys/trusted-keys/trusted_core.c       |  6 ++++
 security/keys/trusted-keys/trusted_tpm1.c       | 44 ++++++++++++++-----------
 7 files changed, 87 insertions(+), 31 deletions(-)
