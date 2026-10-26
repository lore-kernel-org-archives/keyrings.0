Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793035481;
	b=YZp3L4stWn5H8B29SBae6GPNiV8GcsQrKCECz+OcFGhdBimdZe5wlmClbeVwKhobLGQs
	 MuH5jjuWpcTYDxFZb4c1NZnQ4AN16nV0yplvWyto/cn8ZRBJsTwtVu3yqf3NgsDcYtutR
	 6vvPBV128G/ygR8mDmaFwnfHJhLofyCNmVmPgq3E75v+unSReZXXg7Pbd/tC5HAhZVUdr
	 RU6f7gqcLgpYYM6nLVF5oq2AhqP0jIvV4bvD9OdXDMGl0UvzaQqSndIK1zbp6N96u768N
	 VzXelRhI3Bi75Nz6Zd+lmPNMNt3XS6DZT7DHHBffvvPPg+Qx00Zt2yCfRaW+W9ZvFFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793035481;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=mpHqLwhZJ00hnXP8bcxyXG0I+PMD5lZdNWqL2RvtmNs=;
	b=2kfV6xB+0onecnU/C9tCAPyCf4SiFDetTj6SZ+/XSs6vHSJKN3vufzb1vfFP7vAl6m2A
	 lrC2UXC8+no+/1XdHr/2mOko+0Ah3p4goiI7E1rnL4jDqVKna0mIEftST3rw4l8yo/UCF
	 rSIyMrLXmfUycLNJlJxEN59tl4KRs2bka/iEMSJEICL+1KPU+3vpw0DRxstBZSEjHikVV
	 quo1TDdnGbG4/UPVRF4+/rSl+PnpoXErWotB8bt2sLeytBuktxQWzrQHcc6KTmIg4sN8Y
	 T9yaAWcOTtG7aalcBocBK7L0buv79xW2MQ7ViHO09MQ9JGf7XvngoVKHw+uzDMQlnEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="m/PJL7gt";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355C6606A31D;
	Mon, 26 Oct 2026 17:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m/PJL7gt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BE11F031E3;
	Mon, 26 Oct 2026 17:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793035481;
	bh=mpHqLwhZJ00hnXP8bcxyXG0I+PMD5lZdNWqL2RvtmNs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=m/PJL7gtbD6CUxgtJtENKM+MR8LEwjE5x4hOXpcugnNaQGqETHFg4zJj/VqqOTTrL
	 UysGKHUtZSFD9NP6KuGzQfPgFEpI4rLfRkopSeBTCz99UoUhfl8jHHHzg9vNPUI55z
	 QpyJoQa8v+Rib+ABo+7al7vOouu2gQ++NTVWVj2iM36LfKNl4L03r5c4/djt+JgN/C
	 C3dgLjZwLNFpkMTJjBDeHgcR3k5D/0GbXei0jesuCf73mrVYkhgjWIy8W1FU4nbHJ0
	 wq8iSozAPuc3l7QRKdHkp6QyH67nZuNHPE7w3xMdzQrLCEFc1tJZM92UFdMgMuNQo7
	 p7nISezaRHgpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 074263AA58BF;
	Mon, 26 Oct 2026 17:24:41 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER changes for v7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <atueK3rp8d95-Uaj@kernel.org>
References: <atueK3rp8d95-Uaj@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <atueK3rp8d95-Uaj@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpm-v7.4-rc1-rebased
X-PR-Tracked-Commit-Id: 071aa806f00cf2948ce8082102d5f64515f53215
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: b2c505e0ae0ba4b259cad56c87e630dfdf58dcb4
Message-Id: <179303547976.3291751.7664412335372853054.pr-tracker-bot@kernel.org>
Date: Mon, 26 Oct 2026 17:24:39 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Fri, 23 Oct 2026 20:49:31 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpm-v7.4-rc1-rebased

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/b2c505e0ae0ba4b259cad56c87e630dfdf58dcb4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
