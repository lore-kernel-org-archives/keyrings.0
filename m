From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Fri, 03 Apr 2020 12:05:23 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <CAFLxGvyegY-p6MWCBZADRYjrxH17P+EEajupYYojqRkfkoNM3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <1445647.1585576702@warthog.procyon.org.uk>
 <2418286.1585691572@warthog.procyon.org.uk> <20200401144109.GA29945@gardel-login>
 <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
 <2590640.1585757211@warthog.procyon.org.uk> <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net>
 <20200403111144.GB34663@gardel-login> <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
In-Reply-To: <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Lennart Poettering <mzxreary@0pointer.de>, Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Aleksa Sarai <cyphar@cyphar.com>

On Fri, Apr 3, 2020 at 1:40 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
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

I was looking more than once for a nice way to get the mount id.
Having it exposed via statx() would be great!

-- 
Thanks,
//richard
