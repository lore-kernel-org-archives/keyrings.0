Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423639;
	b=3HN1GsDNa6UjbluPlnH8XKVQHsCQ6KQu5iD/F7E9GVbkWcizhFvfPBKFAxd7K7DXPy7E
	 2Bjqmwgd6lPqCWppS4kr8GBmuwvZ5IgbLERbgTgPvaL19UYE66dczaWpQADM01+dPdWtN
	 8lzii9uO4jrUtUBq43AV/QbwSBmcPzS/LJn6k4Cd1h4Z8iip6jHgQlo29B8lixaBBPTvM
	 eNefJTedETSnDUW5wKREY4VaIJahBY90OhkqIiXZNgFp3HWiW6/ruhzRh29d1G0BLLa2V
	 PFn7WMdY9xlTyBblmAtVmXCCUkokiM4zdffxqZsMhhnEEXb+T4Y2UWx3o53RCAIXa+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423639;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=p/d6RhL2Ea+gK3gLTdz2MSZMEDt3+2TPfT6YsedECQ8=;
	b=x5B+OrwCI7rOd0UCnmkr3pFvW10PytTpMov1VFc4sIk1+tfnxqY1C2vuOntBplUJv4BR
	 kLp3m+UJqV/mua4dZSJONZ6ffr7jZrCw6mMVPBUNiCav8XJupoGKNNbnFkK2VgvXoNHum
	 Kmn2AtCFxv6kZ2ChZ//VwlwXlppkrK3RBZ8wAxjXP5Kt8tLiVYPkjKhPMSKXH/3dfyB7M
	 LfOoCQLmpBS7LWr/XqpF+erW7CygdUTJuzs/gqgjDzDKgTWsAntRjcrj095dkHhzeLsjb
	 yg2CkrHEpXcIwQJqE23CPNZRESshwSWe9jpK3Ufz3BunKOcppNmf+SGEjEbdVhuIbMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wa4XtKPY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C4FB660B5044;
	Mon, 19 Oct 2026 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Wa4XtKPY
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1BEB51F000C4;
	Mon, 19 Oct 2026 15:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792423638;
	bh=p/d6RhL2Ea+gK3gLTdz2MSZMEDt3+2TPfT6YsedECQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wa4XtKPYJ+VsN4O9LnnUfUlWnBYjMA+2WbPDAeDekCO1892qGW9gpq4arBBxdtyG0
	 VJg9bZj9lvIYFyWBqYpla8Nz1pSc/ypinDjNVW4GV7BbPxiAki5ehjzhfSg4Y5JjlS
	 OASniCfLVra6fUeAyap6CVDeC0qiLRM+ly6qbuUZ8bTXH7HVEocHzUHaQ2EiRv22Qz
	 j8JmOWcd4IgRk+i5ATSlvKlw9K+L9qp+YIo+h1OrvGBTd9Cz6sRcJ2w2jbTUyS6W61
	 okbMw218xg3P23p/oj1WnRhk82AStrY6Z4WLSnrVwT8yC9xU4FBLxGIz7ir50gZjx/
	 aw3Z/9sTqcB2g==
Date: Mon, 19 Oct 2026 18:27:15 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH 5/6] KEYS: Replace assoc_array with struct
 keyring_index
Message-ID: <atY20yF6B6-FpslZ@kernel.org>
References: <20261016215326.4110064-6-jarkko@kernel.org>
 <20261016215326.4110064-1-jarkko@kernel.org>
 <2608630.1792422168@warthog.procyon.org.uk>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2608630.1792422168@warthog.procyon.org.uk>

On Mon, Oct 19, 2026 at 04:02:48PM +0100, David Howells wrote:
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > Maintain two linked lists in the index:
> > 
> > - all: enumerate committed links without retrying hash table walks when
> >   the table resizes.
> > - keyrings: visit nested keyrings during recursive search without scanning
> >   links to other key types.
> 
> Do you actually need two lists?  Can you just "sort" the list to put all the
> keyrings first?
> 
> > +			struct keyring_index __rcu *links;
> 
> Does that actually need an __rcu mark?  Is it going to get replaced once
> allocated?
> 
> > +struct keyring_link;
> > +
> 
> Somewhere near the top of internal.h, please, not sandwiched in the middle of
> some func declarations.
> 
> > --- a/security/keys/keyring.c
> > +++ b/security/keys/keyring.c
> > @@ -14,12 +14,12 @@
> >  #include <linux/err.h>
> >  #include <linux/user_namespace.h>
> >  #include <linux/nsproxy.h>
> > +#include <keys/keyring-type.h>
> > +#include <keys/user-type.h>
> 
> Why #include user-type.h here?
> 
> > +struct keyring_index {
> > +	struct rhashtable	ht;
> > +	struct list_head	all;
> > +	struct list_head	keyrings;
> > +	unsigned long		nr;		/* Number of committed links */
> 
> Given key->serial is 1-INT_MAX, nr probably doesn't need to be unsigned long -
> otoh, it's not likely to leave a hole, I guess.
> 
> > +struct keyring_link {
> 
> I wonder if keyring_entry would be a better name, but the docs do mention
> making and removing links.
> 
> > +	unsigned long		hash;
> > ...
> > +	struct rcu_head		rcu;
> 
> Can they be in a union?  And I would put rcu first as I think there are (or
> maybe used to be) some things that required it to be first.
> 
> > +	struct list_head	keyrings_link;	/* in keyring_index::keyrings */
> 
> This may be unnecessary if you can put keyrings at the front of the list.
> 
> > +	struct keyring_link	*replaces;	/* Link this one replaces, or NULL */
> 
> Please don't put this in keyring_link.  It's only needed by __key_link() and
> friends and could be passed around in a context struct as the edit script is
> done now:
> 
> 	struct keyring_link_context {
> 		struct keyring_link *spare;	/* Spare link block */
> 		struct keyring_link *replace;	/* Link being replaced */
> 	};
> 
> then:
> 
> 	 int __key_link_begin(struct key *keyring,
> 			     const struct keyring_index_key *index_key,
> 	-		     struct assoc_array_edit **_edit)
> 	+		     struct keyring_link_context **_edit)
> 
> > +/*
> > + * Remove every link from a keyring.  The caller holds keyring->sem
> > + * write-locked.  A concurrent RCU reader can see some of the links gone and
> > + * others not yet.
> > + */
> > +static void keyring_remove_all_links(struct key *keyring)
> > +{
> > +	struct keyring_index *links = keyring_index_locked(keyring);
> > +	struct keyring_link *link, *tmp;
> > +
> > +	if (!links)
> > +		return;
> > +	list_for_each_entry_safe(link, tmp, &links->all, all_link)
> > +		keyring_remove_link(links, link);
> >  }
> > ...
> >  int keyring_clear(struct key *keyring)
> >  {
> > ...
> > +	keyring_remove_all_links(keyring);
> 
> This can be made atomic by replacing the key->links pointer value with NULL
> (since key->links is marked __rcu), then destroying the content afterwards.

Great remarks. I'll try to address them all together when I address
Eric's remarks and there's been a few cleanups I've made. I'll fuse
this all together but there's one thing.

I just sent a patch set, which is a result of going through the
head of the patch set and hand-crafted bug fixes that make
sense and dropped false positives. If we could get those ack'd
soon I could then iterate a cleaner version of this patch
set.

> 
> David
> 

Br, Jarkko
