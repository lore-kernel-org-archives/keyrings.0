From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Wed, 07 Jun 2017 10:09:31 +0000
Subject: Re: [PATCH] security/keys: rewrite all of big_key crypto
Message-Id: <CAHmME9oNnWvqq6+yaeC3nyHZ4Pkiqp3e=GHCCR0BuuzGPw8q8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20170606173900.29279-1-Jason@zx2c4.com> <4079216.Z1x2SUeU2i@tauon.chronox.de>
In-Reply-To: <4079216.Z1x2SUeU2i@tauon.chronox.de>
To: =?UTF-8?Q?Stephan_M=C3=BCller?= <smueller@chronox.de>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers3@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Kirill Marinushkin <k.marinushkin@gmail.com>, security@kernel.org, stable@vger.kernel.org

On Wed, Jun 7, 2017 at 7:14 AM, Stephan M=C3=BCller <smueller@chronox.de> w=
rote:
> including those who like FIPS and Co. The crypto/rng code

I'm 99% certain it was this way because the developer who wrote it
originally didn't know what he was doing. Also, no other code anywhere
in the kernel instantiates that generator like hat. More generally,
though, I refuse to FIPS.
