From: Uladzislau Rezki <urezki@gmail.com>
Date: Tue, 07 Apr 2020 21:24:47 +0000
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <20200407212447.GA29554@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200407200318.11711-1-longman@redhat.com>
 <0fe5dcaf078be61ef21c7f18b750c5dc14c69dd7.camel@perches.com>
 <67c51b03-192c-3006-5071-452f351aee67@redhat.com>
 <CAHk-=whV5Z4XioUOW0UM-PBrW7iqb0HwWKQU5Vn8b5pmsDm=Ww@mail.gmail.com>
In-Reply-To: <CAHk-=whV5Z4XioUOW0UM-PBrW7iqb0HwWKQU5Vn8b5pmsDm=Ww@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Waiman Long <longman@redhat.com>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>

On Tue, Apr 07, 2020 at 02:01:01PM -0700, Linus Torvalds wrote:
> On Tue, Apr 7, 2020 at 1:45 PM Waiman Long <longman@redhat.com> wrote:
> >
> > If the memory is really virtually mapped, the only way to find out the
> > size of the object is to use find_vm_area() which can be relatively high
> > cost and no simple helper function is available.
> 
> We _could_ just push it down to a "vfree_sensitive()", and do it
> inside the vfree logic. That ends up obviously figuring out the size
> of the area eventually.
> 
> But since the vmalloc data structures fundamentally aren't irq-safe,
> vfree() actually has magical things like "if called in an interrupt,
> we'll delay it to work context".
> 
Just some thoughts. Sorry for jumping in.

Seems like there is only one place where we can "sleep". I mean when we
call vfree(). That is free_vmap_area_noflush() -> try_purge_vmap_area_lazy().
Basically try_purge_vmap_area_lazy() can call the schedule() what is not 
allowed for IRQs. Instead of inlining the try_purge_vmap_area_lazy()
into current context we can schedule_work(). And i think it makes sense
from many point of views.

Also, we can end up in zeroed non-existance vmap area if we do not find_vmap_area().

Thanks!

--
Vlad Rezki
