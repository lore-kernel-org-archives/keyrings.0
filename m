From: David Howells <dhowells@redhat.com>
Date: Fri, 03 Apr 2020 15:36:31 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <3248809.1585928191@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200403151223.GB34800@gardel-login> <2418286.1585691572@warthog.procyon.org.uk> <20200401144109.GA29945@gardel-login> <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com> <2590640.1585757211@warthog.procyon.org.uk> <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com> <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net> <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com> <27994c53034c8f769ea063a54169317c3ee62c04.camel@themaw.net> <20200403111144.GB34663@gardel-login> <CAJfpeguQAw+Mgc8QBNd+h3KV8=Y-SOGT7TB_N_54wa8MCoOSzg@mail.gmail.com>
In-Reply-To: <20200403151223.GB34800@gardel-login>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>, Ian Kent <raven@themaw.net>, Christian Brauner <christian.brauner@ubuntu.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>

Lennart Poettering <mzxreary@0pointer.de> wrote:

> BTW, while we are at it: one more thing I'd love to see exposed by
> statx() is a simple flag whether the inode is a mount point.

Note that an inode or a dentry might be a mount point in one namespace, but
not in another.  Do you actually mean an inode - or do you actually mean the
(mount,dentry) pair that you're looking at?  (Ie. should it be namespace
specific?)

David
