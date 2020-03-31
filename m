From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Tue, 31 Mar 2020 08:15:07 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <20200331081507.f6an4x32cxwpxdpd@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1445647.1585576702@warthog.procyon.org.uk>
 <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
 <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com>
In-Reply-To: <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Lennart Poettering <lennart@poettering.net>, Aleksa Sarai <cyphar@cyphar.com>

On Tue, Mar 31, 2020 at 07:11:11AM +0200, Miklos Szeredi wrote:
> On Mon, Mar 30, 2020 at 11:17 PM Christian Brauner
> <christian.brauner@ubuntu.com> wrote:
> 
> > Fwiw, putting down my kernel hat and speaking as someone who maintains
> > two container runtimes and various other low-level bits and pieces in
> > userspace who'd make heavy use of this stuff I would prefer the fd-based
> > fsinfo() approach especially in the light of across namespace
> > operations, querying all properties of a mount atomically all-at-once,
> 
> fsinfo(2) doesn't meet the atomically all-at-once requirement.  Sure,
> it's possible to check the various change counters before and after a
> batch of calls to check that the result is consistent.  Still, that's
> not an atomic all-at-once query, if you'd really require that, than
> fsinfo(2) as it currently stands would be inadequate.

It at all that's only true for batch requests.

> 
> > and safe delegation through fds. Another heavy user of this would be
> > systemd (Cced Lennart who I've discussed this with) which would prefer
> > the fd-based approach as well. I think pulling this into a filesystem
> > and making userspace parse around in a filesystem tree to query mount
> > information is the wrong approach and will get messy pretty quickly
> > especially in the face of mount and user namespace interactions and
> > various other pitfalls.
> 
> Have you actually looked at my proposed patch?   Do you have concrete

Yes. So have others, Al actively disliked and nacked it and no-one got
excited about it.

> issues or just vague bad feelings?

We have had that discussion on-list where I made my "vague bad feelings"
clear where you responded with the same dismissive style so I don't see
the point in repeating this experience.

Again, I want to make it clear that here I'm stating my preference as a
user of this api and as such I don't want to have to parse through a
filesystem to get complex information about filesystems. We've had
fruitful discussions [1] around how fsinfo() ties in with supervised
mounts and the rest of the mount api and its clear and simple especially
in the face of namespaces and implements a nice delegation model. So +1
from me.

Christian

[1]: https://youtu.be/LN2CUgp8deo?th40
