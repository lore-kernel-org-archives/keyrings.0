From: Matthew Wilcox <willy@infradead.org>
Date: Mon, 06 Apr 2020 17:24:44 +0000
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <20200406172444.GG21484@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <d509771b7e08fff0d18654b746e413e93ed62fe8.camel@perches.com>
 <a291cce3ff1ba978e7ad231a8e1b7d82f6164e86.camel@perches.com>
 <20200406023700.1367-1-longman@redhat.com>
 <319765.1586188840@warthog.procyon.org.uk>
 <334933.1586190389@warthog.procyon.org.uk>
 <dbfcbbd55c63fc87bfb31af3cae1b15e04d8a821.camel@perches.com>
In-Reply-To: <dbfcbbd55c63fc87bfb31af3cae1b15e04d8a821.camel@perches.com>
To: Joe Perches <joe@perches.com>
Cc: David Howells <dhowells@redhat.com>, Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-mm@kvack.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Apr 06, 2020 at 10:10:20AM -0700, Joe Perches wrote:
> On Mon, 2020-04-06 at 17:26 +0100, David Howells wrote:
> > Joe Perches <joe@perches.com> wrote:
> > 
> > > While I agree with Linus about the __ prefix,
> > > the z is pretty common and symmetric to all
> > > the <foo>zalloc uses.
> > > 
> > > And if _sensitive is actually used, it'd be
> > > good to do a s/kzfree/kfree_sensitive/ one day
> > > sooner than later.
> > 
> > How much overhead would it be to always use kvfree_sensitive() and never have
> > a kfree_sensitive()?
> 
> Another possibility:
> 
> Add yet another alloc flag like __GFP_SENSITIVE
> and have kfree operate on that and not have a
> kfree_sensitive at all.

kfree() doesn't take GFP flags.
