From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 07 Apr 2020 20:26:57 +0000
Subject: Re: [PATCH v2] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <CAHk-=wg2Vsb0JETo24=Tc-T2drwMopMRfKnc__r5SZ6tEnbwcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200406185827.22249-1-longman@redhat.com> <c2c8adf48be7cb18bbdf0aef7d21e2defe3d2183.camel@perches.com>
 <CAHk-=wg_mkSc-pH8ntGHR=no9DOLRQyxdtU20p55DrM1su6QzA@mail.gmail.com>
In-Reply-To: <CAHk-=wg_mkSc-pH8ntGHR=no9DOLRQyxdtU20p55DrM1su6QzA@mail.gmail.com>
To: Joe Perches <joe@perches.com>
Cc: Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>

On Tue, Apr 7, 2020 at 1:16 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Think of it this way: free() doesn't really change the data, it kills
> the lifetime of it. You can't access it afterwards - you can neither
> read it nor write it validly. That is a completely different - and
> independent - operation from writing to it.

Side note: I'd really love to be able to describe that operation, but
there's sadly no such extension.

So the _real_ prototype for 'free()'-like operations should be something like

    void free(const volatile killed void *ptr);

where that "killed" also tells the compiler that the pointer lifetime
is dead, so that using it afterwards is invalid. So that the compiler
could warn us about some of the most trivial use-after-free cases.

Because we've had even those trivially stupid ones

Yes, obviously various analysis systems do exactly that kind of
analysis (and usually go much further), but then it's external things
like coverity etc.

The point being that the lifetime of an object is independent from
being able to write to an object, and the "const" in the "free()" is
not "I promise to not write to it", but "I can accept a constant
pointer".

We've had a number of places in the kernel where we do that kind of
"lifetime" marking explicitly by assigning a NULL (or invalid value)
to the pointer when we free it.

I have this dim memory of us even (long long long ago) trying to use a
#define kfree() ... to do that, but it turns out to be basically
impossible to get the proper "use once" semantics, so it doesn't work
if the argument to kfree() has side effects.

               Linus
