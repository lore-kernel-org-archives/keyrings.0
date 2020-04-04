From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 04 Apr 2020 21:13:03 +0000
Subject: Re: [GIT PULL] Mount and superblock notifications
Message-Id: <CAHk-=wghjTM+z_oAATqWOvPa8Lh6BKRtTVMi7hLxo6pbqc+kVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1445647.1585576702@warthog.procyon.org.uk> <1449543.1585579014@warthog.procyon.org.uk>
In-Reply-To: <1449543.1585579014@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, jlayton@redhat.com, Ian Kent <raven@themaw.net>, andres@anarazel.de, Christian Brauner <christian.brauner@ubuntu.com>, keyrings@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Mon, Mar 30, 2020 at 7:37 AM David Howells <dhowells@redhat.com> wrote:
>
> If you could consider pulling this - or would you prefer it to go through
> Al?  It adds a couple of VFS-related event sources for the general
> notification mechanism:

<y issue with these remains the same it was last time, so I'll just
quote what I said back then:

 "So I no longer hate the implementation, but I do want to see the
  actual user space users come out of the woodwork and try this out for
  their use cases.

  I'd hate to see a new event queue interface that people then can't
  really use due to it not fulfilling their needs, or can't use for some
  other reason."

I want to see somebody step up enough to say "yes, I actually use
this, and have the patches for the user space side, and it helps my
load by 3000%, and here are the numbers, and the event overflow case
isn't an issue because Y"

Or whatever. It doesn't have to be performance, but the separate
discussion I've seen has been about that being the reason for it.

I just don't want it to be a _hypothetical_ reason. I want it to be a
tested reason where people said "yeah, this is easy to use and
actually fixes the problems".

Because if what happens is that when the events overflow, and maybe
people fall back on the old model (or whatever) then that probably
just means that you do better up until a point where you start doing
_worse_ than we used to.

Or people find out that they needed more information anyway, and the
event model doesn't work when you restart your special server because
you've lost the original state. Or any other number of "cool feature,
but I can't really use it".

IOW, I really want to know that yes, the design is what people will
then use and it actually fixes real-world issues.

And it needs to be interesting and pressing enough that those people
actually at least do a working prototype on top of a patch-set that
hasn't made it into the kernel yet.

Now, I realize that other projects won't _upstream_ their support
before the kernel has the infrastructure, so I'm not looking for
_that_ kind of "yeah, look, project XYZ already does this and Red Hat
ships it". No, I'm looking for those outside developers who say more
than "this is a pet peeve of mine with the existing interface". I want
to see some actual use - even if it's just in a development
environment - that shows that it's (a) sufficient and (b) actually
fixes problems.

             Linus
