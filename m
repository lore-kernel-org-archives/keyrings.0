From: Lennart Poettering <mzxreary@0pointer.de>
Date: Mon, 06 Apr 2020 18:48:12 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <20200406184812.GA37843@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net>
 <20200403111144.GB34663@gardel-login>
 <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
 <20200403151223.GB34800@gardel-login>
 <20200403203024.GB27105@fieldses.org>
 <20200406091701.q7ctdek2grzryiu3@ws.net.home>
 <CAHk-=wjW735UE+byK1xsM9UvpF2ubh7bCMaAOwz575U7hRCKyA@mail.gmail.com>
In-Reply-To: <CAHk-=wjW735UE+byK1xsM9UvpF2ubh7bCMaAOwz575U7hRCKyA@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Karel Zak <kzak@redhat.com>, "J. Bruce Fields" <bfields@fieldses.org>, Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Aleksa Sarai <cyphar@cyphar.com>

On Mo, 06.04.20 09:34, Linus Torvalds (torvalds@linux-foundation.org) wrote:

> On Mon, Apr 6, 2020 at 2:17 AM Karel Zak <kzak@redhat.com> wrote:
> >
> > On Fri, Apr 03, 2020 at 04:30:24PM -0400, J. Bruce Fields wrote:
> > >
> > > nfs-utils/support/misc/mountpoint.c:check_is_mountpoint() stats the file
> > > and ".." and returns true if they have different st_dev or the same
> > > st_ino.  Comparing mount ids sounds better.
> >
> > BTW, this traditional st_dev+st_ino way is not reliable for bind mounts.
> > For mountpoint(1) we search the directory in /proc/self/mountinfo.
>
> These days you should probably use openat2() with RESOLVE_NO_XDEV.

Note that opening a file is relatively "heavy" i.e. typically triggers
autofs and stuff, and results in security checks (which can fail and
such, and show up in audit).

statx() doesn't do that, and that's explicitly documented
(i.e. AT_NO_AUTOMOUNT and stuff).

Hence, unless openat2() has some mechanism of doing something like an
"open() but not really" (O_PATH isn't really sufficient for this, no?)
I don't think it could be a good replacement for a statx() type check
if something is a mount point or not.

I mean, think about usecases: a common usecase for "is this a
mountpoint" checks are tools that traverse directory trees and want to
stop at submounts. They generally try to minimize operations and hence
stat stuff but don't open anything unless its what they look foor (or a
subdir they identified as a non-submount). Doing an extra openat2() in
between there doesn't sound so attractive, since you pay heavily...

Lennart

--
Lennart Poettering, Berlin
