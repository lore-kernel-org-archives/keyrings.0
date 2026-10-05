Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBFAC358378;
	Mon,  5 Oct 2026 22:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791240405; cv=none; b=j5qmvHBZjsik3CHs4Bzb/ZqAMQu+CbNR7nVG6QMrqoXkTCQTBECOIYSvsouzFJQHIrs2TTN7Y7cRO5x3rjLdCJE8CtEFMLpEN+PC5r1y4Mnb/9mcOhrfso8HwEnjNW02LrH+pIDjFY6ggCnCEiAI0CfMGkHFRZC9wruSPVyshxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791240405; c=relaxed/simple;
	bh=wpcUYiuuJ2s1L5IZGWhATXeXgoxRvxanQmPZDT3mPcE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J9dtmM6kSdIiUpOc8BHnISPb3i2RrDV8qHDCKtsK7IYWqRRIKbmDsgBEi2u6olsWyrPZcAJN4O+SLvCVwVxJoZrjl8bxkOMeaPJ1KNAnyMpr3CgU1fhQMBB/4tKdQKT3W981beNlpHE439g6qNbCAAU5LF6Tak0XAb4tFU8CjFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LkrB1/Gh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LkrB1/Gh"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DE5CB1F000FF;
	Mon,  5 Oct 2026 22:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791240404;
	bh=cPZgMUryOgJLNtBZJUJKmeCHqfhJTZMkraZmCaTi35c=;
	h=Date:From:To:Cc:Subject;
	b=LkrB1/GhAfmmquVuhDZEXn2ehlJiP5NyoOAt9lxXYhfX5ksWPGsBMa1XEcEFM/J2u
	 JIJYiZW16MzYpGpKk7zlGdCODIH0qX494fW/jpT3fk0vNt7IW3gdpnnIeEXjhPK/J+
	 HrWJoUiWXoUHotc2jitbKaKZIn/vkHdW4K/0V/+ZGISpAj+aH1EPJi6ph2tn5DHAlX
	 Uy9TvWhWb7msMeszqVqH5nIeYlm0NK+LcOZUQu7PkknCMB3pnHG7dcU1/9WdBU0qE3
	 0TQEZ+gCiDH6oSslbdteUCLThgnq41bFkh/x648pnei4VNfzQdlxGDYZs6ftWfZRc9
	 jT1MRsWDylYew==
Date: Tue, 6 Oct 2026 01:46:40 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: [GIT PULL] KEYS changes for v7.3-rc7
Message-ID: <asQo0Kb0SF0vZcHa@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: aerc

Hi,

I've started to take steps towards better quality PRs. 

Br, Jarkko

The following changes since commit 7704c4c5bb127673b4f0ead839919db573559e38:

  Merge tag 'i2c-fixes-7.3-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux (2026-10-04 09:38:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-v7.3-rc7

for you to fetch changes up to dd3ea3fcba7c75493760cdbccd35f029597e8d5e:

  KEYS: Fix add_key() race with keyring restriction (2026-10-04 21:09:32 +0300)

----------------------------------------------------------------
KEYS changes for v7.3-rc7

This pull request contains two critical bug fixes, which can be briefly
descibed as follows:

1. key_get_persistent() creates a new persisten keyring for UID  if it does
   not exist yet, and creates a link from it to the nominated keyring.
   Function did not set timeout when linking failed, therefore preventing
   GC. The bug was addressed by calling key_set_timeout() regardless of
   key_link() result when the persistent keyring gets created by
   key_get_persistent().
2. __key_create_or_update() made a copy of keyring->restrict_link before
   holding keyring->sem, which can cause add_key() to be executed against
   stale keyring restrictions. The bug was fixed by copying the value only
   after keyring->sem was taken.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

----------------------------------------------------------------
Karl Mehltretter (1):
      keys: finalize persistent keyring timeout after link attempt

성병찬 (1):
      KEYS: Fix add_key() race with keyring restriction

 security/keys/key.c        |  6 ++---
 security/keys/persistent.c | 55 +++++++++++++++++++++++++++-------------------
 2 files changed, 35 insertions(+), 26 deletions(-)
