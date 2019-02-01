From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 01 Feb 2019 06:26:55 +0000
Subject: Re: [RFC PATCH v4] akcipher: new verify API for public key algorithms
Message-Id: <20190201062655.hmxeqo5hprhcgtfx@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190125180116.13702-1-vt@altlinux.org>
In-Reply-To: <20190125180116.13702-1-vt@altlinux.org>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Aymen Sghaier <aymen.sghaier@nxp.com>, Alexandre Torgue <alexandre.torgue@st.com>, Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>, qat-linux@intel.com, Gary Hook <gary.hook@amd.com>, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org

On Fri, Jan 25, 2019 at 09:01:16PM +0300, Vitaly Chikunov wrote:
>
> @@ -781,36 +780,17 @@ static int tpm_key_verify_signature(const struct key *key,
>  	if (!req)
>  		goto error_free_tfm;
>  
> -	ret = -ENOMEM;
> -	outlen = crypto_akcipher_maxsize(tfm);
> -	output = kmalloc(outlen, GFP_KERNEL);
> -	if (!output)
> -		goto error_free_req;
> -
> -	sg_init_one(&sig_sg, sig->s, sig->s_size);
> -	sg_init_one(&digest_sg, output, outlen);
> -	akcipher_request_set_crypt(req, &sig_sg, &digest_sg, sig->s_size,
> -				   outlen);
> +	sg_init_table(&src_sg, 2);
> +	sg_set_buf(&src_sg[0], sig->s, sig->s_size);
> +	sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);
> +	akcipher_request_set_crypt(req, &src_sg, NULL, sig->s_size,
> +				   sig->digest_size);

It's not clear that sig->digest is guaranteed to be kmalloc memory.
In any case, it's best not to mix unrelated changes in a single
patch.  So please keep the kmalloc on output and then copy
sig->digest into it and put output into the SG list.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
