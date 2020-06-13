From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 13 Jun 2020 17:03:51 +0000
Subject: Re: [GIT PULL] General notification queue and key notifications
Message-Id: <CAHk-=wgX1WM-ST+imRUUKabBo8GodUkYLGSAZ9NsGyqjA-q1Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1503686.1591113304@warthog.procyon.org.uk> <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
 <CAHk-=whypJLi6T01HOZ5+UPe_rs+hft8wn6iOmQpZgbZzbAumA@mail.gmail.com>
 <3984625.1592053492@warthog.procyon.org.uk> <CAHk-=wh=9bYycJM5ginkkwymb3x-geMtiT5i2FvRS0zbKYR9LQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh=9bYycJM5ginkkwymb3x-geMtiT5i2FvRS0zbKYR9LQ@mail.gmail.com>
To: David Howells <dhowells@redhat.com>
Cc: Karel Zak <kzak@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, Christian Brauner <christian.brauner@ubuntu.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, keyrings@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Jun 13, 2020 at 9:47 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If we have multiple uses, and one of them notices some problem that
> requires any ABI changes, but the other one has already started using
> it, we'll have more problems.

Ok, it's merged in my tree, although I was somewhat unhappy about the
incomprehensible calling conventions of "get_pipe_info()". The random
second argument just makes no sense when you read the code, it would
have probably been better as a helper function or #define to clarify
the whole "for_splice" thing.

But let's see how it works and what actually happens.

               Linus
