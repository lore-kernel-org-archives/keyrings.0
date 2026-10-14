Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D357F3002C8;
	Wed, 14 Oct 2026 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791994268; cv=none; b=mDTH0jWsIoaEzOgG/2TMiwGYpqns/fC2nk58LQhJhCpHx0Tk6p3yj6jb4w9Xnp6Fg4apycu9nW2O32vMk68RAQbGT83PWXFqVrGM44J9RCHp5+O8lexiXQfQbss8CGhS11aAViduvg0W66Pj582baDwUtLZJ9w7zFLGDba2AlJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791994268; c=relaxed/simple;
	bh=v0NhpUhMSqrvLLPOALAIgu0MNTPIf/RfIokKvbHjXBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lU+tZ3wQWIN7GoYfVEYCEqDowt8j5pykuominTmzRPH00GVBTjlvfG4lcGcR5i8CrYpMx1cgeDSrtyt/AAWg4DvLqduczve8/+ZBKGNkdDcGgfy4zCWfj29kq3PvkU/deKfrcUNaLSWdzHWgDXUvUqwdzP4ER9CSbf0u0VQQT+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NyngLFQ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NyngLFQ1"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CD4E81F000C4;
	Wed, 14 Oct 2026 16:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791994265;
	bh=VEWvC+r/z9vEd4FgfXLCYSC+BNajrvmQfh7OxCDJTXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NyngLFQ1w64cw8idojxNlWIrWXxuaG0peMdrxZ4QZ8gKmtjpsWUouycJISjMJgfbp
	 lnzorwE3mDG3K3hxbt+eIgVsQPWVc8o27o00kY//RQ868wCdiK/tndg3Cfrne6U6RO
	 HxLD2fEXNz+U0GZpEMDOx0jLjCcuFTL327ytWQZ4Ze86urDerzUyUbo9BTwkqdwQ2i
	 OH6zmBjKStGscGjMSqHLDARWTP1HrxIE5iCASCWmhzdMpeP+D1qci4pK2Pfr8ppcxZ
	 FFKjS5sRy/n957vUh5mTSXvP1HFjoZ+7GlOzoHovuMRDbEs8Qf9JzAO6smk0RDXbHE
	 TQHuPeA1MBqSw==
Date: Wed, 14 Oct 2026 19:11:01 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Kyle Zeng <kylebot@openai.com>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, dhowells@redhat.com
Subject: Re: [PATCH v2] keys: make keyring indexes independent of kernel
 addresses
Message-ID: <as-plb31O6Lioa1C@kernel.org>
References: <20261013231251.56170-1-kylebot@openai.com>
 <as941m0HXNruztLc@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as941m0HXNruztLc@kernel.org>

On Wed, Oct 14, 2026 at 03:43:06PM +0300, Jarkko Sakkinen wrote:
> On Tue, Oct 13, 2026 at 04:12:51PM -0700, Kyle Zeng wrote:
> > KEYCTL_READ returns the serial numbers in a keyring in associative-array
> > traversal order.  The first word of the index is a public, deterministic
> > hash of the type pointer, domain pointer and description.  An unprivileged
> > user can therefore insert keys with known descriptions, predict their
> > order for each possible KASLR slide, and recover the kernel image address.
> > On an x86-64 build with 16 MiB alignment, 45 user keys suffice to
> > distinguish the candidate slides.
> > 
> > Remove the addresses from the whole index, not just its first hash word.
> > Assign each key type and domain a nonzero 64-bit ID and hash those IDs and
> > the description with a once-initialized SipHash key.  Use the full IDs in
> > the later index chunks as well.  Truncating or hashing the IDs there would
> > lose the guarantee that distinct type/domain/description tuples have a
> > differing index bit.
> > 
> > Allocate IDs lazily since private key types need not be registered.  Cache
> > them in the index key so tree walks and copies of an existing index do not
> > need to dereference a type descriptor that may have been unregistered.
> > Keep the 32-bit chunk layout and diff_objects() bit offsets consistent,
> > and retain the separate root slot for keyrings used by recursive search.
> > The key comparison, permissions and userspace data format are unchanged;
> > only the address-dependent in-memory ordering is replaced.
> > 
> > Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> > Assisted-by: Codex:gpt-6-astra
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> I'll apply this.

Now I did it, and your patch is now in my master branch (not yet -next,
will get there). Thank you.

It took a while because kunit test for assoc-array took almost the whole
day [1] (mainly figuring out test data that is not too much pain
to recap later on that replaced lottery I originally had).

[1] https://lore.kernel.org/keyrings/20261014160144.1835860-1-jarkko@kernel.org/T/#u

Br, Jarkko
