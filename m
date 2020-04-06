From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 06 Apr 2020 09:22:31 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <CAJfpegudLD8F-25k-k=9G96JKB+5Y=xFT=ZMwiBkNTwkjMDumA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <20200402143623.GB31529@gardel-login> <CAJfpegtRi9epdxAeoVbm+7UxkZfzC6XmD4K_5dg=RKADxy_TVA@mail.gmail.com>
 <20200402152831.GA31612@gardel-login> <CAJfpegum_PsCfnar8+V2f_VO3k8CJN1LOFJV5OkHRDbQKR=EHg@mail.gmail.com>
 <20200402155020.GA31715@gardel-login> <CAJfpeguM__+S6DiD4MWFv5GCf_EUWvGFT0mzuUCCrfQwggqtDQ@mail.gmail.com>
 <20200403110842.GA34663@gardel-login> <CAJfpegtYKhXB-HNddUeEMKupR5L=RRuydULrvm39eTung0=yRg@mail.gmail.com>
 <20200403150143.GA34800@gardel-login>
In-Reply-To: <20200403150143.GA34800@gardel-login>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>

On Fri, Apr 3, 2020 at 5:01 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> On Fr, 03.04.20 13:48, Miklos Szeredi (miklos@szeredi.hu) wrote:
>
> > > > Does that make any sense?
> > >
> > > When all mounts in the init mount namespace are unmounted and all
> > > remaining processes killed we switch root back to the initrd, so that
> > > even the root fs can be unmounted, and then we disassemble any backing
> > > complex storage if there is, i.e. lvm, luks, raid, …
> >
> > I think it could be done the other way round, much simpler:
> >
> >  - switch back to initrd
> >  - umount root, keeping the tree intact (UMOUNT_DETACHED)
> >  - kill all remaining processes, wait for all to exit
>
> Nah. What I wrote above is drastically simplified. It's IRL more
> complex. Specific services need to be killed between certain mounts
> are unmounted, since they are a backend for another mount. NFS, or
> FUSE or stuff like that usually has some processes backing them
> around, and we need to stop the mounts they provide before these
> services, and then the mounts these services reside on after that, and
> so on. It's a complex dependency tree of stuff that needs to be done
> in order, so that we can deal with arbitrarily nested mounts, storage
> subsystems, and backing services.

That still doesn't explain why you need to keep track of all mounts in
the system.

If you are aware of the dependency, then you need to keep track of
that particular mount. If not, then why?

What I'm starting to see is that there's a fundamental conflict
between how systemd people want to deal with new mounts and how some
other people want to use mounts (i.e. tens of thousands of mounts in
an automount map).

I'm really curious how much the mount notification ring + per mount
query (any implementation) can help that use case.

> Anyway, this all works fine in systemd, the dependency logic is
> there. We want a more efficient way to watch mounts, that's
> all. Subscribing and constantly reparsing /proc/self/mountinfo is
> awful, that's all.

I'm not sure that is all.   To handle storms of tens of thousands of
mounts, my guess is that the fundamental way of dealing with these
changes will need to be updated in systemd.

Thanks,
Miklos
