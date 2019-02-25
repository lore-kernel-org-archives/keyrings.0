From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Mon, 25 Feb 2019 21:20:49 +0000
Subject: Re: [PATCH v5 10/10] integrity: support EC-RDSA signatures for asymmetric_verify
Message-Id: <874l8rr2dq.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190224060828.2527-1-vt@altlinux.org> <20190224060828.2527-11-vt@altlinux.org>
In-Reply-To: <20190224060828.2527-11-vt@altlinux.org>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>


Hello Vitaly,

Vitaly Chikunov <vt@altlinux.org> writes:

> Allow to use EC-RDSA signatures for IMA by determining signature type by
> the hash algorithm name. This works good for EC-RDSA since Streebog and
> EC-RDSA should always be used together.
>
> Cc: Mimi Zohar <zohar@linux.ibm.com>
> Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> Cc: linux-integrity@vger.kernel.org
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> ---
>  security/integrity/digsig_asymmetric.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
> index d775e03fbbcc..c4a3313e0210 100644
> --- a/security/integrity/digsig_asymmetric.c
> +++ b/security/integrity/digsig_asymmetric.c
> @@ -104,9 +104,14 @@ int asymmetric_verify(struct key *keyring, const char *sig,
>
>  	memset(&pks, 0, sizeof(pks));
>
> -	pks.pkey_algo = "rsa";
>  	pks.hash_algo = hash_algo_name[hdr->hash_algo];
> -	pks.encoding = "pkcs1";
> +	if (!strncmp(pks.hash_algo, "streebog", 8)) {

Is it possible to test hdr->hash_algo instead of pkcs.hash_algo? IMHO if
an integer value is available it's preferable to check it rather than
doing a string comparison.

Also, it would be good to have a comment here mentioning that Streebog
and EC-RDSA should always be used together

> +		pks.pkey_algo = "ecrdsa";
> +		pks.encoding = "raw";
> +	} else {
> +		pks.pkey_algo = "rsa";
> +		pks.encoding = "pkcs1";
> +	}
>  	pks.digest = (u8 *)data;
>  	pks.digest_size = datalen;
>  	pks.s = hdr->sig;

--
Thiago Jung Bauermann
IBM Linux Technology Center
