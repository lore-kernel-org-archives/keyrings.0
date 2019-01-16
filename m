From: David Howells <dhowells@redhat.com>
Date: Wed, 16 Jan 2019 17:12:20 +0000
Subject: Re: [RFC PATCH v2] akcipher: Introduce verify_rsa/verify for public key algorithms
Message-Id: <24887.1547658740@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190116164703.9267-1-vt@altlinux.org>
In-Reply-To: <20190116164703.9267-1-vt@altlinux.org>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, Aymen Sghaier <aymen.sghaier@nxp.com>, Alexandre Torgue <alexandre.torgue@st.com>, =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>, qat-linux@intel.com, linux-stm32@st-md-mailman.stormreply.com, Gary Hook <gary.hook@amd.com>, linux-kernel@vger.kernel.org, Tudor Ambarus <tudor-dan.ambarus@nxp.com>, dhowells@redhat.com, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, Herbert Xu <herbert@gondor.apana.org.au>

Umm...  What do I apply this patch to?

In your modified public_key_verify_signature():

> -	sg_init_one(&digest_sg, output, outlen);
> -	akcipher_request_set_crypt(req, &sig_sg, &digest_sg, sig->s_size,
> +	sg_init_one(&output_sg, output, outlen);
> +	akcipher_request_set_crypt(req, &sig_sg, &output_sg, sig->s_size,
>  				   outlen);

Why is the output necessary?  It was there for the decoded hash to be placed
in prior to comparison - but now that's not necessary.

> -	ret = crypto_wait_req(crypto_akcipher_verify(req), &cwait);
> +	ret = crypto_wait_req(crypto_akcipher_verify(req, sig->digest,
> +						     sig->digest_size), &cwait);

I see sig->digest is passed in here.  Should it be passed in in place of
output_sg above?

> -	inst->alg.verify = pkcs1pad_verify;
> +	inst->alg.verify_rsa = pkcs1pad_verify;

Is there a reason that pkcs1pad_verify() can't do the comparison?

> -	.verify = rsa_verify,
> +	.verify_rsa = rsa_verify,

Likewise verify_rsa()?

Granted, this might involve pkcs1pad_verify() dressing up the signature in the
appropriate wrappings and passing it along to verify_rsa() to do the actual
comparison there (ie. what pkcs1pad_verify_complete() does).

> -	.verify = caam_rsa_enc,
> +	.verify_rsa = caam_rsa_enc,

I presume this is the reason - because this reuses its encrypt operation
directly.  But could this instead perform the comparison upon completion, say
in rsa_pub_done()?

> -	.verify = qat_rsa_enc,
> +	.verify_rsa = qat_rsa_enc,

Again, this could do the comparison, say, in qat_rsa_cb().

David
