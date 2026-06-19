Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54953346FB0;
	Fri, 19 Jun 2026 19:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781897107; cv=none; b=PtZiJbSeSKUvyqCePL+Kesd6K2/clz4TjR1xEu+D05pNgNF1oQBjDgRUkatYtGCwPZIhdWgLxhdmMY/cr8ApiR6yL4NyhyKlepqnmNm8EFNiyfhyiKVHNo8TkBbRKjISUj5i252x0Dk3sUgeY/rRWxxjbX+HkCRDQdCWW+wAiDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781897107; c=relaxed/simple;
	bh=UGnk2RC54tSfyMoaS0aqJkgMFxdUmHvhGBk0q4mIJjQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DZBIDq5WDgp6gktCQUgkNUV8030xn6uW3Cl3RYOA6LtvqueHFKgtNWARACz8/XvtcC457ZqzORVdvgC2hRlLxg6LC+u9P9/bVzm819IT9ohol4WnaV6fH+e+Fk27gQBNbiasggyn+JUy0Rg8S5vH75lMWxikqQspg6b9vkYPRlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XApynUs0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XApynUs0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AC61F000E9;
	Fri, 19 Jun 2026 19:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781897106;
	bh=Z3FydwmTWJXvoQ8BEXqGFu8msvCVysTXPPI1kYYSP3o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=XApynUs0Lw41YqfxJS45IlncGoHGSeTUrFbGal7/fK8ttAUV3uVexQVf7UhncpBd1
	 0VuVLyinOIymHQzueBIlMGXPuWE6sxR/MYKcdNOVs5WdtJ+108V/kLipHUmQH9kOcj
	 ORwxtYfluUBw/TY6RwrsdJ1AXVI0cdYoB2NyRUO6kbleOHmJv/+RyU/LTiR93xdkby
	 7sLjrODX4qCKZ2j6Pzsvr7OW765kBIzZXfhf2GhUqZWPjBsWrKMNNhxF4JB8KZxkZM
	 2CTUx/KpzJ0kkJXSaSmtrkvCy8eTgh4sW42AzLdvPlURoN/K0qB/06HBimkloVhLMH
	 qnadrfW+eGIFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56B663AAA0F6;
	Fri, 19 Jun 2026 19:25:00 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: for-next-keys-7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <ajSR22PC_X6HWjo2@kernel.org>
References: <ajSR22PC_X6HWjo2@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <ajSR22PC_X6HWjo2@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-keys-7.2-rc1
X-PR-Tracked-Commit-Id: 1b9524250996b1f2f49833a1b2ae21c34e486f85
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: e2c0595b56e9526e67ddd228fc35fa9ff20724ec
Message-Id: <178189709892.4037507.15759304723989789471.pr-tracker-bot@kernel.org>
Date: Fri, 19 Jun 2026 19:24:58 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 19 Jun 2026 03:48:27 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-keys-7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/e2c0595b56e9526e67ddd228fc35fa9ff20724ec

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
