Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048A2231836;
	Mon,  5 Oct 2026 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791226007; cv=none; b=GoEbMqcFEOwt//wVPBZooV5XN/UJ6ewfDjC9BarHS1GSL8hVNPVcyXYo2ncG7KL6pm4ykYCGzA3LB6tG0SIQzoO86mOfwC/eSZ6U5EzoLc6qoMuDEqDKGbLmvhIBYS+4h0PTFD6KKqQS7J+i2EooaIxXCsp8T5sUU7Jx0Gxa720=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791226007; c=relaxed/simple;
	bh=wqjCpQ9tSSLEKp5371BkODsWqpE5DeMuYFrXGKs0wNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3teX+kiVGEfqm8w56qKLo8cMTOHYyl7PuDPeAvvcx0tRgCascufXaJaXqiMUfuQx73dP2BioR73Cb4ukDrPHdRct49mNmAkGWge4Mm2fyv2ocbj0F5ti5nvTKinvzWXKcPYroFvLUBFea3RAzh27bLObgWOpA/fY5/wz/Mo9E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jkd0x2dt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jkd0x2dt"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0A7591F000FF;
	Mon,  5 Oct 2026 18:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791226005;
	bh=6KzADS7/m3KFsPRgHOCgcxV+LvShi+KqALtytnCQ19g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jkd0x2dtjOdKrhjyzYLdIPfJmBloXnKxqzzcXdB2YPP93Qo1EJ61qacmNzn1Qwpcp
	 ChMZmyGgR6LG9t20fsFMXgfu5Ivb4ZRHRgzE+qaJdhCs8hD35Pn+03ZMKB6qNpE2RM
	 +1j3olgy1TxhRkEIrRLYs3Ssfxj3u1Bw6tJHwHXYiPGrQMi8UZpwu8Eiwbi5iCrNOq
	 uEXXucPIULaQ7cMrTtShiPYBj6BNoglurWwnhbYaxpabfaHCUPWk86ODzhfzhb/aM5
	 T11oLZqhSJjCp8WYGRkz1vXyko5+YyA4pI7m5jquizUoPigQBmDL4voRfGEs4gqqEW
	 HOJF2mhN2IJmA==
Date: Mon, 5 Oct 2026 21:46:41 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: keyrings@vger.kernel.org, Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH 0/2] keys: Address lookup_user_key() mutability
Message-ID: <asPwkdi7ZdO4YoRu@kernel.org>
References: <20260924055521.1981957-1-jarkko@kernel.org>
 <asKSvjz2YLZhFI4t@kernel.org>
 <asOhhCION3dwTAo+@hallyn.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asOhhCION3dwTAo+@hallyn.com>

On Mon, Oct 05, 2026 at 08:09:24AM -0500, Serge E. Hallyn wrote:
> On Sun, Oct 04, 2026 at 08:54:06PM +0300, Jarkko Sakkinen wrote:
> > On Thu, Sep 24, 2026 at 08:55:16AM +0300, Jarkko Sakkinen wrote:
> > > The main objective in these patches is to remove to unneeded mutability
> > > from key look ups. It does harm and brings no value so it is pretty obvious
> > > to me that addressing this harmful behaviour is what we should do.
> > > 
> > > I based the first patch on what Jann suggested in [1]. Nothing too clever here
> > > and I'm ofc open for further suggestions.
> > > 
> > > [1] https://lore.kernel.org/keyrings/CAG48ez0XjVSR=M--UBauTm8sJuc+ZbhKzaPa3a6wrSVHyoKevw@mail.gmail.com/
> > > 
> > > Jarkko Sakkinen (2):
> > >   keys: Return user session keyring on lookup
> > >   keys: Reject keyring creation with overridden credentials
> > > 
> > >  Documentation/security/keys/core.rst |  7 ++-
> > >  security/keys/process_keys.c         | 65 +++++++++++++++-------------
> > >  2 files changed, 40 insertions(+), 32 deletions(-)
> > > 
> > > --
> > > 2.47.3
> > > 
> > 
> > So.. should I move forward to with non-RFC v2?
> 
> Patch 2 absolutely makes sense, "doc, it hurts when I do this", "don't do
> that then."
> 
> Regarding patch 1, that seems like quite a change in behavior, right?  I
> don't see any docs or comments that promise the current behavior, but
> has any userspace or subsystem come to depend on it?  I guess that, if so,
> then it just has to create a link to the user session keyring like pam
> (according to what I've read) does?

Thanks a lot of responding.

I fully agree with you but I'd need help for evaluating things further.

1/2 based on Jann's email about the topic and my interpretation of the
suggestion. I neither used brains nor AI for this and consider the patch
merely as a conversation starter (and what a great success it was on doing
that) :-)

All feedback is good feedback at this point. I need supporting code to
remember/recall later on so at least this serves that purpose.

Br, Jarkko
