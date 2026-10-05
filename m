Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BE941686D;
	Mon,  5 Oct 2026 21:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791237483; cv=none; b=kYbftIbO6iseXg/QWww9A6CFU6gMwXqJgiWJL+Phrg9mpuzSCEkHWCyknUOEyNKT3BSM6VWPl5sT+wkNeiVeN90xsLLKJsldV97EJzIYs1Sg6hSKSjT3/zaTq8+WuDH14rS4TxBYCYCP0rLsSJkMysVnThoyxpRGtCf9MTAVaSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791237483; c=relaxed/simple;
	bh=Ngu7pFS9me7r3yO67Mb5zTZZsWCa5i1XJEM4FdzCFsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C78a3iNyA4E5De6yxlsroZds/k5aiGzPNd00u33mj4SWurBHIDR9jxYUsK2uhn06ROa0M8fEdbp3Mj0RulMkExr3hL/qqkROkXZPvsUKsjNj1hHPnDxbKWiONjsh+px4NzmLvgqQID8ZEJ5sJUgTzXL8vaHxflhq5isQZyhpEH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGNX29Dz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGNX29Dz"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DACCF1F000FF;
	Mon,  5 Oct 2026 21:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791237482;
	bh=VxFHdG+ifOnGOH6o1Tq0HY7/CGw/vCWQt90vVvSA//c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EGNX29DzcKQGFBd0mlRZuELLXdpyE8pkJeDv9rc9TwiKULgMm9bxcdjcWJO3106DC
	 74TIcWJzRCBk4sapr9W8MM7rXxhB6VcWHWgyRvPAVReS/5kEDFffGKW08shDtwSOVk
	 p2tJZyTFM34HWtSZMWs3HxnEP5S2sKfVkpfFkC/EltnoM/hJvZgNo69PNE3ZE1kHkV
	 RKEN8+GA0b1dxi+3IpaQ7qrsaMRw8aQyMJz6ec9bCSae0mZ+kcAx/YejiGusr7tZ+X
	 7+u2pwpPfEHS5Qb0pwnaubu98O62kqF/9+JvZCw7b3OMFknmUR8iR2BqBD7Ra/AncN
	 GIVMR/pOL6HFg==
Date: Tue, 6 Oct 2026 00:57:58 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Srish Srinivasan <ssrish@linux.ibm.com>,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	stefanb@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
	rnsastry@linux.ibm.com
Subject: Re: [PATCH v2] keys/trusted_keys: reuse TPM version in option
 handling
Message-ID: <asQdZiv7uktfyRWU@kernel.org>
References: <20261002071050.179879-1-ssrish@linux.ibm.com>
 <asMYa0lD7RNcoszb@iki.fi>
 <d3574d84-84dd-4aa5-b80f-acc7844c3f12@linux.ibm.com>
 <asO7zHFE3C6W8TV/@hallyn.com>
 <asP8sl912TVaCEIE@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asP8sl912TVaCEIE@kernel.org>

On Mon, Oct 05, 2026 at 10:38:32PM +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 05, 2026 at 10:01:32AM -0500, Serge E. Hallyn wrote:
> > On Mon, Oct 05, 2026 at 11:31:46AM +0530, Srish Srinivasan wrote:
> > > Hi Jarkko,
> > > 
> > > On 10/5/26 8:54 AM, Jarkko Sakkinen wrote:
> > > > On Fri, Oct 02, 2026 at 12:40:50PM +0530, Srish Srinivasan wrote:
> > > > > Determine the TPM version once in the seal and unseal paths and reuse it
> > > > > when allocating and parsing trusted key options. This avoids redundant TPM
> > > > > version checks.
> > > > So this is a bit nitpicking perhaps but a patch that would just clean
> > > > the code up a bit would not be be worth of applying. Almost anything
> > > > that "does nothing" goes to that bin.
> > > > 
> > > > What I'm saying is that the conclusion in the last sentence goes to
> > > > wrong direction but luckily the change has also feasible effects that
> > > > we care about.
> > > > 
> > > > By caching tpm_is_tpm2() there are less fallible sites in the key
> > > > creation process, and reduced number of roundtrips with the TPM chip.
> > > > 
> > > > Or from blackbox perspective it reduces I/O traffic between kernel
> > > > and the hardware platform.
> > > 
> > > 
> > > Yes, that makes sense. Thank you for pointing this out.
> > > 
> > > I will revise the commit message to highlight the reduced failure
> > > surface and I/O between the kernel and the TPM, and
> > > send v3.
> > 
> > And I've seen chips where every round trip is a roll of the dice as
> > to whether the chip will become useless till next reboot, so that is
> > a bigger win than I was first thinking.
> 
> This is true and happens quite often. And in CPU companies in fact all
> the time with early FPGA implementations and very early ASIC based
> software development platforms.
> 
> We also have opt-in bus encryption feature where extra roundtrips have
> a horrible time cost.
> 
> Roundtrip removals are high value patches for both R&D and production,
> and they are always most welcome.

Serge, your comment reminded me of hwrng. In my opinion TPM driver
should limit itself randomness supply because it could have positive
effect on some issues that people are having [1]. hwrng can never
properly control TPM as it is behind abstraction.

I think there should be a tpm_chip associated pool of randomness. This
pool is filled with some timer triggering with a constant frequency. On
each iteration, it is filled with best effort i.e. with a single
TPM2_GetRandom invocation.

Then hwrng_fill is also filled with best effort from the pool without
any TPM interaction.

This would be an architecture that would be vastly easier to deduce
than the one which we have now, which is more unstable, which is
bad considering e.g., latency peaks and whatnot.

This basic idea can be improved with a low watermark: when going 
below it hwrng_fillfn would start the timer. I don't think high
watermark is needed as pool can be always filled just up to its
size.

I had this idea already 3-4 years ago but had forgotten about it.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=217890

Br, Jarkkko
