From: David Howells <dhowells@redhat.com>
Date: Tue, 07 Apr 2020 22:54:10 +0000
Subject: Re: [PATCH v2] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <749735.1586300050@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHk-=whwaNvyd1q=h0nUQio9byojpxufGkOiVfAh10woRs8KSA@mail.gmail.com> <20200406185827.22249-1-longman@redhat.com> <c2c8adf48be7cb18bbdf0aef7d21e2defe3d2183.camel@perches.com> <CAHk-=wg_mkSc-pH8ntGHR=no9DOLRQyxdtU20p55DrM1su6QzA@mail.gmail.com> <CAHk-=wg2Vsb0JETo24=Tc-T2drwMopMRfKnc__r5SZ6tEnbwcA@mail.gmail.com> <699292.1586294051@warthog.procyon.org.uk>
In-Reply-To: <CAHk-=whwaNvyd1q=h0nUQio9byojpxufGkOiVfAh10woRs8KSA@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Joe Perches <joe@perches.com>, Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>, law@redhat.com

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > It might be worth asking the compiler folks to give us an __attribute__ for
> > that - even if they don't do anything with it immediately.  So we might have
> > something like:
> >
> >         void free(const volatile void *ptr) __attribute__((free(1)));
> 
> Yeah, that sounds sane.

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=94527

> Even if it wasn't initially used for anything it wouldn't hurt, and maybe
> some day it would improve warnings (and allow the compiler to do the dead
> store elimination that started this whole long set of threads in the first
> place..)

With regard to this, I've got back "not sure what Linus was talking about WRT
DSE, if he's got examples he could pass along, they'd be appreciated"

David
