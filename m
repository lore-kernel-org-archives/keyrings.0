From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 20 Jul 2018 05:55:07 +0000
Subject: Re: [PATCH 2/2] crypto: ECDH - fix typo of P-192 b value
Message-Id: <20180720055506.l3lklp5ledu2kk7r@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <31905154.JqEMqoRUPu@positron.chronox.de>
In-Reply-To: <31905154.JqEMqoRUPu@positron.chronox.de>
To: keyrings@vger.kernel.org

On Wed, Jul 11, 2018 at 08:36:23PM +0200, Stephan M=FCller wrote:
> Fix the b value to be compliant with FIPS 186-4 D.1.2.1. This fix is
> required to make sure the SP800-56A public key test passes for P-192.
>=20
> Signed-off-by: Stephan Mueller <smueller@chronox.de>

Patch applied.  Thanks.
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
