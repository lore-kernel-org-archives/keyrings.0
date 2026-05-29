Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8C23630BF;
	Fri, 29 May 2026 22:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780093991; cv=none; b=e6M/MCMJjMvosnKCwK4ZUL515HUD3YKCBcZ4CD/k9KO+qmww2Pb6srD1FT0KFhzrlLLrIvMlajX0Ubc5ntd3dCTuPOPsL64avaQ2CUEcTfAYMbmM66j8CvvrtJfM4gpWhOO7wuxRwNFvk6HkKIiAhycfYYy1f64wKdB2QkaYxHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780093991; c=relaxed/simple;
	bh=BMJTQbmjtk56nbc5+Uf9UPPM8WVufIXj5mJ052tqzM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OlJPqYeNRO7sxPxjEPU6a6hB7jYxuPkskmLAy6SdnkkjVumUK15jrQASiisNxrNfIoI1Ls85UU9yzmICGgNO7b/vwN3eKHQ7AGaCm4OtcCVqmXqOvMjr9Jhfdzjcx7iQvkXsKxDiSBidpXqkBbNgm0X+ZjJXQ+KTgzgsb5gXVeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NgMsLZB7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NgMsLZB7"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 808CF1F00893;
	Fri, 29 May 2026 22:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780093990;
	bh=kjpDzPjEODq7Ts9oiQp8TP0Hsn5YrdFOZnqRGmiIHrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NgMsLZB7khjmOWa3syHZ2cVMOcLaJ9WoyuzMvt3jYpS6BOfWpPUB4egVbL73lexFP
	 3z3lx4++4XB+6IlFj9tDXaDI9IIpHNOpS/Xyos+RnPXQHQMyE9r8yEiUozgAkxOWml
	 qDwRiLGwT8PrtGPVpzhHB0apfuIIFEdypXQVWNfPL+5PhlzpNKQlD48JttJH2cSu37
	 rdsgtfbjTUZC2qBd9AKiMKaVe1rOnDnmvpEvPkf8YtwFHEjmbnJOTSAVi9xbJZ02rE
	 NcP5vWi+/NLtMoiGJwD2sruzGn30Q42+Z7nWTWm43jQtv5GqShYURH/Oxo9mWQhT5l
	 jaeXmOUJIc2Ug==
Date: Sat, 30 May 2026 01:33:06 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org,
	Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>,
	Arun Menon <armenon@redhat.com>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	Alec Brown <alec.r.brown@oracle.com>,
	Ross Philipson <ross.philipson@gmail.com>,
	Stefan Berger <stefanb@linux.ibm.com>,
	Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] tpm-buf: memory-safe allocations
Message-ID: <ahoUItv3BMEYT0oM@kernel.org>
References: <20260522013555.1063716-1-jarkko@kernel.org>
 <33b4a34ceea0934e238c08e0256b975511ef99c8.camel@HansenPartnership.com>
 <ahVRefyT4BTKOu0m@kernel.org>
 <27db53d88a44e057c2f0ed5a637f65e4e18c8c3d.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <27db53d88a44e057c2f0ed5a637f65e4e18c8c3d.camel@HansenPartnership.com>

On Fri, May 29, 2026 at 10:08:52AM -0400, James Bottomley wrote:
> On Tue, 2026-05-26 at 10:53 +0300, Jarkko Sakkinen wrote:
> > On Mon, May 25, 2026 at 01:50:51PM -0400, James Bottomley wrote:
> > > On Fri, 2026-05-22 at 04:35 +0300, Jarkko Sakkinen wrote:
> > > > Decouple kzalloc from buffer creation, so that a managed
> > > > allocation
> > > > can be
> > > > used:
> > > > 
> > > > 	struct tpm_buf *buf __free(kfree) buf =
> > > > kzalloc(TPM_BUFSIZE,
> > > > 						GFP_KERNEL);
> > > > 	if (!buf)
> > > > 		return -ENOMEM;
> > > > 
> > > > 	tpm_buf_init(buf, TPM_BUFSIZE);
> > > > 
> > > > Alternatively, stack allocations are also possible:
> > > > 
> > > > 	u8 buf_data[512];
> > > > 	struct tpm_buf *buf = (struct tpm_buf *)buf_data;
> > > > 	tpm_buf_init(buf, sizeof(buf_data));
> > > 
> > > This isn't really a good idea from a security point of view.
> > >  Remember the buffer has to be big enough for both the sent and the
> > > received data.  Today we simply set TPM_BUFSIZE to the maximum
> > > amount a TPM requires and all the send and receives just work.  If
> > > we let callers set this size, we're asking for them to get it wrong
> > > (or at least forget about the receive part) and for us to get a DMA
> > > overrun from the TPM ... which might be potentially exploitable
> > > depending on how it occurs (think of an unseal of user chosen data
> > > overrunning).
> > 
> > It's one patch so you're free to remark the call sites where this
> > happens. This is not a majorn concern at all.
> 
> Nearly twenty years ago, when the kernel was a lot smaller, a then
> kernel luminary called Rusty Russell realized we needed to pay much
> more attention to how we design APIs inside the kernel if we wanted it
> to grow successfully.  He published his initial thoughts and gave talks
> at both the kernel summit and OLS on it:
> 
> https://ozlabs.org/~rusty/index.cgi/tech/2008-03-18.html
> 
> The key point that's always stuck with me is "hard to misuse beats easy
> to use". Later he came up with a rating scale (now known as the Rusty
> API classification):
> 
> https://ozlabs.org/~rusty/index.cgi/tech/2008-03-30.html
> 
> and for chuckles and grins on April fools day he came up with a
> negative rating ridiculing some of our dafter API choices:
> 
> https://ozlabs.org/~rusty/index.cgi/tech/2008-04-01.html
> 
> The point for this patch set is that the sizing of the original tpm_buf
> interface scores 10/10 on the Rusty scale (it's impossible to get
> wrong).  Simply threading size through the whole API, as this patch
> does, may look like the right answer, but it causes a massive reduction
> in API score.  In fact, since the buffer has to be sized not only
> according to what goes in, but also what gets returned and this is
> nowhere mentioned in the new documentation it scores -3 (read the
> documentation and you can still get it wrong).  Now by mentioning the
> sizing problems in the doc, you can probably get it up to +3 (read the
> documentation and you'll get it right) but my question was not if you
> got it wrong somewhere in the patch but whether we couldn't do a whole
> lot better in terms of API score by designing a better API.
> 
> A key point about the 185 version of the TPM spec is that it's really
> only a few commands that need larger buffers (the Post Quantum ML-KEM
> keys) which doesn't apply to most of the in-kernel TPM callsites. 
> Since tpm_buf_init takes the ordinal, we can actually tell at runtime
> (or compile time if the ordinal is a constant) if the command would
> need a larger buffer.  We can also tell from the TPM properties whether
> the TPM itself can take a larger buffer, so for every current TPM we
> could retain the original score 10/10 API and warn at runtime if there
> might be a problem.  Then the larger keys seem to fit into 8k, so we
> could still retain most of the original API properties of being
> difficult to misuse simply by having an 8k size flag (which we could
> ignore if the TPM doesn't support it) and warn at runtime if
> tpm_buf_init sends an ordinal which might need a larger buffer.  At
> worst we should be able to get to an API which scores 5/10 (do it right
> or it will break at runtime).
> 
> Regards,
> 
> James

This patch has pre-existed long before any of this post-quantum stuff,
and there are good reasons so to have buffers managed given e.g., 
complexity of tpm2-sessions code. It prevents any major risk for
memory leaks.

Trenchboot extends the use buffers to early boot and we want a robust
structure. I'm not going to spend my time reading about philosophical
aspects of API design. There are quantitative reasons to decrease
the risk of memory leaks.

BR, Jarkko
