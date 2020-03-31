From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 31 Mar 2020 15:10:34 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <CAJfpegvo=T0VuXsPnvo83H3RqwHLE-9Q=dTZKWxnBKMykfJcNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1445647.1585576702@warthog.procyon.org.uk> <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
 <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com>
 <20200331083430.kserp35qabnxvths@ws.net.home> <CAJfpegsNpabFwoLL8HffNbi_4DuGMn4eYpFc6n7223UFnEPAbA@mail.gmail.com>
 <20200331122554.GA27469@gardel-login>
In-Reply-To: <20200331122554.GA27469@gardel-login>
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Karel Zak <kzak@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>

On Tue, Mar 31, 2020 at 2:25 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
>
> On Di, 31.03.20 10:56, Miklos Szeredi (miklos@szeredi.hu) wrote:
>
> > On Tue, Mar 31, 2020 at 10:34 AM Karel Zak <kzak@redhat.com> wrote:
> > >
> > > On Tue, Mar 31, 2020 at 07:11:11AM +0200, Miklos Szeredi wrote:
> > > > On Mon, Mar 30, 2020 at 11:17 PM Christian Brauner
> > > > <christian.brauner@ubuntu.com> wrote:
> > > >
> > > > > Fwiw, putting down my kernel hat and speaking as someone who maintains
> > > > > two container runtimes and various other low-level bits and pieces in
> > > > > userspace who'd make heavy use of this stuff I would prefer the fd-based
> > > > > fsinfo() approach especially in the light of across namespace
> > > > > operations, querying all properties of a mount atomically all-at-once,
> > > >
> > > > fsinfo(2) doesn't meet the atomically all-at-once requirement.
> > >
> > > I guess your /proc based idea have exactly the same problem...
> >
> > Yes, that's exactly what I wanted to demonstrate: there's no
> > fundamental difference between the two API's in this respect.
> >
> > > I see two possible ways:
> > >
> > > - after open("/mnt", O_PATH) create copy-on-write object in kernel to
> > >   represent mount node -- kernel will able to modify it, but userspace
> > >   will get unchanged data from the FD until to close()
> > >
> > > - improve fsinfo() to provide set (list) of the attributes by one call
> >
> > I think we are approaching this from the wrong end.   Let's just
> > ignore all of the proposed interfaces for now and only concentrate on
> > what this will be used for.
> >
> > Start with a set of use cases by all interested parties.  E.g.
> >
> >  - systemd wants to keep track attached mounts in a namespace, as well
> > as new detached mounts created by fsmount()
> >
> >  - systemd need to keep information (such as parent, children, mount
> > flags, fs options, etc) up to date on any change of topology or
> > attributes.
>
> - We also have code that recursively remounts r/o or unmounts some
>   directory tree (with filters),

Recursive remount-ro is clear.  What is not clear is whether you need
to do this for hidden mounts (not possible from userspace without a
way to disable mount following on path lookup).  Would it make sense
to add a kernel API for recursive setting of mount flags?

What exactly is this unmount with filters?  Can you give examples?

> - We also have code that needs to check if /dev/ is plain tmpfs or
>   devtmpfs. We cannot use statfs for that, since in both cases
>   TMPFS_MAGIC is reported, hence we currently parse
>   /proc/self/mountinfo for that to find the fstype string there, which
>   is different for both cases.

Okay.

Thanks,
Miklos
