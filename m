From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 13 Dec 2018 10:14:01 +0000
Subject: Re: [RFC PATCH] X.509: Parse public key parameters from x509 for akcipher
Message-Id: <20181213101401.zsmpkz6okgkjmbw3@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
In-Reply-To: <20181209135548.26232-1-vt@altlinux.org>
References: <20181209135548.26232-1-vt@altlinux.org>
In-Reply-To: <20181209135548.26232-1-vt@altlinux.org>
To: Vitaly Chikunov <vt@altlinux.org>
Cc: dhowells@redhat.com, davem@davemloft.net, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Vitaly Chikunov <vt@altlinux.org> wrote:
> Some public key algorithms (like ECDSA) keep in parameters field
> important data such as digest and curve OIDs (possibly more for
> different ECDSA variants). Thus, just setting a public key (as
> for RSA) is not enough.
> 
> Introduce set_params() callback for akcipher which will be used to
> pass BER encoded parameters array, with additional argument of
> algorithm OID.
> 
> This is done with the intent of adding support for EC-RDSA (ISO/IEC
> 14888-3:2018, RFC 7091, and basically ECDSA variant) public keys (which
> will be finally used in IMA subsystem). Thus, also oid_registry.h is
> updated.
> 
> Rationale:
> 
> - For such keys just setting public key without parameters is
>  meaningless, so it would be possible to add parameters in
>  crypto_akcipher_set_pub_key (and .set_pub_key) calls. But, this will
>  needlessly change API for RSA akcipher. Also, additional callback
>  making it possible to pass parameters after
>  crypto_akcipher_set_priv_key (and .set_priv_key) in the future.
> 
> - Algorithm OID is passed to be validated in .set_params callback,
>  otherwise, it could have the wrong value.
> 
> - Particular algorithm OIDs are checked in x509_note_params, (because
>  this is called from AlgorithmIdentifier (ASN.1) parser, which is
>  called multiple times, as it's used multiple times in X.509
>  certificate), to distinguish a public key call from a signature call.
> 
> Signed-off-by: Vitaly Chikunov <vt@altlinux.org>

Please post this with a patch that actually uses the set_params
callback.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
