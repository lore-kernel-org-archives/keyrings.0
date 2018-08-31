From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 31 Aug 2018 11:06:43 +0000
Subject: Re: [RFC] KEYS: inject an MKTME specific safety check in the keyctl revoke path
Message-Id: <20180831110643.GC9346@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180814020538.GA18424@alison-desk.jf.intel.com>
	<20180831110543.GB9346@linux.intel.com>
In-Reply-To: <20180831110543.GB9346@linux.intel.com>
To: linux-security-module@vger.kernel.org

On Fri, Aug 31, 2018 at 02:05:43PM +0300, Jarkko Sakkinen wrote:
> On Mon, Aug 13, 2018 at 07:05:38PM -0700, Alison Schofield wrote:
> > This RFC is asking for feedback on a problem I'm running into using
> > the Kernel Key Service for MKTME (MultiKey Total Memory Encryption).
> > 
> > I previously posted an RFC with the proposal to create a new key type
> > "mktme" to support MKTME (Multi-Key Total Memory Encryption).
> > https://www.spinics.net/lists/keyrings/msg03702.html
> > 
> > The MKTME key service maps userspace keys to hardware keyids. Those
> > keys are used in a new system call that encrypts memory. The keys
> > need to be tightly controlled. One example is that userspace keys
> > should not be revoked while the hardware keyid slot is still in use.
> 
> What is the new syscall? Can you point to a description?
> 
> > 
> > The KEY_FLAG_KEEP bit offers good control. The mktme service uses that
> > bit to prevent userspace keys from disappearing without the service
> > being notified.
> > 
> > Problem is that we need a safe and synchronous way to revoke keys. The
> > way .revoke methods function now, the key service type is called late
> > in the revoke process. The mktme key service has no means to reject the
> > request. So, even if the mktme service sanity checks the request in its
> > .revoke method, it's too late to do anything about it.
> 
> I have trouble understanding the problem. I'm just seeing what you need
> but I don't know why you need it...

Ignore this. I got the problem once I looked at the :-) Do not ignore
other comments.

/Jarkko
