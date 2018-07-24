From: Ian Kent <raven@themaw.net>
Date: Tue, 24 Jul 2018 00:37:54 +0000
Subject: Re: [RFC][PATCH 0/5] Mount, Filesystem and Keyrings notifications
Message-Id: <1532392674.3546.17.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153235954191.32640.5792167066538704794.stgit@warthog.procyon.org.uk>
         <675e5c24-36ef-4cc5-846c-1414c1195d85@schaufler-ca.com>
In-Reply-To: <675e5c24-36ef-4cc5-846c-1414c1195d85@schaufler-ca.com>
To: Casey Schaufler <casey@schaufler-ca.com>, David Howells <dhowells@redhat.com>, viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

On Mon, 2018-07-23 at 09:31 -0700, Casey Schaufler wrote:
> On 7/23/2018 8:25 AM, David Howells wrote:
> > Hi Al,
> > 
> > Here's a set of patches to add a general variable-length notification queue
> > concept and to add sources of events for:
> 
> Overall I approve. The interface is a bit clunky. Some concerns below.
> 
> > 
> >  (1) Mount topology and reconfiguration change events.
> 
> With the possibility of unprivileged mounting you're
> going to have to address access control on events.
> If root in a user namespace mounts a filesystem you
> may have a case where the "real" user wouldn't want the
> listener to receive a notification.
> 
> >  (2) Superblocks EIO, ENOSPC and EDQUOT events (not complete yet).
> 
> Here, too. If SELinux (for example) policy says you can't see
> anything on a filesystem you shouldn't get notifications about
> things that happen to that filesystem.
> 
> >  (3) Key/keyring changes events
> 
> And again, I should only get notifications about keys and
> keyrings I have access to.
> 
> I expect that you intentionally left off
> 
>    (4) User injected events
> 
> at this point, but it's an obvious extension. That is going
> to require access controls (remember kdbus) so I think you'd
> do well to design them in now rather than have some security
> module hack like me come along later and "fix" it. 

I thought mount name space should be considered too even
though I wasn't considering the cloning of file handles
into a user mount name space.

But can this happen in other ways besides user mount name
space creation (I'm fishing here)?

And nsenter(1) doesn't require an exec for anything other
than a pid name space change so a forced close on exec
wouldn't be enough. Or am I mistaken in that nsenter(1)
actually requires running a program (even though the man
page implies it's optional) ...

Are there other consideration my limited understanding is
missing?

> 
> > One of the reasons for this is so that we can remove the issue of processes
> > having to repeatedly and regularly scan /proc/mounts, which has proven to be
> > a
> > system performance problem.
> > 
> > 
> > Design decisions:
> > 
> >  (1) A misc chardev is used to create and open a ring buffer:
> > 
> > 	fd = open("/dev/watch_queue", O_RDWR);
> > 
> >      which is then configured and mmap'd into userspace:
> > 
> > 	ioctl(fd, IOC_WATCH_QUEUE_SET_SIZE, BUF_SIZE);
> > 	ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter);
> > 	buf = mmap(NULL, BUF_SIZE * page_size, PROT_READ | PROT_WRITE,
> > 		   MAP_SHARED, fd, 0);
> > 
> >      The fd cannot be read or written (though there is a facility to use
> > write
> >      to inject records for debugging) and userspace just pulls data directly
> >      out of the buffer.
> > 
> >  (2) The ring index pointers are stored inside the ring and are thus
> >      accessible to userspace.  Userspace should only update the tail pointer
> >      and never the head pointer or risk breaking the buffer.  The kernel
> >      checks that the pointers appear valid before trying to use them.  A
> >      'skip' record is maintained around the pointers.
> > 
> >  (3) poll() can be used to wait for data to appear in the buffer.
> > 
> >  (4) Records in the buffer are binary, typed and have a length so that they
> >      can be of varying size.
> > 
> >      This means that multiple heterogeneous sources can share a common
> >      buffer.  Tags may be specified when a watchpoint is created to help
> >      distinguish the sources.
> > 
> >  (5) The queue is reusable as there are 16 million types available, of which
> >      I've used 4, so there is scope for others to be used.
> > 
> >  (6) Records are filterable as types have up to 256 subtypes that can be
> >      individually filtered.  Other filtration is also available.
> > 
> >  (7) Each time the buffer is opened, a new buffer is created - this means
> > that
> >      there's no interference between watchers.
> > 
> >  (8) When recording a notification, the kernel will not sleep, but will
> > rather
> >      mark a queue as overrun if there's insufficient space, thereby avoiding
> >      userspace causing the kernel to hang.
> > 
> >  (9) The 'watchpoint' should be specific where possible, meaning that you
> >      specify the object that you want to watch.
> > 
> > (10) The buffer is created and then watchpoints are attached to it, using
> > one
> >      of:
> > 
> > 	keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fd, 0x01);
> > 	mount_notify(AT_FDCWD, "/", 0, fd, 0x02);
> > 	sb_notify(AT_FDCWD, "/mnt", 0, fd, 0x03);
> > 
> >      where in all three cases, fd indicates the queue and the number after
> > is
> >      a tag between 0 and 255.
> > 
> > (11) The watch must be removed if either the watch buffer is destroyed or
> > the
> >      watched object is destroyed.
> > 
> > 
> > Things I want to avoid:
> > 
> >  (1) Introducing features that make the core VFS dependent on the network
> >      stack or networking namespaces (ie. usage of netlink).
> > 
> >  (2) Dumping all this stuff into dmesg and having a daemon that sits there
> >      parsing the output and distributing it as this then puts the
> >      responsibility for security into userspace and makes handling
> > namespaces
> >      tricky.  Further, dmesg might not exist or might be inaccessible inside
> > a
> >      container.
> > 
> >  (3) Letting users see events they shouldn't be able to see.
> > 
> > 
> > Further things that need to be done:
> > 
> >  (1) fsinfo() syscall needs to find superblocks by ID as well as by path so
> >      that it can query a superblock for information without the need to try
> >      and work out how to reach it - if the calling process even can.
> > 
> >  (2) A mount_info() syscall is needed that can enumerate all the children of
> > a
> >      mount.  This is necessary because mountpoints can hide each other by
> >      stacking, so paths are not unique keys.  This will require the ability
> > to
> >      look up a mount by ID.  This avoids the need to parse /proc/mounts.
> > 
> >  (3) A keyctl call is needed to allow a watch on a keyring to be extended to
> >      "children" of that keyring, such that the watch is removed from the
> > child
> >      if it is unlinked from the keyring.
> > 
> >  (4) A global superblock event queue maybe?
> > 
> >  (5) Propagating watches to child superblock over automounts?
> > 
> > 
> > The patches can be found here also:
> > 
> > 	http://git.kernel.org/cgit/linux/kernel/git/dhowells/linux-fs.git/log/?h
> > =notifications
> > 
> > David
> > ---
> > David Howells (5):
> >       General notification queue with user mmap()'able ring buffer
> >       KEYS: Add a notification facility
> >       vfs: Add a mount-notification facility
> >       vfs: Add superblock notifications
> >       Add sample notification program
> > 
> > 
> >  Documentation/security/keys/core.rst   |   59 ++
> >  Documentation/watch_queue.rst          |  305 ++++++++++++
> >  arch/x86/entry/syscalls/syscall_32.tbl |    2 
> >  arch/x86/entry/syscalls/syscall_64.tbl |    2 
> >  drivers/misc/Kconfig                   |    9 
> >  drivers/misc/Makefile                  |    1 
> >  drivers/misc/watch_queue.c             |  835
> > ++++++++++++++++++++++++++++++++
> >  fs/Kconfig                             |   21 +
> >  fs/Makefile                            |    1 
> >  fs/fs_context.c                        |    1 
> >  fs/mount.h                             |   26 +
> >  fs/mount_notify.c                      |  178 +++++++
> >  fs/namespace.c                         |   18 +
> >  fs/super.c                             |  116 ++++
> >  include/linux/dcache.h                 |    1 
> >  include/linux/fs.h                     |   77 +++
> >  include/linux/key.h                    |    4 
> >  include/linux/syscalls.h               |    4 
> >  include/linux/watch_queue.h            |   87 +++
> >  include/uapi/linux/keyctl.h            |    1 
> >  include/uapi/linux/watch_queue.h       |  156 ++++++
> >  kernel/sys_ni.c                        |    6 
> >  mm/interval_tree.c                     |    2 
> >  mm/memory.c                            |    1 
> >  samples/Kconfig                        |    6 
> >  samples/Makefile                       |    2 
> >  samples/watch_queue/Makefile           |    9 
> >  samples/watch_queue/watch_test.c       |  232 +++++++++
> >  security/keys/Kconfig                  |   10 
> >  security/keys/compat.c                 |    3 
> >  security/keys/gc.c                     |    5 
> >  security/keys/internal.h               |   29 +
> >  security/keys/key.c                    |   37 +
> >  security/keys/keyctl.c                 |   90 +++
> >  security/keys/keyring.c                |   17 -
> >  security/keys/request_key.c            |    4 
> >  36 files changed, 2332 insertions(+), 25 deletions(-)
> >  create mode 100644 Documentation/watch_queue.rst
> >  create mode 100644 drivers/misc/watch_queue.c
> >  create mode 100644 fs/mount_notify.c
> >  create mode 100644 include/linux/watch_queue.h
> >  create mode 100644 include/uapi/linux/watch_queue.h
> >  create mode 100644 samples/watch_queue/Makefile
> >  create mode 100644 samples/watch_queue/watch_test.c
> > 
> > 
> 
> 
