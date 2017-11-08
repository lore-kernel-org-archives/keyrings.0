From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 08 Nov 2017 21:54:23 +0000
Subject: Re: [PATCH 1/4] Add a function to start/reduce a timer
Message-Id: <alpine.DEB.2.20.1711082253220.1962@nanos>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <150937786557.31781.15521097996984061107.stgit@warthog.procyon.org.uk> <150937787256.31781.8531811303029438707.stgit@warthog.procyon.org.uk>
In-Reply-To: <150937787256.31781.8531811303029438707.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-afs@lists.infradead.org

On Mon, 30 Oct 2017, David Howells wrote:

> Add a function, similar to mod_timer(), that will start a timer it isn't
> running and will modify it if it is running and has an expiry time longer
> than the new time.  If the timer is running with an expiry time that's the
> same or sooner, no change is made.
> 
> The function looks like:
> 
> 	int reduce_timer(struct timer_list *timer, unsigned long expires);

It seems you missed to address any comment I made in:

http://lkml.kernel.org/r/alpine.DEB.2.20.1710201359480.2908@nanos

Thanks,

	tglx
