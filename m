From: David Howells <dhowells@redhat.com>
Date: Wed, 01 Apr 2020 13:58:22 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <2488734.1585749502@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <2488530.1585749351@warthog.procyon.org.uk> <CAJfpeguu52VuLAzjFH4rJJ7WYLB5ag8y+r3VMb-0bqH8c-uJUg@mail.gmail.com> <20200330211700.g7evnuvvjenq3fzm@wittgenstein> <1445647.1585576702@warthog.procyon.org.uk> <2418286.1585691572@warthog.procyon.org.uk> <20200401090445.6t73dt7gz36bv4rh@ws.net.home>
In-Reply-To: <2488530.1585749351@warthog.procyon.org.uk>
Cc: dhowells@redhat.com, Miklos Szeredi <miklos@szeredi.hu>, Karel Zak <kzak@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Lennart Poettering <lennart@poettering.net>, Aleksa Sarai <cyphar@cyphar.com>

David Howells <dhowells@redhat.com> wrote:

> > Attached patch applies against readfile patch.
> 
> But doesn't actually do what Karel asked for.  show_mountinfo() itself does
> not give you what Karel asked for.  Plus there's more information you need to
> add to it.

And arguably, it's worse than just reading /proc/mounts.  If you get a
notification that something changed (ie. you poll /proc/mounts or mount
notifications gives you an overrun) you now have to read *every*
/mountfs/*/info file.  That is way more expensive.

David
