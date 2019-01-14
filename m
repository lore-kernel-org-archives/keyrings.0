From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 14 Jan 2019 17:44:16 +0000
Subject: Re: [PATCH 5/6] crypto: hkdf - add known answer tests
Message-Id: <20190114174415.GA7644@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190103143227.9138-1-jlee@suse.com>
 <9857029.1Sm7LFDBlJ@positron.chronox.de>
 <20190112051914.GB639@sol.localdomain>
 <2750733.sbdFDJOICv@positron.chronox.de>
In-Reply-To: <2750733.sbdFDJOICv@positron.chronox.de>
To: Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, James Bottomley <James.Bottomley@hansenpartnership.com>, Andy Lutomirski <luto@amacapital.net>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>, linux-crypto@vger.kernel.org

On Mon, Jan 14, 2019 at 10:25:16AM +0100, Stephan M=FCller wrote:
> Am Samstag, 12. Januar 2019, 06:19:15 CET schrieb Eric Biggers:
>=20
> Hi Eric,
>=20
> [...]
> >=20
> > > +			}
> > > +		}
> > > +	}, {
> > > +		.alg =3D "hkdf(hmac(sha224))",
> > > +		.test =3D alg_test_null,
> > > +		.fips_allowed =3D 1,
> >=20
> > I think it is dumb to add algorithms to the testmgr with no tests just =
so
> > the 'fips_allowed' flag can be set.=20
>=20
> Currently it is the only way. But I agree that it could be done better.
>=20
> > And doesn't FIPS sometimes require
> > tests anyway?  I don't think the "null test" should count as a test :-)
>=20
> Yes, it DOES count as a test (as strange as it may sound)! :-)
>=20
> The FIPS requirements are as follows:
>=20
> - raw ciphers must be subject to a FIPS test with one block chaining mode=
 to=20
> cover that cipher with all block chaining modes (e.g. you can test ecb(ae=
s) to=20
> cover AES with *all* existing block chaining modes).
>=20
> - for compound crypto algorithm (like RSA with respect to hashes, KDF wit=
h=20
> respect to the keyed message digest, HMAC with respect to hashes), the=20
> wrapping crypto algorithm needs to be tested with *one* wrapped cipher at=
=20
> least (but also not more. E.g. if you have a self test for, say, all SHA-=
1 and=20
> SHA-2, you only need one HMAC SHA test or one KDF HMAC SHA test.
>=20
> - in some circumstances, it is even permissible to test wrapping crypto=20
> algorithms where the underlying algo is implicitly tested. E.g. if you ha=
ve a=20
> HMAC SHA-256 test, you do not need an individual SHA-256 test.
>=20
>=20
> >=20
> > Perhaps just include sha256 and sha512, and have tests for them?
>=20
> Do you happen to have an official SHA-512 HKDF test vector? RFC5869 only =
has=20
> SHA-1 and SHA-256 tests.
> >=20
>=20

No, I don't know of any official HKDF-SHA512 test vectors.

> [...]
> > >=20
> > > +/* Test vectors from RFC 5869 appendix A */
> > > +static struct kdf_testvec hkdf_hmac_sha256_tv_template[] =3D {
> >=20
> > const
> >=20
> > Likewise for all other kdf_testvecs.
>=20
> const does not work with __VECS :-(
>=20
> I leave it without const at the moment. I think the __VECS should be upda=
ted=20
> along with all test vectors.
>=20
> [...]

I don't see why.  kdf_testvec just needs to be made const everywhere.

- Eric
