From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 03 Apr 2020 11:48:51 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <CAJfpegtYKhXB-HNddUeEMKupR5L=RRuydULrvm39eTung0=yRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <2590640.1585757211@warthog.procyon.org.uk> <CAJfpegsXqxizOGwa045jfT6YdUpMxpXET-yJ4T8qudyQbCGkHQ@mail.gmail.com>
 <36e45eae8ad78f7b8889d9d03b8846e78d735d28.camel@themaw.net>
 <CAJfpegsCDWehsTRQ9UJYuQnghnE=M8L0_bJBTTPA+Upu87t90w@mail.gmail.com>
 <20200402143623.GB31529@gardel-login> <CAJfpegtRi9epdxAeoVbm+7UxkZfzC6XmD4K_5dg=RKADxy_TVA@mail.gmail.com>
 <20200402152831.GA31612@gardel-login> <CAJfpegum_PsCfnar8+V2f_VO3k8CJN1LOFJV5OkHRDbQKR=EHg@mail.gmail.com>
 <20200402155020.GA31715@gardel-login> <CAJfpeguM__+S6DiD4MWFv5GCf_EUWvGFT0mzuUCCrfQwggqtDQ@mail.gmail.com>
 <20200403110842.GA34663@gardel-login>
In-Reply-To: <20200403110842.GA34663@gardel-login>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Karel Zak <kzak@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>

On Fri, Apr 3, 2020 at 1:08 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> On Do, 02.04.20 19:20, Miklos Szeredi (miklos@szeredi.hu) wrote:
>
> > On Thu, Apr 2, 2020 at 5:50 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
> > >
> > > On Do, 02.04.20 17:35, Miklos Szeredi (miklos@szeredi.hu) wrote:
> > >
> > > > > systemd cares about all mount points in PID1's mount namespace.
> > > > >
> > > > > The fact that mount tables can grow large is why we want something
> > > > > better than constantly reparsing the whole /proc/self/mountinfo. But
> > > > > filtering subsets of that is something we don't really care about.
> > > >
> > > > I can accept that, but you haven't given a reason why that's so.
> > > >
> > > > What does it do with the fact that an automount point was crossed, for
> > > > example?  How does that affect the operation of systemd?
> > >
> > > We don't care how a mount point came to be. If it's autofs or
> > > something else, we don't care. We don't access these mount points
> > > ourselves ever, we just watch their existance.
> > >
> > > I mean, it's not just about startup it's also about shutdown. At
> > > shutdown we need to unmount everything from the leaves towards the
> > > root so that all file systems are in a clean state.
> >
> > Unfortunately that's not guaranteed by umounting all filesystems from
> > the init namespace.  A filesystem is shut down when all references to
> > it are gone.  Perhaps you instead want to lazy unmount root (yeah,
> > that may not actually be allowed, but anyway, lazy unmounting the top
> > level ones should do) and watch for super block shutdown events
> > instead.
> >
> > Does that make any sense?
>
> When all mounts in the init mount namespace are unmounted and all
> remaining processes killed we switch root back to the initrd, so that
> even the root fs can be unmounted, and then we disassemble any backing
> complex storage if there is, i.e. lvm, luks, raid, …

I think it could be done the other way round, much simpler:

 - switch back to initrd
 - umount root, keeping the tree intact (UMOUNT_DETACHED)
 - kill all remaining processes, wait for all to exit

I think that should guarantee that all super blocks have been shut down.  Al?

The advantage would be that there's no need to walk the mount tree
unmounting individual leafs, since it's all done automagically.

Thanks,
Miklos
