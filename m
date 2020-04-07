From: David Howells <dhowells@redhat.com>
Date: Tue, 07 Apr 2020 21:14:11 +0000
Subject: Re: [PATCH v2] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <699292.1586294051@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHk-=wg2Vsb0JETo24=Tc-T2drwMopMRfKnc__r5SZ6tEnbwcA@mail.gmail.com> <20200406185827.22249-1-longman@redhat.com> <c2c8adf48be7cb18bbdf0aef7d21e2defe3d2183.camel@perches.com> <CAHk-=wg_mkSc-pH8ntGHR=no9DOLRQyxdtU20p55DrM1su6QzA@mail.gmail.com>
In-Reply-To: <CAHk-=wg2Vsb0JETo24=Tc-T2drwMopMRfKnc__r5SZ6tEnbwcA@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Joe Perches <joe@perches.com>, Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So the _real_ prototype for 'free()'-like operations should be something like
> 
>     void free(const volatile killed void *ptr);
> 
> where that "killed" also tells the compiler that the pointer lifetime
> is dead, so that using it afterwards is invalid. So that the compiler
> could warn us about some of the most trivial use-after-free cases.

It might be worth asking the compiler folks to give us an __attribute__ for
that - even if they don't do anything with it immediately.  So we might have
something like:

	void free(const volatile void *ptr) __attribute__((free(1)));

There are some for allocation functions, some of which we use, though I'm not
sure we do so as consistently as we should (should inline functions like
kcalloc() have them, for example?).

David
