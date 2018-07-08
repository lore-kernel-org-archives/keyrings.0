From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sun, 08 Jul 2018 16:44:14 +0000
Subject: Re: [PATCH v2] crypto: DH - add public key verification test
Message-Id: <20180708164414.jrj3k7jvkq2jnrst@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <2573864.V43BhLOfag@positron.chronox.de>
In-Reply-To: <2573864.V43BhLOfag@positron.chronox.de>
To: keyrings@vger.kernel.org

On Wed, Jun 27, 2018 at 08:15:31AM +0200, Stephan M=FCller wrote:
> Hi,
>=20
> Changes v2:
> * addition of a check that mpi_alloc succeeds.
>=20
> ---8<---
>=20
> According to SP800-56A section 5.6.2.1, the public key to be processed
> for the DH operation shall be checked for appropriateness. The check
> shall covers the full verification test in case the domain parameter Q
> is provided as defined in SP800-56A section 5.6.2.3.1. If Q is not
> provided, the partial check according to SP800-56A section 5.6.2.3.2 is
> performed.
>=20
> The full verification test requires the presence of the domain parameter
> Q. Thus, the patch adds the support to handle Q. It is permissible to
> not provide the Q value as part of the domain parameters. This implies
> that the interface is still backwards-compatible where so far only P and
> G are to be provided. However, if Q is provided, it is imported.
>=20
> Without the test, the NIST ACVP testing fails. After adding this check,
> the NIST ACVP testing passes. Testing without providing the Q domain
> parameter has been performed to verify the interface has not changed.
>=20
> Signed-off-by: Stephan Mueller <smueller@chronox.de>
> ---
>  crypto/dh.c         | 66 ++++++++++++++++++++++++++++++++++++++++++---
>  crypto/dh_helper.c  | 15 ++++++++---
>  include/crypto/dh.h |  4 +++
>  3 files changed, 79 insertions(+), 6 deletions(-)

Patch applied.  Thanks.
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
