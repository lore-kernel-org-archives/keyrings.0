From: David Howells <dhowells@redhat.com>
Date: Sat, 13 Jun 2020 13:24:01 +0000
Subject: Re: [GIT PULL] General notification queue and key notifications
Message-Id: <3986609.1592054641@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHk-=wjUP6WmngGq70GFKrtDp5Z9mkqORtBD2uStp2p_H-nzqA@mail.gmail.com> <1503686.1591113304@warthog.procyon.org.uk> <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
In-Reply-To: <CAHk-=wjUP6WmngGq70GFKrtDp5Z9mkqORtBD2uStp2p_H-nzqA@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Karel Zak <kzak@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, Christian Brauner <christian.brauner@ubuntu.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, keyrings@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> > All the next operations are done with "fd". It's nowhere used as a
> > pipe, and nothing uses pipefd[1].
> 
> As an aside, that isn't necessarily true.
> 
> In some of the examples, pipefd[1] is used for configuration (sizing
> and adding filters), although I think right now that's not really
> enforced, and other examples seem to have pipefd[0] do that too.

The configuration can happen on either end of the pipe.  I just need to be
able to find the pipe object.

> DavidH: should that perhaps be a hard rule, so that you can pass a
> pipefd[0] to readers, while knowing that they can't then change the
> kinds of notifications they see.

You can argue that the other way: that it should be a hard rule that you can
pass pipefd[1] to writers, whilst knowing that they can't then change the kind
of notifications that the kernel can insert into the pipe.  My feeling is that
it's more likely that you would keep the read end yourself and give the write
end away - if at all.  Most likely, IMO, would be that you attach notification
sources and never use the write end directly.

There is some argument for making it so that the notification sources belong
to the read end only and that they keep the write side alive internally -
meaning that you can just close the write end.  All the notification sources
just then disappear when the read end is closed - but dup() might make this
kind of tricky as there is only one pipe object and its shared between both
ends.  The existence of O_RDWR FIFOs might also make this tricky.

> In the "pipe: Add general notification queue support" commit message,
> the code example uses pipefd[0] for IOC_WATCH_QUEUE_SET_SIZE, but then
> in the commit message for "watch_queue: Add a key/keyring notification
> facility" it uses pipefd[1].
>
> And that latter example does make sense: using the write-side
> pipefd[1] for configuration, while the read-side pipefd[0] is the side
> that sees the results. That is also how it would work if you have a
> user-mode pipe with the notification source controlling the writing
> side - the reading side can obviously not add filters or change the
> semantics of the watches.
> 
> So that allows a trusted side to add and create filters, while some
> untrusted entity can then see the results.

As stated above, I think you should be looking at this the other way round -
you're more likely to keep the read end for yourself.  If you attach multiple
sources to a pipe, everything they produce comes out mixed together from the
read end of the pipe.

You might even pass the write end to multiple userspace-side event generators,
but I'm not sure it would make sense to pass the read end around unless you
have sufficient flow that you need multiple consumers to keep up with it.

David
