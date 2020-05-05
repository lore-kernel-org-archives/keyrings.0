From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 05 May 2020 20:35:21 +0000
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <20200505133521.eb8901d0b92e09452191ab49@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <694135.1586290793@warthog.procyon.org.uk>
	<20200407200318.11711-1-longman@redhat.com>
	<694340.1586290917@warthog.procyon.org.uk>
In-Reply-To: <694340.1586290917@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>

On Tue, 07 Apr 2020 21:21:57 +0100 David Howells <dhowells@redhat.com> wrote:

> David Howells <dhowells@redhat.com> wrote:
> 
> > >  			if (unlikely(key_data))
> > > -				__kvzfree(key_data, key_data_len);
> > > +				kvfree_sensitive(key_data, key_data_len);
> > 
> > I think the if-statement is redundant.
> 
> Ah - I see that you explicitly wanted to keep it.

Why's that?

> There's a good chance it'll get janitored at some point.

Indeed.  Perhaps add a few little comments to explain the reasoning and
to keep the janitorial fingers away?
