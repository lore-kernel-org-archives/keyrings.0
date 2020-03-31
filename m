From: Lennart Poettering <mzxreary@0pointer.de>
Date: Tue, 31 Mar 2020 15:24:51 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <20200331152451.GG27959@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1445647.1585576702@warthog.procyon.org.uk>
 <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
 <CAJfpegtjmkJUSqORFv6jw-sYbqEMh9vJz64+dmzWhATYiBmzVQ@mail.gmail.com>
 <20200331083430.kserp35qabnxvths@ws.net.home>
 <CAJfpegsNpabFwoLL8HffNbi_4DuGMn4eYpFc6n7223UFnEPAbA@mail.gmail.com>
 <20200331122554.GA27469@gardel-login>
 <CAJfpegvo=T0VuXsPnvo83H3RqwHLE-9Q=dTZKWxnBKMykfJcNA@mail.gmail.com>
In-Reply-To: <CAJfpegvo=T0VuXsPnvo83H3RqwHLE-9Q=dTZKWxnBKMykfJcNA@mail.gmail.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Karel Zak <kzak@redhat.com>, Christian Brauner <christian.brauner@ubuntu.com>, David Howells <dhowells@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@zeniv.linux.org.uk>, dray@redhat.com, Miklos Szeredi <mszeredi@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>

On Di, 31.03.20 17:10, Miklos Szeredi (miklos@szeredi.hu) wrote:

> On Tue, Mar 31, 2020 at 2:25 PM Lennart Poettering <mzxreary@0pointer.de> wrote:
> >
> > On Di, 31.03.20 10:56, Miklos Szeredi (miklos@szeredi.hu) wrote:
> >
> > > On Tue, Mar 31, 2020 at 10:34 AM Karel Zak <kzak@redhat.com> wrote:
> > > >
> > > > On Tue, Mar 31, 2020 at 07:11:11AM +0200, Miklos Szeredi wrote:
> > > > > On Mon, Mar 30, 2020 at 11:17 PM Christian Brauner
> > > > > <christian.brauner@ubuntu.com> wrote:
> > > > >
> > > > > > Fwiw, putting down my kernel hat and speaking as someone who maintains
> > > > > > two container runtimes and various other low-level bits and pieces in
> > > > > > userspace who'd make heavy use of this stuff I would prefer the fd-based
> > > > > > fsinfo() approach especially in the light of across namespace
> > > > > > operations, querying all properties of a mount atomically all-at-once,
> > > > >
> > > > > fsinfo(2) doesn't meet the atomically all-at-once requirement.
> > > >
> > > > I guess your /proc based idea have exactly the same problem...
> > >
> > > Yes, that's exactly what I wanted to demonstrate: there's no
> > > fundamental difference between the two API's in this respect.
> > >
> > > > I see two possible ways:
> > > >
> > > > - after open("/mnt", O_PATH) create copy-on-write object in kernel to
> > > >   represent mount node -- kernel will able to modify it, but userspace
> > > >   will get unchanged data from the FD until to close()
> > > >
> > > > - improve fsinfo() to provide set (list) of the attributes by one call
> > >
> > > I think we are approaching this from the wrong end.   Let's just
> > > ignore all of the proposed interfaces for now and only concentrate on
> > > what this will be used for.
> > >
> > > Start with a set of use cases by all interested parties.  E.g.
> > >
> > >  - systemd wants to keep track attached mounts in a namespace, as well
> > > as new detached mounts created by fsmount()
> > >
> > >  - systemd need to keep information (such as parent, children, mount
> > > flags, fs options, etc) up to date on any change of topology or
> > > attributes.
> >
> > - We also have code that recursively remounts r/o or unmounts some
> >   directory tree (with filters),
>
> Recursive remount-ro is clear.  What is not clear is whether you need
> to do this for hidden mounts (not possible from userspace without a
> way to disable mount following on path lookup).  Would it make sense
> to add a kernel API for recursive setting of mount flags?

I would be very happy about an explicit kernel API for recursively
toggling the MS_RDONLY. But for many usecases in systemd we need the
ability to filter some subdirs and leave them as is, so while helpful
we'd have to keep the userspace code we currently have anyway.

> What exactly is this unmount with filters?  Can you give examples?

Hmm, actually it's only the r/o remount that has filters, not the
unmount. Sorry for the confusion. And the r/o remount with filters
just means: "remount everything below X read-only except for X/Y and
X/Z/A"...

Lennart

--
Lennart Poettering, Berlin
