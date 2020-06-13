From: David Howells <dhowells@redhat.com>
Date: Sat, 13 Jun 2020 13:04:52 +0000
Subject: Re: [GIT PULL] General notification queue and key notifications
Message-Id: <3984625.1592053492@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHk-=whypJLi6T01HOZ5+UPe_rs+hft8wn6iOmQpZgbZzbAumA@mail.gmail.com> <1503686.1591113304@warthog.procyon.org.uk> <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
In-Reply-To: <CAHk-=whypJLi6T01HOZ5+UPe_rs+hft8wn6iOmQpZgbZzbAumA@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: dhowells@redhat.com, Karel Zak <kzak@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, Christian Brauner <christian.brauner@ubuntu.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, keyrings@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Linus Torvalds <torvalds@linux-foundation.org> wrote:

> I'm not even convinced O_NOTIFICATION_PIPE is necessary, but at worst
> it will be a useful marker. I think the only real reason for it was to
> avoid any clashes with splice(), which has more complex use of the
> pipe buffers.

The main reason is to prevent splice because the iov_iter rewind for splice
gets quite tricky if the kernel can randomly insert packets into the pipe
buffer in between what splice is inserting.

> I'm so far just reading this thread and the arguments for users, and I
> haven't yet looked at all the actual details in the pull request - but
> last time I had objections to things it wasn't the code, it was the
> lack of any use.

Would you be willing at this point to consider pulling the mount notifications
and fsinfo() which helps support that?  I could whip up pull reqs for those
two pieces - or do you want to see more concrete patches that use it?

David
