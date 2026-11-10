Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794271385;
	b=bZHC0GSPu4JbXQzyJ7XFK7lOPpeMXWmZM3m7ckk3hjbLI7GPwq+m+dMDFU/BVAt/jTcV
	 HjNVUyBICAIFNrQ6+kCePvlxybHmPDpiql8axTeyLb6hHAeOaowER/6wrkpIt4G5sA0DS
	 5H4oi3ZKavOW41MJGSUp4H7Lp7wI5iXFY7T69HPdTS8IhrsgLtI/AMzD8UfhYAENWWItb
	 RpRuzS5+PhRD7cPY08M4XLumoBJ9SzxRb+/NS1YegeHnYWwhHmEI4dzqiOSk7oroGfxzc
	 Ul1mFPSxsgdnskwOFnKgBS1NtthPyHc6k18q+II6rKbrkL6VWjNQ/QSB2B7IDWb4vOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794271385;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=XR5kc/s67IUeOt4N1NDN7IAeisrzxOSTVyQdgslnSMM=;
	b=hsagVqcXIlJtM1XJP0LKhcFl21mJ617foGPLYQGuf+GD18Z9Ll5AUa4FiYuX+PWwJ5a8
	 dIQO9m0dfxS4MUkfkBIkxCDUmIOBYrrLLrtQRWEG2t5wgPm89BdGYTbO5QgxJSeX7GjEY
	 SJauJILKM9fdH2u5JP/9/h2sCkBi7qejn67SVOm6hhKP/+gV2qo0k6iDRl+zm8BRUnyHj
	 a8ialW3TfILeDplRbzrjkg/a72O6PGEQRPNLQKJP9nNwr52I3mIGFTmjskHZ1D4uEPiuu
	 sXUMtFAxA3YHIy+xuw5EOAcH5p90HqizfrLJyFHB7TU9gat6qe30pLOQAGs/jmBQmAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZPgSuMM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCB2606A31C;
	Tue, 10 Nov 2026 00:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EZPgSuMM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7FC41F0089F;
	Tue, 10 Nov 2026 00:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794271384;
	bh=XR5kc/s67IUeOt4N1NDN7IAeisrzxOSTVyQdgslnSMM=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=EZPgSuMMPlZL90n8uqwE6Doyl8bnXIgHX7x0hrYvj1p3Gw6ttP3JMAeuNEvp1xmHY
	 5q7fViCS40ZltdA+nG0q8hpniryaIeVTXkIanrWu0+yVAJdORAB7C3E6SaBrGf7CgH
	 m7Vx/L5YFmvslze/P2SHGZx32b4cRFEY1sUyufbJ5buPO30KX18yZcdXiBtPvAHGjU
	 dEkdf3Zo0BU+grma42XyTodeOFNt1VHkRxNHkwmQpSGhIxJtBg4GSa1kJEAxkpSKaj
	 KQaXFG4Br9n0hcuv/MHjs4Kk5pAGl9ei/fDVY3eX+IasI9czT98mNHb/HZ50vdo+r8
	 ADmx6J2s9AERw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B3A1391AFB2;
	Tue, 10 Nov 2026 00:43:04 +0000 (UTC)
Subject: Re: [GIT PULL] KEYS: changes for v7.4-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <avH6lqK4nq9j5aKs@kernel.org>
References: <avH6lqK4nq9j5aKs@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <avH6lqK4nq9j5aKs@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-v7.4-rc3
X-PR-Tracked-Commit-Id: 51bcd09b9ffca7a2a3b66fb57182bb391364f612
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f1bfe4003916a6d56e43b08698f38bad4443bcf4
Message-Id: <179427138334.3573198.12622953115863298188.pr-tracker-bot@kernel.org>
Date: Tue, 10 Nov 2026 00:43:03 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, Eric Biggers <ebiggers@kernel.org>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Mon, 9 Nov 2026 18:53:42 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-v7.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f1bfe4003916a6d56e43b08698f38bad4443bcf4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
