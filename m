From: Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
Date: Wed, 07 Jun 2017 11:30:44 +0000
Subject: Re: [PATCH] security/keys: rewrite all of big_key crypto
Message-Id: <6959639.4HXaobxm8b@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20170606173900.29279-1-Jason@zx2c4.com> <4079216.Z1x2SUeU2i@tauon.chronox.de> <CAHmME9oNnWvqq6+yaeC3nyHZ4Pkiqp3e=GHCCR0BuuzGPw8q8w@mail.gmail.com>
In-Reply-To: <CAHmME9oNnWvqq6+yaeC3nyHZ4Pkiqp3e=GHCCR0BuuzGPw8q8w@mail.gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers3@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Kirill Marinushkin <k.marinushkin@gmail.com>, security@kernel.org, stable@vger.kernel.org

Am Mittwoch, 7. Juni 2017, 12:09:31 CEST schrieb Jason A. Donenfeld:

Hi Jason,

> On Wed, Jun 7, 2017 at 7:14 AM, Stephan M=FCller <smueller@chronox.de> wr=
ote:
> > including those who like FIPS and Co. The crypto/rng code
>=20
> I'm 99% certain it was this way because the developer who wrote it
> originally didn't know what he was doing. Also, no other code anywhere
> in the kernel instantiates that generator like hat. More generally,
> though, I refuse to FIPS.

The right way to instantiate the crypto API RNG is by crypto_get_default_rn=
g=20
and crypto_put_default_rng.

I can understand that you refuse FIPS. It would even be great if *nobody*=20
outside the crypto/testmgr.c needs to care about FIPS at all. That would im=
ply=20
that the get_random_bytes provdes access to a DRBG if somebody desires FIPS.

Thus, if the get_random_bytes would provide random numbers from a pluggable=
=20
DRNG allowing users to use a DRBG if desired (or ChaCha20 or another favori=
te=20
DRNG), the entire RNG API in the kernel crypto API could be removed entirel=
y=20
in favor of a get_random_bytes call everywhere.

Ciao
Stephan
