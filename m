From: David Howells <dhowells@redhat.com>
Date: Mon, 06 Apr 2020 07:44:13 +0000
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <6504.1586159053@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <alpine.DEB.2.21.2004052119530.243304@chino.kir.corp.google.com> <20200406023700.1367-1-longman@redhat.com>
In-Reply-To: <alpine.DEB.2.21.2004052119530.243304@chino.kir.corp.google.com>
To: David Rientjes <rientjes@google.com>
Cc: dhowells@redhat.com, Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

David Rientjes <rientjes@google.com> wrote:

> > +static inline void kvfree_sensitive(const void *addr, size_t len)
> > +{
> > +	if (addr) {
> 
> Shouldn't this be if (unlikely(ZERO_OR_NULL_PTR(addr))?

You've reversed the logic - it needs a '!' there.

David
