From: Ian Kent <raven@themaw.net>
Date: Fri, 03 Apr 2020 01:44:01 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
         <1445647.1585576702@warthog.procyon.org.uk>
         <2418286.1585691572@warthog.procyon.org.uk>
         <20200401144109.GA29945@gardel-login>
         <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
         <2590640.1585757211@warthog.procyon.org.uk>
         <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
         <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
         <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
In-Reply-To: <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: David Howells <dhowells@redhat.com>, Lennart Poettering <mzxreary@0pointer.de>, Christian Brauner <christian.brauner@ubuntu.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>

On Thu, 2020-04-02 at 15:52 +0200, Miklos Szeredi wrote:
> On Thu, Apr 2, 2020 at 4:52 AM Ian Kent <raven@themaw.net> wrote:
> > On Wed, 2020-04-01 at 18:40 +0200, Miklos Szeredi wrote:
> > > On Wed, Apr 1, 2020 at 6:07 PM David Howells <dhowells@redhat.com
> > > >
> > > wrote:
> > > > Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > 
> > > > > I've still not heard a convincing argument in favor of a
> > > > > syscall.
> > > > 
> > > > From your own results, scanning 10000 mounts through mountfs
> > > > and
> > > > reading just
> > > > two values from each is an order of magnitude slower without
> > > > the
> > > > effect of the
> > > > dentry/inode caches.  It gets faster on the second run because
> > > > the
> > > > mountfs
> > > > dentries and inodes are cached - but at a cost of >205MiB of
> > > > RAM.  And it's
> > > > *still* slower than fsinfo().
> > > 
> > > Already told you that we can just delete the dentry on
> > > dput_final, so
> > > the memory argument is immaterial.
> > > 
> > > And the speed argument also, because there's no use case where
> > > that
> > > would make a difference.  You keep bringing up the notification
> > > queue
> > > overrun when watching a subtree, but that's going to be painful
> > > with
> > > fsinfo(2) as well.   If that's a relevant use case (not saying
> > > it's
> > > true), might as well add a /mnt/MNT_ID/subtree_info (trivial
> > > again)
> > > that contains all information for the subtree.  Have fun
> > > implementing
> > > that with fsinfo(2).
> > 
> > Forgive me for not trawling through your patch to work this out
> > but how does a poll on a path get what's needed to get mount info.
> > 
> > Or, more specifically, how does one get what's needed to go
> > directly
> > to the place to get mount info. when something in the tree under
> > the
> > polled path changes (mount/umount). IIUC poll alone won't do
> > subtree
> > change monitoring?
> 
> The mechanisms are basically the same as with fsinfo(2).   You can
> get
> to the mountfs entry through the mount ID or through a proc/fd/ type
> symlink.  So if you have a path, there are two options:
> 
>  - find out the mount ID belonging to that path and go to
> /mountfs/$mntid/
>  - open the path with fd = open(path, O_PATH) and the go to
> /proc/self/fdmount/$fd/
> 
> Currently the only way to find the mount id from a path is by parsing
> /proc/self/fdinfo/$fd.  It is trivial, however, to extend statx(2) to
> return it directly from a path.   Also the mount notification queue
> that David implemented contains the mount ID of the changed mount.

I'm aware the mount id comes through David's notifications, I was
wondering how to get that via your recommendation, thanks.

In your scheme it sounds like the mount id doesn't hold the
importance it deserves, it's central to the whole idea of getting
information about these mounts. But it sounds like you need to
open fds to paths you might not know to find it ...

Your explanation wasn't clear on how one gets notifications of
events within a tree under a mount you've opened an fd on to
get events?

> 
> > Don't get me wrong, neither the proc nor the fsinfo implementations
> > deal with the notification storms that cause much of the problem we
> > see now.
> > 
> > IMHO that's a separate and very difficult problem in itself that
> > can't even be considered until getting the information efficiently
> > is resolved.
> 
> This mount notification storm issue got me thinking.   If I
> understand
> correctly, systemd wants mount notifications so that it can do the
> desktop pop-up thing.   Is that correct?
> 
> But that doesn't apply to automounts at all.  A new mount performed
> by
> automount is uninteresting to to desktops, since it's triggered by
> crossing the automount point (i.e. a normal path lookup), not an
> external event like inserting a usb stick, etc...
> 
> Am I missing something?

Yeah, you're not missing anything.

Unfortunately, in a recent discussion on the autofs mailing list,
an investigation showed that systemd does want/get events for
autofs mounts and proceeds to issue around a 100 or so events on
the d-bus for every one.

> 
> Maybe the solution is to just allow filtering out such notifications
> at the source, so automount triggers don't generate events for
> systemd.

Except that autofs automounts might be expected to be seen on a
desktop, that's not out of the question I guess.

Ian
