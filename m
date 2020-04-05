From: Andres Freund <andres@anarazel.de>
Date: Sun, 05 Apr 2020 22:52:40 +0000
Subject: Re: [GIT PULL] Mount and superblock notifications
Message-Id: <20200405225240.kofadjkmpigfzcfy@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1445647.1585576702@warthog.procyon.org.uk>
 <1449543.1585579014@warthog.procyon.org.uk>
 <CAHk-=wghjTM+z_oAATqWOvPa8Lh6BKRtTVMi7hLxo6pbqc+kVg@mail.gmail.com>
In-Reply-To: <CAHk-=wghjTM+z_oAATqWOvPa8Lh6BKRtTVMi7hLxo6pbqc+kVg@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, jlayton@redhat.com, Ian Kent <raven@themaw.net>, Christian Brauner <christian.brauner@ubuntu.com>, keyrings@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi,

On 2020-04-04 14:13:03 -0700, Linus Torvalds wrote:
> And it needs to be interesting and pressing enough that those people
> actually at least do a working prototype on top of a patch-set that
> hasn't made it into the kernel yet.
> 
> Now, I realize that other projects won't _upstream_ their support
> before the kernel has the infrastructure, so I'm not looking for
> _that_ kind of "yeah, look, project XYZ already does this and Red Hat
> ships it". No, I'm looking for those outside developers who say more
> than "this is a pet peeve of mine with the existing interface". I want
> to see some actual use - even if it's just in a development
> environment - that shows that it's (a) sufficient and (b) actually
> fixes problems.

FWIW, postgres remains interested in using the per-superblock events.

On 2020-03-30 15:36:54 +0100, David Howells wrote:
>  (2) Superblock notifications.
> 
>      This one is provided to allow systemd or the desktop to more easily
>      detect events such as I/O errors and EDQUOT/ENOSPC.  This would be of
>      interest to Postgres:
> 
> 	https://lore.kernel.org/linux-fsdevel/20200211005626.7yqjf5rbs3vbwagd@alap3.anarazel.de/
> 
>      But could also be used to indicate to systemd when a superblock has
>      had its configuration changed.

What prevents me from coming up with a prototype is that the error
handling pieces aren't complete, as far as I can tell:

On 2020-03-30 15:36:54 +0100, David Howells wrote:
>  (2) Superblock events, such as R/W<->R/O changes, quota overrun and I/O
>      errors (not complete yet).

There's afaict no notify_sb_error() callers, making it hard for me to
actually test anything.

The important issue for us is I/O errors, but EDQUOT/ENOSPC could also
be useful (but is not urgent).

Greetings,

Andres Freund
