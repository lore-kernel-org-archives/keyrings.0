From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Sun, 06 Oct 2019 23:52:38 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <20191006235238.GA16641@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <1570140491.5046.33.camel@linux.ibm.com>
 <1570147177.10818.11.camel@HansenPartnership.com>
 <20191004182216.GB6945@linux.intel.com>
 <1570213491.3563.27.camel@HansenPartnership.com>
 <20191004183342.y63qdvspojyf3m55@cantor>
 <1570214574.3563.32.camel@HansenPartnership.com>
 <20191004200728.xoj6jlgbhv57gepc@cantor>
 <20191004201134.nuesk6hxtxajnxh2@cantor>
 <1570227068.17537.4.camel@HansenPartnership.com>
 <1570322333.5046.145.camel@linux.ibm.com>
In-Reply-To: <1570322333.5046.145.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Jerry Snitselaar <jsnitsel@redhat.com>, David Safford <david.safford@ge.com>, linux-integrity@vger.kernel.org, stable@vger.kernel.org, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Sat, Oct 05, 2019 at 08:38:53PM -0400, Mimi Zohar wrote:
> On Fri, 2019-10-04 at 15:11 -0700, James Bottomley wrote:
>=20
> > +
> > +/**
> > + * tpm_get_random() - get random bytes influenced by the TPM's RNG
> > + * @chip:	a &struct tpm_chip instance, %NULL for the default chip
> > + * @out:	destination buffer for the random bytes
> > + * @max:	the max number of bytes to write to @out
> > + *
> > + * Uses the TPM as a source of input to the kernel random number
> > + * generator and then takes @max bytes directly from the kernel.  In
> > + * the worst (no other entropy) case, this will return the pure TPM
> > + * random number, but if the kernel RNG has any entropy at all it will
> > + * return a mixed entropy output which doesn't rely on a single
> > + * source.
> > + *
> > + * Return: number of random bytes read or a negative error value.
> > + */
> > +int tpm_get_random(struct tpm_chip *chip, u8 *out, size_t max)
> > +{
> > +	int rc;
> > +
> > +	rc =3D __tpm_get_random(chip, out, max);
> > +	if (rc <=3D 0)
> > +		return rc;
> > +	/*
> > +	 * assume the TPM produces pure randomness, so the amount of
> > +	 * entropy is the number of bits returned
> > +	 */
> > +	add_hwgenerator_randomness(out, rc, rc * 8);
> > +	get_random_bytes(out, rc);
>=20
> Using the TPM as a source of input to the kernel random number
> generator is fine, but please don't change the meaning of trusted
> keys. =A0The trusted-encrypted keys documentation clearly states
> "Trusted Keys use a TPM both to generate and to seal the keys."
>=20
> If you really want to use a different random number source instead of
> the TPM, then define a new trusted key option (eg. rng=3Dkernel), with
> the default being the TPM.

I'll add a patch that updates the documentation because it is clearly
not a good practice to use TPM to generate keys that are not keys
residing inside the TPM.

With TEE coming in, TPM is not the only hardware measure anymore sealing
the keys and we don't want a mess where every hardware asset does their
own proprietary key generation. The proprietary technology should only
take care of the sealing part.

/Jarkko
