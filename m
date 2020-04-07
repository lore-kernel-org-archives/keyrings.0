From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 07 Apr 2020 20:16:47 +0000
Subject: Re: [PATCH v2] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <CAHk-=wg_mkSc-pH8ntGHR=no9DOLRQyxdtU20p55DrM1su6QzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200406185827.22249-1-longman@redhat.com> <c2c8adf48be7cb18bbdf0aef7d21e2defe3d2183.camel@perches.com>
In-Reply-To: <c2c8adf48be7cb18bbdf0aef7d21e2defe3d2183.camel@perches.com>
To: Joe Perches <joe@perches.com>
Cc: Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>

On Mon, Apr 6, 2020 at 12:40 PM Joe Perches <joe@perches.com> wrote:
>
> 2.1.44 changed kfree(void *) to kfree(const void *) but
> I didn't find a particular reason why.

Because "free()" should always have been const (and volatile, for that
matter, but the kernel doesn't care since we eschew volatile data
structures).

It's a bug in the C library standard.

Think of it this way: free() doesn't really change the data, it kills
the lifetime of it. You can't access it afterwards - you can neither
read it nor write it validly. That is a completely different - and
independent - operation from writing to it.

And  more importantly, it's perfectly fine to have a const data
structure (or a volatile one) that you free. The allocation may have
done something like this:

   struct mystruct {
       const struct dictionary *dictionary;
       ...
   };

and it was allocated and initialized before it was assigned to that
"dictionary" pointer. That's _good_ code.

So it wasn't const before the allocation, but it turned const
afterwards, and freeing it doesn't change that, it just kills the
lifetime entirely.

So "free()" should take a const pointer without complaining, and saying

   free(mystruct->dictionary);
   free(mystruct);

is a sensible an correct thing to do. Warning about - or requiring
that dictionary pointer to be cast to be freed - is fundamentally
wrong.

We're not bound by the fact that the C standard library got their
rules wrong, so we can fix it in the kernel.

             Linus
