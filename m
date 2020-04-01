From: Lennart Poettering <mzxreary@0pointer.de>
Date: Wed, 01 Apr 2020 14:41:09 +0000
Subject: Re: Upcoming: Notifications, FS notifications and fsinfo()
Message-Id: <20200401144109.GA29945@gardel-login>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200330211700.g7evnuvvjenq3fzm@wittgenstein>
 <1445647.1585576702@warthog.procyon.org.uk>
 <2418286.1585691572@warthog.procyon.org.uk>
In-Reply-To: <2418286.1585691572@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>, torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, dray@redhat.com, kzak@redhat.com, mszeredi@redhat.com, swhiteho@redhat.com, jlayton@redhat.com, raven@themaw.net, andres@anarazel.de, keyrings@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, cyphar@cyphar.com

On Di, 31.03.20 22:52, David Howells (dhowells@redhat.com) wrote:

> Christian Brauner <christian.brauner@ubuntu.com> wrote:
>
> > querying all properties of a mount atomically all-at-once,
>
> I don't actually offer that, per se.
>
> Having an atomic all-at-once query for a single mount is actually quite a
> burden on the system.  There's potentially a lot of state involved, much of
> which you don't necessarily need.

Hmm, do it like with statx() and specify a mask for the fields userspace
wants? Then it would be as lightweight as it possibly could be?

Lennart

--
Lennart Poettering, Berlin
