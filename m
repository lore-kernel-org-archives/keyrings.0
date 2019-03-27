From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 27 Mar 2019 18:10:20 +0000
Subject: Re: [PATCH v8 10/10] integrity: support EC-RDSA signatures for asymmetric_verify
Message-Id: <1553710220.4608.9.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20190326125842.24110-1-vt@altlinux.org>
         <20190326125842.24110-11-vt@altlinux.org>
In-Reply-To: <20190326125842.24110-11-vt@altlinux.org>
To: Vitaly Chikunov <vt@altlinux.org>, Herbert Xu <herbert@gondor.apana.org.au>, David Howells <dhowells@redhat.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2019-03-26 at 15:58 +0300, Vitaly Chikunov wrote:
> Allow to use EC-RDSA signatures for IMA by determining signature type by
> the hash algorithm name. This works good for EC-RDSA since Streebog and
> EC-RDSA should always be used together.
> 
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: linux-integrity@vger.kernel.org
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  security/integrity/digsig_asymmetric.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
> index d775e03fbbcc..99080871eb9f 100644
> --- a/security/integrity/digsig_asymmetric.c
> +++ b/security/integrity/digsig_asymmetric.c
> @@ -104,9 +104,16 @@ int asymmetric_verify(struct key *keyring, const char *sig,
>  
>  	memset(&pks, 0, sizeof(pks));
>  
> -	pks.pkey_algo = "rsa";
>  	pks.hash_algo = hash_algo_name[hdr->hash_algo];
> -	pks.encoding = "pkcs1";
> +	if (hdr->hash_algo = HASH_ALGO_STREEBOG_256 ||
> +	    hdr->hash_algo = HASH_ALGO_STREEBOG_512) {
> +		/* EC-RDSA and Streebog should go together. */
> +		pks.pkey_algo = "ecrdsa";
> +		pks.encoding = "raw";

IMA signatures are stored as xattrs, making them persistent.  Support
for streebog was upstreamed in linux-5.0.  This change would break
existing systems using streebog.  As long as this is not yet a concern

Reviewed-by:  Mimi Zohar <zohar@linux.ibm.com>

> +	} else {
> +		pks.pkey_algo = "rsa";
> +		pks.encoding = "pkcs1";
> +	}
>  	pks.digest = (u8 *)data;
>  	pks.digest_size = datalen;
>  	pks.s = hdr->sig;
