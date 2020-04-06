From: Joe Perches <joe@perches.com>
Date: Mon, 06 Apr 2020 17:20:24 +0000
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <7eb36a794df38c885689085618a8a4ff9df3dd2c.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <a291cce3ff1ba978e7ad231a8e1b7d82f6164e86.camel@perches.com>
	 <20200406023700.1367-1-longman@redhat.com>
	 <319765.1586188840@warthog.procyon.org.uk>
	 <d509771b7e08fff0d18654b746e413e93ed62fe8.camel@perches.com>
	 <CAHk-=whgvhyi_=2AsfFLUznqmrO9TOjuzTvcYHvCC=f0+Y7PkQ@mail.gmail.com>
	 <adc76d7c441e8f10697b61ceaff66207fb219886.camel@perches.com>
	 <CAHk-=wgyt8j5rEnyKE8YdrRjQof1kvyom1CensTE0-Bp-meGnA@mail.gmail.com>
In-Reply-To: <CAHk-=wgyt8j5rEnyKE8YdrRjQof1kvyom1CensTE0-Bp-meGnA@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, 2020-04-06 at 10:11 -0700, Linus Torvalds wrote:
> On Mon, Apr 6, 2020 at 9:44 AM Joe Perches <joe@perches.com> wrote:
> > Dubious assertion.  Both end up with zeroed memory.
> 
> You don't understand the function.

Another dubious assertion.

> You ignored the part where the zeroed memory isn't even the _point_.
> 
> Yes, for kzalloc() it is.  There the zero is inherent and important.
> People very much depend on it, and it's the whole point of that
> function. The 'z' is not silent.
> 
> But for kzfree() it really really isn't.  There the zeroing is never
> going to be seen by anybody wjho does the right thing, and is not
> important at all - it's purely a "let's make sure old contents don't
> leak".
> 
> The "zero" part is completely immaterial, it could just as well have
> been a "memset(0xaa)" instead.

or memfill(0xdeadbeef).
 
> And you didn't seem to understand that kzfree() shouldn't use memset()
> in the first place, so it's not even using the same operation.
> 
> You really don't seem to get the whole "kzfree() has absolutely
> _nothing_ to do with kzalloc() apart from a dubious implementation
> details".

API function naming symmetry is good.
You ignore or don't quote the kzfree/kfree_sensitive too.

Yet I don't say _you_ don't understand something.
