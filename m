From: Matthew Wilcox <willy@infradead.org>
Date: Tue, 07 Apr 2020 22:24:11 +0000
Subject: Re: [PATCH v2] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <20200407222411.GN21484@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHk-=wg2Vsb0JETo24=Tc-T2drwMopMRfKnc__r5SZ6tEnbwcA@mail.gmail.com>
 <20200406185827.22249-1-longman@redhat.com>
 <c2c8adf48be7cb18bbdf0aef7d21e2defe3d2183.camel@perches.com>
 <CAHk-=wg_mkSc-pH8ntGHR=no9DOLRQyxdtU20p55DrM1su6QzA@mail.gmail.com>
 <699292.1586294051@warthog.procyon.org.uk>
In-Reply-To: <699292.1586294051@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Joe Perches <joe@perches.com>, Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Rientjes <rientjes@google.com>

On Tue, Apr 07, 2020 at 10:14:11PM +0100, David Howells wrote:
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
> 
> > So the _real_ prototype for 'free()'-like operations should be something like
> > 
> >     void free(const volatile killed void *ptr);
> > 
> > where that "killed" also tells the compiler that the pointer lifetime
> > is dead, so that using it afterwards is invalid. So that the compiler
> > could warn us about some of the most trivial use-after-free cases.
> 
> It might be worth asking the compiler folks to give us an __attribute__ for
> that - even if they don't do anything with it immediately.  So we might have
> something like:
> 
> 	void free(const volatile void *ptr) __attribute__((free(1)));
> 
> There are some for allocation functions, some of which we use, though I'm not
> sure we do so as consistently as we should (should inline functions like
> kcalloc() have them, for example?).

GCC recognises free() as being a __builtin.  I don't know if there's
an __attribute__ for it.

gcc/builtins.def:DEF_LIB_BUILTIN        (BUILT_IN_FREE, "free", BT_FN_VOID_PTR, ATTR_NOTHROW_LEAF_LIST)

It looks like the only two things this really does is warn you if you
try to free a pointer that gcc can prove isn't in the heap, and elide
the call if gcc can prove it's definitely NULL.  Which are both things
that a compiler should do, but aren't all that valuable.
