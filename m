Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E06E36C0AB;
	Thu, 17 Sep 2026 22:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682458; cv=none; b=B3GjaHSsKkQIw0L6zZ2lmlmwkCMSk5t2irxPS8/0TzVZDlQZNbMbMUru9XAZg/yo23mcdXWbijZH6gVHESyFKqnn9oIher7has7HmUDKSlBvwpx9l3hYDhfjdN26yGFC1C68Npj5eO3rMgu3oES+mFBjNISCb3KlS74tKIEI8D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682458; c=relaxed/simple;
	bh=6L7vucZUAcrgkfQUqLZk2RAq146FA6EjkWTjMj9U3VA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Eq0If9bfkgXQZ/N2cje+30MkIIpkNw/NyATeCGtv2yQNF50h6UU69QTzQzoXfpbU6Bitsp+9TddBqYE4rWw48i2GF5ACioNU2NxoqXsUPumv+2+PbW69kBgUZ5njSfKYHj7uoUC6+bZje40sNVp29D8+1y9tVRVsSlEVrRnU9fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRzd1t8L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRzd1t8L"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 22E691F000FF;
	Thu, 17 Sep 2026 22:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789682456;
	bh=zcsanuDMR7V3fAHIm38tj5h2BZhLZIeRSjBgoNT9Wlk=;
	h=Date:From:To:Cc:Subject;
	b=DRzd1t8LQWViVmon/WyriTCuYyz4O9cy7QGj4mTnohkv2rf2Wu3SJwQy31BX1ytrR
	 oI4N3koEZCF/ets/U2k5cMyFCDWjXKXkgwLd1aZllokW79IocPrughjWMQfDKchIo0
	 5HZDod7koclHWhJeqyLUF6DwJLl4VPjetUz/mhSSiveGXpmMmUrkDLNvSeaD+yp22r
	 S/Ug4bQgDnChM1oCbm/h/oG++/F9naBW0c3DBZJTLFa0H8wGtfzCaMAkYH1HQSmgAJ
	 kguddbtjdIrxchPm+uvy6zRP8NyIfzeAftsgqgSDjle3bpiHUxQ6Vl0wkW3zrWzZp3
	 2kMieYtBdh7OQ==
Date: Fri, 18 Sep 2026 01:00:52 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [GIT PULL] KEYS: for-next-keys-v7.3-rc4
Message-ID: <aqxjFEZwvSB_7exH@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: aerc

The following changes since commit 827751b699b79a6e569983359c02dce67f81b94c:

  Merge tag 'riscv-for-linus-7.3-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2026-09-11 13:15:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-keys-v7.3-rc4

for you to fetch changes up to 8697c431e297eb0d0ab13dda6bc172b48a34f05c:

  KEYS: encrypted: fix integer overflow of datablob_len (2026-09-12 00:43:45 +0300)

----------------------------------------------------------------
Hi

Please pull these bug fixes for keys accumulated since v7.3-rc1.

BR, Jarkko

----------------------------------------------------------------
Cen Zhang (1):
      KEYS: encrypted: fix integer overflow of datablob_len

Jarkko Sakkinen (1):
      KEYS: trusted: Fix tpm2_load_cmd() boundary check

Karl Mehltretter (1):
      keys: fix lost wakeup when reaping a dead key type

Maoyi Xie (1):
      keys: translate request_key_auth pid for the reading procfs instance

 include/keys/request_key_auth-type.h      |  2 +-
 security/keys/encrypted-keys/encrypted.c  | 20 ++++++++++++++------
 security/keys/gc.c                        |  4 +---
 security/keys/request_key_auth.c          | 12 +++++++++---
 security/keys/trusted-keys/trusted_tpm2.c | 12 +++++++-----
 5 files changed, 32 insertions(+), 18 deletions(-)
