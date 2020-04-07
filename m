From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 07 Apr 2020 21:30:56 +0000
Subject: Re: [PATCH v3] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <CAHk-=whrZLs=+VkBXS_KWrMwoM2PRmw6mKEPJHRBQ_e3raFh9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200407200318.11711-1-longman@redhat.com> <0fe5dcaf078be61ef21c7f18b750c5dc14c69dd7.camel@perches.com>
 <67c51b03-192c-3006-5071-452f351aee67@redhat.com> <CAHk-=whV5Z4XioUOW0UM-PBrW7iqb0HwWKQU5Vn8b5pmsDm=Ww@mail.gmail.com>
 <20200407212447.GA29554@pc636>
In-Reply-To: <20200407212447.GA29554@pc636>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Waiman Long <longman@redhat.com>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>, David Rientjes <rientjes@google.com>

On Tue, Apr 7, 2020 at 2:25 PM Uladzislau Rezki <urezki@gmail.com> wrote:
>
> Seems like there is only one place where we can "sleep". I mean when we
> call vfree(). That is free_vmap_area_noflush() -> try_purge_vmap_area_lazy().
> Basically try_purge_vmap_area_lazy() can call the schedule() what is not
> allowed for IRQs. Instead of inlining the try_purge_vmap_area_lazy()
> into current context we can schedule_work(). And i think it makes sense
> from many point of views.

I don't think that's the only case.

Or rather, that may be the only case of _sleeping_, but we also aren't
irq-safe wrt locking.

And I'm not just talking about the vmap_purge_lock mutex, but all the
spinlocks etc we have.

That said, I haven't looked at that code in _ages_. Maybe those things
would be trivial to just turn into irq-safe ones and there are no real
latency issues anywhere.

                Linus
