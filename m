From: Vitaly Chikunov <vt@altlinux.org>
Date: Thu, 28 Feb 2019 05:37:07 +0000
Subject: Re: [PATCH v5 04/10] crypto: akcipher - new verify API for public key algorithms
Message-Id: <20190228053707.xdod46ohnobtyt4g@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190224060828.2527-1-vt@altlinux.org>
 <20190224060828.2527-5-vt@altlinux.org>
 <1551310117.10911.108.camel@linux.ibm.com>
In-Reply-To: <1551310117.10911.108.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, David Howells <dhowells@redhat.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 06:28:37PM -0500, Mimi Zohar wrote:
>=20
> On Sun, 2019-02-24 at 09:08 +0300, Vitaly Chikunov wrote:
> > Previous akcipher .verify() just `decrypts' (using RSA encrypt which is
> > using public key) signature to uncover message hash, which was then
> > compared in upper level public_key_verify_signature() with the expected
> > hash value, which itself was never passed into verify().
> >=20
> > This approach was incompatible with EC-DSA family of algorithms,
> > because, to verify a signature EC-DSA algorithm also needs a hash value
> > as input; then it's used (together with a signature divided into halves
> > `r||s') to produce a witness value, which is then compared with `r' to
> > determine if the signature is correct. Thus, for EC-DSA, nor
> > requirements of .verify() itself, nor its output expectations in
> > public_key_verify_signature() wasn't sufficient.
> >=20
> > Make improved .verify() call which gets hash value as input and produce
> > complete signature check without any output besides status.
> >=20
> > Now for the top level verification only crypto_akcipher_verify() needs
> > to be called.
>=20
> All but this patch apply. =9AWhich branch is this patch based against?

This patchest is over 920d7f7215d87005beb4aa2b90b9cb0b74b36947 in
cryptodev/master.

>=20
> Mimi
