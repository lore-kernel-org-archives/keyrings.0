Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794674944;
	b=PtK4Ib590vAx29JqVtzJFY3zaHOOCbJF05xcqBP4mjMp4p1u939fIRcE9fGnv2YypftQ
	 GB/ztr4/2Cf+T9q8msosbfeevv0sUOL4/DTIrwAYd14HicSiiw1TcM7wpNo87E2Fsw673
	 SmvzBVpP/TGfML3fFFVCO7NyjhSB2CfqIJZoVhSVgUGGYnGdImXEkc60uXGRSDmeEjlfI
	 p0Qyp88v4GNS2G5U5mm6nWM+ke8eHNmqfytmwll04agf7AwYG0N0NlyWBwOpkJtIQemVw
	 pgQQl+0GDRS0eUGovi7BAI0p5z5oYYN0AfSte2usyWEYae5NQddQOSvZDGMEcT/rw+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794674944;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=gsJlCChiSXGwM6irbAnczOsPw0wUpfxy0gH0wb2TROo=;
	b=PkI2YI5K2j0kJxp4pzsSTL6twpmL/fdE/kLFATLgYIeqHMAW+qowlXlIeDuH+1TraY2k
	 4cPpfYwQt7sZf6KQ+rqXFyGMhf4XnkpimhrNY3d5r7BBumJGKoTRiAG2m6Mk8enFgA9Li
	 qJD55pOmqhmCxWU4D4ExLjM7cCu62EuB2L4NZe02YpOkKlmbHQUtl9egeHqmBbQ+61Plc
	 N6QuAV4td1ccE57tpi1ev5EFf4XcVVIRAMNf9gSQ8O+k9MEdRM1rbiuvHSRn/ZUJ7D9PN
	 wbLvuaSV/OepHsQCD21RsLd9FDAnVz7m52dkG0c5uoJNzzfK3U1WJQGSHDqWY1NQRkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FGydmjt+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB3D606A331;
	Sat, 14 Nov 2026 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FGydmjt+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450981F000C4;
	Sat, 14 Nov 2026 16:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794674944;
	bh=gsJlCChiSXGwM6irbAnczOsPw0wUpfxy0gH0wb2TROo=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=FGydmjt+6rHdfF2f9Q4Kyy/jfmzNLqMtuZSnjE+QuXJGqYAqw6M6B59jG75sKjtuZ
	 9TzZHM4Dj4DgrhSGNpGrcvlAJ77R2JGJgotgDiw4l8tNbI6pFjRnfrwDCayo3ID3Nv
	 L8ao9Z2drOhz8zkGfoshqQoBCESFljI/AtEPx2Lc3I94oyrvdsPEZ1xwTEbdOWje+T
	 NZJiDKL9gHHLkbIU6vNjqE/3E8vNec5UOKHg6nvQUF+uoI0SmS4F2rL3jMlGqXOBP5
	 tsX8R1xePDvObf4r39GpH9khKrUMecCAnfP6sPCC7XRPz95kQES9BIVp4PJHa3oxq5
	 vH4wB7iayzQRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A5C0380821F;
	Sat, 14 Nov 2026 16:49:04 +0000 (UTC)
Subject: Re: [GIT PULL] KEYS: changes for v7.4-rc3-2
From: pr-tracker-bot@kernel.org
In-Reply-To: <avdhk_n9dwfd4jVk@kernel.org>
References: <avdhk_n9dwfd4jVk@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <avdhk_n9dwfd4jVk@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-v7.4-rc3-2
X-PR-Tracked-Commit-Id: bab48a1044475f62d6e910c6d7267ce4bae847f9
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 860b3016e6d6fd6ae83eb8f05d1861a1876db060
Message-Id: <179467494286.2233204.15066682104595915003.pr-tracker-bot@kernel.org>
Date: Sat, 14 Nov 2026 16:49:02 +0000
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

The pull request you sent on Fri, 13 Nov 2026 21:14:27 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-v7.4-rc3-2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/860b3016e6d6fd6ae83eb8f05d1861a1876db060

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
