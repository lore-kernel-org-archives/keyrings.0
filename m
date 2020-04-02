From: David Howells <dhowells@redhat.com>
Date: Thu, 02 Apr 2020 15:51:27 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <3072811.1585842687@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200402152831.GA31612@gardel-login> <1445647.1585576702@warthog.procyon.org.uk> <2418286.1585691572@warthog.procyon.org.uk> <20200401144109.GA29945@gardel-login> <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com> <2590640.1585757211@warthog.procyon.org.uk> <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com> <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net> <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com> <20200402143623.GB31529@gardel-login> <CAJfpegtRi9epdxAeoVbm+7UxkZfzC6XmD4K_5dg=RKADxy_TVA@mail.gmail.com>
In-Reply-To: <20200402152831.GA31612@gardel-login>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>, Christian Brauner <christian.brauner@ubuntu.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>

Lennart Poettering <mzxreary@0pointer.de> wrote:

> systemd cares about all mount points in PID1's mount namespace.
> 
> The fact that mount tables can grow large is why we want something
> better than constantly reparsing the whole /proc/self/mountinfo. But
> filtering subsets of that is something we don't really care about.

With the notifications stuff I've done, you can do, for example:

	pipe2(pipefd, O_NOTIFICATION_PIPE);
	ioctl(pipefd[0], IOC_WATCH_QUEUE_SET_SIZE, 256);
	watch_mount(AT_FDCWD, "/", 0, pipefd[0], 0x02);

And that will catch all mount object changes in the subtree rooted at the
given path, in this case "/".

If you want to limit it to just the notifications on that mount, you would
need to install a filter:

	struct watch_notification_filter filter = {
		.nr_filters	= 1,
		.filters = {
			[0]	= {
				.type		= WATCH_TYPE_MOUNT_NOTIFY,
				.subtype_filter[0]= UINT_MAX,
				.info_mask	= NOTIFY_MOUNT_IS_RECURSIVE,
				.info_filter	= 0,
			},
		},
	};
	ioctl(fd, IOC_WATCH_QUEUE_SET_FILTER, &filter);

Note that this doesn't monitor for superblock changes and events.  They must
be watched individually with something like:

	watch_sb(AT_FDCWD, "/afs", AT_NO_AUTOMOUNT, pipefd[0], 0x27);

David
