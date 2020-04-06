From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 06 Apr 2020 17:58:28 +0000
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <CAHk-=wgT6W7z-ZUB=hqx96tp+u2Hg-0KbnnWWufwVWbVgXXHXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <d509771b7e08fff0d18654b746e413e93ed62fe8.camel@perches.com>
 <a291cce3ff1ba978e7ad231a8e1b7d82f6164e86.camel@perches.com>
 <20200406023700.1367-1-longman@redhat.com> <319765.1586188840@warthog.procyon.org.uk>
 <334933.1586190389@warthog.procyon.org.uk> <dbfcbbd55c63fc87bfb31af3cae1b15e04d8a821.camel@perches.com>
 <CAHk-=wiPHA4XbL-CVTDBwjYzUJwaGYriGD44uvOaqQai+zOw6A@mail.gmail.com> <354824.1586195497@warthog.procyon.org.uk>
In-Reply-To: <354824.1586195497@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Joe Perches <joe@perches.com>, Waiman Long <longman@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Apr 6, 2020 at 10:51 AM David Howells <dhowells@redhat.com> wrote:
>
> The allocation might be by vmalloc rather than kmalloc.  I'm not sure if that
> makes things more difficult.

It does add yet another place where we'd have to save the "this
allocation is special", but it's not insurmountable.

That said, I think the short-term and simple solution is to just teach
people that sensitive free's are different, and at least have the key
subsystem with sane naming.

And yes, then eventually convert the existing crypto subsystem uses
too for consistency.

            Linus
