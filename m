From: Eric Biggers <ebiggers3@gmail.com>
Date: Fri, 10 Nov 2017 18:41:05 +0000
Subject: Re: [PATCH] lib/mpi: call cond_resched() from mpi_powm() loop
Message-Id: <20171110184105.GA99710@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171107061951.861-1-ebiggers3@gmail.com>
 <20171110113729.GD26163@gondor.apana.org.au>
In-Reply-To: <20171110113729.GD26163@gondor.apana.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-crypto@vger.kernel.org, Tudor-Dan Ambarus <tudor.ambarus@microchip.com>, Mat Martineau <mathew.j.martineau@linux.intel.com>, Salvatore Benedetto <salvatore.benedetto@intel.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>, stable@vger.kernel.org

On Fri, Nov 10, 2017 at 10:37:30PM +1100, Herbert Xu wrote:
> On Mon, Nov 06, 2017 at 10:19:51PM -0800, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > On a non-preemptible kernel, if KEYCTL_DH_COMPUTE is called with the
> > largest permitted inputs (16384 bits), the kernel spends 10+ seconds
> > doing modular exponentiation in mpi_powm() without rescheduling.  If all
> > threads do it, it locks up the system.  Moreover, it can cause
> > rcu_sched-stall warnings.
> > 
> > Notwithstanding the insanity of doing this calculation in kernel mode
> > rather than in userspace, fix it by calling cond_resched() as each bit
> > from the exponent is processed.  It's still noninterruptible, but at
> > least it's preemptible now.
> > 
> > Cc: stable@vger.kernel.org # v4.12+
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> 
> Patch applied.  Thanks.
> -- 

If it's not too late can you fix the stable line to be just

	Cc: stable@vger.kernel.org

As Mat pointed out KEYCTL_DH_COMPUTE was actually introduced in v4.7.  Also I
think the code is also reachable through RSA by adding an x509 certificate using
the "asymmetric" key type, although that appears to be limited to 4096-bit
inputs rather than 16384 bits.

Eric
