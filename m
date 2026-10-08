Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876D44DDB37;
	Thu,  8 Oct 2026 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473173; cv=none; b=dN+viY+2OXDvhIG6+gHBi/xZ9jZjAUU7+ulrzA1jcGTGCIYwYn1dMIXaJSCuYctIaEi1A5h49pkkgdj7rMaxM5dCpu6PPoRiSIDICgiXn/a6FUPuZ/z3rSd9yBWLOss1kFShpupQkf8ALf5jet/vYp9652G+SJbcnLAa+ZhvxaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473173; c=relaxed/simple;
	bh=cDyuwEKK8sXGpAj3kWtZyNN+HaU08rNG0W1xctdiPug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InwyyYOQ8ZytumyQi30SqnNodGgs3ngItd3S3JtJdeitllY0AoqxoiaOWvoAjKytqap9VbW3CxpiSRXDMkh1gx9CEGgM3Ln1Om0gbTGq9srwmOkZ8tt57uRqbFwGFBEIBQgaHEhOdiB/Dm03fIGYQPMgBGBwH6P5L36rS1wkoPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=f9INlEzW; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="f9INlEzW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1791473148; bh=cDyuwEKK8sXGpAj3kWtZyNN+HaU08rNG0W1xctdiPug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f9INlEzWvRKdr/Fb3T5Ad0Gww3mff6qF274Hh6qjZDcgZoItXuJ/GPwrJbw9NrxCu
	 47STDsY6pWekjbCUBwrDFdx59pH6kr/RDs/RRMBMtHMZ+LoiWP16LYuBMFomx+Zmuw
	 QP7MhJyvW8BAm7eOcPYT2aZUbTGTbgtdzi86Kcm7lAljvdfM+SQWkdu7Cffkp6nlma
	 uhxKRDvTp1+6vN7KW2xZgC6y/Fk+nciX9qD3LMfa5sUL5ETmVj8kTCeatcIF1eBKFF
	 F5goSCrada9f7KvJar7ESKWMlbK3JPZwgXg/u1GAr41q2gPb3Kp0hmxegSZ5yAEqDx
	 A2JaIXt7uutfw==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id A5939196B; Thu,  8 Oct 2026 10:25:48 -0500 (CDT)
Date: Thu, 8 Oct 2026 10:25:48 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH 0/2] keys: Address lookup_user_key() mutability
Message-ID: <ase1/CnbnqL24SOQ@hallyn.com>
References: <20260924055521.1981957-1-jarkko@kernel.org>
 <asKSvjz2YLZhFI4t@kernel.org>
 <asOhhCION3dwTAo+@hallyn.com>
 <asPwkdi7ZdO4YoRu@kernel.org>
 <asVDbPtyCNy210-R@shallyn-amd>
 <aseoJvcBh0RZ31Uo@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aseoJvcBh0RZ31Uo@kernel.org>

On Thu, Oct 08, 2026 at 05:26:46PM +0300, Jarkko Sakkinen wrote:
> On Tue, Oct 06, 2026 at 01:52:28PM -0500, Serge Hallyn (AMD) wrote:
> > On Mon, Oct 05, 2026 at 09:46:41PM +0300, Jarkko Sakkinen wrote:
> > > On Mon, Oct 05, 2026 at 08:09:24AM -0500, Serge E. Hallyn wrote:
> > > > On Sun, Oct 04, 2026 at 08:54:06PM +0300, Jarkko Sakkinen wrote:
> > > > > On Thu, Sep 24, 2026 at 08:55:16AM +0300, Jarkko Sakkinen wrote:
> > > > > > The main objective in these patches is to remove to unneeded mutability
> > > > > > from key look ups. It does harm and brings no value so it is pretty obvious
> > > > > > to me that addressing this harmful behaviour is what we should do.
> > > > > > 
> > > > > > I based the first patch on what Jann suggested in [1]. Nothing too clever here
> > > > > > and I'm ofc open for further suggestions.
> > > > > > 
> > > > > > [1] https://lore.kernel.org/keyrings/CAG48ez0XjVSR=M--UBauTm8sJuc+ZbhKzaPa3a6wrSVHyoKevw@mail.gmail.com/
> > > > > > 
> > > > > > Jarkko Sakkinen (2):
> > > > > >   keys: Return user session keyring on lookup
> > > > > >   keys: Reject keyring creation with overridden credentials
> > > > > > 
> > > > > >  Documentation/security/keys/core.rst |  7 ++-
> > > > > >  security/keys/process_keys.c         | 65 +++++++++++++++-------------
> > > > > >  2 files changed, 40 insertions(+), 32 deletions(-)
> > > > > > 
> > > > > > --
> > > > > > 2.47.3
> > > > > > 
> > > > > 
> > > > > So.. should I move forward to with non-RFC v2?
> > > > 
> > > > Patch 2 absolutely makes sense, "doc, it hurts when I do this", "don't do
> > > > that then."
> > > > 
> > > > Regarding patch 1, that seems like quite a change in behavior, right?  I
> > > > don't see any docs or comments that promise the current behavior, but
> > > > has any userspace or subsystem come to depend on it?  I guess that, if so,
> > > > then it just has to create a link to the user session keyring like pam
> > > > (according to what I've read) does?
> > > 
> > > Thanks a lot of responding.
> > > 
> > > I fully agree with you but I'd need help for evaluating things further.
> > > 
> > > 1/2 based on Jann's email about the topic and my interpretation of the
> > > suggestion. I neither used brains nor AI for this and consider the patch
> > > merely as a conversation starter (and what a great success it was on doing
> > > that) :-)
> > 
> >  :)
> > 
> > > All feedback is good feedback at this point. I need supporting code to
> > > remember/recall later on so at least this serves that purpose.
> > > 
> > > Br, Jarkko
> > 
> > I've been staring at the before and after code for a bit now.
> > It does even more than I was thinking :)  But I was trying to
> > detail the changed behavior (from userspace's pov), and after
> > several attempts, it seems maybe there actually isn't any.
> > 
> > Q: is there any path whereby the 
> > 
> > ```
> >         else if (test_bit(KEY_FLAG_UID_KEYRING,
> >                                     &ctx.cred->session_keyring->flags) &&
> >                            lflags & KEY_LOOKUP_CREATE) {
> > ```
> > 
> > case can still happen?  Or was this the only place where we installed
> > the user_session keyring as session keyring, so that we can drop this
> > branch?
> 
> Right, so *I think* that it is not useful and e.g., PAM uses NULL.
> 
> At the same time it is harmless. We could remove it but it would be
> also uapi change (for granted, useless branch).

There's

https://sources.debian.org/src/e2fsprogs/1.47.4-1/misc/e4crypt.c?hl=568#L568

which bemoans that:
	 * The fact that the keyctl system call and the add_key system
	 * call treats KEY_SPEC_SESSION_KEYRING differently when a
	 * session keyring does not exist is very unfortunate and
	 * confusing, but so it goes...

Near as I can tell, add_key just always uses KEY_LOOKUP_CREATE?

And https://sources.debian.org/src/krb5/1.22.1-3/src/lib/krb5/ccache/cc_keyring.c?hl=307#L307

I'm not sure whether previous kernels did that, or whether the authors
mixed up testing with and without KEY_LOOKUP_CREATE.

> I could do it but not without any feedback from David.
> 
> Br, Jarkko
