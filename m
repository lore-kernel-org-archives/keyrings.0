From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 31 Mar 2020 19:42:48 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <CAJfpegtn1A=dL9VZJQ2GRWsOiP+YSs-4ezE9YgEYNmb-AF0OLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1445647.1585576702@warthog.procyon.org.uk> <CAJfpegvZ_qtdGcP4bNQyYt1BbgF9HdaDRsmD43a-Muxgki+wTw@mail.gmail.com>
 <2294742.1585675875@warthog.procyon.org.uk>
In-Reply-To: <2294742.1585675875@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, Christian Brauner <christian.brauner@ubuntu.com>, Lennart Poettering <mzxreary@0pointer.de>, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 7:31 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > The basic problem in my view, is that the performance requirement of a
> > "get filesystem information" type of API just does not warrant a
> > binary coded interface. I've said this a number of times, but it fell
> > on deaf ears.
>
> It hasn't so fallen, but don't necessarily agree with you.  Let's pin some
> numbers on this.

Cool, thanks for testing.  Unfortunately the test-fsinfo-perf.c file
didn't make it into the patch.   Can you please refresh and resend?

> Okay, the results:
>
>   For  1000 mounts, f= 1514us f2= 1102us p=  6014us p2=  6935us; p=4.0*f p=5.5*f2 p=0.9*p2
>   For  2000 mounts, f= 4712us f2= 3675us p= 20937us p2= 22878us; p=4.4*f p=5.7*f2 p=0.9*p2
>   For  3000 mounts, f= 6795us f2= 5304us p= 31080us p2= 34056us; p=4.6*f p=5.9*f2 p=0.9*p2
>   For  4000 mounts, f= 9291us f2= 7434us p= 40723us p2= 46479us; p=4.4*f p=5.5*f2 p=0.9*p2
>   For  5000 mounts, f423us f2= 9219us p= 50878us p2= 58857us; p=4.5*f p=5.5*f2 p=0.9*p2
>   For 10000 mounts, f"899us f2240us p1054us p27273us; p=4.4*f p=5.5*f2 p=0.9*p2
>   For 20000 mounts, fE811us f27211us p 3640us p2#7377us; p=4.4*f p=5.5*f2 p=0.9*p2
>   For 30000 mounts, fi703us f2T800us p06778us p257629us; p=4.4*f p=5.6*f2 p=0.9*p2

So even the p2 method will give at least 80k queries/s, which is quite
good, considering that the need to rescan the complete mount tree
should be exceedingly rare (and in case it mattered, could be
optimized by priming from /proc/self/mountinfo).

Thanks,
Miklos
