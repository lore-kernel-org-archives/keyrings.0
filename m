From: Ian Kent <raven@themaw.net>
Date: Mon, 08 Jun 2020 00:49:43 +0000
Subject: Re: [GIT PULL] General notification queue and key notifications
Message-Id: <4e388597a0fc05fc553c7afd5076d77e232f875e.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1503686.1591113304@warthog.procyon.org.uk>
         <639a79d90f51da0b53a0ba45ec28d5b0dd9fee7b.camel@themaw.net>
In-Reply-To: <639a79d90f51da0b53a0ba45ec28d5b0dd9fee7b.camel@themaw.net>
To: David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, dray@redhat.com, kzak@redhat.com, mszeredi@redhat.com, swhiteho@redhat.com, jlayton@redhat.com, andres@anarazel.de, christian.brauner@ubuntu.com, jarkko.sakkinen@linux.intel.com, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 2020-06-03 at 10:15 +0800, Ian Kent wrote:
> On Tue, 2020-06-02 at 16:55 +0100, David Howells wrote:
> > [[ With regard to the mount/sb notifications and fsinfo(), Karel
> > Zak
> > and
> >    Ian Kent have been working on making libmount use them,
> > preparatory to
> >    working on systemd:
> > 
> > 	https://github.com/karelzak/util-linux/commits/topic/fsinfo
> > 	
> > https://github.com/raven-au/util-linux/commits/topic/fsinfo.public
> > 
> >    Development has stalled briefly due to other commitments, so I'm
> > not
> >    sure I can ask you to pull those parts of the series for
> > now.  Christian
> >    Brauner would like to use them in lxc, but hasn't started.
> >    ]]
> 
> Linus,
> 
> Just so your aware of what has been done and where we are at here's
> a summary.
> 
> Karel has done quite a bit of work on libmount (at this stage it's
> getting hold of the mount information, aka. fsinfo()) and most of
> what I have done is included in that too which you can see in Karel's
> repo above). You can see a couple of bug fixes and a little bit of
> new code present in my repo which hasn't been sent over to Karel
> yet.
> 
> This infrastructure is essential before notifications work is started
> which is where we will see the most improvement.
> 
> It turns out that while systemd uses libmount it has it's own
> notifications handling sub-system as it deals with several event
> types, not just mount information, in the same area. So,
> unfortunately,
> changes will need to be made there as well as in libmount, more so
> than the trivial changes to use fsinfo() via libmount.
> 
> That's where we are at the moment and I will get back to it once
> I've dealt with a few things I postponed to work on libmount.
> 
> If you would like a more detailed account of what we have found I
> can provide that too.
> 
> Is there anything else you would like from me or Karel?

I think there's a bit more I should say about this.

One reason work hasn't progressed further on this is I spent
quite a bit of time looking at the affects of using fsinfo().

My testing was done by using a large autofs direct mount map of
20000 entries which means that at autofs startup 20000 autofs
mounts must be done and at autofs shutdown those 20000 mounts
must be umounted. Not very scientific but something to use to
get a feel for the affect of our changes.

Initially just using fsinfo() to load all the mount entries was
done to see how that would perform. This was done in a way that
required no modifications to library user code but didn't get
much improvement.

Next loading all the mount ids (alone) for mount entry traversal
was done and the various fields retrieved on-demand (implemented
by Karel).

Loading the entire mount table and then traversing the entries
means the mount table is always possibly out of date. And loading
the ids and getting the fields on-demand might have made that
problem worse. But loading only the mount ids and using an
on-demand method to get needed fields worked surprisingly well.

The main issue is a mount going away while getting the fields.
Testing showed that simply checking the field is valid and
ignoring the entry if it isn't is enough to handle that case.

Also the mount going away after the needed fields have been
retrieved must be handled by callers of libmount as mounts
can just as easily go away after reading the proc based tables.

The case of the underlying mount information changing needs to
be considered too. We will need to do better on that in the
future but it too is a problem with the proc table handing and
hasn't seen problems logged against libmount for it AFAIK.

So, all in all, this approach worked pretty well as libmount
users do use the getter access methods to retrieve the mount
entry fields (which is required for the on-demand method to
work). Certainly systemd always uses them (and it looks like
udisks2 does too).

Unfortunately using the libmount on-demand implementation
requires library user code be modified (only a little in
the systemd case) to use the implementation.

Testing showed that we get between 10-15% reduction in
overhead and CPU usage remained high.

I think processing large numbers of mounts is simply a lot
of work and there are particular cases that will remain that
require the use of the load and traverse method. For example
matching all mounts with a given prefix string (one of the
systemd use cases).

It's hard to get information about this but I can say that
running pref during the autofs start and stop shows the bulk
of the counter hits on the fsinfo() table construction code
so that ahs to be where the overhead is.

The unavoidable conclusion is that the load and traverse method
that's been imposed on us for so long (even before libmount)
for mount handling is what we need to get away from. After all,
this is essentially where the problem comes from in the first
place. And fsinfo() is designed to not need to use this method
for getting mount information for that reason.

There's also the notifications side of things which is the next
area to work on. Looking at systemd I see that monitoring the
proc mount table leads to a load, traverse, and process of the
entire table for every single notification. It's clear that's
because of the (what I'll call) anonymous notifications that we
have now.

The notifications in David's series carry event specific
information, for example the mount id for mount notifications
and the libmount fsinfo() implementation is written to use the
mount id (lowest overhead lookup option), so there has to be
significant improvement for this case.

But systemd has it's own notifications handling code so there
will need to be non-trivial changes there as well as changes
in libmount.

Bottom line is we have a bit of a challenge with this because we
are trying to change coding practices developed over many years
that, necessarily, use a load/traverse method and it's going to
take quite a while to change these coding practices.

My question is, is there something specific, besides what we are
doing, that you'd like to see done now in order to get the series
merged?

Ian
