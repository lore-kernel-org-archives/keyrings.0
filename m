Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508285;
	b=EDsCRKGCt5kQsvri2mrFDp4mNdMoA5ayXaSA3G6uoheBZs6La4SQMjyNkqO0noFpUujl
	 c4xROfwXsd6uvYBHMk7oO4HBTdokpV9F50TuakYfutmVhYFsBtdCJo0UIj3eYZIjvNB2z
	 CKnMzMhMqN+zoS0zdluUBX7uGdltwgGKmw/3r72HCWkgRGezm6aXcbyXJLD9kG5o7heoU
	 yj5FwJCEUp7HbVRbiGCJGJKmJIqyMEPhZ+JI352ff5tsBLQQDfvDDcsbwvjuBkh0Zzhm2
	 U/WMQYgVGl5ONrb022g3L0TlHiMCenW3P6CWUkU3ej1svA0nuBebOG0kgk+Vi6ysveg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508285;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=0dN4cxCqX+qChnRZLKr0bVTTWPEQ60W0u+gzzpZJsWI=;
	b=2S/h+Y76gf3HgG/AEyogR10oQTWqybOvz0tEmOVEJX3szZ9L5ZYAgrlpShxNonkiRWX+
	 L63maKFKbmE5a/zLeBvv9skFaM13P7tupzu47yfu8Ekcn2VfckFhtUhZ2lQGcKpcQd9G7
	 jVj4c2L8Ltt0f4IQCirBtFDKKa2Z6h+8m9ToDjYW7v0Y7kenzysPAYTE3mZAL11K0bZM2
	 NTlEvPElCYf09zBVHOv1P7kPlrounQ1BslK1CMq6iA58ENj5GyTc/An8/Kxx7h+E73GiQ
	 B5kRcbV+MN4qChhtrV2eK8Jz2V473efEONX/sxiAOILsX+pUdLDMkaX5PIH8gEelLqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C9+PJJzM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2EF60A260D;
	Thu, 12 Nov 2026 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C9+PJJzM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D081F000C5;
	Thu, 12 Nov 2026 18:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794508285;
	bh=0dN4cxCqX+qChnRZLKr0bVTTWPEQ60W0u+gzzpZJsWI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=C9+PJJzMM/y0FVkT3esi46iKKkX2A1pGmpQOBYGiuNRNLpfeffHOKta4hYLyrnEKG
	 K0wqNJwjwyiecbGZM8NS7MiO08T9ucBOGSJALxH6XFs/gZ3LqLw68qvFr1JMZhm1wA
	 zFDg3yBG8U/fmyWDF8nQbx2QuesZWtQ9MOh9cuM8jJ3O5ckIbqGDnNGB3dMRH9yjKs
	 P1Ul1Kljf4KxJ1rCCkCiBxzoKX0f4X8+AENPh7R5ex0x9YfXpHHhFDGCMvb9Z9dtR3
	 e8sEGyH8MizMsWxO5KuesBoukod6eqUAQb/eqSejGhOicaw3uzNcd0OdnJmIIz984G
	 0MeOZmLPCKTrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1917380AAFF;
	Thu, 12 Nov 2026 18:31:24 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER changes for v7.4-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <avUFwDt0ZQjf2os-@kernel.org>
References: <avUFwDt0ZQjf2os-@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <avUFwDt0ZQjf2os-@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpm-v7.4-rc3
X-PR-Tracked-Commit-Id: 03fcb358249dc715124b3616f814ea0ecc6ec36c
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae7e0f32277099a25a1d7804b8cb2f6dd30ee2f3
Message-Id: <179450828382.579071.933992315437413665.pr-tracker-bot@kernel.org>
Date: Thu, 12 Nov 2026 18:31:23 +0000
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

The pull request you sent on Thu, 12 Nov 2026 02:18:08 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpm-v7.4-rc3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae7e0f32277099a25a1d7804b8cb2f6dd30ee2f3

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
