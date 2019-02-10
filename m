From: Vitaly Chikunov <vt@altlinux.org>
Date: Sun, 10 Feb 2019 18:46:28 +0000
Subject: Re: [RFC PATCH 1/4] X.509: Parse public key parameters from x509 for akcipher
Message-Id: <20190210184628.yupsxgjlaicwbxg6@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190106133608.820-1-vt@altlinux.org>
 <20190106133608.820-2-vt@altlinux.org>
 <20190209214240.56gq7ivn3pw3bssf@altlinux.org>
In-Reply-To: <20190209214240.56gq7ivn3pw3bssf@altlinux.org>
To: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Feb 10, 2019 at 12:42:40AM +0300, Vitaly Chikunov wrote:
> On Sun, Jan 06, 2019 at 04:36:05PM +0300, Vitaly Chikunov wrote:
> > Some public key algorithms (like ECDSA) keep in parameters field
> > important data such as digest and curve OIDs (possibly more for
> > different ECDSA variants). Thus, just setting a public key (as
> > for RSA) is not enough.
> > 
> > Introduce set_params() callback for akcipher which will be used to
> > pass DER encoded parameters array, with additional argument of
> > algorithm OID.
> > 
> > This is done with the intent of adding support for EC-RDSA (ISO/IEC
> > 14888-3:2018, RFC 7091, and basically ECDSA variant) public keys (which
> > will be finally used in IMA subsystem). Thus, also oid_registry.h is
> > updated.
> > 
> > Rationale:
> > 
> > - For such keys just setting public key without parameters is
> >   meaningless, so it would be possible to add parameters in
> >   crypto_akcipher_set_pub_key (and .set_pub_key) calls. But, this will
> >   needlessly change API for RSA akcipher. Also, additional callback
> >   making it possible to pass parameters after
> >   crypto_akcipher_set_priv_key (and .set_priv_key) in the future.
> >
> > - Algorithm OID is passed to be validated in .set_params callback,
> >   otherwise, it could have the wrong value.
> > 
> > - Particular algorithm OIDs are checked in x509_note_params, (because
> >   this is called from AlgorithmIdentifier (ASN.1) parser, which is
> >   called multiple times, as it's used multiple times in X.509
> >   certificate), to distinguish a public key call from a signature call.
> > 
> > Signed-off-by: Vitaly Chikunov <vt@altlinux.org>
> > ---
> 
> > @@ -263,6 +274,11 @@ int public_key_verify_signature(const struct public_key *pkey,
> >        if (pkey->key_is_private)
> >                ret = crypto_akcipher_set_priv_key(tfm,
> >                                                   pkey->key, pkey->keylen);
> >        else
> >                ret = crypto_akcipher_set_pub_key(tfm,
> >                                                  pkey->key, pkey->keylen);
> >        if (ret)
> >                goto error_free_req;
> > +	ret = crypto_akcipher_set_params(tfm, pkey->algo, pkey->params,
> > +					 pkey->paramlen);
> 
> Nobody said anything if this is a good idea to call set_params after
> set_{pub,priv}_key and not before.
> 
> When `struct crypto_akcipher' is allocated ctx data is never zeroed,
> thus either call will be the first to zero ctx, making these calls not
> swappable in the future.
> 
> Also, algorithm parameters could be interpreted without knowing the key,
> but the key cannot be interpreted without knowing the parameters.

From the other point of view, set_params may never be called or
implemented. So, making it called first and move memory zeroing
into set_params may create more complications than simplicity.

Making both callbacks callable in any order also will not make
things simpler. (Need to be prepared to be called in different
order.)

Maybe it's better to make memzero in akcipher_request_alloc() and allow
optional call to crypto_akcipher_set_params() strictly before
crypto_akcipher_set_{pub,priv}_key(), so, set_{pub,priv}_key will
already know everything to set the key properly. set_params may not be
implemented if akcipher does not need it (as with RSA).

> 
> > +	if (ret)
> > +		goto error_free_req;
> > +
> >  	ret = -ENOMEM;
> >  	outlen = crypto_akcipher_maxsize(tfm);
> >  	output = kmalloc(outlen, GFP_KERNEL);
