From: David Howells <dhowells@redhat.com>
Date: Thu, 02 Apr 2020 15:42:45 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <3072199.1585842165@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAJfpegv4=wAi+mH32pHM9g8gk+JGESWa25n04BwfnkhVBf=3rA@mail.gmail.com> <CAJfpeguu52VuLAzjFH4rJJ7WYLB5ag8y+r3VMb-0bqH8c-uJUg@mail.gmail.com> <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <1445647.1585576702@warthog.procyon.org.uk> <2418286.1585691572@warthog.procyon.org.uk> <20200401090445.6t73dt7gz36bv4rh@ws.net.home> <2488530.1585749351@warthog.procyon.org.uk> <2488734.1585749502@warthog.procyon.org.uk> <CAJfpeguLJcAEgx2JWRNcKMkyFTWB0r4wS6F4fJHK3VHtY=EjXQ@mail.gmail.com> <2590276.1585756914@warthog.procyon.org.uk> <CAJfpeguxDiq3BW94AVFhgY75P+jy_+jk3pdyNZ5z-aJPXNvvGA@mail.gmail.com> <3070724.1585840971@warthog.procyon.org.uk>
In-Reply-To: <CAJfpegv4=wAi+mH32pHM9g8gk+JGESWa25n04BwfnkhVBf=3rA@mail.gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dhowells@redhat.com, Karel Zak <kzak@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Lennart Poettering <lennart@poettering.net>, Aleksa Sarai <cyphar@cyphar.com>

Miklos Szeredi <miklos@szeredi.hu> wrote:

> > ext4_show_mount(), for example, doesn't lock against "mount -o remount", so
> > the configuration can be changing whilst it's being rendered to text.
> 
> Does s_umount nest inside namespace_sem?  I really don't see the
> relation of those locks.

If I understand aright what Al has told me, it's a bad idea to do any blocking
operation inside of namespace_sem apart from kmalloc(GFP_KERNEL).

David
