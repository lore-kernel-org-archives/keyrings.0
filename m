Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D8D486422;
	Tue, 29 Sep 2026 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716928; cv=none; b=n2qfnFHY5pT269qCY1YLS8/VVgQq9TY4WKPl6OoW0OjFk/9Aegq8fziyX2v0Cbic2lrl2BEJ9/AmNBla4SHkb90Y8xJsVhchUUp6i2Tu2ZTXhxYkaqEgEfg/vbBmZiU9b5fd+HUszcD3UhS5v+HHTaCV/IS2YbSq0NMC1rcSK04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716928; c=relaxed/simple;
	bh=zTqy30vqknuSyleVsDDMUFWuh/A2u/sfpJyIYOVlSdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQ4rq90T5w/K90aWlcBU2O0rdxFy1wd+P+4fnRgEohlsoe7pONOZCMn7V2k1GqBe44DGXRviQQ4+PQdVdcM4lpNKq/f3mXbosBiwg2QefO2imjaQUUQyS9CiYvVuCOy/SpaouzYgW0BvrDfvzAmUC8XszD86aFedjtoTNP+WL/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/DeIdLr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/DeIdLr"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 943B31F000FF;
	Tue, 29 Sep 2026 21:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790716927;
	bh=dCT0JyM1L7y46G+ANqsfvbzWXFF4/9rwphu+Qnh5z88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D/DeIdLrWzrfMmjvwps2rjaIR2QBXwmKtXq0C1BZuWNut2naCX2sXgC1gJOtOzEQA
	 5WGwecSvzcXbynEIzTJMALovkS9644T6MMjk31dQtB2kqGHgDQ4h0sqPIOHv3bIV1u
	 JPcUleX4ttaM2tc2xBJTZQu6gJUKRCAQuqAo4J/rkxnuwZdzyHSgXMMzVf82OyrfwT
	 7rqvmnRoAqsfeSC36JXBJmes2Uqwyda8pMDI3SYbZdG1OmqxqqkCr7Zv4+t7F+BGmC
	 7JkAfkZy6mTqdHqLjUnbqA42hReI8Doutd0bQ6M9o16bZe+V6hpsqtfenWUOgfEQSO
	 pfA2hJxtUzWMA==
Date: Wed, 30 Sep 2026 00:22:03 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] keys: Fix key_user use-after-free during ownership
 changes
Message-ID: <arwr-80xENDNBNLp@kernel.org>
References: <20260904080940.575882-1-nicoyip.dev@gmail.com>
 <aqHhZO0GjMTOer4j@kernel.org>
 <CAAo+4rW_kT_GL_3cr8aSHkAM29yQQgNL4EJktfTirOi4nHwOOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAo+4rW_kT_GL_3cr8aSHkAM29yQQgNL4EJktfTirOi4nHwOOA@mail.gmail.com>

On Mon, Sep 28, 2026 at 01:19:44AM +0800, Chengfeng Ye wrote:
> On Thu, Sep 10, 2026 at 6:44 AM Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > On Fri, Sep 04, 2026 at 04:09:40PM +0800, Chengfeng Ye wrote:
> > > keyctl_chown_key() replaces key->user and then drops the key's
> > > reference to the previous key_user. Several paths access key->user
> > > without any common synchronization with this replacement, including
> > > the /proc/keys iterators, find_keyring_by_name(), quota accounting, and
> > > key instantiation.
> > >
> > > This allows an ownership change to free the previous key_user while a
> > > reader is still accessing it:
> > >
> > >   CPU 0 (/proc/keys)            CPU 1 (KEYCTL_CHOWN)
> > >   user = key->user
> > >                                 old = key->user
> > >                                 key->user = newowner
> > >                                 key_user_put(old)
> > >                                   kfree(old)
> > >   uid = user->uid
> > >
> > > The same missing synchronization also can corrupt instantiated-key
> > > accounting. KEY_LOOKUP_PARTIAL allows keyctl_chown_key() to change the
> > > owner of a key while it is still being instantiated:
> > >
> > >   CPU 0 (instantiate)           CPU 1 (KEYCTL_CHOWN)
> > >   atomic_inc(old->nikeys)
> > >                                 observe KEY_IS_UNINSTANTIATED
> > >                                 skip the nikeys transfer
> > >                                 key->user = newowner
> > >   mark key instantiated
> > >
> > > The increment remains charged to the previous owner. Quota reservation
> > > can similarly select one owner for its quota limit and another owner
> > > for the usage update, or access an owner that has already been freed.
> > >
> > > The existing locks do not provide common exclusion for these
> > > operations. keyctl_chown_key() holds key->sem, key construction uses
> > > key_construction_mutex, and the affected readers hold their respective
> > > tree or list locks.
> > >
> > > Use key_user_lock to serialize access to key ownership. Hold it across
> > > the accounting transfer and key->user replacement in keyctl_chown_key().
> > > Use the same lock while readers copy the owner's UID, while quota usage
> > > is updated, and while the instantiated-key count and key state are
> > > committed.
> > >
> > > key_user_lock already serializes final key_user removal, so an old
> > > owner cannot be freed while one of these readers is accessing it.
> > >
> > > Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's owner")
> > > Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> > > ---
> > > Changes in v2:
> > > - Audit every user->uid occurrence and all direct key->user accesses.
> > > - Take key_user_lock explicitly at each namespace-filtering reader instead
> > >   of hiding the lock acquisition in an accessor.
> > > - Serialize quota reservation and construction accounting with ownership
> > >   changes while preserving the existing direct key->user accesses.
> > > - Use the commit that introduced ownership changes as the Fixes target.
> > >
> > > Link: https://lore.kernel.org/keyrings/20260823170448.3856516-1-nicoyip.dev@gmail.com/ [v1]
> >
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html#separate-your-changes
> >
> > I.e. no bundle commits. This unreviewable.
> 
> Thanks for the review. I have split the changes into two patches
> and sent them as v3:
> 
> https://lists.openwall.net/linux-kernel/2026/09/27/734

Thank you, it is just what SubmittingPatches says about commits :-)

> 
> Best regards,
> Chengfeng

Br, Jarkko
