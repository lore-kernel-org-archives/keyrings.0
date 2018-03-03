From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Sat, 03 Mar 2018 20:11:59 +0000
Subject: Re: [PATCH 1/5] tpm: Trigger only missing TPM 2.0 self tests
Message-Id: <1520107919.3105.9.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
         <20180228195819.22231-2-jarkko.sakkinen@linux.intel.com>
In-Reply-To: <20180228195819.22231-2-jarkko.sakkinen@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Alexander Steffen <Alexander.Steffen@infineon.com>, stable@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkine@linux.intel.com>, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>

On Wed, 2018-02-28 at 21:58 +0200, Jarkko Sakkinen wrote:
> From: Alexander Steffen <Alexander.Steffen@infineon.com>
> 
> My Nuvoton 6xx in a Dell XPS-13 has been intermittently failing to
> work (necessitating a reboot). The problem seems to be that the TPM
> gets into a state where the partial self-test doesn't return
> TPM_RC_SUCCESS (meaning all tests have run to completion), but
> instead returns TPM_RC_TESTING (meaning some tests are still running
> in the background).  There are various theories that resending the
> self-test command actually causes the tests to restart and thus
> triggers more TPM_RC_TESTING returns until the timeout is exceeded.
> 
> There are several issues here: firstly being we shouldn't slow down
> the boot sequence waiting for the self test to complete once the TPM
> backgrounds them.  It will actually make available all functions that
> have passed and if it gets a failure return TPM_RC_FAILURE to every
> subsequent command.  So the fix is to kick off self tests once and if
> they return TPM_RC_TESTING log that as a backgrounded self test

I still think removing all logging traces is a mistake for something
that can consume a significant amount of time in the boot sequence.
 It's going to cause lost of people doing boot timings to waste lots of
effort.

However, removing the log messages makes the above statement a lie, so
one of the two needs fixing.

[...]
> @@ -852,27 +837,24 @@ static const struct tpm_input_header
> tpm2_selftest_header = {
>   */
>  static int tpm2_do_selftest(struct tpm_chip *chip)
>  {
> +	struct tpm_buf buf;
> +	int full;
>  	int rc;
> -	unsigned int delay_msec = 10;
> -	long duration;
> -	struct tpm2_cmd cmd;
>  
> -	duration = jiffies_to_msecs(
> -		tpm2_calc_ordinal_duration(chip,
> TPM2_CC_SELF_TEST));
> -
> -	while (1) {
> -		cmd.header.in = tpm2_selftest_header;
> -		cmd.params.selftest_in.full_test = 0;
> -
> -		rc = tpm_transmit_cmd(chip, NULL, &cmd,
> TPM2_SELF_TEST_IN_SIZE,
> -				      0, 0, "continue selftest");
> +	for (full = 0; full < 2; full++) {
> +		rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS,
> TPM2_CC_SELF_TEST);
> +		if (rc)
> +			return rc;
>  
> -		if (rc != TPM2_RC_TESTING || delay_msec >= duration)
> -			break;
> +		tpm_buf_append_u8(&buf, full);
> +		rc = tpm_transmit_cmd(chip, NULL, buf.data,
> PAGE_SIZE, 0, 0,
> +				      "attempting the self test\n");

There shouldn't be a \n in the string: the failure message already
appends one.

James

