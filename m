Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC0837883E;
	Tue,  1 Sep 2026 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282211; cv=none; b=BNIeyr5kebg+svO/JcstcbZ51EBmCvDq4woyiO8d1JamLBHdQNZ2eC54tOuGS84HieyXglz7P5V86ABuSv4j4lGWGZxT5VvJEzkLPX8o7EwUu4eVK7UlPuPcUiXmUN1Y2ZroWe+EREQxYUObIs6CXaXPYJbVO6hs0TCI2nZd/dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282211; c=relaxed/simple;
	bh=clyhNJ5ys6AGj4exC8GBbbxbr4oPTQNSXXoSwrBy9B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3Tr97xY0ISAzSj1TQNc/bUxLa9Pi6+PQoaQZQ8cnpTTsYkVYjLRW6Lw/kgjrRIQZO29su45Vt//DT8M7lezUwFCrnyXg/Z92JTWJ9rkC4M934t78m0Vju+0Pl04MEpgY3p3EyFXSyi98z7wffPwjrZQj00c7Io0WeDQ0kzzdm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZ/QG4fd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ/QG4fd"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 891D61F000E9;
	Tue,  1 Sep 2026 17:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282210;
	bh=mMBaEIM6VBR1QxnR1jC0Z0I7a31saztKbmWgDYCjBXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UZ/QG4fdx23ThIjvvURi9Mo2O4Itohh9pwIk94N7kjjdnXI2v+nT4Z23Ps2dyR50A
	 6F+UeS8x7X0026Hrvm4bU9LMUeeKve5/XaGeAvhgWjT3P/NtETCiERH//e10FyDSLW
	 J+3qFDKYxD9eCqh4fFLLKK8H4pbWvMfYCMxwmDxP0xWeXA2Mh3NLbjWVKBIOB2BPS8
	 fTiXwNey8KHN5uZZmcTGaxRN8uWFb83arqhu0mdS/MEaLiqHgf8zmLEySZJMIzxrIf
	 8klCDMCZAGxhi0d2Rp0SQkpwzagbTlXho/90N4ZITsBU/yPNnKKBsAkCiVwtE7KRz0
	 b81Ur+LZ2D3Dw==
Date: Tue, 1 Sep 2026 20:03:26 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: set persistent keyring timeout before destination
 linking
Message-ID: <apcFXsSiZ9WA8E67@kernel.org>
References: <bb0370340c671.1788111790.git.kmehltretter@gmail.com>
 <apbTc9BisLTqBaE_@kernel.org>
 <apb5_kMgDxSIviWb@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apb5_kMgDxSIviWb@gmail.com>

On Tue, Sep 01, 2026 at 06:16:12PM +0200, Karl Mehltretter wrote:
> On Tue, Sep 01, 2026 at 04:30:27PM +0100, Jarkko Sakkinen wrote:
> > > Tested with QEMU 10.2.1 TCG. The reproducer set
> > > /proc/sys/kernel/keys/persistent_keyring_expiry to 60 seconds, restricted
> > > the destination with KEYCTL_RESTRICT_KEYRING, and then called
> > > KEYCTL_GET_PERSISTENT. No LSM policy was loaded.
> > > 
> > >                       syscall result  /proc/keys expiry
> > >   i386 baseline       -EPERM          perm
> > >   i386 patched        -EPERM          1m
> > >   x86_64 patched      -EPERM          1m
> > > 
> > > Full kernel builds completed for i386 and ARM926, and for x86_64 with
> > > CONFIG_PROVE_LOCKING=y. The x86_64 reproducer completed without lockdep
> > > reports, warnings, or bugs.
> > 
> > Please describe this in the commit message and delete most of
> > the text it has. This is the motivation part.
> 
> Got it, thanks. I'll shorten commit message.
> 
> I also found a narrow race if linking is delayed past expiry and GC runs.
> It is unlikely in practice, but reproducible with an injected delay, so
> I'll address it in v2.
> 

Yeah, I mean what say there is not secret as it is here already.

So better to document the relevant data to commit message. That is
what is useful for me as a maintainer fast-forward to the future.

While writing a commit message think more what makes sense to backtrack
in the future rather than writing a tutorial ;-)

> Thanks,
> Karl

BR, Jarkko
