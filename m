From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Sat, 12 Jan 2019 09:55:35 +0000
Subject: Re: [PATCH 4/6] crypto: hkdf - RFC5869 Key Derivation Function
Message-Id: <20190112095535.36rh3ptnrf7yxacv@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190103143227.9138-1-jlee@suse.com>
 <20190109082103.GA8586@sol.localdomain>
 <9733066.Vrs4h5eWcW@positron.chronox.de>
 <2423373.Zd5ThvQH5g@positron.chronox.de>
 <20190112051252.GA639@sol.localdomain>
In-Reply-To: <20190112051252.GA639@sol.localdomain>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>, James Bottomley <James.Bottomley@hansenpartnership.com>, Andy Lutomirski <luto@amacapital.net>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>, linux-crypto@vger.kernel.org

On Fri, Jan 11, 2019 at 09:12:54PM -0800, Eric Biggers wrote:
> Hi Stephan,
>=20
> On Fri, Jan 11, 2019 at 08:10:39PM +0100, Stephan M=FCller wrote:
> > The RFC5869 compliant Key Derivation Function is implemented as a
> > random number generator considering that it behaves like a deterministic
> > RNG.
> >=20
>=20
> Thanks for the proof of concept!  I guess it ended up okay.  But can you =
explain
> more the benefits of using the crypto_rng interface, as opposed to just s=
ome
> crypto_hkdf_*() helper functions that are exported for modules to use?

I agree.  I see no benefit in adding this through the RNG API as
opposed to just providing it as a helper.  If some form of hardware
acceleration were to eventuate in the future we could always revisit
this.

Cheers,
--=20
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
