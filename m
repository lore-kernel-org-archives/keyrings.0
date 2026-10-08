Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296A3389106;
	Thu,  8 Oct 2026 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791489648; cv=none; b=rnKCrZsY+QOzovYMwYXEk/eSI3FvlzQuE+bYHfrzuAAa3JIFmRZG/UbjjR9LyTHhGTlUgYK/5kaZ1BI5ULU5dv0HNifw8QfHiIdqnSOsMNVJ1fEndw98GSW+TnJhSTfTgAMamtRYe6Hsa/vRLPUqanTVszHGrNR0QHHHub/lii0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791489648; c=relaxed/simple;
	bh=arfG0OA/S9WZVWpBsdEgGBN7fLQBR15stdBh8zgrKNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YBIaZ1lxpatLxg+SsonYtCJg1vN1Ypc1UOT0GxH/PfmSayV0zixAgIDhmsBeUqH7O1nwTphsUa8wKYGBO5ZHPU7mF29jyKm0N4eAZcjn//dpQ0ZfmcGiju19XA5paJgqPuQf0LOmp+2fcsbg/c+gnvNbGMdxfJ37WIpN8VPDKVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m20tKdkN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m20tKdkN"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EFAF71F000FF;
	Thu,  8 Oct 2026 20:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791489643;
	bh=5tJiEx61Ou6+oXfbj3HPCZcottfX1az5DxPRXfwB8YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=m20tKdkNeHKiy7gdwiE8Y1trAcpuPFAsYRucsTv9bhT1Dk/akACmW1RpYTp40dMxu
	 r8iE5MhUMCeGHFVac8iIEpka7074agLj4yM4DLAbIgpAAf/RAYjT1Kr72yffQg8HUb
	 yTkU9DHqGn24QDhpP2Dwy5vpirbS7VQK5oAw/1ttP/QNE1K5rrqNmVn01Zwqr8dBUZ
	 Kz9mZPnoTUmiAyN/msCGvAd8+mVeKJYhN6s7sm8G8A951gLjXAVQC0TpvZnJNJLSru
	 hcwVB5WUZKj5AotdXB9htUpyyGxUaxzRELMVYD5z/rJ1fFNOj9a5An9bujmNU4EgpQ
	 Pq3Pef+sFKGrg==
Date: Thu, 8 Oct 2026 23:00:39 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH 0/2] keys: Address lookup_user_key() mutability
Message-ID: <asf2Z5R1u6Rth6-6@kernel.org>
References: <20260924055521.1981957-1-jarkko@kernel.org>
 <asKSvjz2YLZhFI4t@kernel.org>
 <asOhhCION3dwTAo+@hallyn.com>
 <asPwkdi7ZdO4YoRu@kernel.org>
 <asVDbPtyCNy210-R@shallyn-amd>
 <aseoJvcBh0RZ31Uo@kernel.org>
 <ase1/CnbnqL24SOQ@hallyn.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ase1/CnbnqL24SOQ@hallyn.com>

On Thu, Oct 08, 2026 at 10:25:48AM -0500, Serge E. Hallyn wrote:
> On Thu, Oct 08, 2026 at 05:26:46PM +0300, Jarkko Sakkinen wrote:
> > On Tue, Oct 06, 2026 at 01:52:28PM -0500, Serge Hallyn (AMD) wrote:
> > > On Mon, Oct 05, 2026 at 09:46:41PM +0300, Jarkko Sakkinen wrote:
> > > > On Mon, Oct 05, 2026 at 08:09:24AM -0500, Serge E. Hallyn wrote:
> > > > > On Sun, Oct 04, 2026 at 08:54:06PM +0300, Jarkko Sakkinen wrote:
> > > > > > On Thu, Sep 24, 2026 at 08:55:16AM +0300, Jarkko Sakkinen wrote:
> > > > > > > The main objective in these patches is to remove to unneeded mutability
> > > > > > > from key look ups. It does harm and brings no value so it is pretty obvious
> > > > > > > to me that addressing this harmful behaviour is what we should do.
> > > > > > > 
> > > > > > > I based the first patch on what Jann suggested in [1]. Nothing too clever here
> > > > > > > and I'm ofc open for further suggestions.
> > > > > > > 
> > > > > > > [1] https://lore.kernel.org/keyrings/CAG48ez0XjVSR=M--UBauTm8sJuc+ZbhKzaPa3a6wrSVHyoKevw@mail.gmail.com/
> > > > > > > 
> > > > > > > Jarkko Sakkinen (2):
> > > > > > >   keys: Return user session keyring on lookup
> > > > > > >   keys: Reject keyring creation with overridden credentials
> > > > > > > 
> > > > > > >  Documentation/security/keys/core.rst |  7 ++-
> > > > > > >  security/keys/process_keys.c         | 65 +++++++++++++++-------------
> > > > > > >  2 files changed, 40 insertions(+), 32 deletions(-)
> > > > > > > 
> > > > > > > --
> > > > > > > 2.47.3
> > > > > > > 
> > > > > > 
> > > > > > So.. should I move forward to with non-RFC v2?
> > > > > 
> > > > > Patch 2 absolutely makes sense, "doc, it hurts when I do this", "don't do
> > > > > that then."
> > > > > 
> > > > > Regarding patch 1, that seems like quite a change in behavior, right?  I
> > > > > don't see any docs or comments that promise the current behavior, but
> > > > > has any userspace or subsystem come to depend on it?  I guess that, if so,
> > > > > then it just has to create a link to the user session keyring like pam
> > > > > (according to what I've read) does?
> > > > 
> > > > Thanks a lot of responding.
> > > > 
> > > > I fully agree with you but I'd need help for evaluating things further.
> > > > 
> > > > 1/2 based on Jann's email about the topic and my interpretation of the
> > > > suggestion. I neither used brains nor AI for this and consider the patch
> > > > merely as a conversation starter (and what a great success it was on doing
> > > > that) :-)
> > > 
> > >  :)
> > > 
> > > > All feedback is good feedback at this point. I need supporting code to
> > > > remember/recall later on so at least this serves that purpose.
> > > > 
> > > > Br, Jarkko
> > > 
> > > I've been staring at the before and after code for a bit now.
> > > It does even more than I was thinking :)  But I was trying to
> > > detail the changed behavior (from userspace's pov), and after
> > > several attempts, it seems maybe there actually isn't any.
> > > 
> > > Q: is there any path whereby the 
> > > 
> > > ```
> > >         else if (test_bit(KEY_FLAG_UID_KEYRING,
> > >                                     &ctx.cred->session_keyring->flags) &&
> > >                            lflags & KEY_LOOKUP_CREATE) {
> > > ```
> > > 
> > > case can still happen?  Or was this the only place where we installed
> > > the user_session keyring as session keyring, so that we can drop this
> > > branch?
> > 
> > Right, so *I think* that it is not useful and e.g., PAM uses NULL.
> > 
> > At the same time it is harmless. We could remove it but it would be
> > also uapi change (for granted, useless branch).
> 
> There's
> 
> https://sources.debian.org/src/e2fsprogs/1.47.4-1/misc/e4crypt.c?hl=568#L568
> 
> which bemoans that:
> 	 * The fact that the keyctl system call and the add_key system
> 	 * call treats KEY_SPEC_SESSION_KEYRING differently when a
> 	 * session keyring does not exist is very unfortunate and
> 	 * confusing, but so it goes...
> 
> Near as I can tell, add_key just always uses KEY_LOOKUP_CREATE?
> 
> And https://sources.debian.org/src/krb5/1.22.1-3/src/lib/krb5/ccache/cc_keyring.c?hl=307#L307
> 
> I'm not sure whether previous kernels did that, or whether the authors
> mixed up testing with and without KEY_LOOKUP_CREATE.

Ugh, I feel that I always to go the code from beginning to check these
up but those workarounds are still valid i.e., these patches do not
address write divergence.

I would summarize my fixes along the lines of:

1. 1/2 exactly removes cred creation as a side-effect invisible to the
   caller..
2. 2/2 handles request_key()'s from nfsd and other in-kernel daemons.
   I.e. it transforms BUG_ON() into -EPERM.

I'd like to keep this patch set strictly within scope and somewhat
surgical if/when it is applied.

And it looks to me a lot that this might well be the smallest possible
change that addresses exactly unwanted BUG_ON() conditions pointed out
by Jann surpsingly well.

Br, Jarkko
