Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB79357D08;
	Thu,  8 Oct 2026 20:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493126; cv=none; b=hxx9s1OniTOGrdG06Wt/IYJ0DASvPlA4nlCKDEPmTOoeg9N8DHO2xoiy/zi13Fl6p61NAEaDjX/F2jI4JpMKSbj06tDYoM3vGeVsaKJbJ23JqP4velBHV6IAkEYhxyQYlPMvrP1AkGdLYoxFUgJTR36ocKQMNGBQEa8Ac4GWGns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493126; c=relaxed/simple;
	bh=lHg/uyQ0fkAT6uAgONudVUOSkjJurJvPC8rGOkEpNx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0ugSbw9jcFh6y+XV4rYG8vuiY8hB1cPNqhACl8wFYPzULzNLBhgEbKabkg1HPrmkXJGjCJ8rlnUrsNv268QFI08CyE6fKjPyMHvwHzMlT11J5PhKuuXTlzwGEfSbEHQdmbDTY3RTkY4E95LbZRVQ/VgBb1T2i6sNk8cKc9L7TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3zw5MC3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3zw5MC3"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EB9761F000FF;
	Thu,  8 Oct 2026 20:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791493125;
	bh=pDwKVy4Aoq1GoydvAush+WkC9ECSHjmdPN6on930qJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c3zw5MC3zAEUmnxFTgRZR2kUn2UNZZEEnfO12xznqShOPXBfsMwZaeCZZN1aACNos
	 nSonp/nbrMe69otjBlADe3+g63SR07Nk3Q0upHmFtsUvlKJvQOOCFgQA1OvgGaYTNI
	 wXxJwol8EqS5hit41O6ihQVzQxEsmS7dU+VBlKrJQCMJSSzt1y5LZy66nAbqQRLnhK
	 u5tANoj3kdmXo80sVPLCrH9FzNTAOPSZvZvzEOLsIkN0jyuiLcORNRbff1iUtf4PpM
	 Er//1pjI3GjLCybp691L0sDY00dyE40ApqkDnM3puvoxBcZcKjppkW2JmbIQ4nWFZi
	 GF9GLwMUJbgUQ==
Date: Thu, 8 Oct 2026 23:58:41 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: adrimg3196@gmail.com
Cc: linux-kernel@vger.kernel.org, keyrings@vger.kernel.org,
	dhowells@redhat.com
Subject: Re: [PATCH v2] KEYS: Fix key_reject_and_link() race with keyring
 restriction
Message-ID: <asgEAcvTSQ6PBI_m@kernel.org>
References: <CACO1+RQ5KXAAbjpiQ=cs0wLZ=z+=JQbW_-pgG+BM0f23W112Tg@mail.gmail.com>
 <asf5kyDXUQ3z6RMv@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asf5kyDXUQ3z6RMv@kernel.org>

On Thu, Oct 08, 2026 at 11:14:16PM +0300, Jarkko Sakkinen wrote:
> On Thu, Oct 08, 2026 at 11:18:02AM -0700, adrimg3196@gmail.com wrote:
> > Jarkko, you're right — v1 arrived without the diff. Here's v2 with the
> > full patch.
> 
> And it would not be your fault if it had gone to my PR as I have
> ultimate responsibility for that part.
> 
> Anyhow, put side-notes under '---'. It's a good place for these
> as it does not get pulled into the commit log.
> 
> For single-patch submission it is also great place to maintain
> changelog.
> 
> > 
> > The restrict_link check in key_reject_and_link() is done before taking
> > the keyring semaphore, racing with a concurrent keyring_restrict()
> > that installs the restriction while holding the semaphore in write
> > mode.
> > 
> > This is the same pattern that commit dd3ea3fc ("KEYS: Fix add_key()
> > race with keyring restriction") just fixed in __key_create_or_update()
> > by moving the restrict_link snapshot to after the semaphore is taken.
> > 
> > Move the check under __key_link_lock() so a restriction installed
> > concurrently cannot be bypassed when linking a negative key.
> > 
> 
> Fixes: 5ac7eace2d00 ("KEYS: Add a facility to restrict new links into a keyring")o
> > Signed-off-by: Adrian Martinez <adrimg3196@gmail.com>
> > ---
> Here.
> >  security/keys/key.c | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> > 
> > --- a/security/keys/key.c
> > +++ b/security/keys/key.c
> > @@ -588,10 +588,17 @@ int key_reject_and_link(struct key *key,
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
> > +			 * concurrent restriction install (cf. the fix for
> > +			 * __key_create_or_update()).
> > +			 */
> > +			if (keyring->restrict_link) {
> > +				__key_link_end(keyring, &key->index_key, edit);
> > +				return -EPERM;
> > +			}
> >  			link_ret = __key_link_begin(keyring, &key->index_key, &edit);
> >  			if (link_ret < 0)
> >  				__key_link_end(keyring, &key->index_key, edit);
> 
> 
> Looks good to me, thank you.
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

So send v3 that addresses:

(141) $ b4 shazam https://lore.kernel.org/keyrings/asf5kyDXUQ3z6RMv@kernel.org/T/#t
Grabbing thread from lore.kernel.org/all/asf5kyDXUQ3z6RMv@kernel.org/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 3 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v2] KEYS: Fix key_reject_and_link() race with keyring restriction
    + Fixes: 5ac7eace2d00 ("KEYS: Add a facility to restrict new links into a keyring")o (✓ DKIM/kernel.org)
    + Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org> (✓ DKIM/kernel.org)
  ---
  ✓ Signed: DKIM/gmail.com
---
Total patches: 1
---
Applying: KEYS: Fix key_reject_and_link() race with keyring restriction
Patch failed at 0001 KEYS: Fix key_reject_and_link() race with keyring restriction
error: corrupt patch at line 31
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"

You can retain my reviewed-by and please add fixes tag while at it.

Br, Jarkko
