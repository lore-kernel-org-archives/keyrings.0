From: David Howells <dhowells@redhat.com>
Date: Tue, 02 Jun 2020 15:51:44 +0000
Subject: [GIT PULL] General notification queue and key notifications
Message-Id: <1503047.1591113104@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: dhowells@redhat.com, viro@zeniv.linux.org.uk, dray@redhat.com, kzak@redhat.com, mszeredi@redhat.com, swhiteho@redhat.com, jlayton@redhat.com, raven@themaw.net, andres@anarazel.de, christian.brauner@ubuntu.com, jarkko.sakkinen@linux.intel.com, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Linus,

Can you pull this, please?  It adds a general notification queue concept
and adds an event source for keys/keyrings, such as linking and unlinking
keys and changing their attributes.

Thanks to Debarshi Ray, we do have a pull request to use this to fix a
problem with gnome-online-accounts - as mentioned last time:

    https://gitlab.gnome.org/GNOME/gnome-online-accounts/merge_requests/47

Without this, g-o-a has to constantly poll a keyring-based kerberos cache
to find out if kinit has changed anything.

[[ With regard to the mount/sb notifications and fsinfo(), Karel Zak and
   Ian Kent have been working on making libmount use them, preparatory to
   working on systemd:

	https://github.com/karelzak/util-linux/commits/topic/fsinfo
	https://github.com/raven-au/util-linux/commits/topic/fsinfo.public

   Development has stalled briefly due to other commitments, so I'm not
   sure I can ask you to pull those parts of the series for now.  Christian
   Brauner would like to use them in lxc, but hasn't started.
   ]]


LSM hooks are included:

 (1) A set of hooks are provided that allow an LSM to rule on whether or
     not a watch may be set.  Each of these hooks takes a different
     "watched object" parameter, so they're not really shareable.  The LSM
     should use current's credentials.  [Wanted by SELinux & Smack]

 (2) A hook is provided to allow an LSM to rule on whether or not a
     particular message may be posted to a particular queue.  This is given
     the credentials from the event generator (which may be the system) and
     the watch setter.  [Wanted by Smack]

I've provided SELinux and Smack with implementations of some of these hooks.


WHY
===

Key/keyring notifications are desirable because if you have your kerberos
tickets in a file/directory, your Gnome desktop will monitor that using
something like fanotify and tell you if your credentials cache changes.

However, we also have the ability to cache your kerberos tickets in the
session, user or persistent keyring so that it isn't left around on disk
across a reboot or logout.  Keyrings, however, cannot currently be
monitored asynchronously, so the desktop has to poll for it - not so good
on a laptop.  This facility will allow the desktop to avoid the need to
poll.


DESIGN DECISIONS
================

 (1) The notification queue is built on top of a standard pipe.  Messages
     are effectively spliced in.  The pipe is opened with a special flag:

	pipe2(fds, O_NOTIFICATION_PIPE);

     The special flag has the same value as O_EXCL (which doesn't seem like
     it will ever be applicable in this context)[?].  It is given up front
     to make it a lot easier to prohibit splice and co. from accessing the
     pipe.

     [?] Should this be done some other way?  I'd rather not use up a new
     	 O_* flag if I can avoid it - should I add a pipe3() system call
     	 instead?

     The pipe is then configured::

	ioctl(fds[1], IOC_WATCH_QUEUE_SET_SIZE, queue_depth);
	ioctl(fds[1], IOC_WATCH_QUEUE_SET_FILTER, &filter);

     Messages are then read out of the pipe using read().

 (2) It should be possible to allow write() to insert data into the
     notification pipes too, but this is currently disabled as the kernel
     has to be able to insert messages into the pipe *without* holding
     pipe->mutex and the code to make this work needs careful auditing.

 (3) sendfile(), splice() and vmsplice() are disabled on notification pipes
     because of the pipe->mutex issue and also because they sometimes want
     to revert what they just did - but one or more notification messages
     might've been interleaved in the ring.

 (4) The kernel inserts messages with the wait queue spinlock held.  This
     means that pipe_read() and pipe_write() have to take the spinlock to
     update the queue pointers.

 (5) Records in the buffer are binary, typed and have a length so that they
     can be of varying size.

     This allows multiple heterogeneous sources to share a common buffer;
     there are 16 million types available, of which I've used just a few,
     so there is scope for others to be used.  Tags may be specified when a
     watchpoint is created to help distinguish the sources.

 (6) Records are filterable as types have up to 256 subtypes that can be
     individually filtered.  Other filtration is also available.

 (7) Notification pipes don't interfere with each other; each may be bound
     to a different set of watches.  Any particular notification will be
     copied to all the queues that are currently watching for it - and only
     those that are watching for it.

 (8) When recording a notification, the kernel will not sleep, but will
     rather mark a queue as having lost a message if there's insufficient
     space.  read() will fabricate a loss notification message at an
     appropriate point later.

 (9) The notification pipe is created and then watchpoints are attached to
     it, using one of:

	keyctl_watch_key(KEY_SPEC_SESSION_KEYRING, fds[1], 0x01);
	watch_mount(AT_FDCWD, "/", 0, fd, 0x02);
	watch_sb(AT_FDCWD, "/mnt", 0, fd, 0x03);

     where in both cases, fd indicates the queue and the number after is a
     tag between 0 and 255.

(10) Watches are removed if either the notification pipe is destroyed or
     the watched object is destroyed.  In the latter case, a message will
     be generated indicating the enforced watch removal.


Things I want to avoid:

 (1) Introducing features that make the core VFS dependent on the network
     stack or networking namespaces (ie. usage of netlink).

 (2) Dumping all this stuff into dmesg and having a daemon that sits there
     parsing the output and distributing it as this then puts the
     responsibility for security into userspace and makes handling
     namespaces tricky.  Further, dmesg might not exist or might be
     inaccessible inside a container.

 (3) Letting users see events they shouldn't be able to see.


TESTING AND MANPAGES
====================

 (*) The keyutils tree has a pipe-watch branch that has keyctl commands for
     making use of notifications.  Proposed manual pages can also be found
     on this branch, though a couple of them really need to go to the main
     manpages repository instead.

     If the kernel supports the watching of keys, then running "make test"
     on that branch will cause the testing infrastructure to spawn a
     monitoring process on the side that monitors a notifications pipe for
     all the key/keyring changes induced by the tests and they'll all be
     checked off to make sure they happened.

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/keyutils.git/log/?h=pipe-watch

 (*) A test program is provided (samples/watch_queue/watch_test) that can
     be used to monitor for keyrings, mount and superblock events.
     Information on the notifications is simply logged to stdout.

Thanks,
David
