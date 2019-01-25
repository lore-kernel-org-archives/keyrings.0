From: Vitaly Chikunov <vt@altlinux.org>
Date: Fri, 25 Jan 2019 11:18:09 +0000
Subject: Re: [RFC PATCH v3] akcipher: Introduce verify_rsa/verify for public key algorithms
Message-Id: <20190125111808.slyoptlns53t7fiw@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190118205846.20309-1-vt@altlinux.org>
 <20190125100929.zxmqbsibnnikh7tv@gondor.apana.org.au>
In-Reply-To: <20190125100929.zxmqbsibnnikh7tv@gondor.apana.org.au>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Howells <dhowells@redhat.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 06:09:29PM +0800, Herbert Xu wrote:
> On Fri, Jan 18, 2019 at 11:58:46PM +0300, Vitaly Chikunov wrote:
> > Previous akcipher .verify() just `decrypts' (using RSA encrypt which is
> > using public key) signature to uncover message hash, which was then
> > compared in upper level public_key_verify_signature() with the expected
> > hash value, which itself was never passed into verify().
> > 
> > This approach was incompatible with EC-DSA family of algorithms,
> > because, to verify a signature EC-DSA algorithm also needs a hash value
> > as input; then it's used (together with a signature divided into halves
> > `r||s') to produce a witness value, which is then compared with `r' to
> > determine if the signature is correct. Thus, for EC-DSA, nor
> > requirements of .verify() itself, nor its output expectations in
> > public_key_verify_signature() wasn't sufficient.
> > 
> > Make improved .verify() call which gets hash value as parameter and
> > produce complete signature check without any output besides status.
> > 
> > RSA-centric drivers have replaced verify() with verify_rsa() which
> > have old semantic and which they still should implement (if they want
> > pkcs1pad to work). If akcipher have .verify_rsa() callback, it will be
> > used for a partial verification, which then is finished in
> > crypto_akcipher_verify().
> > 
> > Now for the top level verification only crypto_akcipher_verify() needs
> > to be called.
> > 
> > For pkcs1pad crypto_akcipher_verify_rsa() is introduced which directly
> > calls .verify_rsa() for its backend. Without this api PKCS1 can not be
> > implemented.
> > 
> > Tested on x86_64.
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> 
> Thanks for working on this!
> 
> We have been here before.  We changed the AEAD interface in a way
> that is not dissimilar to what you want to do here.
> 
> So I think the basic plan should be:

While time goes, I got another simpler idea how we should settle this:

1. Since we are know that by nature RSA sign/verify is just encrypt/decrypt,
and since sign/verify calls should not be used directly by any normal
users:
- Remove sign/verify calls from all existing RSA backends.

2. pkcs1pad should use encrypt/decrypt API for its low level purposes
(instead of sign/verify API, which now would be not implemented by them),
and provide sign (same as before) and new verify (returning only status).

Thus, we avoid verify_rsa call altogether while remaining its
functionality, and skipping conversion step.

> 1) Implement new top-level verify, alongside existing verify_rsa.
> 2) For existing drivers implement a wrapper over verify_rsa.
> 3) Convert *all* existing users to the new verify API.
> 4) Remove top-level verify_rsa API.
> 5) Convert existing drivers over to verify API.
> 6) Remove verify_rsa completely.
> 
> > +int crypto_akcipher_verify(struct akcipher_request *req,
> > +			   const unsigned char *digest, unsigned int digest_len)
> 
> We should not add new fields outside of akcipher_request.  So
> these fields need to go inside it.  However, I think we don't
> actually need two new fields.  They could both go into the src
> scatterlist.  All we need is a new field, say textlen to indicate
> where the text stops and where the hash starts.  We could also
> overlay textlen over dstlen as it would now be unused for verify.

Well, if we allowed to reuse dst* fields why not just put digest over
dst scatterlist? That would be much simpler.

Thanks,


> The advantage of having it in one scatterlist is that for those
> users that already have the two pieces together could simply provide
> a single SG element (I don't know how likely that is in practice
> though).
> 
> For others you would simply tack on an extra SG element.
> 
> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
