From: Eric Biggers <ebiggers3@gmail.com>
Date: Wed, 31 May 2017 19:11:07 +0000
Subject: Re: [PATCH] KEYS: fix dereferencing NULL payload with nonzero length
Message-Id: <20170531191107.GB72735@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170403175929.GB72831@gmail.com>
	<20170401213428.17097-1-ebiggers3@gmail.com>
	<3451.1491234402@warthog.procyon.org.uk>
	<6884.1491247244@warthog.procyon.org.uk>
	<20170403213041.GA140817@gmail.com>
In-Reply-To: <20170403213041.GA140817@gmail.com>
To: linux-security-module@vger.kernel.org

On Mon, Apr 03, 2017 at 02:30:41PM -0700, Eric Biggers wrote:
> On Mon, Apr 03, 2017 at 08:20:44PM +0100, David Howells wrote:
> > Eric Biggers <ebiggers3@gmail.com> wrote:
> > 
> > > > > -	if (_payload) {
> > > > > +	if (plen) {
> > > > 
> > > > "if (_payload && plen)" would be better.
> > > > 
> > > > David
> > > 
> > > No, that doesn't solve the problem.  The problem is that userspace can pass
> > > in a NULL payload with nonzero length, causing the kernel to dereference a
> > > NULL pointer for some key types.  For example:
> > 
> > Okay, in that case, I think there should be an else-statement that clears plen
> > if !_payload.
> > 
> > David
> 
> I think it's preferable to return EFAULT in the case in question.  Most syscalls
> work like that, i.e. if you say you have 100 bytes (or any number > 0) at
> address NULL you'll get EFAULT.
> 
> Also note that anyone doing this before would have been either crashing the
> kernel or getting EINVAL.  So starting to return EFAULT would be very unlikely
> to break anything.
> 
> - Eric

David, can you please apply this?  Or if you haven't applied it because you
prefer the other solution then please explain your reasoning.

It's really not acceptable for unprivileged users to be able to trivially oops
the kernel.

Eric
