Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2E04F474C;
	Fri,  2 Oct 2026 17:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790960723; cv=none; b=QLRzfYFU1G4CqUppheD6L1+/pvcN5V5W24r2y58PYnGiRhPBy8+jfklGbZ4tLQJ/zJcnuWyJGIRG+5XPQvAaVxwmfAnKkRGZn4ur+Wcn6m9zZ66xJ8Qoa+caiPud0WZBvvB3TsODptFpjJ+8eQtFveLvf8PF3509iSR39tohekQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790960723; c=relaxed/simple;
	bh=KkcRYFWSsesoZj4Z0gAiKBXyB1mLQ7QFc5S49Wt0+MM=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=PuXIWMfz/OPh/lkx8CuDlWjWDJWXZllhx6muJ2LLvbJEfoYBH7ccfsLWowIkcyTWrJgqdx5rcOtUcOHVIlId7M5n+piI1vI/tALuQqnYwRG8iAVsqXmuAT9ZXeTcl7e+H4NqUFVWU4eVGRH/wY0lJZcVRsYUha3cy6DCAtLA24U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DT7bJF+W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DT7bJF+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC92F1F000FF;
	Fri,  2 Oct 2026 17:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790960718;
	bh=wfmI5iDIlj2ZUNjU33T6Go0o6lQ2B5OKPnJG4DMcYu0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=DT7bJF+WbdogMBC8XsYA2fBJ6Zk+0tJZnWKPrkVPRhi7BRS4nqZmOISkNpWUPs1mv
	 o3onQJA7+z2D5sCMOLscdiQ0U0bmWtR5NWhrDG98Qi/wY3qicVQI/W3oakJqXqm2wr
	 ZyrRWMdzNM/P+Z7ZCmW76dpyc3zVDV7UZKpxU6CuXXLOCHbgOuilta6qb0JrqsSVw2
	 +xLL6SUJUC9+TwOKKeWe9xTdj6/QY36JzC6MSpCRuUrjVfFpo8sYSIon63woo6YoB4
	 I2y7pvk5UnFFfftyvP6xNZ2rogCbuFW2ifkYpzoV7kJzUxWg5ndrZmVuOmYXdZGr2x
	 4abLhx+mTt26g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B461B3811A66;
	Fri,  2 Oct 2026 17:05:18 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: for-next-tpm-v7.3-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ar9D-mM-KA9P_pJC@kernel.org>
References: <ar9D-mM-KA9P_pJC@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <ar9D-mM-KA9P_pJC@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-tpm-v7.3-rc6
X-PR-Tracked-Commit-Id: 015fb29a748342a186f37b602ac70017098c8251
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 17a58009754886eeacb9b826aa6d7bf5e294454d
Message-Id: <179096071720.3506251.4252907125690026720.pr-tracker-bot@kernel.org>
Date: Fri, 02 Oct 2026 17:05:17 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 2 Oct 2026 08:41:14 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-tpm-v7.3-rc6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/17a58009754886eeacb9b826aa6d7bf5e294454d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
