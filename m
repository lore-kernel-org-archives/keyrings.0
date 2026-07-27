Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF71F42FCB0;
	Mon, 27 Jul 2026 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785189041; cv=none; b=nSidckkUuz9sjXXRhDMmieHl+tGIxSFK3/zxB9rHxEg2oJBlRGAF3fbxTxVJWDPSIpkgGg02fSMKYeEF7ZGogp8oOHAvKtkRr6Nr/Lkb7x/V94Zb4oOSQdCTYcUUHj280FnGmPVShUNY+2hGVBl6LkEzTmsV005ADcXC9SWy2RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785189041; c=relaxed/simple;
	bh=Pp6bHO3sa+B5efpC5FZNyA1vjZYajJBtZRhiEwuw+Ik=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pV/IiE301236ejjHIQNeuxbBc5LvZmESsLYvO4rHB9Ia/H5qRoChvWL0zYw/obziSo5rQHukS4q/TDoEEJfK24E/J8YYU//S7qfpBax4tA4vQTDpueFEo7rYeOjxEojYyc9ZIf34OYMbkQP67CIunUgDvt1cJmRxYNOsZPyImFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TulJkxwn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TulJkxwn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925B51F00A3A;
	Mon, 27 Jul 2026 21:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785189040;
	bh=hS3INzS2IGY6o6eQTzf6QDVQoW7S640ipFH3IaOj7lo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=TulJkxwnqh4eBmge6Hm9a+Uq3xIaQF1z+Q8YYPxGzLp19X5NvHAj+4qMZO6D+Kxbj
	 3hCiilwd9+Jt75s9Ku7P2Km6KluhxI0LEvKqKBN5UKX2RFTPyyhzl2B8SVJ6oMJyoN
	 URAmlTk4b3toj63+di6CZEtzkpEe2uIep342JtU5thJ0lrs4ZjHqKqCdgo2TPybnwH
	 G2Sfr0ianJuYChvL/jU3t0NGweadUgKvUwdKSuiYxxc5haCMtaQQ2l6z3XWmDHhUX3
	 Gx5/Whd1s5R3KSI/bvnS0sjdei+A2KFYZMms4fia8xgvzEKHwKCpI/KxeEJcraXZHJ
	 FiODgYeqjN8cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198BA380CECE;
	Mon, 27 Jul 2026 21:50:07 +0000 (UTC)
Subject: Re: [GIT PULL] KEYS: for-next-keys-7.2-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <amenZnA_QgqwMNeC@kernel.org>
References: <amenZnA_QgqwMNeC@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <amenZnA_QgqwMNeC@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-keys-7.2-rc6
X-PR-Tracked-Commit-Id: a82c8a05e86f3f84e09698f65b4515b5d04633f6
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: aa6fc3defb36b11eb82c4d1f4e95b5f6d8a0bca6
Message-Id: <178518900592.1430977.11592301794262799337.pr-tracker-bot@kernel.org>
Date: Mon, 27 Jul 2026 21:50:05 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, Fabrice Derepas <fabrice.derepas@canonical.com>, Michael Bommarito <michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 27 Jul 2026 21:45:58 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-keys-7.2-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/aa6fc3defb36b11eb82c4d1f4e95b5f6d8a0bca6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
