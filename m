From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 01 Oct 2019 20:54:45 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <20191001205445.GC26709@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190926171601.30404-1-jarkko.sakkinen@linux.intel.com>
 <20190928180559.jivt5zlisr43fnva@cantor>
In-Reply-To: <20190928180559.jivt5zlisr43fnva@cantor>
To: linux-integrity@vger.kernel.org, stable@vger.kernel.org, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Sat, Sep 28, 2019 at 11:05:59AM -0700, Jerry Snitselaar wrote:
> On Thu Sep 26 19, Jarkko Sakkinen wrote:
> > Only the kernel random pool should be used for generating random numbers.
> > TPM contributes to that pool among the other sources of entropy. In here it
> > is not, agreed, absolutely critical because TPM is what is trusted anyway
> > but in order to remove tpm_get_random() we need to first remove all the > > call sites.  > > 
> > Cc: stable@vger.kernel.org
> > Fixes: 0c36264aa1d5 ("KEYS: asym_tpm: Add loadkey2 and flushspecific [ver #2]")
> > Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > ---
> > crypto/asymmetric_keys/asym_tpm.c | 7 ++-----
> > 1 file changed, 2 insertions(+), 5 deletions(-)
> > 
> > diff --git a/crypto/asymmetric_keys/asym_tpm.c b/crypto/asymmetric_keys/asym_tpm.c
> > index 76d2ce3a1b5b..c14b8d186e93 100644
> > --- a/crypto/asymmetric_keys/asym_tpm.c
> > +++ b/crypto/asymmetric_keys/asym_tpm.c
> > @@ -6,6 +6,7 @@
> > #include <linux/kernel.h>
> > #include <linux/seq_file.h>
> > #include <linux/scatterlist.h>
> > +#include <linux/random.h>
> > #include <linux/tpm.h>
> > #include <linux/tpm_command.h>
> > #include <crypto/akcipher.h>
> > @@ -54,11 +55,7 @@ static int tpm_loadkey2(struct tpm_buf *tb,
> > 	}
> > 
> > 	/* generate odd nonce */
> > -	ret = tpm_get_random(NULL, nonceodd, TPM_NONCE_SIZE);
> > -	if (ret < 0) {
> > -		pr_info("tpm_get_random failed (%d)\n", ret);
> > -		return ret;
> > -	}
> > +	get_random_bytes(nonceodd, TPM_NONCE_SIZE);
> > 
> > 	/* calculate authorization HMAC value */
> > 	ret = TSS_authhmac(authdata, keyauth, SHA1_DIGEST_SIZE, enonce,
> > -- 
> > 2.20.1
> > 
> 
> Should tpm_unbind and tpm_sign in asym_tpm.c be switched as well then?

Without doubt. Thanks. I'll send an update soon.

/Jarkko
