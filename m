Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07823126D6;
	Sun, 23 Aug 2026 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787502679; cv=none; b=aYr0RUuLWn7AQHGxzPtALy3WwAx0hTPgDjmJjuPtZiGCMmY+AqhxAIgwec6mtEnP01GmvSsujGer8fpiTS8mMfI0KTDhdTQC84nk1QMKKPr1a7q1bQA9oiaDMj+OahZ9d9fSEAhabKpZhvLNkmxQ97XIQqsZexo4/aF5rhOnie4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787502679; c=relaxed/simple;
	bh=R5ne7KmCaXEYUqqUN2VBmSMcsFdvWsPrldVybsgvv8E=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=A0IMCbEvzAIfJeJMYaSBePhlnZyDGTIMas52zJ/dDFh8ZliuyKR9NdT1JqTFmF6N0dXvORosl/UWwwZ+Uq0uNlWdF8B9BPGL2M3HumVKyc/znTXobb940QQqW4UxMw13pNuRFSIdtgWc5lwwENhThbiDwJPR5XG5h3XOQ9sPCqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8M8BFXj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8M8BFXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C771F01572;
	Sun, 23 Aug 2026 16:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787502668;
	bh=M/b6WfklxMi1HQdFk+7zXIusvgfovG55xOyfTDpwLcc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=E8M8BFXjIFIdnsAPRaFIYtx8Tr+LYnpEWAJWt62Va4ykXxOD28um0k60zBbDvTNd/
	 abLnYx7JnaRg7YQu/S02Cn4CUoCGOfkvsuEQ1JSj5S7AT8JtNdqL0tFmpGYDODhJY3
	 2v/6kRSveOEy9WFNTkg2aboMsdShifUev4ahZGtnCvZuvT5WlgDLJqn8Hz1XieDuHa
	 vTFN+W87DaIHFGdULxl5YI26xshD8lUvYY/rvSF6OO31MPRWdQOV+/LapS2XcBos43
	 MlFbbTNgFmtkhHgZ1+b6lguTE/aW0rPRKBUecE5B5ShZKrsPNBESLLDCGXUe0djTp2
	 VEnxlPPjgnkCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F28EB380AA78;
	Sun, 23 Aug 2026 16:30:17 +0000 (UTC)
Subject: Re: [GIT PULL] KEYS: for-next-keys-v7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <aopjCf7Srz1ejx2I@kernel.org>
References: <aopjCf7Srz1ejx2I@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <aopjCf7Srz1ejx2I@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-keys-v7.3
X-PR-Tracked-Commit-Id: 5e2d672280d97d83de43031d93761b12dadd7b8a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8552019d09867164a6350bda7d731f140a90d7ac
Message-Id: <178750261666.2078512.301274795305878798.pr-tracker-bot@kernel.org>
Date: Sun, 23 Aug 2026 16:30:16 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 23 Aug 2026 06:03:37 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-keys-v7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8552019d09867164a6350bda7d731f140a90d7ac

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
