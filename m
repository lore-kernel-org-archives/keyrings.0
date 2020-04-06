From: David Rientjes <rientjes@google.com>
Date: Mon, 06 Apr 2020 23:20:12 +0000
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <alpine.DEB.2.21.2004061618580.45667@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <alpine.DEB.2.21.2004052119530.243304@chino.kir.corp.google.com> <20200406023700.1367-1-longman@redhat.com> <6504.1586159053@warthog.procyon.org.uk>
In-Reply-To: <6504.1586159053@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, 6 Apr 2020, David Howells wrote:

> David Rientjes <rientjes@google.com> wrote:
> 
> > > +static inline void kvfree_sensitive(const void *addr, size_t len)
> > > +{
> > > +	if (addr) {
> > 
> > Shouldn't this be if (unlikely(ZERO_OR_NULL_PTR(addr))?
> 
> You've reversed the logic - it needs a '!' there.
> 

Ah lol, yeah.  Probably just better to do

	if (unlikely(ZERO_OR_NULL_PTR(addr)))
		return;

but I agree that mm.h is likely not the right spot.
