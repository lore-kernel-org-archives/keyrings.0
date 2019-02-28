From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 28 Feb 2019 09:01:25 +0000
Subject: Re: [RFC PATCH 1/4] X.509: Parse public key parameters from x509 for akcipher
Message-Id: <20190228090125.6n62v4oxpwl5yzv4@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190106133608.820-1-vt@altlinux.org>
 <20190106133608.820-2-vt@altlinux.org>
 <20190209214240.56gq7ivn3pw3bssf@altlinux.org>
 <20190210184628.yupsxgjlaicwbxg6@altlinux.org>
 <20190219043732.x3sbwzqlz4ikntxo@gondor.apana.org.au>
 <20190224064840.hii4ccjksjdnewae@altlinux.org>
 <20190228061444.3escryzoit3idtwg@gondor.apana.org.au>
 <20190228070449.gjwoq4c2b3x5grie@altlinux.org>
 <20190228075141.s6mftb44yuylbzys@gondor.apana.org.au>
 <20190228082801.2aofw23r2shzwy4n@altlinux.org>
In-Reply-To: <20190228082801.2aofw23r2shzwy4n@altlinux.org>
To: David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 11:28:01AM +0300, Vitaly Chikunov wrote:
> On Thu, Feb 28, 2019 at 03:51:41PM +0800, Herbert Xu wrote:
> > On Thu, Feb 28, 2019 at 10:04:49AM +0300, Vitaly Chikunov wrote:
> > > 
> > > It seems that you insist on set_params to be removed and both key and
> > > params to be passed into set_{pub,priv}_key. This means reworking all
> > > existing RSA drivers and callers, right? Can you please confirm that
> > > huge rework to avoid misunderstanding?
> > 
> > I don't understand why we even need to touch the existing RSA
> > drivers.  Nothing needs to change as far as they're concerned.
> > 
> > Only the new algorithms would need to decode the extra parameters
> > in the key stream.
> 
>         int (*set_pub_key)(struct crypto_akcipher *tfm, const void *key,
>                            unsigned int keylen);
>         int (*set_priv_key)(struct crypto_akcipher *tfm, const void *key,
>                             unsigned int keylen);
> 
> So you want `keylen' not to cover parameters data, but parameters
> actually present in key after `keylen' bytes (in come packed format)?
> (And if there is no parameters appended, there is still appended some
> marker, like 0, to signify that there is no parameters.)
> 
> This looks a bit counter-intuitive usage of arguments (as argument
> signifying length does not cover all arguments data), is this ok to you?

This is how we handle things in DH as well as other places such
as authenc.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
