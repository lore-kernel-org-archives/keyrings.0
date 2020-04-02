From: David Howells <dhowells@redhat.com>
Date: Thu, 02 Apr 2020 15:56:39 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <3073173.1585842999@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <3072811.1585842687@warthog.procyon.org.uk> <20200402152831.GA31612@gardel-login> <1445647.1585576702@warthog.procyon.org.uk> <2418286.1585691572@warthog.procyon.org.uk> <20200401144109.GA29945@gardel-login> <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com> <2590640.1585757211@warthog.procyon.org.uk> <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com> <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net> <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com> <20200402143623.GB31529@gardel-login> <CAJfpegtRi9epdxAeoVbm+7UxkZfzC6XmD4K_5dg=RKADxy_TVA@mail.gmail.com>
In-Reply-To: <3072811.1585842687@warthog.procyon.org.uk>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>, Christian Brauner <christian.brauner@ubuntu.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>

David Howells <dhowells@redhat.com> wrote:

> 				.info_mask	= NOTIFY_MOUNT_IS_RECURSIVE,

Sorry, I meant NOTIFY_MOUNT_IN_SUBTREE; NOTIFY_MOUNT_IS_RECURSIVE indicates
that the operation was recursive in nature.

David
