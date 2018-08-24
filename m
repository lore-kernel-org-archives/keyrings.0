From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 24 Aug 2018 06:19:56 +0000
Subject: Re: [PATCH 01/23] TPM: Add new TPMs to the tail of the list to prevent inadvertent change of dev
Message-Id: <20180824061956.GA3584@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <153486700916.13066.12870860668352070081.stgit@warthog.procyon.org.uk>
 <153486701644.13066.13372706238885253812.stgit@warthog.procyon.org.uk>
In-Reply-To: <153486701644.13066.13372706238885253812.stgit@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: denkenz@gmail.com, jejb@linux.vnet.ibm.com, keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, tpmdd-devel@lists.sourceforge.net, linux-security-module@vger.kernel.org

Use "tpm" instead of "TPM" in the short summary.

On Tue, Aug 21, 2018 at 04:56:56PM +0100, David Howells wrote:
> Add newly registered TPMs to the tail of the list, not the beginning, so that
> things that are specifying TPM_ANY_NUM don't find that the device they're
> using has inadvertently changed.  Adding a second device would break IMA, for
> instance.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
> cc: stable@vger.kernel.org

Usually I add Cc-tag before signed-off-by's (and have the first c in
upper case).

Peter's singed-off-by should be accompanied with a co-developed-by tag
if he has participated to the development of this commit.

As far as I see signed-off-by without co-developed-by makes sense in two
occasions:

* You own the subsystem tree i.e. you have to sign the changes that you
  include part of your pull request.
* You are the initial authoer of the change.  

> ---
> 
>  drivers/char/tpm/tpm-interface.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/tpm/tpm-interface.c b/drivers/char/tpm/tpm-interface.c
> index 6af17002a115..cfb9089887bd 100644
> --- a/drivers/char/tpm/tpm-interface.c
> +++ b/drivers/char/tpm/tpm-interface.c
> @@ -1122,7 +1122,7 @@ struct tpm_chip *tpm_register_hardware(struct device *dev,
>  
>  	/* Make chip available */
>  	spin_lock(&driver_lock);
> -	list_add_rcu(&chip->list, &tpm_chip_list);

I would add here a comment just as a remainder.
> +	list_add_tail_rcu(&chip->list, &tpm_chip_list);
>  	spin_unlock(&driver_lock);
>  
>  	return chip;

/Jarkko
