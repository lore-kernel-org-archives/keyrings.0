From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 06 Apr 2020 16:41:31 +0000
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <CAHk-=whgvhyi_=2AsfFLUznqmrO9TOjuzTvcYHvCC=f0+Y7PkQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <a291cce3ff1ba978e7ad231a8e1b7d82f6164e86.camel@perches.com>
 <20200406023700.1367-1-longman@redhat.com> <319765.1586188840@warthog.procyon.org.uk>
 <d509771b7e08fff0d18654b746e413e93ed62fe8.camel@perches.com>
In-Reply-To: <d509771b7e08fff0d18654b746e413e93ed62fe8.camel@perches.com>
To: Joe Perches <joe@perches.com>
Cc: David Howells <dhowells@redhat.com>, Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Apr 6, 2020 at 9:12 AM Joe Perches <joe@perches.com> wrote:
>
> While I agree with Linus about the __ prefix,
> the z is pretty common and symmetric to all
> the <foo>zalloc uses.

Yes, we have a pattern of 'z' for zero.

But the _operation_ isn't symmetric.

"kzalloc()" has absolutely _nothing_ to do with "kzfree()". They are
not some kind of "opposite symmetric operation".  They are totally
different. They have absolutely nothing in common.

So using the same naming is wrong. They have one implementation detail
that looks superficially similar ("zero the area"), but even that
superficial similarity is actually completely false. They may both use
"memset()", but in one case it is correct and makes sense, and in the
other case it's actually a bug waiting to happen, and you really
should use that "memzero_explicit()", which is a very very different
operation from a normal memzero().

So even the implementation isn't really validly similar, but even if
it had been, the _reason_ for doing so is completely different.

They simply don't really pair up in any way.

             Linus
