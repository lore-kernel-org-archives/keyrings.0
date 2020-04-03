From: Lennart Poettering <mzxreary@0pointer.de>
Date: Fri, 03 Apr 2020 15:12:23 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <20200403151223.GB34800@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <2418286.1585691572@warthog.procyon.org.uk>
 <20200401144109.GA29945@gardel-login>
 <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
 <2590640.1585757211@warthog.procyon.org.uk>
 <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net>
 <20200403111144.GB34663@gardel-login>
 <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
In-Reply-To: <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>

On Fr, 03.04.20 13:38, Miklos Szeredi (miklos@szeredi.hu) wrote:

> On Fri, Apr 3, 2020 at 1:11 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
> >
> > On Fr, 03.04.20 09:44, Ian Kent (raven@themaw.net) wrote:
> >
> > > > Currently the only way to find the mount id from a path is by parsing
> > > > /proc/self/fdinfo/$fd.  It is trivial, however, to extend statx(2) to
> > > > return it directly from a path.   Also the mount notification queue
> > > > that David implemented contains the mount ID of the changed mount.
> >
> > I would love to have the mount ID exposed via statx().
>
> Here's a patch.

Oh, this is excellent. I love it, thanks!

BTW, while we are at it: one more thing I'd love to see exposed by
statx() is a simple flag whether the inode is a mount point. There's
plenty code that implements a test like this all over the place, and
it usually isn't very safe. There's one implementation in util-linux
for example (in the /usr/bin/mountpoint binary), and another one in
systemd. Would be awesome to just have a statx() return flag for that,
that would make things *so* much easier and more robust. because in
fact most code isn't very good that implements this, as much of it
just compares st_dev of the specified file and its parent. Better code
compares the mount ID, but as mentioned that's not as pretty as it
could be so far...

Lennart

--
Lennart Poettering, Berlin
