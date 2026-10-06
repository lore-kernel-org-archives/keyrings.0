Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E997A20C029;
	Tue,  6 Oct 2026 03:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791255877; cv=none; b=oOhUg5T1mTsrnhEqr66WfJNHZL2zpdB0y7Q9NPmUd/WJoogbyrNfw+i85wXcJm/P/aN2MvOMRHOk9ClD5cPzqEtfFGrxdExC6zLcN/BGTIawHugk4pSZPMB3z+o2vLaWHmhBNkOE9GaWP3qt+3SfTHQ4K+tBFFdWUrD/+/VpRp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791255877; c=relaxed/simple;
	bh=38u6i/vQe/S15L2jeenc7rRFJ4dlyvejt7VJcj919B0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eoLREdDyDXQHs+Ff2BiLutkUVlikZRABbvi1q1UfyWSCc6JfXiSrYTsEYEtk//k2hOctb1kFz2Oa03zycx6f1cpp/WBXLTd8uWCGE+Gpt62DW7QTt8YGd4eQU5l0l0mHGcnQ1K9lw69pzd6t245puyoRX/bfM/M9lMNR4PH0QJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYtRsl0v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYtRsl0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFCE1F000FF;
	Tue,  6 Oct 2026 03:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791255875;
	bh=Wfy4NmblZ6gLHUHVysTGeAjWUZIV2QWkt7Z9k9kQ9sU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=PYtRsl0vVKXNQeXxNqcWu6sXg2RZ1rLu9WsOYwRcHHoMqR9ymiaCIXclOjUzkOQ8e
	 M+0+lzfJMYMS/TOfQjYKwwbOgszr9ufIXqv0bdQsI+Jh8AWgSKGjibNvH1thn18c+b
	 C0YSBJJAge3mUa40ofTY6DRu0/oG7Aab8P23CosHdAG9CsgCxrhYq4CQrYCWjoh0KL
	 6/aqH7mAwI7SRDRo261i0Ic+Hix3N/H4zy6SHFhG3lZjyCIRHf98H+oMkKFxIUPk2w
	 wD0ob1P1zifIXsP/92WnsxjvFq4fk2ZXkfUo+nBryQZYw2RDWyO7qfJ0rfdV5Jrcv5
	 aZxQ5/NbKgZtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B476A3927040;
	Tue,  6 Oct 2026 03:04:35 +0000 (UTC)
Subject: Re: [GIT PULL] KEYS changes for v7.3-rc7
From: pr-tracker-bot@kernel.org
In-Reply-To: <asQo0Kb0SF0vZcHa@kernel.org>
References: <asQo0Kb0SF0vZcHa@kernel.org>
X-PR-Tracked-List-Id: <linux-integrity.vger.kernel.org>
X-PR-Tracked-Message-Id: <asQo0Kb0SF0vZcHa@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-v7.3-rc7
X-PR-Tracked-Commit-Id: dd3ea3fcba7c75493760cdbccd35f029597e8d5e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2c3418fffa9d037b2038a6db48be63f9e2291806
Message-Id: <179125587434.1990513.5785468216551584632.pr-tracker-bot@kernel.org>
Date: Tue, 06 Oct 2026 03:04:34 +0000
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 6 Oct 2026 01:46:40 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-v7.3-rc7

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2c3418fffa9d037b2038a6db48be63f9e2291806

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
