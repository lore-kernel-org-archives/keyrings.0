Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF27C9443;
	Sun, 19 Apr 2026 21:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776634688; cv=none; b=YgGjzTU8SMSrsFaTPAGXxchrDI6qSJBb7Xq/64IT9JlBS1GtBevIRatu51x2zYHFnafZAMgKBFmnbNKP8U5H8Bt7sMcvKtMWVyQTiCxNdNHevGNMDa5SzAGnMgV0immajW8s20xLpMY805qXnVKjBoObvLLmlqIvGPRTc1QwBWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776634688; c=relaxed/simple;
	bh=lphXXtf4rMOiVev+LwdAu2WmAPwNIvseLtw00SxPHCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuBckS9DR1bwED+86NOMfa6FS40tv0EnDgDtdHzsfSNdpBoguuSFUiQ+9hl877kfTd6URn6XtGx2HrEsU2AwAVCQbU1idasu90vQ7ZyXuvaijh6SFjyFC6rw5BpT57RvgiEDX41bMRPWeG/HlfcNiHf4LxbgSuOR2nqWKzVQlcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVP8gQJH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVP8gQJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05608C2BCAF;
	Sun, 19 Apr 2026 21:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776634688;
	bh=lphXXtf4rMOiVev+LwdAu2WmAPwNIvseLtw00SxPHCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lVP8gQJHvizrBx8LmgjPdJ5pwWotbewZSMzFkiLFrHz+cLlJTGa37zv+UwqI7en2Y
	 bdyd0ejq/+KV0ucd7jajMtCGMSu8b3dIJB6FJ/dxyBcJkIAZmTEYchY5ZesCU2CNgN
	 S5mqtZkiC9LfJSpbGV9bigOcU6d86R11UyfaOTKkLu9oPyTaRtiiUlBg36NIzNBMPF
	 i1zEco6APh2rBfHEPcr95RtLSMgWsaGGLmUoexa9MdHWj3AbKNMgNkujtBLMUjACuS
	 weQpCvo7kC1/luE1TOLzeQLXT8qsJDB21Xf9OOaLnuoBs5o+Z1CdYU21qnWxE3VGo7
	 NrMx0vbhJ/ejw==
Date: Mon, 20 Apr 2026 00:38:04 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [GIT PULL] KEYS: keys-next-7.1-rc1
Message-ID: <aeVLPLa8JDLIEgDR@kernel.org>
References: <aeTLzOgblMZRnDvF@kernel.org>
 <CAHk-=whjUfVy22QCcsCS2h8AkJVpQBjHyVW4_hKXpUxHn9S65w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whjUfVy22QCcsCS2h8AkJVpQBjHyVW4_hKXpUxHn9S65w@mail.gmail.com>

On Sun, Apr 19, 2026 at 08:43:20AM -0700, Linus Torvalds wrote:
> This too appears to have been rebased just minutes before sending the email
> 
> No.
> 
> That counts as "zero testing" when you don't even explain why it happened.
> 
>                 Linus


I tested both PRs for the same baseline with two separate buildroot builds of

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd-test.git

The only last minute changes after testing I can recall were updating
stable cc tags for TPM patches.

For the last minute patches I applied from Jacqueline I've tested their
earlier version, and the patches I applied were just addressing
checkpatch.pl --strict issues.

Granted not very explained so I get where you're coming from. So how to
move forward?

BR, Jarkko
