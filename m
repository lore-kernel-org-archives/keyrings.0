From: Miklos Szeredi <mszeredi@redhat.com>
Date: Sat, 13 Jun 2020 19:22:49 +0000
Subject: Re: [GIT PULL] General notification queue and key notifications
Message-Id: <CAOssrKe2hNU9OfMo5CWiq7L_Mmv_2OStYMgYgeo5yy6ppmhTrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1503686.1591113304@warthog.procyon.org.uk> <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
 <CAHk-=whypJLi6T01HOZ5+UPe_rs+hft8wn6iOmQpZgbZzbAumA@mail.gmail.com> <3984625.1592053492@warthog.procyon.org.uk>
In-Reply-To: <3984625.1592053492@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Karel Zak <kzak@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, Christian Brauner <christian.brauner@ubuntu.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, keyrings@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Jun 13, 2020 at 3:05 PM David Howells <dhowells@redhat.com> wrote:

> > I'm so far just reading this thread and the arguments for users, and I
> > haven't yet looked at all the actual details in the pull request - but
> > last time I had objections to things it wasn't the code, it was the
> > lack of any use.
>
> Would you be willing at this point to consider pulling the mount notifications
> and fsinfo() which helps support that?  I could whip up pull reqs for those
> two pieces - or do you want to see more concrete patches that use it?

Well, I had some questions and comments for the mount notifications
last time around[1] and didn't yet get a reply.

And the fsinfo stuff is simply immature, please lets not merge it just
yet.  When we have some uses (most notably systemd) running on top of
the current fsinfo interface, we can sit down and discuss how the API
can be cleaned up.

BTW I had a similar experience with the fsconfig() merge, which was
pushed with some unpolished bits and where my comments were also
largely ignored.  So, before asking to pull, please at least *answer*
reviews.  You don't have to agree, but at least consider and think
about the comments.

Thanks,
Miklos

[1] https://lore.kernel.org/linux-fsdevel/CAJfpegspWA6oUtdcYvYF?ij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com/
