From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 Jun 2020 22:01:11 +0000
Subject: Re: [GIT PULL] General notification queue and key notifications
Message-Id: <CAHk-=wjUP6WmngGq70GFKrtDp5Z9mkqORtBD2uStp2p_H-nzqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1503686.1591113304@warthog.procyon.org.uk> <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
In-Reply-To: <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
To: Karel Zak <kzak@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, Christian Brauner <christian.brauner@ubuntu.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, keyrings@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

[ Actually going through the code now ]

On Wed, Jun 10, 2020 at 4:13 AM Karel Zak <kzak@redhat.com> wrote:
>
> All the next operations are done with "fd". It's nowhere used as a
> pipe, and nothing uses pipefd[1].

As an aside, that isn't necessarily true.

In some of the examples, pipefd[1] is used for configuration (sizing
and adding filters), although I think right now that's not really
enforced, and other examples seem to have pipefd[0] do that too.

DavidH: should that perhaps be a hard rule, so that you can pass a
pipefd[0] to readers, while knowing that they can't then change the
kinds of notifications they see.

In the "pipe: Add general notification queue support" commit message,
the code example uses pipefd[0] for IOC_WATCH_QUEUE_SET_SIZE, but then
in the commit message for "watch_queue: Add a key/keyring notification
facility" it uses pipefd[1].

And that latter example does make sense: using the write-side
pipefd[1] for configuration, while the read-side pipefd[0] is the side
that sees the results. That is also how it would work if you have a
user-mode pipe with the notification source controlling the writing
side - the reading side can obviously not add filters or change the
semantics of the watches.

So that allows a trusted side to add and create filters, while some
untrusted entity can then see the results.

This isn't going to hold up me merging the code, but it would be good
to clarify and make that something that gets enforced if we decide
it's worth it.

It does seem conceptually like a good idea, and potentially actually
useful to clearly separate the domain of "you can add watches and
filters" from "you can see the notifications".

               Linus
