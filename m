From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 03 Mar 2020 21:20:10 +0000
Subject: Re: [PATCH v6 6/6] security: keys: trusted: implement counter/timer policy
Message-Id: <20200303212010.GA110353@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200302122759.5204-1-James.Bottomley@HansenPartnership.com>
 <20200302122759.5204-7-James.Bottomley@HansenPartnership.com>
 <20200303200820.GE5775@linux.intel.com>
 <1583268041.3638.9.camel@HansenPartnership.com>
In-Reply-To: <1583268041.3638.9.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Tue, Mar 03, 2020 at 03:40:41PM -0500, James Bottomley wrote:
> On Tue, 2020-03-03 at 22:08 +0200, Jarkko Sakkinen wrote:
> > On Mon, Mar 02, 2020 at 07:27:59AM -0500, James Bottomley wrote:
> > > This is actually a generic policy allowing a range of comparisons
> > > against any value set in the TPM Clock, which includes things like
> > > the reset count, a monotonic millisecond count and the restart
> > > count.  The most useful comparison is against the millisecond count
> > > for expiring keys.  However, you have to remember that currently
> > > Linux doesn't try to sync the epoch timer with the TPM, so the
> > > expiration is actually measured in how long the TPM itself has been
> > > powered on ... the TPM timer doesn't count while the system is
> > > powered down.  The millisecond counter is a u64 quantity found at
> > > offset 8 in the timer structure, and the <= comparision operand is
> > > 9, so a policy set to expire after the TPM has been up for 100
> > > seconds would look like
> > > 
> > > 0000016d00000000000f424000080009
> > > 
> > > Where 0x16d is the counter timer policy code and 0xf4240 is 100 000
> > > in hex.
> > > 
> > > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > > om>
> > 
> > It is techincally possible to merge 1-5 without this and have
> > something functional?
> 
> Yes: it just adds to the policy types we understand, but we can still
> do password and PCR policies without this.

OK, cool. Did not mean  that I'd have any particular problem to merge
it. Just want to know the constraints that I live in.

/Jarkko
