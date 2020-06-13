From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 13 Jun 2020 16:47:30 +0000
Subject: Re: [GIT PULL] General notification queue and key notifications
Message-Id: <CAHk-=wh=9bYycJM5ginkkwymb3x-geMtiT5i2FvRS0zbKYR9LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1503686.1591113304@warthog.procyon.org.uk> <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
 <CAHk-=whypJLi6T01HOZ5+UPe_rs+hft8wn6iOmQpZgbZzbAumA@mail.gmail.com> <3984625.1592053492@warthog.procyon.org.uk>
In-Reply-To: <3984625.1592053492@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Karel Zak <kzak@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, Christian Brauner <christian.brauner@ubuntu.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, keyrings@vger.kernel.org, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Jun 13, 2020 at 6:05 AM David Howells <dhowells@redhat.com> wrote:
>
> Would you be willing at this point to consider pulling the mount notifications
> and fsinfo() which helps support that?  I could whip up pull reqs for those
> two pieces - or do you want to see more concrete patches that use it?

I'd want to see more concrete use cases, but I'd also like to see that
this keyring thing gets used and doesn't find any show-stoppers when
it does.

If we have multiple uses, and one of them notices some problem that
requires any ABI changes, but the other one has already started using
it, we'll have more problems.

          Linus
