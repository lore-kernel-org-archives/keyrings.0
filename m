From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 Jun 2020 21:32:42 +0000
Subject: Re: [GIT PULL] General notification queue and key notifications
Message-Id: <CAHk-=whypJLi6T01HOZ5+UPe_rs+hft8wn6iOmQpZgbZzbAumA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1503686.1591113304@warthog.procyon.org.uk> <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
In-Reply-To: <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
To: Karel Zak <kzak@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, Christian Brauner <christian.brauner@ubuntu.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, keyrings@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

[ Finally getting around to this since my normal pull queue is now empty ]

On Wed, Jun 10, 2020 at 4:13 AM Karel Zak <kzak@redhat.com> wrote:
>
> The notification stuff looks pretty promising, but I do not understand
> why we need to use pipe for this purpose

The original intent was never to use the "pipe()" system call itself,
only use pipes as the actual transport mechanism (because I do not for
a second believe in the crazy "use sockets" model that a lot of other
people seem to blindly believe in).

But using "pipe()" also allows for non-kernel notification queues (ie
where the events come from a user space process). Then you'd not use
O_NOTIFICATION_PIPE, but O_DIRECT (for a packetized pipe).

> Is it because we need to create a new file descriptor from nothing?
> Why O_NOTIFICATION_PIPE is better than introduce a new syscall
> notifyfd()?

We could eventually introduce a new system call.

But I most definitely did *NOT* want to see anything like that for any
first gen stuff.  Especially since it wasn't clear who was going to
use it, and whether early trials would literally be done with that
user-space emulation model of using a perfectly regular pipe (just
with packetization).

I'm not even convinced O_NOTIFICATION_PIPE is necessary, but at worst
it will be a useful marker. I think the only real reason for it was to
avoid any clashes with splice(), which has more complex use of the
pipe buffers.

I'm so far just reading this thread and the arguments for users, and I
haven't yet looked at all the actual details in the pull request - but
last time I had objections to things it wasn't the code, it was the
lack of any use.

             Linus
