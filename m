Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833023B5837;
	Fri,  2 Oct 2026 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790982148; cv=none; b=A+I8nESGaxxY5xwhxQDzTs3n4jLDOzOJX4zlt6FCDtAgKIkM7AppUdIQWCbPtvyjqeDyBrxZA3UnNJPmTGP8P34wdg8ImpNQsFwxh7LM4BdHJd0XnebVoL8CDi1EFAmf9Co+t07ei4NRVav8Wq5zBKSWVpn5GcFinM/aj/kp4N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790982148; c=relaxed/simple;
	bh=CDPAZWuIdj8ZaOf7KeaFjUL9Xy7OhSX+pUmQQ7bVSu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Of4HUnnPoISA0XqGFxupiAZA9rdgWhAHwiglnEi2djsfsoRAxFtfAOoSXwBbcpF5t9kJgRkwB0+DqWTSYfyejqAvRCqtvjfd0zk1KOitxRlGbCMn4FiZpXSAmmIetJSDcw8eRjYuNfaVFrAprQWPsob9c2ySDYtvxvxK/KpY4x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgnTgpM/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgnTgpM/"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9BB1E1F000FF;
	Fri,  2 Oct 2026 23:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790982147;
	bh=2bPcJ1Vj8h7H8XnZ0ivuQvN1htMPEcW/dLYM4Htgp5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cgnTgpM/kS7Nbx22UEUHqd5lcEz7b/smakh7FJslcgsz4RkBoIYkqfseT0SMSaR6s
	 LPxggm7TrmRjkOkbB673kDEGKRsG6Ix0hTKnhrZt1lczoL2iHm9265DeU/BUW5Y0TE
	 SzoUmMVo3rXC+ueQr2kbAx3ELeX/YhYPQ4Q3fUZA+5QZL+0vp8BrMZ+gvAP6ONyN6C
	 zGN8+bLORDsMuELHiZA2EGDjhwLHkzZQVw79N+pFLUC4Ai2evz954INxoMJzHo42pe
	 750tdYvXn+SNzt21Kgf4/qxTheoqaA7KGsRp1A70zsmzYj5mOZv+WoylT4cZfM1eRL
	 FVPWU0gwFbAWg==
Date: Sat, 3 Oct 2026 02:02:23 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] TPM DEVICE DRIVER: for-next-tpm-v7.3-rc6
Message-ID: <asA3_3lVVcm-v9F_@kernel.org>
References: <ar9D-mM-KA9P_pJC@kernel.org>
 <CAHk-=wjeUnds=_XoHpuPt2A0ZefYC4RUvOp0=LfPR2jzQFaeLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjeUnds=_XoHpuPt2A0ZefYC4RUvOp0=LfPR2jzQFaeLQ@mail.gmail.com>

On Fri, Oct 02, 2026 at 09:10:45AM -0700, Linus Torvalds wrote:
> On Thu, 1 Oct 2026 at 22:41, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > Please pull these bug fixes, which have landed after v7.3-rc1.
> 
> Jarkko, I've asked you before: please write an explanation for your
> pull requests.
> 
> "Please pull" is not a reason to pull. The "which landed after
> v7.3-rc1" is also not talking about what they do.
> 
> The tag contains three lines of text, and none of those lines are in
> the least helpful or relevant to the contents of the pull.

I do remember that you've said about this a few times. 

> 
> It doesn't have to be much. For simple driver fixes it can sometimes
> be as trivial as just "Misc trivial fixes". But in this case it
> clearly could have been something like "Fix tpm error handling and
> buffer size bugs". Merge messages and pull requests  don't need the
> _details_ - those are in the individual commits - but they should have
> a high-level "what happened" overview.

I meditated for a while before answering.

It's best to not do what I've done or try to fix it. Nothing works;
neither me nor the process...

I'll start faithfully writing cover letters progressively on side
while reviewing. That resolves about 75% of "what words to use"
and that type of stuff.

I mean I'm also right now zeroing my hard effort from code reviews
by not writing down the facts when they are still are fresh.

> 
> And this pull request is actively hard to parse. The subject line says
> "for-next". So I have to look at an email that is actively *trying* to
> make it hard for me to decide whether I should pull and gives me *no*
> information at all about what it contains.

I'll change it to:

"[GIT PULL] TPM DEVICE DRIVER changes for vX.Y.Z-rcW"

> 
> Be better. Please.
> 
>                 LInus

I'll do exactly what said above I will do, which I hope will equal to
that :-)

Br, Jarkko
