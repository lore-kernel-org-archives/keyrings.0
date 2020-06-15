From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 15 Jun 2020 08:44:57 +0000
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and attribute change notifications [ver #5]
Message-Id: <CAJfpeguZuCTmCWf-mF3=iZQeaaUYRoCRU9wcyz_gCMD94-bFFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
 <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
 <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com> <0991792b6e2af0a5cc1a2c2257b535b5e6b032e4.camel@themaw.net>
In-Reply-To: <0991792b6e2af0a5cc1a2c2257b535b5e6b032e4.camel@themaw.net>
To: Ian Kent <raven@themaw.net>
Cc: David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, Nicolas Dichtel <nicolas.dichtel@6wind.com>, Christian Brauner <christian@brauner.io>, andres@anarazel.de, Jeff Layton <jlayton@redhat.com>, dray@redhat.com, Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org, Linux API <linux-api@vger.kernel.org>, linux-fsdevel@vger.kernel.org, LSM <linux-security-module@vger.kernel.org>, linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 5:07 AM Ian Kent <raven@themaw.net> wrote:
>
> On Thu, 2020-04-02 at 17:19 +0200, Miklos Szeredi wrote:
> >
> > > Firstly, a watch queue needs to be created:
> > >
> > >         pipe2(fds, O_NOTIFICATION_PIPE);
> > >         ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, 256);
> > >
> > > then a notification can be set up to report notifications via that
> > > queue:
> > >
> > >         struct watch_notification_filter filter = {
> > >                 .nr_filters = 1,
> > >                 .filters = {
> > >                         [0] = {
> > >                                 .type = WATCH_TYPE_MOUNT_NOTIFY,
> > >                                 .subtype_filter[0] = UINT_MAX,
> > >                         },
> > >                 },
> > >         };
> > >         ioctl(fds[1], IOC_WATCH_QUEUE_SET_FILTER, &filter);
> > >         watch_mount(AT_FDCWD, "/", 0, fds[1], 0x02);
> > >
> > > In this case, it would let me monitor the mount topology subtree
> > > rooted at
> > > "/" for events.  Mount notifications propagate up the tree towards
> > > the
> > > root, so a watch will catch all of the events happening in the
> > > subtree
> > > rooted at the watch.
> >
> > Does it make sense to watch a single mount?  A set of mounts?   A
> > subtree with an exclusion list (subtrees, types, ???)?
>
> Yes, filtering, perhaps, I'm not sure a single mount is useful
> as changes generally need to be monitored for a set of mounts.
>
> Monitoring a subtree is obviously possible because the monitor
> path doesn't need to be "/".
>
> Or am I misunderstanding what your trying to get at.
>
> The notion of filtering types and other things is interesting
> but what I've seen that doesn't fit in the current implementation
> so far probably isn't appropriate for kernel implementation.
>
> There's a special case of acquiring a list of mounts where the
> path is not a mount point itself but you need all mount below
> that path prefix.
>
> In this case you get all mounts, including the mounts of the mount
> containing the path, so you still need to traverse the list to match
> the prefix and that can easily mean the whole list of mounts in the
> system.
>
> Point is it leads to multiple traversals of a larger than needed list
> of mounts, one to get the list of mounts to check, and one to filter
> on the prefix.
>
> I've seen this use case with fsinfo() and that's where it's needed
> although it may be useful to carry it through to notifications as
> well.
>
> While this sounds like it isn't such a big deal it can sometimes
> make a considerable difference to the number of mounts you need
> to traverse when there are a large number of mounts in the system.
>
> I didn't consider it appropriate for kernel implementation but
> since you asked here it is. OTOH were checking for connectedness
> in fsinfo() anyway so maybe this is something that could be done
> without undue overhead.

Good point.  Filtering notifications for mounts outside of the
specified path makes sense.

Thanks,
Miklos
