From: David Howells <dhowells@redhat.com>
Date: Thu, 23 Jul 2020 10:48:46 +0000
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and attribute change notifications [ver #5]
Message-Id: <1293241.1595501326@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com> <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk> <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
In-Reply-To: <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dhowells@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com, Ian Kent <raven@themaw.net>, Christian Brauner <christian@brauner.io>, andres@anarazel.de, Jeff Layton <jlayton@redhat.com>, dray@redhat.com, Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org, Linux API <linux-api@vger.kernel.org>, linux-fsdevel@vger.kernel.org, LSM <linux-security-module@vger.kernel.org>, linux-kernel@vger.kernel.org

Miklos Szeredi <miklos@szeredi.hu> wrote:

> On Wed, Mar 18, 2020 at 4:05 PM David Howells <dhowells@redhat.com> wrote:
> >
> > Add a mount notification facility whereby notifications about changes in
> > mount topology and configuration can be received.  Note that this only
> > covers vfsmount topology changes and not superblock events.  A separate
> > facility will be added for that.
> >
> > Every mount is given a change counter than counts the number of topological
> > rearrangements in which it is involved and the number of attribute changes
> > it undergoes.  This allows notification loss to be dealt with.
> 
> Isn't queue overrun signalled anyway?
> 
> If an event is lost, there's no way to know which object was affected,
> so how does the counter help here?

An event may up the counter multiple times.  For example, imagine that you
do the following:

	mkdir /foo
	mount -t tmpfs none /foo
	mkdir /foo/b
	chroot /foo/b
	watch_mount("/")

now someone else comes along and does:

	mkdir /foo/a
	mkdir /foo/b/c
	mount -t tmpfs none /foo/a
	mount -o move /foo/a /foo/b/c

thereby moving a mount from outside your chroot window to inside of it.  The
move will generate two events (move-from and move-to), but you'll only get to
see one of them.  The usage on the mount at /foo, however, will be bumped by
2, not 1.

Also, if someone instead does this:

	mkdir /foo/a/d
	mkdir /foo/a/e
	mount -t tmpfs none /foo/a/d
	mount -o move /foo/a/e /foo/a/e

you won't get any notifications, but the counter still got bumped by 2.
You'll see an unusual bump in it at the next event, but you know you didn't
miss any events that pertain to you and can keep your copy of the counter up
to date... provided there hasn't been an overrun.

If there has been an overrun, you ask fsinfo() for a list of
{mount_id,counter} and then you have to scan anything where the counter has
changed unexpectedly.  It gives you the chance to keep up to date more
readily.

Maybe putting the counter into the notification message isn't really
necessary, but it's cheap to do if the counter is available.

> >  Later
> > patches will provide a way to quickly retrieve this value, along with
> > information about topology and parameters for the superblock.
> 
> So?  If we receive a notification for MNT1 with change counter CTR1
> and then receive the info for MNT1 with CTR2, then we know that we
> either missed a notification or we raced and will receive the
> notification later.  This helps with not having to redo the query when
> we receive the notification with CTR2, but this is just an
> optimization, not really useful.

Are optimisations ever useful?

> > In this case, it would let me monitor the mount topology subtree rooted at
> > "/" for events.  Mount notifications propagate up the tree towards the
> > root, so a watch will catch all of the events happening in the subtree
> > rooted at the watch.
> 
> Does it make sense to watch a single mount?  A set of mounts?   A
> subtree with an exclusion list (subtrees, types, ???)?
> 
> Not asking for these to be implemented initially, just questioning
> whether the API is flexible enough to allow these cases to be
> implemented later if needed.

You can watch a single mount or a whole subtree.  I could make it possible to
add exclusions into the filter list.

> >
> > After setting the watch, records will be placed into the queue when, for
> > example, as superblock switches between read-write and read-only.  Records
> > are of the following format:
> >
> >         struct mount_notification {
> >                 struct watch_notification watch;
> >                 __u32   triggered_on;
> >                 __u32   auxiliary_mount;
> 
> What guarantees that mount_id is going to remain a 32bit entity?

You think it likely we'd have >4 billion concurrent mounts on a system?  That
would require >1.2TiB of RAM just for the struct mount allocations.

But I can expand it to __u64.

> >                 __u32   topology_changes;
> >                 __u32   attr_changes;
> >                 __u32   aux_topology_changes;
> 
> Being 32bit this introduces wraparound effects.  Is that really worth it?

You'd have to make 2 billion changes without whoever's monitoring getting a
chance to update their counters.  But maybe it's not worth it putting them
here.  If you'd prefer, I can make the counters all 64-bit and just retrieve
them with fsinfo().

> >         } *n;
> >
> > Where:
> >
> >         n->watch.type will be WATCH_TYPE_MOUNT_NOTIFY.
> >
> >         n->watch.subtype will indicate the type of event, such as
> >         NOTIFY_MOUNT_NEW_MOUNT.
> >
> >         n->watch.info & WATCH_INFO_LENGTH will indicate the length of the
> >         record.
> 
> Hmm, size of record limited to 112bytes?  Is this verified somewhere?
> Don't see a BUILD_BUG_ON() in watch_sizeof().

127 bytes now, including the header.  I can add a BUILD_BUG_ON().

> >         n->watch.info & NOTIFY_MOUNT_IS_RECURSIVE if true indicates that
> >         the notifcation was generated by an event (eg. SETATTR) that was
> >         applied recursively.  The notification is only generated for the
> >         object that initially triggered it.
> 
> Unused in this patchset.  Please don't add things to the API which are not
> used.

Christian Brauner has patches for mount_setattr() that will need to use this.

> >         n->watch.info & NOTIFY_MOUNT_IS_NOW_RO will be used for
> >         NOTIFY_MOUNT_READONLY, being set if the superblock becomes R/O, and
> >         being cleared otherwise,
> 
> Does this refer to mount r/o flag or superblock r/o flag?  Confused.

Sorry, that should be "mount".

> > and for NOTIFY_MOUNT_NEW_MOUNT, being set
> >         if the new mount is a submount (e.g. an automount).
> 
> Huh?  What has r/o flag do with being a submount?

That should read "if the new mount is readonly".

> >         n->watch.info & NOTIFY_MOUNT_IS_SUBMOUNT if true indicates that the
> >         NOTIFY_MOUNT_NEW_MOUNT notification is in response to a mount
> >         performed by the kernel (e.g. an automount).
> >
> >         n->triggered_on indicates the ID of the mount to which the change
> >         was accounted (e.g. the new parent of a new mount).
> 
> For move there are two parents that are affected.  This doesn't look
> sufficient to reflect that.

You get up to two messages in that case:

	NOTIFY_MOUNT_MOVE_FROM	= 5, /* Mount moved from here */
	NOTIFY_MOUNT_MOVE_TO	= 6, /* Mount moved to here (compare op_id) */

but either message may get filtered because the event occurred outside of your
watched tree.

David
