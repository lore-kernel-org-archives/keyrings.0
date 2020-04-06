From: Matthew Wilcox <willy@infradead.org>
Date: Mon, 06 Apr 2020 14:39:51 +0000
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <20200406143951.GD21484@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200406023700.1367-1-longman@redhat.com>
 <alpine.DEB.2.21.2004052119530.243304@chino.kir.corp.google.com>
 <3f6658e5-0082-7759-1d08-eda9cb3eba2f@redhat.com>
In-Reply-To: <3f6658e5-0082-7759-1d08-eda9cb3eba2f@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: David Rientjes <rientjes@google.com>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Apr 06, 2020 at 10:36:07AM -0400, Waiman Long wrote:
> ZERO_OR_NULL_PTR is defined in slab.h. Using it may cause some header
> file dependency problem. To guard against the possibility of 0-length
> allocation request, how about just

Why is all the kvalloc/kvfree crap in mm.h to begin with?  slab.h is
a more sensible place to put it.  I had a patch to do that once, but I
think it went stale before I posted it.
