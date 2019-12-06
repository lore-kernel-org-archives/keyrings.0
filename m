From: David Howells <dhowells@redhat.com>
Date: Fri, 06 Dec 2019 22:15:27 +0000
Subject: Re: [RFC PATCH 04/10] pipe: Use head and tail pointers for the ring, not cursor and length [ver #2]
Message-Id: <21300.1575670527@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191206214725.GA2108@latitude> <157186182463.3995.13922458878706311997.stgit@warthog.procyon.org.uk> <157186186167.3995.7568100174393739543.stgit@warthog.procyon.org.uk>
In-Reply-To: <20191206214725.GA2108@latitude>
To: Johannes Hirte <johannes.hirte@datenkhaos.de>
Cc: dhowells@redhat.com, torvalds@linux-foundation.org, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, nicolas.dichtel@6wind.com, raven@themaw.net, Christian Brauner <christian@brauner.io>, keyrings@vger.kernel.org, linux-usb@vger.kernel.org, linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-kernel@vger.kernel.org

Johannes Hirte <johannes.hirte@datenkhaos.de> wrote:

> > Convert pipes to use head and tail pointers for the buffer ring rather than
> > pointer and length as the latter requires two atomic ops to update (or a
> > combined op) whereas the former only requires one.
> 
> This change breaks firefox on my system. I've noticed that some pages
> doesn't load correctly anymore (e.g. facebook, spiegel.de). The pages
> start loading and than stop. Looks like firefox is waiting for some
> dynamic loading content. I've bisected to this commit, but can't revert
> because of conflicts.

There are a number of patches committed to upstream in the last couple of days
that might fix your problem.  See:

	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/

and look for:

	pipe: Fix iteration end check in fuse_dev_splice_write()
	pipe: fix incorrect caching of pipe state over pipe_wait()
	pipe: Fix missing mask update after pipe_wait()
	pipe: Remove assertion from pipe_poll()

David
