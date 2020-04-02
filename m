From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 02 Apr 2020 15:19:03 +0000
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and attribute change notifications [ver #5]
Message-Id: <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
 <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
In-Reply-To: <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <sds@tycho.nsa.gov>, nicolas.dichtel@6wind.com, Ian Kent <raven@themaw.net>, Christian Brauner <christian@brauner.io>, andres@anarazel.de, Jeff Layton <jlayton@redhat.com>, dray@redhat.com, Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org, Linux API <linux-api@vger.kernel.org>, linux-fsdevel@vger.kernel.org, LSM <linux-security-module@vger.kernel.org>, linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 4:05 PM David Howells <dhowells@redhat.com> wrote:
>
> Add a mount notification facility whereby notifications about changes in
> mount topology and configuration can be received.  Note that this only
> covers vfsmount topology changes and not superblock events.  A separate
> facility will be added for that.
>
> Every mount is given a change counter than counts the number of topological
> rearrangements in which it is involved and the number of attribute changes
> it undergoes.  This allows notification loss to be dealt with.

Isn't queue overrun signalled anyway?

If an event is lost, there's no way to know which object was affected,
so how does the counter help here?

>  Later
> patches will provide a way to quickly retrieve this value, along with
> information about topology and parameters for the superblock.

So?  If we receive a notification for MNT1 with change counter CTR1
and then receive the info for MNT1 with CTR2, then we know that we
either missed a notification or we raced and will receive the
notification later.  This helps with not having to redo the query when
we receive the notification with CTR2, but this is just an
optimization, not really useful.

> Firstly, a watch queue needs to be created:
>
>         pipe2(fds, O_NOTIFICATION_PIPE);
>         ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, 256);
>
> then a notification can be set up to report notifications via that queue:
>
>         struct watch_notification_filter filter = {
>                 .nr_filters = 1,
>                 .filters = {
>                         [0] = {
>                                 .type = WATCH_TYPE_MOUNT_NOTIFY,
>                                 .subtype_filter[0] = UINT_MAX,
>                         },
>                 },
>         };
>         ioctl(fds[1], IOC_WATCH_QUEUE_SET_FILTER, &filter);
>         watch_mount(AT_FDCWD, "/", 0, fds[1], 0x02);
>
> In this case, it would let me monitor the mount topology subtree rooted at
> "/" for events.  Mount notifications propagate up the tree towards the
> root, so a watch will catch all of the events happening in the subtree
> rooted at the watch.

Does it make sense to watch a single mount?  A set of mounts?   A
subtree with an exclusion list (subtrees, types, ???)?

Not asking for these to be implemented initially, just questioning
whether the API is flexible enough to allow these cases to be
implemented later if needed.

>
> After setting the watch, records will be placed into the queue when, for
> example, as superblock switches between read-write and read-only.  Records
> are of the following format:
>
>         struct mount_notification {
>                 struct watch_notification watch;
>                 __u32   triggered_on;
>                 __u32   auxiliary_mount;

What guarantees that mount_id is going to remain a 32bit entity?

>                 __u32   topology_changes;
>                 __u32   attr_changes;
>                 __u32   aux_topology_changes;

Being 32bit this introduces wraparound effects.  Is that really worth it?

>         } *n;
>
> Where:
>
>         n->watch.type will be WATCH_TYPE_MOUNT_NOTIFY.
>
>         n->watch.subtype will indicate the type of event, such as
>         NOTIFY_MOUNT_NEW_MOUNT.
>
>         n->watch.info & WATCH_INFO_LENGTH will indicate the length of the
>         record.

Hmm, size of record limited to 112bytes?  Is this verified somewhere?
Don't see a BUILD_BUG_ON() in watch_sizeof().

>
>         n->watch.info & WATCH_INFO_ID will be the fifth argument to
>         watch_mount(), shifted.
>
>         n->watch.info & NOTIFY_MOUNT_IN_SUBTREE if true indicates that the
>         notifcation was generated in the mount subtree rooted at the watch,

notification

>         and not actually in the watch itself.
>
>         n->watch.info & NOTIFY_MOUNT_IS_RECURSIVE if true indicates that
>         the notifcation was generated by an event (eg. SETATTR) that was
>         applied recursively.  The notification is only generated for the
>         object that initially triggered it.

Unused in this patchset.  Please don't add things to the API which are not used.

>
>         n->watch.info & NOTIFY_MOUNT_IS_NOW_RO will be used for
>         NOTIFY_MOUNT_READONLY, being set if the superblock becomes R/O, and
>         being cleared otherwise,

Does this refer to mount r/o flag or superblock r/o flag?  Confused.

> and for NOTIFY_MOUNT_NEW_MOUNT, being set
>         if the new mount is a submount (e.g. an automount).

Huh?  What has r/o flag do with being a submount?

>
>         n->watch.info & NOTIFY_MOUNT_IS_SUBMOUNT if true indicates that the
>         NOTIFY_MOUNT_NEW_MOUNT notification is in response to a mount
>         performed by the kernel (e.g. an automount).
>
>         n->triggered_on indicates the ID of the mount to which the change
>         was accounted (e.g. the new parent of a new mount).

For move there are two parents that are affected.  This doesn't look
sufficient to reflect that.

>
>         n->axiliary_mount indicates the ID of an additional mount that was
>         affected (e.g. a new mount itself) or 0.
>
>         n->topology_changes provides the value of the topology change
>         counter of the triggered-on mount at the conclusion of the
>         operarion.

operation

>
>         n->attr_changes provides the value of the attribute change counter
>         of the triggered-on mount at the conclusion of the operarion.

operation

>
>         n->aux_topology_changes provides the value of the topology change
>         counter of the auxiliary mount at the conclusion of the operation.
>
> Note that it is permissible for event records to be of variable length -
> or, at least, the length may be dependent on the subtype.  Note also that
> the queue can be shared between multiple notifications of various types.

Will review code later...

Thanks,
Miklos
