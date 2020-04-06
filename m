From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 06 Apr 2020 18:06:02 +0000
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <CAHk-=wgjiHUWLZWKZJ4eU+RrOc2xNZCHn4ETmJ0S+H=Eig28Cw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <a291cce3ff1ba978e7ad231a8e1b7d82f6164e86.camel@perches.com>
 <20200406023700.1367-1-longman@redhat.com> <319765.1586188840@warthog.procyon.org.uk>
 <d509771b7e08fff0d18654b746e413e93ed62fe8.camel@perches.com> <19cbf3b1-2c3f-dd0f-a5c6-69ca3f77dd68@redhat.com>
In-Reply-To: <19cbf3b1-2c3f-dd0f-a5c6-69ca3f77dd68@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Joe Perches <joe@perches.com>, David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Apr 6, 2020 at 10:59 AM Waiman Long <longman@redhat.com> wrote:
>
> I have actually been thinking about that. I saw a couple of cases in the
> crypto code where a memzero_explicit() is followed by kfree(). Those can
> be replaced by kfree_sensitive.

Ack.

Doing that (and renaming kvzfree) should be a fairly straightforward
coccinelle patch.

Somebody (maybe you) asked whether we could just use
kvfree_sensitive() for everything, We probably could. The extra test
is cheap - much cheaper than the memzero_explicit().

That said, _there_ I think that consistency with regular kfree/kvfree
naming means that we might as well keep separate names, and keep the
kmalloc->kfree_sensitive and kvmalloc->kvfree_sensitive pairing. Even
if technically we could do with just the one function that works for
both cases.

            Linus
