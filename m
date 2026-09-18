Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6C94C6D;
	Fri, 18 Sep 2026 00:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690172; cv=none; b=qjh37jjL3t+E6AB3b6JUtJQ5CumJuwTI8jsYRTV3IaoSgwAJdT5Icult8jSH1qn36YKV5ZQfUR4jvMDiKwTEVS4tZtMynJCZJRdE4HH1B2ALAItFTscNSybw90JWRi/ysiVlh9hR/n8ddwWadYnovtN8MmvQj7D4pDUprrBN/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690172; c=relaxed/simple;
	bh=mlyIpGxz8LISSFQMeNxTI24BMtXO3+gZAEhxbwNtMww=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=ZZiOskBRawrbgsxYaqE0yJz+KBiGzwzfnv2UJ7UslC+0WjwZo4PcJuLYZboOh88cdbjndeZcAruNK884s5ApzzubLzYErfugyAnQxlbb5+HOmm2j9N+TnxYxqSgnSduJvrvafxnFNNWbNrljPP3cDsIyqNysSc2RuVbDlSww388=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnebO9oB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnebO9oB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E805B1F00893;
	Fri, 18 Sep 2026 00:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789690170;
	bh=nIu0KnbDEXKbg55PWXwakDH9/Kn5BbLUJga/9JiR8VA=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=lnebO9oBMN+1DKsAHBoPdstyRrZNIL5am434T2Of9WWMb3VuglTU3uivkvBTyLq0z
	 RbBs7Qew/q0z4rE7ZJsT23j8gisbv46BgBgzVYguua5RC31HSvHa1sNjRSV/dBDArP
	 VHOVDS13hZirFORXT9fZ455GGNqFFotGtSNQ8MT1dycGp6b2nCc3wNEPI4HMwvhVj2
	 y4+aD4Ypknq0YthQ5D8zNauF9ieJHRC24y0Jc8G2ze+pbaSdhUd3vTOQylSLURAPc6
	 jZGcagDkchKE10+ezRiRBG/l0fUOCT7PAqoRC2liGbRa+ZncvyqVR5QHQK7YqtpeTb
	 HCsUvZVj7uG9A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BBB380820D;
	Fri, 18 Sep 2026 00:08:25 +0000 (UTC)
Subject: Re: [GIT PULL] KEYS: for-next-keys-v7.3-rc4
From: pr-tracker-bot@kernel.org
In-Reply-To: <aqxjFEZwvSB_7exH@kernel.org>
References: <aqxjFEZwvSB_7exH@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <aqxjFEZwvSB_7exH@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-keys-v7.3-rc4
X-PR-Tracked-Commit-Id: 8697c431e297eb0d0ab13dda6bc172b48a34f05c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5dd1818b15d98d4a20806cd00b1b40320b06004f
Message-Id: <178969010425.190692.2028439215296374658.pr-tracker-bot@kernel.org>
Date: Fri, 18 Sep 2026 00:08:24 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 18 Sep 2026 01:00:52 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-keys-v7.3-rc4

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5dd1818b15d98d4a20806cd00b1b40320b06004f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
