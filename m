Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF21247291;
	Fri,  2 Oct 2026 05:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919680; cv=none; b=P2sjV1XpkKsyCSTm62tFWSwVXWUPelA6ogWbvBkaO0M4KbC+Eas4aWvL7fKq6P13nsISI5BkKhGEriCJqQBkP5uwdgSIVep4cvNLqdtZyGokdGY4zluYfo4T4YwHmtI/R0vdYCVmNuL5DzCTsiwhL4THBRrfC1x+n5VrfBY6zv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919680; c=relaxed/simple;
	bh=jFrquyh0KzBfk62Vk19NncU4x/89uYpsShFOT9gFLi0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NBvgDlxHiDYY2h1ZQ9jRScKYxQlDlXhhkjZVYdkKDzKnzJxSwvd9WLbJlRNSpPUPWaE/zSQaWek8XxSMd/M5RmFV1ree3RbPW6R44YPH9spkE+YHeo5GIaYHPTr/CUYoyNI1HkMjHbxaBLnfcclvmbhzfjsV72W7xLlRT7sfH6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvBvGCEN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvBvGCEN"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 770A41F000FF;
	Fri,  2 Oct 2026 05:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790919679;
	bh=8tg2oYmq3RO1SCq8rpxRbKnkrPEolpP2Yk8HAvjhLx0=;
	h=Date:From:To:Cc:Subject;
	b=bvBvGCENFurEjEWysC/ltI6DmIo3fuFg0Ga0U0Gt4E1OL5ho+zPTaW3DF4Vy7aTPr
	 RvwE256Gmq1U1XtPMThoqX9DnQdn8WcFt9m+/CYBx31fDuYhBsSR0Owhb4rxJ047Uk
	 iWrtUnq5guHJE2wWHWdCsVOD6saPIySB+eWSbZhJ2/jIDj0wauHiBGm8GfHjl1Fvm7
	 irhQYXj1vpOGhnlqQ/PKUniAwJHB88Y+YC8tlt7LC7HoQ68CoY5UCgWQD/qppkhayQ
	 QyJSAPZ692Incd7CmqPS2SsPamNOTjywyxMib9YBpTTn/Wx9HwM3nHmOzxFeIaPu2u
	 1wkWBFir/pNuQ==
Date: Fri, 2 Oct 2026 08:41:14 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER: for-next-tpm-v7.3-rc6
Message-ID: <ar9D-mM-KA9P_pJC@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6f8319e3e9a44dd537d17f41565a8453c560a581:

  Merge tag 'mm-hotfixes-stable-2026-09-27-19-12' of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2026-09-28 20:11:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-tpm-v7.3-rc6

for you to fetch changes up to 015fb29a748342a186f37b602ac70017098c8251:

  tpm: Disable TPM on null key name mismatch (2026-09-29 22:15:21 +0300)

----------------------------------------------------------------
Hi,

Please pull these bug fixes, which have landed after v7.3-rc1.

Br, Jarkko

----------------------------------------------------------------
Jiangshan Yi (3):
      tpm: Fix heap buffer overflow in tpm_transmit_cmd()
      tpm: Fix auth session leak in tpm2_get_random() error path
      tpm: fix off-by-four bounds check in tpm2_get_random()

Surendran Kanagaraj (1):
      tpm: Disable TPM on null key name mismatch

 drivers/char/tpm/tpm-interface.c | 2 +-
 drivers/char/tpm/tpm2-cmd.c      | 6 ++++--
 drivers/char/tpm/tpm2-sessions.c | 1 +
 3 files changed, 6 insertions(+), 3 deletions(-)
