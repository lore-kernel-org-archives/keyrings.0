From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 01 Apr 2020 15:33:57 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <1445647.1585576702@warthog.procyon.org.uk>
 <2418286.1585691572@warthog.procyon.org.uk> <20200401144109.GA29945@gardel-login>
In-Reply-To: <20200401144109.GA29945@gardel-login>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: David Howells <dhowells@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>

On Wed, Apr 1, 2020 at 4:41 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> On Di, 31.03.20 22:52, David Howells (dhowells@redhat.com) wrote:
>
> > Christian Brauner <christian.brauner@ubuntu.com> wrote:
> >
> > > querying all properties of a mount atomically all-at-once,
> >
> > I don't actually offer that, per se.
> >
> > Having an atomic all-at-once query for a single mount is actually quite a
> > burden on the system.  There's potentially a lot of state involved, much of
> > which you don't necessarily need.
>
> Hmm, do it like with statx() and specify a mask for the fields userspace
> wants? Then it would be as lightweight as it possibly could be?

Yes, however binary structures mixed with variable length fields are
not going to be pretty.

Again, if we want something even halfway sane for a syscall interface,
go with a string key/value vector.

If that's really needed.  I've still not heard a convincing argument
in favor of a syscall.

Thanks,
Miklos
