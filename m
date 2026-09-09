Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C88396D03;
	Wed,  9 Sep 2026 21:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988678; cv=none; b=ftpF7fbGcfoHBwgP9B6hTo0C5p1N/03L6IfZLrF6Vpmnft12zkVlKToziDyXEo/Xl70dkroPJWj5iq0SoLaarx/6/b5eOTKwWWkdIeN4mP8q5ird5ML3EKzZLQ8zljovPbucjv2XNaRkSeLLJyXkGh2LvyTHTu5IBBIcuuXci1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988678; c=relaxed/simple;
	bh=cl5ibjokb5GY4hVPhX+zvH8b69OUWrnsGTCPiFv+LQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ayN7EBMKE9oPwZIYAbMLUdnVOUr8ECobpyVBifZ0sN9zLxwCXBhiFWT9Q9GIuoEPm/NAoO7fQ8IR/VV7yvoS2YGbWU35bUxrCCchew4ZfbI0ryQul0mdohZd0JuCG0PxWut3VuOsoTD6O/ntyvK5ITBD7gdxDl42OPZ+Uqo0ZxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8DtBw6j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8DtBw6j"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2A86F1F00893;
	Wed,  9 Sep 2026 21:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788988676;
	bh=grn2lPkVoCYf7LoGi2oTY6E6qQ2YEkrH/5E/pEvcJO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f8DtBw6j/VnOF+W/mSgqCrniuaeAAUuQPtll5SyTdqbsFAPjDIRji4p0YsvUCP7S7
	 2cHPlJ1tCLThU7Fqolk1AANmwFkAltrY637ta6zVXa9qLZHOo6kiafk8QjmVSobqQy
	 F5pt1ugvQd3BdA0+C1T6ytUjX2sq9ucDVammOTDiV2g5fu8cWjNWyoKz3AmmqBySLu
	 029aS0twoFjeeeOtW27kF7PxMBhBewf/ieamvWi86rhFdVUAIx0PflhOJmmhDZ+i0b
	 PfRqK5kFwS2KAmDB0yX7X743P9uAFewSxQSD5oOffRBLeQwsuycBaYAcbgq/b3oVyv
	 7aDMgaT03kyMg==
Date: Thu, 10 Sep 2026 00:17:52 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] keys: finalize persistent keyring timeout after link
 attempt
Message-ID: <aqHNAKKsc8yD_pgm@kernel.org>
References: <20260901191743.39210-1-kmehltretter@gmail.com>
 <apdZKMddhZoASXmL@kernel.org>
 <aphkt2PpqUFcTvun@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aphkt2PpqUFcTvun@gmail.com>

On Wed, Sep 02, 2026 at 08:04:30PM +0200, Karl Mehltretter wrote:
> On Wed, Sep 02, 2026 at 02:00:56AM +0100, Jarkko Sakkinen wrote:
> > > +		*persistent_ref = find_key_to_update(reg_ref, index_key);
> > > +		if (*persistent_ref)
> > > +			return 1;
> > 
> > I'd return -ENOENT here instead and not make return value tristate.
> > 
> 
> I don't think using an error to mean "found" is safe. keyring_alloc()
> can return -ENOENT through security_key_alloc(). A BPF LSM key_alloc
> hook can return any errno.
> 
> I checked this in QEMU with a BPF LSM hook returning -ENOENT.
> keyring_alloc(".persistent_register") returned -ENOENT and
> KEYCTL_GET_PERSISTENT failed with ENOENT.
> 
> So -ENOENT would be ambiguous. I also considered +EEXIST instead of 1,
> but that seems a bit too clever. I'd rather keep 0/1/<0.

Fair enough.

Let's tweak documentation then:

 * Return 0 if a keyring was created, 1 if an existing keyring was found, or a
 * negative error.  On a nonnegative return, persistent_ref holds a reference
 * to the keyring.

How about being here a bit less convoluted and replace the text with:

 * Returns a boolean value on success case, which tell whether a new
 * keyring was created or not.

This is imho quite well in the ballpark with detail/clarity.


> 
> Thanks,
> Karl

BR, Jarkko
