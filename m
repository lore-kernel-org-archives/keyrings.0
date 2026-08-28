Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C48737F002;
	Fri, 28 Aug 2026 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939387; cv=none; b=Mb6nkI4X62U9aRsE7gGXRrQANCETPCF3eP/BMLSwr0FjNb8378nnVlMimsRM0vttjgRN8cc7bobqIh8T/9AmqQfjZ+TXqhLkCxYJ/QnzfCFHDlbchMhAkzmmuH9Ur7wK+WCk6ux1XDIzCxCdGA7fs98jWttotfCWkfKsJ5j0sWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939387; c=relaxed/simple;
	bh=ROLQ2DAzuicW+OuTwrELTBOb21wy49spbPSorYrIWvk=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=flzoNolGCVa5KW1umHEt9OcqYOSq3sE1ZQ2uxvZTj+e8UsbMYJ/0GY3sam749po/0jeoo05bDHysk+zkpHJ9/tLoDfeTkQ+Y45RqapIlx2z0tdig2TxYT9Gpp9Hav7Cgvm6/fkPXepeDRCMyoUwRsnDAcuriW330pgcN9j1nsp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiSkg42z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiSkg42z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EE71F000E9;
	Fri, 28 Aug 2026 17:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787939386;
	bh=QGvHVA48fsjCmxVUac5Tbl7FahHOvvPOIoWdumtwROY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=OiSkg42zuxSWunQiewATfHNrAbSWv48uEkCnvpGvEoeD4UxAV7AGGFNs+j6jjxwiG
	 NahG8N8v1uj+VP2nM3Y4tLPEydIlEwPO/4sdAndSzJ+xj/Oq/VYpaKEnH9YinAytUe
	 84akk5OvPhgEqMTQ2wQ+KM81z89Qy2ACgqINaHWb1jUZCZWSpkwGd8xecfoUJoe1Rs
	 nYbDStTXsU6s9bL9k5dDo/0LrTZOOptn7qaZYGgYd28L4xZ/qXwGYicG7xlu0jXu93
	 gdgTfgLnGxoaNJckdMxHuArznSng8G4yvXTkLpfbKhf414imvKG+AyeML6HeTpgTPC
	 tlei+ixcoWVGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939FB380AA67;
	Fri, 28 Aug 2026 17:48:52 +0000 (UTC)
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: for-next-tpm-7.3
From: pr-tracker-bot@kernel.org
In-Reply-To: <apCluywYWo97vyYr@kernel.org>
References: <apCluywYWo97vyYr@kernel.org>
X-PR-Tracked-List-Id: <keyrings.vger.kernel.org>
X-PR-Tracked-Message-Id: <apCluywYWo97vyYr@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-tpm-7.3
X-PR-Tracked-Commit-Id: 55ba91d4c54ab31ee8387bae40e799de467f8269
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: afe0579334f622c803f2864f22c04c20c320bd80
Message-Id: <178793933115.2708560.2385527122662363073.pr-tracker-bot@kernel.org>
Date: Fri, 28 Aug 2026 17:48:51 +0000
To: jarkko@kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, "Daniel P. Smith" <dpsmith@apertussolutions.com>, trenchboot-devel@googlegroups.com, Ross Philipson <ross.philipson@gmail.com>, x86@kernel.org
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Aug 2026 00:01:47 +0300:

> git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/for-next-tpm-7.3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/afe0579334f622c803f2864f22c04c20c320bd80

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
