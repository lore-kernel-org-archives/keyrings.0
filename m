Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C6E34FF74;
	Sat, 10 Oct 2026 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791664881; cv=none; b=l6aiusloDaOSkLoHBF4FCfjjvLBobfKdSEMMTqRNKRsLbW9zNAhFtKOpGTpxpBsU4Rp/hhkgHG9xs2T4unsH6kOT3OFxist1iwVE4GkQDJRXvp/vPk6rwDVT43rIO+lEM5kJ4kru1hM5oKi2O59IPSnZO+SjZJVmILIUWfjwmnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791664881; c=relaxed/simple;
	bh=L/fuTs9pOrB834mUiha1Ujo9flaUwFokiNRJam3zXSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUREGXaMFxX60m+aYTfGaWsvwlDOw+88eHuN4pTXzF+LOqPT8pS5pWysV61DB9EvChINKJ5EKNydPvEzQvtCdKdObrKLEZV6L2lT0IR2zdwTpT0r1NJSQIoivw3HSV5X72dpV9Z2mnHPkw7sCbXB/R0n+WWgmQx3iQ8WfdS8Q6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJSua80Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJSua80Y"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 052531F000FF;
	Sat, 10 Oct 2026 20:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791664879;
	bh=qvdQlgHLzooXyFBIg7TFK2OTgH6Fn1zz8/Mf3axs4SU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mJSua80YV34Xkkhe02r8orkcEzmeYuGAO/Xqc83N4K4SixdNHX/jSnaIlGKwF6+7N
	 uLEr5lmfnSz9PbL9IbwZNjjBmbnf6UDxCjP3cKf6Eqqefik79dL6SrGMLLEYnoJuBF
	 MbWujoo/V9+Qm3wIW8xbjtVq4jRcdRV2vxw1oc6Mu40bC32pMvRfEbCG/kXhZk6rZN
	 k8mfoIX6jtt61pgDjT80CT+G5cPrQf4TgZ4BDkBQ5QpxyK+pINtl5K7W9PCfQ4zytK
	 rcO8XrVGTfBw7jprWLdT/bPyqT0DJ501sPlNLUp6TuFHnYVK7c45PLM9kekmCk3ZPS
	 YJDkIdphPWAwA==
Date: Sat, 10 Oct 2026 23:41:15 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: adrimg3196@gmail.com
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	dhowells@redhat.com
Subject: Re: [PATCH v3] KEYS: Fix key_reject_and_link() race with keyring
 restriction
Message-ID: <asqi665qym18rB4o@kernel.org>
References: <CACO1+RT+m==BY+ZPkE+fo536D0qu3wog4xE1dfuXQ56g+=Qv=A@mail.gmail.com>
 <asqTtizyto7y2wYn@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asqTtizyto7y2wYn@kernel.org>

On Sat, Oct 10, 2026 at 10:36:27PM +0300, Jarkko Sakkinen wrote:
> On Thu, Oct 08, 2026 at 02:03:51PM -0700, adrimg3196@gmail.com wrote:
> > The restrict_link check in key_reject_and_link() is done before taking
> > the keyring semaphore, racing with a concurrent keyring_restrict()
> > that installs the restriction while holding the semaphore in write
> > mode.
> > 
> > Move the check to after __key_link_lock(), so it is done under the
> > semaphore, matching the pattern used in __key_create_or_update().
> > 
> > Fixes: 5ac7eace2d00 ("KEYS: Add a facility to restrict new links into
> > a keyring")
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > Signed-off-by: Adrian Martinez <adrimg3196@gmail.com>
> > ---
> > Changelog:
> >  v3: Add Fixes tag and Reviewed-by; resend with clean patch (v2 was corrupt).
> >  v2: Resend with full patch (v1 arrived without the diff).
> > 
> >  security/keys/key.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> > 
> > diff --git a/security/keys/key.c b/security/keys/key.c
> > index 1234567..abcdefg 100644
> > --- a/security/keys/key.c
> > +++ b/security/keys/key.c
> > @@ -590,10 +590,17 @@ int key_reject_and_link(struct key *key,
> >  	ret = -EBUSY;
> > 
> >  	if (keyring) {
> > -		if (keyring->restrict_link)
> > -			return -EPERM;
> > -
> >  		link_ret = __key_link_lock(keyring, &key->index_key);
> >  		if (link_ret == 0) {
> > +			/*
> > +			 * Check the restriction under the keyring semaphore.
> > +			 * keyring_restrict() installs it while holding the
> > +			 * semaphore, so testing it beforehand races with a
> > +			 * concurrent restriction install.
> > +			 */
> > +			if (keyring->restrict_link) {
> > +				__key_link_end(keyring, &key->index_key, edit);
> > +				return -EPERM;
> > +			}
> >  			link_ret = __key_link_begin(keyring, &key->index_key, &edit);
> >  			if (link_ret < 0)
> >  				__key_link_end(keyring, &key->index_key, edit);
> 
> Thank you!
> 
> I applied this.
> 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

But scripts/checkpatch.pl complains:

-------------------------------------------------------------------------------------
Commit fd17650a59fc ("KEYS: Fix key_reject_and_link() race with keyring restriction")
-------------------------------------------------------------------------------------
WARNING: From:/Signed-off-by: email name mismatch: 'From: "adrimg3196@gmail.com" <adrimg3196@gmail.com>' != 'Signed-off-by: Adrian Martinez <adrimg3196@gmail.com>'

total: 0 errors, 1 warnings, 0 checks, 21 lines checked

I can fix this up, so no need for new version but it is good
to be aware of this if you plan to send anything in the future.

Br, Jarkko
