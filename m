From: Ian Kent <raven@themaw.net>
Date: Wed, 03 Jun 2020 02:15:34 +0000
Subject: Re: [GIT PULL] General notification queue and key notifications
Message-Id: <639a79d90f51da0b53a0ba45ec28d5b0dd9fee7b.camel@themaw.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1503686.1591113304@warthog.procyon.org.uk>
In-Reply-To: <1503686.1591113304@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>, torvalds@linux-foundation.org
Cc: viro@zeniv.linux.org.uk, dray@redhat.com, kzak@redhat.com, mszeredi@redhat.com, swhiteho@redhat.com, jlayton@redhat.com, andres@anarazel.de, christian.brauner@ubuntu.com, jarkko.sakkinen@linux.intel.com, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2020-06-02 at 16:55 +0100, David Howells wrote:
> 
> [[ With regard to the mount/sb notifications and fsinfo(), Karel Zak
> and
>    Ian Kent have been working on making libmount use them,
> preparatory to
>    working on systemd:
> 
> 	https://github.com/karelzak/util-linux/commits/topic/fsinfo
> 	
> https://github.com/raven-au/util-linux/commits/topic/fsinfo.public
> 
>    Development has stalled briefly due to other commitments, so I'm
> not
>    sure I can ask you to pull those parts of the series for
> now.  Christian
>    Brauner would like to use them in lxc, but hasn't started.
>    ]]

Linus,

Just so your aware of what has been done and where we are at here's
a summary.

Karel has done quite a bit of work on libmount (at this stage it's
getting hold of the mount information, aka. fsinfo()) and most of
what I have done is included in that too which you can see in Karel's
repo above). You can see a couple of bug fixes and a little bit of
new code present in my repo which hasn't been sent over to Karel
yet.

This infrastructure is essential before notifications work is started
which is where we will see the most improvement.

It turns out that while systemd uses libmount it has it's own
notifications handling sub-system as it deals with several event
types, not just mount information, in the same area. So, unfortunately,
changes will need to be made there as well as in libmount, more so
than the trivial changes to use fsinfo() via libmount.

That's where we are at the moment and I will get back to it once
I've dealt with a few things I postponed to work on libmount.

If you would like a more detailed account of what we have found I
can provide that too.

Is there anything else you would like from me or Karel?

Ian
