From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 02 Apr 2020 15:35:54 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <CAJfpegum_PsCfnar8+V2f_VO3k8CJN1LOFJV5OkHRDbQKR=EHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1445647.1585576702@warthog.procyon.org.uk> <2418286.1585691572@warthog.procyon.org.uk>
 <20200401144109.GA29945@gardel-login> <CAJfpegs3uDzFTE4PCjZ7aZsEh8b=iy_LqO1DBJoQzkP+i4aBmw@mail.gmail.com>
 <2590640.1585757211@warthog.procyon.org.uk> <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <20200402143623.GB31529@gardel-login> <CAJfpegtRi9epdxAeoVbm+7UxkZfzC6XmD4K_5dg=RKADxy_TVA@mail.gmail.com>
 <20200402152831.GA31612@gardel-login>
In-Reply-To: <20200402152831.GA31612@gardel-login>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>

On Thu, Apr 2, 2020 at 5:28 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> On Do, 02.04.20 17:22, Miklos Szeredi (miklos@szeredi.hu) wrote:
>
> > On Thu, Apr 2, 2020 at 4:36 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
> >
> > > You appear to be thinking about the "udisks" project or so?
> >
> > Probably.
> >
> > The real question is: is there a sane way to filter mount
> > notifications so that systemd receives only those which it is
> > interested in, rather than the tens of thousands that for example
> > autofs is managing and has nothing to do with systemd?
>
> systemd cares about all mount points in PID1's mount namespace.
>
> The fact that mount tables can grow large is why we want something
> better than constantly reparsing the whole /proc/self/mountinfo. But
> filtering subsets of that is something we don't really care about.

I can accept that, but you haven't given a reason why that's so.

What does it do with the fact that an automount point was crossed, for
example?  How does that affect the operation of systemd?

Thanks,
Miklos
