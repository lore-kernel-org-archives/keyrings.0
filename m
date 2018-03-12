From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 12 Mar 2018 11:13:00 +0000
Subject: Re: [PATCH v3 1/5] tpm: fix intermittent failure with self tests
Message-Id: <20180312111300.GB7448@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
 <20180305165614.5469-2-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20180305165614.5469-2-jarkko.sakkinen@linux.intel.com>
To: linux-integrity@vger.kernel.org, James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, stable@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>

On Mon, Mar 05, 2018 at 06:56:10PM +0200, Jarkko Sakkinen wrote:
> From: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> My Nuvoton 6xx in a Dell XPS-13 has been intermittently failing to work
> (necessitating a reboot). The problem seems to be that the TPM gets into a
> state where the partial self-test doesn't return TPM_RC_SUCCESS (meaning
> all tests have run to completion), but instead returns TPM_RC_TESTING
> (meaning some tests are still running in the background).  There are
> various theories that resending the self-test command actually causes the
> tests to restart and thus triggers more TPM_RC_TESTING returns until the
> timeout is exceeded.
> 
> There are several issues here: firstly being we shouldn't slow down the
> boot sequence waiting for the self test to complete once the TPM
> backgrounds them.  It will actually make available all functions that have
> passed and if it gets a failure return TPM_RC_FAILURE to every subsequent
> command.  So the fix is to kick off self tests once and if they return
> TPM_RC_TESTING log that as a backgrounded self test and continue on.  In
> order to prevent other tpm users from seeing any TPM_RC_TESTING returns
> (which it might if they send a command that needs a TPM subsystem which is
> still under test), we loop in tpm_transmit_cmd until either a timeout or we
> don't get a TPM_RC_TESTING return.
> 
> Finally, there have been observations of strange returns from a partial
> test. One Nuvoton is occasionally returning TPM_RC_COMMAND_CODE, so treat
> any unexpected return from a partial self test as an indication we need to
> run a full self test.
> 
> [jarkko.sakkinen@linux.intel.com: cleaned up James' original commit and
>  added a proper Fixes line]
> 
> Fixes: 2482b1bba5122 ("tpm: Trigger only missing TPM 2.0 self tests")
> Cc: stable@vger.kernel.org
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Tested-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>

Already applied to my master (bleeding edge) branch in order to
facilitate testing/review:

git://git.infradead.org/users/jjs/linux-tpmdd.git

I also rewrote the description of the updatesthat I did to this commit
to be more precise (see the commit msg in my GIT tree). If it turns out
that some klog would make a huge difference I'm willing to consider that
later but lets go with this for now.

I'll also send an updated tpm_buf patch set with this one dropped soon.

/Jarkko
