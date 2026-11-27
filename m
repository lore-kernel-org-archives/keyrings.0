Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795803075;
	b=S79H8rggEWBR1SXOiLD24QGMsStOkfz516Weov1+GAOWhIkDxDsHbQmgTSKxCxnDY33x
	 eCIDE8kLPf80YwHdhq4IghErqkfz9Hl7L12Awi48QMdkaUPbtihfzGmUGyDG/fdK5BC5P
	 6klwyN+gDF+LBT+UfeSg6zjTRnDVDIe/hMJJuVqr+lKZfkRTSL9yvIFAC/SDBVtvqWjnq
	 RAD/hEjx1x4t5iLrWxQzFFqK/P/hCya14wxYz0y/DnPfm+UoNAEop57pesHWIM7ps2u7W
	 E1QKzRDrNaC4ulvDA+niy7o6g01vIFTQlTavrL3epcNpnWDzsFB/oJOlK3/sJK1GXxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803075;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=DmWCJTXKS1X+95WW4BlgbZ4tcFEHRZIJDtmUmytJGbI=;
	b=aaCyqso04GzoXsCmOpsMvCJ0+Ts8HlQNxy4DsvSmhoxnbUBqbvEQfux61z7RH9ZM94mU
	 jvhnWfnmJfDBo07F44sSox5cJa311w7OVRxThKrYlyTAw5pi6hv/4+cG3e5wq6ph9L9QH
	 OJjURVteo87pris2mPHtQuZ9f/+jVSAJsfUjWayKgoItCT4uAzLVY08FzJ/zuCAlB+L69
	 NHSfs9+hPdtcIU8GeagQxYHCU7B9USUB3uuAZJhkJQf1LOWDau4e9/apTWUDTMl3dHv+s
	 pJWnRAfhJSN+wmjhAmVuk9JwXUtj0Sy10Ju33eU86jrdcTaKxwIxI8AZCS9rvpJbTCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGgWDlUP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AD6606A31E;
	Fri, 27 Nov 2026 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nGgWDlUP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012551F00893;
	Fri, 27 Nov 2026 18:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795803075;
	bh=DmWCJTXKS1X+95WW4BlgbZ4tcFEHRZIJDtmUmytJGbI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=nGgWDlUP0bb6bLrONJeJThc/OLSME49MhgAm1zlCVihFD3kx5a+9NyOqSUGjFaZ9J
	 KuDRG3l1PFzwpHB3MItXpxK7HNNgMvURmhJ0uWMMyTEGZeqSzQBcXluiS/EMgq4957
	 60wUnNi8ay0kF9uqIoty+oX9o98BxGMm1xkHEwF/bh9OaNomF46wR7u5ETZWFvu4OH
	 sRPEtzFR7Yj5y0rnVFnPaP0z80bn9hgbjv7o0BX85HEzL3sI3wTexrotNabSXubagC
	 LPwCs8eMj+BgcVEy+gkEsjpHs1B+G0u9RmmYq2JVvf7yJUfH5WVQbHvFPFfUH4wYkk
	 HlU4VlCYrY6kA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB9BE392704E;
	Fri, 27 Nov 2026 18:11:14 +0000 (UTC)
Subject: Re: [GIT PULL] KEYS: changes for v7.4-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <awiI1qcs1TjtU3Sq@kernel.org>
References: <awiI1qcs1TjtU3Sq@kernel.org>
X-PR-Tracked-List-Id: <linux-security-module.vger.kernel.org>
X-PR-Tracked-Message-Id: <awiI1qcs1TjtU3Sq@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-v7.4-rc5
X-PR-Tracked-Commit-Id: 1bcff832c48d83c5132662bec83bda37f566d8a2
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5888d706750d0e5dce374c01d2c656bbfe2045be
Message-Id: <179580307345.1619291.14278291896216802104.pr-tracker-bot@kernel.org>
Date: Fri, 27 Nov 2026 18:11:13 +0000
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

The pull request you sent on Thu, 26 Nov 2026 21:30:30 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-v7.4-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5888d706750d0e5dce374c01d2c656bbfe2045be

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
