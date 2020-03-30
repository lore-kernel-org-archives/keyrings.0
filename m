From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 30 Mar 2020 20:28:56 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <CAJfpegvZ_qtdGcP4bNQyYt1BbgF9HdaDRsmD43a-Muxgki+wTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1445647.1585576702@warthog.procyon.org.uk>
In-Reply-To: <1445647.1585576702@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, Christian Brauner <christian.brauner@ubuntu.com>, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 3:58 PM David Howells <dhowells@redhat.com> wrote:
>
>
> Hi Linus,
>
> I have three sets of patches I'd like to push your way, if you (and Al) are
> willing to consider them.

The basic problem in my view, is that the performance requirement of a
"get filesystem information" type of API just does not warrant a
binary coded interface. I've said this a number of times, but it fell
on deaf ears.

Such binary ABIs (especially if not very carefully designed and
reviewed) usually go through several revisions as the structure fails
to account for future changes in the representation of those structure
fields.   There are too many examples of this to count.   Then there's
the problem of needing to update libc, utilities and language bindings
on each revision or extension of the interface.

All this could be solved with a string key/value representation of the
same data, with minimal performance loss on encoding/parsing.  The
proposed fs interface[1] is one example of that, but I could also
imagine a syscall based one too.

Thanks,
Miklos

[1] https://lore.kernel.org/linux-fsdevel/20200309200238.GB28467@miu.piliscsaba.redhat.com/
