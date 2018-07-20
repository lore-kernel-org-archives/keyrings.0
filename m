From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 20 Jul 2018 05:54:54 +0000
Subject: Re: [PATCH 1/2] crypto: DH - update test for public key verification
Message-Id: <20180720055454.uhk2xs4tioluth2d@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <3498555.DuuoTkek00@positron.chronox.de>
In-Reply-To: <3498555.DuuoTkek00@positron.chronox.de>
To: keyrings@vger.kernel.org

On Wed, Jul 11, 2018 at 08:35:49PM +0200, Stephan M=FCller wrote:
> By adding a zero byte-length for the DH parameter Q value, the public
> key verification test is disabled for the given test.
>=20
> Reported-by: Eric Biggers <ebiggers3@gmail.com>
> Signed-off-by: Stephan Mueller <smueller@chronox.de>

Patch applied.  Thanks.
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
