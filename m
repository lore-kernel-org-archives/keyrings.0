From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 01 Mar 2018 10:11:53 +0000
Subject: Re: [PATCH 2/5] tpm: migrate tpm2_shutdown() to use struct tpm_buf
Message-Id: <20180301101153.GA32447@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180228195819.22231-1-jarkko.sakkinen@linux.intel.com>
 <20180228195819.22231-3-jarkko.sakkinen@linux.intel.com>
 <20180228202540.GA19007@ziepe.ca>
In-Reply-To: <20180228202540.GA19007@ziepe.ca>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>

On Wed, Feb 28, 2018 at 01:25:40PM -0700, Jason Gunthorpe wrote:
> On Wed, Feb 28, 2018 at 09:58:15PM +0200, Jarkko Sakkinen wrote:
> > In order to make struct tpm_buf the first class object for constructing TPM
> > commands, migrate tpm2_shutdown() to use it. In addition, removed the klog
> > entry when tpm_transmit_cmd() fails because tpm_tansmit_cmd() already
> > prints an error message.
> > 
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> >  drivers/char/tpm/tpm2-cmd.c | 41 +++++++++++++----------------------------
> >  1 file changed, 13 insertions(+), 28 deletions(-)
> > 
> > diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> > index 6eeff3a60003..5f92141b1e16 100644
> > +++ b/drivers/char/tpm/tpm2-cmd.c
> > @@ -27,10 +27,6 @@ enum tpm2_session_attributes {
> >  	TPM2_SA_CONTINUE_SESSION	= BIT(0),
> >  };
> >  
> > -struct tpm2_startup_in {
> > -	__be16	startup_type;
> > -} __packed;
> > -
> >  struct tpm2_get_tpm_pt_in {
> >  	__be32	cap_id;
> >  	__be32	property_id;
> > @@ -55,7 +51,6 @@ struct tpm2_get_random_out {
> >  } __packed;
> >  
> >  union tpm2_cmd_params {
> > -	struct	tpm2_startup_in		startup_in;
> >  	struct	tpm2_get_tpm_pt_in	get_tpm_pt_in;
> >  	struct	tpm2_get_tpm_pt_out	get_tpm_pt_out;
> >  	struct	tpm2_get_random_in	getrandom_in;
> > @@ -760,40 +755,30 @@ ssize_t tpm2_get_tpm_pt(struct tpm_chip *chip, u32 property_id,  u32 *value,
> >  }
> >  EXPORT_SYMBOL_GPL(tpm2_get_tpm_pt);
> >  
> > -#define TPM2_SHUTDOWN_IN_SIZE \
> > -	(sizeof(struct tpm_input_header) + \
> > -	 sizeof(struct tpm2_startup_in))
> > -
> > -static const struct tpm_input_header tpm2_shutdown_header = {
> > -	.tag = cpu_to_be16(TPM2_ST_NO_SESSIONS),
> > -	.length = cpu_to_be32(TPM2_SHUTDOWN_IN_SIZE),
> > -	.ordinal = cpu_to_be32(TPM2_CC_SHUTDOWN)
> > -};
> > -
> >  /**
> >   * tpm2_shutdown() - send shutdown command to the TPM chip
> >   *
> > + * In places where shutdown command is sent there's no much we can do except
> > + * print the error code on a system failure.
> > + *
> >   * @chip:		TPM chip to use.
> >   * @shutdown_type:	shutdown type. The value is either
> >   *			TPM_SU_CLEAR or TPM_SU_STATE.
> >   */
> >  void tpm2_shutdown(struct tpm_chip *chip, u16 shutdown_type)
> >  {
> > -	struct tpm2_cmd cmd;
> > +	struct tpm_buf buf;
> >  	int rc;
> >  
> > -	cmd.header.in = tpm2_shutdown_header;
> > -	cmd.params.startup_in.startup_type = cpu_to_be16(shutdown_type);
> > -
> > -	rc = tpm_transmit_cmd(chip, NULL, &cmd, sizeof(cmd), 0, 0,
> > -			      "stopping the TPM");
> > -
> > -	/* In places where shutdown command is sent there's no much we can do
> > -	 * except print the error code on a system failure.
> > -	 */
> > -	if (rc < 0 && rc != -EPIPE)
> > -		dev_warn(&chip->dev, "transmit returned %d while stopping the TPM",
> > -			 rc);
> > +	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_SHUTDOWN);
> > +	if (rc) {
> > +		dev_err(&chip->dev, "%s: out of memory", __func__);
> 
> Don't print for out of memory. The kernel already makes lots of
> prints for you. Same comment everywhere.
> 
> Jason

I'll remove that. Thanks!

/Jarkko
