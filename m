From: Joe Perches <joe@perches.com>
Date: Mon, 06 Apr 2020 18:46:26 +0000
Subject: Re: [PATCH] mm: Add kvfree_sensitive() for freeing sensitive data objects
Message-Id: <fa6260781d8a87ea04ac2014ddabaf7066fcdcec.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <a291cce3ff1ba978e7ad231a8e1b7d82f6164e86.camel@perches.com>
	 <20200406023700.1367-1-longman@redhat.com>
	 <319765.1586188840@warthog.procyon.org.uk>
	 <d509771b7e08fff0d18654b746e413e93ed62fe8.camel@perches.com>
	 <19cbf3b1-2c3f-dd0f-a5c6-69ca3f77dd68@redhat.com>
	 <CAHk-=wgjiHUWLZWKZJ4eU+RrOc2xNZCHn4ETmJ0S+H=Eig28Cw@mail.gmail.com>
In-Reply-To: <CAHk-=wgjiHUWLZWKZJ4eU+RrOc2xNZCHn4ETmJ0S+H=Eig28Cw@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Waiman Long <longman@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Linux-MM <linux-mm@kvack.org>, keyrings@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, 2020-04-06 at 11:06 -0700, Linus Torvalds wrote:
> On Mon, Apr 6, 2020 at 10:59 AM Waiman Long <longman@redhat.com> wrote:
> > I have actually been thinking about that. I saw a couple of cases in the
> > crypto code where a memzero_explicit() is followed by kfree(). Those can
> > be replaced by kfree_sensitive.
> 
> Ack.
> 
> Doing that (and renaming kvzfree) should be a fairly straightforward
> coccinelle patch.

Not really as comment and prototype and existing cocci
scripts that contain kzfree are difficult to change.

A sed is straightforward and works well.

$ git grep -w --name-only kzfree | \
  xargs sed -i 's/\bkzfree\b/kfree_sensitive/'

For today's next that's:

$ git diff --shortstat
 116 files changed, 322 insertions(+), 322 deletions(-)

After this change:

The kernel-doc comment in slab_common.c should be
edited from zeroed to something else.

 * kfree_sensitive - like kfree but zero memory
 * @p: object to free memory of
 *
 * The memory of the object @p points to is zeroed before freed.
 * If @p is %NULL, kfree_sensitive() does nothing.
 *
 * Note: this function zeroes the whole allocated buffer which can be a good
 * deal bigger than the requested buffer size passed to kmalloc(). So be
 * careful when using this function in performance sensitive code.
 */
