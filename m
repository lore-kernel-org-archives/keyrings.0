From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 07 Apr 2020 21:22:33 +0000
Subject: Re: [PATCH v2] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <CAHk-=whwaNvyd1q=h0nUQio9byojpxufGkOiVfAh10woRs8KSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200406185827.22249-1-longman@redhat.com> <c2c8adf48be7cb18bbdf0aef7d21e2defe3d2183.camel@perches.com>
 <CAHk-=wg_mkSc-pH8ntGHR=no9DOLRQyxdtU20p55DrM1su6QzA@mail.gmail.com>
 <CAHk-=wg2Vsb0JETo24=Tc-T2drwMopMRfKnc__r5SZ6tEnbwcA@mail.gmail.com> <699292.1586294051@warthog.procyon.org.uk>
In-Reply-To: <699292.1586294051@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Joe Perches <joe@perches.com>, Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>

On Tue, Apr 7, 2020 at 2:14 PM David Howells <dhowells@redhat.com> wrote:
>
> It might be worth asking the compiler folks to give us an __attribute__ for
> that - even if they don't do anything with it immediately.  So we might have
> something like:
>
>         void free(const volatile void *ptr) __attribute__((free(1)));

Yeah, that sounds sane.

> There are some for allocation functions, some of which we use, though I'm not
> sure we do so as consistently as we should (should inline functions like
> kcalloc() have them, for example?).

I think that gcc supports a "malloc" attribute, but it's only used for
alias analysis optimizations, afaik (ie it says that the pointer the
function returns cannot alias anything else).

So we do have that "__malloc" thing, but I'm not sure how much it
actually matters.

And adding it to inline functions shouldn't be _wrong_, but it
shouldn't matter either, since I think the alias analysis would work
regardless.

I wonder how much of a code generation difference it makes. I suspect
not a lot, but maybe I'd be surprsied.

But yes, having the free attribute would be consistent (even if the
syntax for it might be as you suggest, kind of like the __printf()
attribute works). Even if it wasn't initially used for anything it
wouldn't hurt, and maybe some day it would improve warnings (and allow
the compiler to do the dead store elimination that started this whole
long set of threads in the first place..)

            Linus
