Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702204;
	b=5aFY3MJ13YetPXbAlkGwaUtb7DeL7jfpYZa9cO2hSsP8p0ptofdwnDqDKFPOPMyJWqCw
	 +3SqjNWEBPgHkEpweYEbR0aJK6yJ6k8sxOKJ+MJ2/4HT/OVE4JjXiqydWX0eSma0hYCxf
	 Ko1Hn0n1OSuS/pnwX0BfeE4IuGmDCpTEnYEGh1aSIOcGViaIDhkCBkvBMYPkfJcVDIgst
	 ILNuz0sHMtRd9m/BPMdYMqLCMW06IGyLts08YS754okKtvW21gWgtJdsXXmXYrGfmWLNU
	 Wr1E3fVUQNwp4Uyo9AiRuqJ3nIynVBOEHAqXmzryN7XGFg+TbC3DMBsXR5lwK6WIsng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702204;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=qyT3Ilp2lXMewD0w69TIfHBI6769IWTq9P1Nj/4sMPI=;
	b=s+3EZ1O1jVjkKTxlv+GVJvXTG8wqbmQjFkUNWJvhP4U9EEo0/GiUraLu14iUNKcosMK/
	 l/LXOeRoWuFwKAqn9JEsywHVdZasuPblaXsPeCOrCsQ0M/AXZA5n9NXPyPeWnx7HagJhF
	 qae6ik131DaSekc/iaGRUVejz4QDaTuSy3J/yRUfkwECSvNYdTw0v0abcXsXRaiLvlosi
	 cIIvlPguVIrW2/02C4iuifpwVzH0npV4CoH7q2jR1SReuPxkpxTtM3tb1vGDJD9FGiM0M
	 3Lg7Kusje2cmUx+3kuquCjDNqxesQT1iAtw1VyPUQi+Puli/TK19q/zPpUQQa5+SuFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zp1qxDL6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6EA606A32C;
	Thu, 22 Oct 2026 20:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zp1qxDL6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155BE1F031E0;
	Thu, 22 Oct 2026 20:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792702204;
	bh=qyT3Ilp2lXMewD0w69TIfHBI6769IWTq9P1Nj/4sMPI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=Zp1qxDL6wPHU82SHZWS8d1bS478nztXeNIRwbUtCAhjVUYwgHxGq9qhiXvqsXyP9F
	 D6ju//nI384Q4yo2kh/7TAE8zSrz9Hhy6SruMeqnzxOVWyt0xnY+UxOovxxFfhIE0s
	 wVpNSFkfrxDbPHHo2w1iH0JO518OBj8qQ3SfUpob3bWd32rsi4eVb7kJQ/mcyA4V39
	 D/7verzwlRknj2O8VTRaCPanSrYRDUwU2HBqotHGjf4/2rDEqj2mwcR6gZCuB+goXo
	 j6D95jJ/ZRfTYDGSeYhj4BC5ZhKFO6SPST+EwEyHSEYhuepOIqzoUaaCD7qvCBExWk
	 OE6R9R85rKL6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 077BE380822E;
	Thu, 22 Oct 2026 20:50:04 +0000 (UTC)
Subject: Re: [GIT PULL] KEYS: changes for v7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <atjKs7PTN8CgndJg@kernel.org>
References: <atjKs7PTN8CgndJg@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <atjKs7PTN8CgndJg@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-v7.4-rc1
X-PR-Tracked-Commit-Id: 722658cac48a6ba49f5506fd74d010ad9dbb2f05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14785eff402944f56466ef0058408334cfc2f91d
Message-Id: <179270220279.170280.5677887239451087231.pr-tracker-bot@kernel.org>
Date: Thu, 22 Oct 2026 20:50:02 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, James Bottomley <James.Bottomley@hansenpartnership.com>, Mimi Zohar <zohar@linux.ibm.com>, Eric Biggers <ebiggers@kernel.org>, Kyle Zeng <kylebot@openai.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Wed, 21 Oct 2026 17:22:43 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-v7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14785eff402944f56466ef0058408334cfc2f91d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
