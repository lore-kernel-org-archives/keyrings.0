From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 08 Apr 2020 03:36:27 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <CAHk-=wgNuJaJS9Vfe83Tfgq92PonhpfLy1-vvG63SC=3VYf3+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net>
 <20200403111144.GB34663@gardel-login> <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
 <20200403151223.GB34800@gardel-login> <20200403203024.GB27105@fieldses.org>
 <20200406091701.q7ctdek2grzryiu3@ws.net.home> <CAHk-=wjW735UE+byK1xsM9UvpF2ubh7bCMaAOwz575U7hRCKyA@mail.gmail.com>
 <20200406184812.GA37843@gardel-login>
In-Reply-To: <20200406184812.GA37843@gardel-login>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Karel Zak <kzak@redhat.com>, "J. Bruce Fields" <bfields@fieldses.org>, Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Aleksa Sarai <cyphar@cyphar.com>

On Mon, Apr 6, 2020 at 11:48 AM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> On Mo, 06.04.20 09:34, Linus Torvalds (torvalds@linux-foundation.org) wrote:
>
> > On Mon, Apr 6, 2020 at 2:17 AM Karel Zak <kzak@redhat.com> wrote:
> > >
> > > On Fri, Apr 03, 2020 at 04:30:24PM -0400, J. Bruce Fields wrote:
> > > >
> > > > nfs-utils/support/misc/mountpoint.c:check_is_mountpoint() stats the file
> > > > and ".." and returns true if they have different st_dev or the same
> > > > st_ino.  Comparing mount ids sounds better.
> > >
> > > BTW, this traditional st_dev+st_ino way is not reliable for bind mounts.
> > > For mountpoint(1) we search the directory in /proc/self/mountinfo.
> >
> > These days you should probably use openat2() with RESOLVE_NO_XDEV.
>
> Note that opening a file is relatively "heavy" i.e. typically triggers
> autofs and stuff, and results in security checks (which can fail and
> such, and show up in audit).

For the use that Bruce outlined, openat2() with RESOLVE_NO_XDEV is
absolutely the right thing.

He already did the stat() of the file (and ".."), RESOLVE_NO_XDEV is
only an improvement. It's also a lot better than trying to parse
mountinfo.

Now, I don't disagree that a statx() flag to also indicate "that's a
top-level mount" might be a good idea, and may be the right answer for
other cases.

I'm just saying that considering what Bruce does now, RESOLVE_NO_XDEV
sounds like the nobrainer approach, and needs no new support outside
of what we already had for other reasons.

(And O_PATH _may_ or may not be part of what you want to do, it's an
independent separate issue, but automount behavior wrt a O_PATH lookup
is somewhat unclear - see Al's other emails on that subject)

             Linus
