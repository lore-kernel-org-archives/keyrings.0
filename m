Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E7D379C36;
	Mon,  8 Jun 2026 05:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780897347; cv=none; b=SQemMhzbuDzwXffdLCO2W/FN6zX/5g21vsLCz2aMh1MVDFUAtl3NnfuJtx2wJeJFxWAeyhKAyDiuSohxQG40nY5/mXS6mUPr5rBrp2ZnOkveSTHQ0MgPJ3T323LT96GRXY/j4jSb59j2sS8Otr6bqtlGBYOk2L23Mm6nf+HLsyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780897347; c=relaxed/simple;
	bh=MEjPnWtGpVZNRYXWxeJkRixxzKCy8kVEe/W+C9geg9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXEegfywmzyakWldwbDCLErExS322C30fpLqHx2D1uBDrt4lbnBTv1Xy+Tu2LaTYB59/qGardk9aZ/qIdCvHr8fekpOweL2awxB6I4KU8Ca103Zr4sY64Lfv+R2ykhMBxAkvpwx1+vtt47UKjgQ/128jKPPdIGGNgbPmQGmYTiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVni01hY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVni01hY"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2F2EF1F00893;
	Mon,  8 Jun 2026 05:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780897345;
	bh=UBNnGQ0T1BWreuftPNz+nOZHEQDwImLWdEn6blL5Bxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OVni01hY9euV7LHXmS1Gjdb98jIyqhlLne5dQ+YEEyAauKixarBw4jjoh/lPLqDLk
	 srCv17RhLoxI8pBcQqdBmU5jKkZdObJ6AbmnRRjVk+IVt7bRDBz/1jkgocx+MdO+UU
	 PsCHUnp7S3UxqtEssad7679p4i1YKs1z7vo3jjDcXpAaVG70h6XXNBVpo5WixQmzTm
	 ogkEynj1qV+sQlXuR6dcCXaBtB4r4TwLrNANOeTXwJI+bT5KE92ZYPxm3dghWWrSQL
	 3zkHabHxdERBrwjYZwT1TlFdgQo6GFVFdstKMGarnq4OeigYZ0BrlyOtm/ExdUIAbi
	 bB6u5Av5Viivw==
Date: Mon, 8 Jun 2026 08:42:21 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Shaomin Chen <eeesssooo020@gmail.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] keys: Pin request_key_auth payload in instantiate paths
Message-ID: <aiZWPSJZyFq4nmxf@kernel.org>
References: <20260526024838.3368409-1-eeesssooo020@gmail.com>
 <aiYxqTyfHwrDOTCs@kernel.org>
 <aiYynOxFk3LuK4LA@kernel.org>
 <aiZTIzGg_peDVo1M@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiZTIzGg_peDVo1M@kernel.org>

On Mon, Jun 08, 2026 at 08:29:11AM +0300, Jarkko Sakkinen wrote:
> On Mon, Jun 08, 2026 at 06:10:23AM +0300, Jarkko Sakkinen wrote:
> > On Mon, Jun 08, 2026 at 06:06:21AM +0300, Jarkko Sakkinen wrote:
> > > On Tue, May 26, 2026 at 10:48:38AM +0800, Shaomin Chen wrote:
> > > > keyctl_instantiate_key_common() reads request_key_auth from the assumed
> > > > auth key before copying an instantiation payload from userspace.  The copy
> > > > can fault and sleep.  If the request completes and revokes the auth key in
> > > > that window, the auth payload can be detached and freed before the
> > > > instantiate path uses it again.
> > > > 
> > > > A request-key helper reproducer can trigger this race.  One helper child
> > > > blocks in KEYCTL_INSTANTIATE_IOV while the original helper instantiates the
> > > > requested key and returns.  KASAN then reports a use-after-free from the
> > > > stale request_key_auth payload in keyctl_instantiate_key_common().
> > > > 
> > > > Give request_key_auth payloads a refcount.  Take a payload reference while
> > > 
> > > Please, name concrete things accurately. I.e. 'usage' in this case. If
> > > you have a name, use it instead of obfuscating generalizations.
> > > 
> > > > authkey->sem stabilizes the payload and revocation state.  Hold that
> > > > reference across the instantiate and reject paths.  Drop the auth key
> > > > owning reference from revoke and destroy.
> > > > 
> > > > Reported-by: Shaomin Chen <eeesssooo020@gmail.com>
> > > > Closes: https://lore.kernel.org/r/20260519144403.436694-1-eeesssooo020@gmail.com
> > > > Signed-off-by: Shaomin Chen <eeesssooo020@gmail.com>
> > > > ---
> > > >  include/keys/request_key_auth-type.h |  2 ++
> > > >  security/keys/internal.h             |  2 ++
> > > >  security/keys/keyctl.c               | 24 +++++++++++++++-----
> > > >  security/keys/request_key_auth.c     | 33 ++++++++++++++++++++++++++--
> > > >  4 files changed, 53 insertions(+), 8 deletions(-)
> > > 
> > > So first, couple of things.
> > > 
> > > I'm not going to test not that well documented involving OOT driver.
> > 
> > Oops, sorry typo. "not that well documented reproducer" :-)
> > 
> > But it is cool we just then need to draw the picture.
> 
> I think I got this:
> 
> A: request_key()       B: KEYCTL_INSTANTIATE_IOV
> ----------------       -------------------------
> create auth key
> store rka in auth key
> wait for helper
>                        get auth key
>                        load rka from auth key
>                        copy user payload
>                        sleep on #PF
> helper completed
> detach and free rka
> destroy auth key
>                        wake up
>                        use rka->target_key
>                        **USE-AFTER-FREE**
> 
> So nothing really complicated here, is there?

Send v2 with the code changes that I proposed as we want to the change
as ergonomic as possible.

Use this as the commit message:

    keys: Pin request_key_auth payload in instantiate paths

    A: request_key()       B: KEYCTL_INSTANTIATE_IOV
    ----------------       -------------------------
    create auth key
    store rka in auth key
    wait for helper
                           get auth key
                           load rka from auth key
                           copy user payload
                           sleep on #PF

    helper completed
    detach and free rka
    destroy auth key
                           wake up
                           use rka->target_key
                           **USE-AFTER-FREE**

    Give request_key_auth payloads a refcount.  Take a payload reference while
    authkey->sem stabilizes the payload and revocation state.  Hold that
    reference across the instantiate and reject paths.  Drop the auth key
    owning reference from revoke and destroy.

    [jarkko: Replaced the first two paragraphs of text with a concurrency scenario.]

And it includes also the remark at the end.

BR, Jarkko
