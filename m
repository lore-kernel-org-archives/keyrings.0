Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AB42D73A6;
	Sat, 17 Oct 2026 17:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792256786; cv=none; b=pfW+NqVx3AqTcFNEPxWdXTHXz6CKrE98Npsoo27t3BbqyDDP1lPRHZDhX45QIAvk7PjYQ91gi7HpG6dICrpxM4/QtIiDlEBdqYNKyoI0yxNkcZVpW8h7meo6L6otv7cZmt3cl5n6qDHVR9fw58gBTkMo6f4dnEYIO7OyWArL8PE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792256786; c=relaxed/simple;
	bh=y23ZiI7MBYK4EDLV0yVs5IKj5qZmDxJ8i16EpHNWlj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9bri5BXMcwjzUtOu37DYiHEhirjHAX6b5W5vB20GgOkkUTRvu7Aj5udIvAEJai8NYQdqT1g1milJ5R9YXaeiqv7jTPAR8ExJn0FBwXBWpNTXeFvE/GqusNQNw7rNL4POe8DUVQ5SpzuYfKSD3NlRzsncxvQa6FTMEoSMvRpdf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffF9dWoK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffF9dWoK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747C01F000C4;
	Sat, 17 Oct 2026 17:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792256785;
	bh=zb6YdLSsn6WhLG42ci44m/AZ0Xc8wY5TfmE3OMskHh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ffF9dWoKgnfDJGIK14vSTOszntKnMV3PHCI/d265GB1URtgp7svx9xZlKVP+ifd1f
	 k+zPoQUnL4o++tWWgUk3etjYQdPoHar66GhQb4lk1WJMYAiMFZP7yZV3tswmrFXQzi
	 WZFc1L2toO4eT4iZprNMjHCNfVAqll+CXsGKgQFHLojp3P/5OeezS7gsIirVUYSq/Z
	 9zLXyO6Mv+Gc9PLBZoT5GqtBrx0Inuy8oDT9sclp2W8OOz/zlbNEag7Xw5XTMXpCWO
	 fpb+kpm54vdNvX2DB/4nhxenaxUIQJE0DKlZEUGOScTmvU+tJ+Fsj4HmkkPq130fWh
	 F8WMsOrtroS/g==
Date: Sat, 17 Oct 2026 20:06:21 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/6] keys: reclaim link quota during keyring garbage
 collection
Message-ID: <atOrDYkuBlno9_Y7@kernel.org>
References: <20261016215326.4110064-1-jarkko@kernel.org>
 <20261016215326.4110064-3-jarkko@kernel.org>
 <20261017054244.GD29318@sol>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261017054244.GD29318@sol>

On Fri, Oct 16, 2026 at 10:42:44PM -0700, Eric Biggers wrote:
> On Sat, Oct 17, 2026 at 12:53:00AM +0300, Jarkko Sakkinen wrote:
> > Garbage collection removes dead key links without releasing their quota.
> > Repeated collection therefore leaves the owner charged for links that no
> > longer exist, eventually preventing further links with -EDQUOT.
> > 
> > Update the payload reservation from the surviving link count while holding
> > the keyring semaphore. If assoc_array_gc() fails, the tree and its count
> > remain unchanged, so the existing reservation is retained.
> > 
> > Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> > Assisted-by: LLM
> > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > ---
> >  security/keys/keyring.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> > index 7143f3079d20..db987c891811 100644
> > --- a/security/keys/keyring.c
> > +++ b/security/keys/keyring.c
> > @@ -1755,6 +1755,8 @@ void keyring_gc(struct key *keyring, time64_t limit)
> >  	down_write(&keyring->sem);
> >  	assoc_array_gc(&keyring->keys, &keyring_assoc_array_ops,
> >  		       keyring_gc_select_iterator, &limit);
> > +	key_payload_reserve(keyring,
> > +			    keyring->keys.nr_leaves_on_tree * KEYQUOTA_LINK_BYTES);
> >  	up_write(&keyring->sem);
> >  	kleave(" [gc]");
> 
> This doesn't actually hold a reference to the keyring, so can't it race
> with key_put() which released the quota already?  Then the quota for a
> link can be released multiple times.

I agree. Thanks for checking this. I only got through the first today
but plan to inventory them all in detail.  This can be dropped without
any further consideration.

The head is the LLM assisted part from my side and I go through them
with presumption that the changes are not applicable.

> 
> - Eric

Br, Jarkko
