Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1123019C8;
	Mon, 12 Oct 2026 13:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791810203; cv=none; b=ue+fnIdcoFcthgvIP/5Ikhcv0okgKbdymMTAXjCunKvDY5zz9A3j14naK2h0ZobtOpCWzowwr5fi63kSMirLyPDvb7OCFBNz9ZSV6D+eeD/srvI03ZPOKkEfyP+q54Fzi+/UrUQhuOszgf134L3vnRSAtZt09WclGuzitZBPeU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791810203; c=relaxed/simple;
	bh=c5ditRlDNuVrYLICh++R/QG+eGr8/ChIs0nL2LwNAao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8wONVC9lwPTAd2U6zvQ9mjwy/MHsk6/ocP3nEOCLVOimNdQtbh8pDe7noxg9Hi3twHll4snux9GQ5jhuq6XUQ7GSTAm4vpJav9UnLPQJerp/sRbKMYQoOnj72U22ZoJU2RygrbByFvkxSYoazhNvrJi1LH5wNvx+FK84Jqiqcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ca3aQY7a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ca3aQY7a"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5B64A1F0089B;
	Mon, 12 Oct 2026 13:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791810201;
	bh=uSfeAnZlT5t2YxPbWaqpqdgcpZlF7GT8ABWNnZFZuqU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ca3aQY7aOBuCfVKpGkkAttSRyYqTCmJ/i9ya0sDaSHVdx2HbeNG359A3qxI8n9PGI
	 S3M3Do7DVa7kPoJa65H8qF5KebVsFyNMXLo6gi4yWOfZ9pNPUXBzOTF6v2bKPAuGYg
	 10G2N5l7t5qKXtKdvCKIkOnkTpjWMDIvwdB31jqwY2ABzePeMBLT6/VYXoV2FK63KX
	 OFEqz+4smDhwi4nGWCEp/i9E5D+TtAKZ0yerS1/IAkC6AvhYeLSg/ObV7KgXwzFEvf
	 RZAlgwji4mFTkV/5CRcF7/LWHokS6B4Pt4IBCRLNszIDQKsuN2HUECIqiMTIBPofSM
	 FWweCpiKgLOfQ==
Date: Mon, 12 Oct 2026 16:03:18 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, akpm@osdl.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH] KEYS: Protect user key quota access during instantiation
Message-ID: <aszalro6U6BFO_D3@kernel.org>
References: <pm-key-management-objects-candidate-0001-v6-9876bf3e2116d47c065e@gmail.com>
 <aszZ3KPvMMHLEJ0s@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aszZ3KPvMMHLEJ0s@kernel.org>

On Mon, Oct 12, 2026 at 04:00:16PM +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 12, 2026 at 11:15:43AM +0800, Cen Zhang wrote:
> > The owner account must remain alive throughout payload quota
> > reservation. The user key type calls generic_key_instantiate(), which
> > dereferences key->user in key_payload_reserve(), without holding
> > key->sem. The construction mutex excludes other instantiators but does
> > not exclude keyctl_chown_key().
> 
> I'm not following the term "owner account". It is neither an
> actor in the concurrency scenario. What do you exactly mean
> by it?
> 
> > 
> > A kernel caller can allocate an in-quota user key, retain its reference
> > and instantiate it with a nonempty payload after publishing its serial.
> > A concurrent task with Setattr permission and CAP_SYS_ADMIN can chown
> > the still-uninstantiated key through KEY_LOOKUP_PARTIAL. If the key
> > holds the last reference to its non-root account, instantiation has no
> > authorization key, and the new owner has sufficient quota, this ordering
> > is possible:
> > 
> >   Instantiator                       Chown task
> >   key_instantiate_and_link()          keyctl_chown_key()
> >     lock key_construction_mutex        down_write(key->sem)
> >     generic_key_instantiate()
> >       key_payload_reserve()
> >         load old = key->user
> >                                        transfer quota to new owner
> >                                        replace key->user
> >                                        up_write(key->sem)
> >                                        key_put(key)
> >                                        key_user_put(old)
> >                                          kfree(old)
> >         read old->uid
> > 
> > Chown's final free falls between the old pointer load and the uid read.
> > The read can therefore access freed struct key_user storage despite the
> > caller retaining the key itself. Hold the read side of key->sem in a
> > local user instantiation callback across generic_key_instantiate().
> > Chown then cannot replace and release the account until the quota
> > accesses finish. If chown goes first, instantiation takes the semaphore
> > and uses the new account instead.
> 
> And account gets repeated here. I'm not sure hat accounts we are
> talking about here.
> 
> I.e.
> 
> 1. I get the scenario.
> 2. I read all of the text but I do not understand what I'm reading.
> 
> > 
> > Keep locking out of the shared helper, which is also called by
> > big_key_update() with key->sem write-locked.
> 
> On the other hand this could be a bit more verbose.
> 
> > 
> > KASAN report as below:
> > 
> >     BUG: KASAN: slab-use-after-free in key_payload_reserve+0x54d/0x560
> > 
> > 
> > Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's owner")
> > Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> > Assisted-by: LLM
> > 
> > ---
> > 
> > diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
> > index 6f88b507f92791bd9569673c5d6534d76c58a978..b6e09921c11658c09eb7d7954b2abd5b2b7017c1 100644
> > --- a/security/keys/user_defined.c
> > +++ b/security/keys/user_defined.c
> > @@ -15,6 +15,7 @@
> >  #include "internal.h"
> >  
> >  static int logon_vet_description(const char *desc);
> > +static int user_instantiate(struct key *key, struct key_preparsed_payload *prep);
> >  
> >  /*
> >   * user defined keys take an arbitrary string as the description and an
> > @@ -24,7 +25,7 @@ struct key_type key_type_user = {
> >  	.name			= "user",
> >  	.preparse		= user_preparse,
> >  	.free_preparse		= user_free_preparse,
> > -	.instantiate		= generic_key_instantiate,
> > +	.instantiate		= user_instantiate,
> >  	.update			= user_update,
> >  	.revoke			= user_revoke,
> >  	.destroy		= user_destroy,
> > @@ -86,6 +87,19 @@ void user_free_preparse(struct key_preparsed_payload *prep)
> >  }
> >  EXPORT_SYMBOL_GPL(user_free_preparse);
> >  
> > +/*
> > + * Keep the owner account stable while reserving quota during instantiation.
> > + */
> 
> Also here as a kernel developer I do not comprehend what I do when I
> keep "an own account stable". I don't have kernel idioms that match.
> 
> > +static int user_instantiate(struct key *key, struct key_preparsed_payload *prep)
> > +{
> > +	int ret;
> > +
> > +	down_read(&key->sem);
> > +	ret = generic_key_instantiate(key, prep);
> > +	up_read(&key->sem);
> > +	return ret;
> > +}
> > +
> >  static void user_free_payload_rcu(struct rcu_head *head)
> >  {
> >  	struct user_key_payload *payload;
> 
> Not disagreeing with the fix but yeah would really like something else
> than gibberish around the concurrency scenario.

I appreciate the fix but if I'm completely hones the commit message
looks like direct LLM output, which is not acceptable.

It needs to be proof-readed and edited. For this reason, I want a better
iteration before I apply this.

Br, Jarkko
