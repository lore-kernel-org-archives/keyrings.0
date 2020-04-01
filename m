From: David Howells <dhowells@redhat.com>
Date: Wed, 01 Apr 2020 16:06:51 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <2590640.1585757211@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com> <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <1445647.1585576702@warthog.procyon.org.uk> <2418286.1585691572@warthog.procyon.org.uk> <20200401144109.GA29945@gardel-login>
In-Reply-To: <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dhowells@redhat.com, Lennart Poettering <mzxreary@0pointer.de>, Christian Brauner <christian.brauner@ubuntu.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>

Miklos Szeredi <miklos@szeredi.hu> wrote:

> I've still not heard a convincing argument in favor of a syscall.

From your own results, scanning 10000 mounts through mountfs and reading just
two values from each is an order of magnitude slower without the effect of the
dentry/inode caches.  It gets faster on the second run because the mountfs
dentries and inodes are cached - but at a cost of >205MiB of RAM.  And it's
*still* slower than fsinfo().

David
