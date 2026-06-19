Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93AC1E5B63;
	Fri, 19 Jun 2026 00:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781830280; cv=none; b=kVMjc8o0z0e777zAHEinWmyZEB+AoZjnKXQiS53eNYyHjqJgShaFXUKbqGehdAOaNJQD7j8nPKXd2S8LAcLbff8E6j9EHweWEUdz8KZvhi+SxCQ6CT6MMQ2z49lt0G9P8dkGO7kERDVM3cTvdC37FxX4crraQLYDw92kJFOUdYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781830280; c=relaxed/simple;
	bh=NeFx5npBmhRT9Vdu+nU7sYxLq1t6c5XJlhYnkS/lgPo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sa6TZvuEaXcBS27RTcYfPsdJPsomRrFlsZJu31lZiFU0IVlhO8DcsfDmtw6nJ/L76sXTdsRE9fqY1vdYrxfAG4cc8o3FCKFZyVu3cDiawhpctu8LOEfjWm8v2WaPt2CslhdxVPOybPiK4agUbj9qJ0mBt7VM+5axOjDGpLz+Nuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWmsILKW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWmsILKW"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D31D51F000E9;
	Fri, 19 Jun 2026 00:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781830279;
	bh=YAXAN8Iw3D25D1i5OAyMnbpjtCM2E0piWZ+9jYkZjiE=;
	h=Date:From:To:Cc:Subject;
	b=NWmsILKW0igSu9J4ABbP/fqsHW04BVRZW2+IwWVPZSSIB3kZNvTRsp3FSmQkqWjF4
	 nFiMOXtT3xGc1ztXMgXEmVLNximvna38zjfwb4Iaab200KiCfVMzc+OEyPaqkAyllC
	 QbekzAU2I3BGrsPin2Hhj4yVQyLp+RMwnvOcLEu+A1A3SEbo+oYyZZFkPjdEszntg4
	 22aHu/1FzccuejIQmXyTWdUBY/+jO0RqyYMjyoOKBWMYOYWXaYgbCrBvdsYquHnzQS
	 cakZ36zFpJSm8O36uf7c20E9xGmoGYWnDIBlsa3Qh7Sr1Kz3SXCVFxOazKKLvqNadQ
	 CHrLTCZg3pPKA==
Date: Fri, 19 Jun 2026 03:51:15 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [GIT PULL] KEYS: for-next-keys-7.2-rc1-2
Message-ID: <ajSSgzpmg9LoIDCE@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: aerc

The following changes since commit 0e0611827f3349d0a2ac121c023a6d3260dcecdb:

  Merge tag 'pull-fixes' of gitolite.kernel.org:pub/scm/linux/kernel/git/viro/vfs (2026-06-15 15:53:57 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-keys-7.2-rc1-2

for you to fetch changes up to 1b9524250996b1f2f49833a1b2ae21c34e486f85:

  keys: keyctl_pkey: replace BUG with return -EOPNOTSUPP (2026-06-15 15:19:13 +0300)

----------------------------------------------------------------
Hi,

Please, pull. This pull request contains only bug fixes.

BR, Jarkko

----------------------------------------------------------------
David Laight (1):
      keys: Replace strcpy(derived_buf, "AUTH_KEY") with strscpy(..., HASH_SIZE)

Eric Biggers (1):
      KEYS: encrypted: Remove unnecessary selection of CRYPTO_RNG

Gui-Dong Han (1):
      KEYS: Use acquire when reading state in keyring search

Jarkko Sakkinen (2):
      KEYS: fix overflow in keyctl_pkey_params_get_2()
      KEYS: trusted: Debugging as a feature

Len Bao (1):
      keys/trusted_keys: mark 'migratable' as __ro_after_init

Mohammed EL Kadiri (3):
      keys: prevent slab cache merging for key_jar
      keys: request_key: replace BUG with return -EINVAL
      keys: keyctl_pkey: replace BUG with return -EOPNOTSUPP

Shaomin Chen (1):
      keys: Pin request_key_auth payload in instantiate paths

Thorsten Blum (1):
      keys: use kmalloc_flex in user_preparse

 Documentation/admin-guide/kernel-parameters.txt | 16 +++++++++
 include/keys/request_key_auth-type.h            |  2 ++
 include/keys/trusted-type.h                     | 21 +++++++-----
 security/keys/Kconfig                           |  1 -
 security/keys/encrypted-keys/encrypted.c        |  4 +--
 security/keys/internal.h                        |  2 ++
 security/keys/key.c                             |  2 +-
 security/keys/keyctl.c                          | 24 ++++++++++----
 security/keys/keyctl_pkey.c                     | 14 ++++++--
 security/keys/keyring.c                         |  2 +-
 security/keys/request_key.c                     |  2 +-
 security/keys/request_key_auth.c                | 33 +++++++++++++++++--
 security/keys/trusted-keys/Kconfig              | 23 +++++++++++++
 security/keys/trusted-keys/trusted_caam.c       |  7 ++--
 security/keys/trusted-keys/trusted_core.c       |  8 ++++-
 security/keys/trusted-keys/trusted_tpm1.c       | 44 ++++++++++++++-----------
 security/keys/user_defined.c                    |  2 +-
 17 files changed, 158 insertions(+), 49 deletions(-)
