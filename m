From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 14 Jan 2019 17:53:16 +0000
Subject: Re: [PATCH 4/6] crypto: hkdf - RFC5869 Key Derivation Function
Message-Id: <20190114175315.GB7644@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190103143227.9138-1-jlee@suse.com>
 <2423373.Zd5ThvQH5g@positron.chronox.de>
 <20190112051252.GA639@sol.localdomain>
 <4734428.Gj5BGI4uxL@positron.chronox.de>
In-Reply-To: <4734428.Gj5BGI4uxL@positron.chronox.de>
To: Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, James Bottomley <James.Bottomley@hansenpartnership.com>, Andy Lutomirski <luto@amacapital.net>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>, linux-crypto@vger.kernel.org

On Mon, Jan 14, 2019 at 10:30:39AM +0100, Stephan M=FCller wrote:
> Am Samstag, 12. Januar 2019, 06:12:54 CET schrieb Eric Biggers:
>=20
> Hi Eric,
>=20
> [...]
>=20
> > > The extract and expand phases use different instances of the underlyi=
ng
> > > keyed message digest cipher to ensure that while the extraction phase
> > > generates a new key for the expansion phase, the cipher for the
> > > expansion phase can still be used. This approach is intended to aid
> > > multi-threaded uses cases.
> >=20
> > I think you partially misunderstood what I was asking for.  One HMAC tf=
m is
> > sufficient as long as HKDF-Expand is separated from HKDF-Extract, which
> > you've done.  So just use one HMAC tfm, and in crypto_hkdf_seed() key it
> > with the 'salt', and then afterwards with the 'prk'.
>=20
> Ok, thanks for the clarification. I will remove the 2nd HMAC TFM then.
> >=20
> > Also everywhere in this patchset, please avoid using the word "cipher" =
to
> > refer to algorithms that are not encryption/decryption.  I know a lot of
> > the crypto API docs do this, but I think it is a mistake and confusing.=
=20
> > Hash algorithms and KDFs are not "ciphers".
>=20
> As you wish, I will refer to specific name of the cryptographic operation.
>=20
> [...]
>=20
> > > + * NOTE: In-place cipher operations are not supported.
> > > + */
> >=20
> > What does an "in-place cipher operation" mean in this context?  That the
> > 'info' buffer must not overlap the 'dst' buffer?=20
>=20
> Correct, no overlapping.
>=20
> > Maybe
> > crypto_rng_generate() should check that for all crypto_rngs?  Or is it
> > different for different crypto_rngs?
>=20
> This is the case in general for all KDFs (and even RNGs). It is no techni=
cal=20
> or cryptographic error to have overlapping buffers. The only issue is tha=
t the=20
> result will not match the expected value.
>=20
> The issue is that the input buffer to the generate function is an input t=
o=20
> every round of the KDF. If the input and output buffer overlap, starting =
with=20
> the 2nd iteration of the KDF, the input is the output of the 1st round. A=
gain,=20
> I do not think it is a cryptographic error though.
>=20
> (To support my conclusion: A colleague of mine has proposed an update to =
the=20
> HKDF specification where the input data changes for each KDF round. This =

> proposal was considered appropriate by one of the authors of HKDF.)
>=20
> If the requested output is smaller or equal to the output block size of t=
he=20
> KDF, overlapping buffers are even harmless since the implementation will =

> calculate the correct output.
>=20
> Due to that, I removed the statement. But I am not sure we should add a=20
> technical block to deny overlapping input/output buffers.
>=20
> [...]
> > >=20
> > > +	desc->flags =3D crypto_shash_get_flags(expand_kmd) &
> > > +		      CRYPTO_TFM_REQ_MAY_SLEEP;
> >=20
> > This line setting desc->flags doesn't make sense.  How is the user mean=
t to
> > control whether crypto_rng_generate() can sleep or not?  Or can it alwa=
ys
> > sleep? Either way this part is wrong since the user can't get access to=
 the
> > HMAC tfm to set this flag being checked for.
>=20
> Could you please help me why a user should set this flag? Isn't the=20
> implementation specifying that flag to allow identifying whether the=20
> implementation could or could not sleep? Thus, we simply copy the sleepin=
g=20
> flag from the lower level keyed message digest implementation.
>=20
> At least that is also the implementation found in crypto/hmac.c.
>=20
> [...]

Whether the crypto_shash* stuff can sleep is controlled on a per-request ba=
sis,
not a per-implementation basis.  So I don't understand what you are talking
about here.

>=20
> > > +		if (dlen < h) {
> > > +			u8 tmpbuffer[CRYPTO_HKDF_MAX_DIGESTSIZE];
> > > +
> > > +			err =3D crypto_shash_finup(desc, &ctr, 1, tmpbuffer);
> > > +			if (err)
> > > +				goto out;
> > > +			memcpy(dst, tmpbuffer, dlen);
> > > +			memzero_explicit(tmpbuffer, h);
> > > +			goto out;
> > > +		} else {
> >=20
> > No need for the 'else'.
>=20
> Could you please help me why that else branch is not needed? If the buffe=
r to=20
> be generated is equal or larger than the output block length of the keyed=
=20
> message digest, I would like to directly operate on the output buffer to =
avoid=20
> a memcpy.

I'm simply saying you don't need the 'else' keyword as the previous block e=
nds
with a goto.

> >=20
> > > +			err =3D crypto_shash_finup(desc, &ctr, 1, dst);
> > > +			if (err)
> > > +				goto out;
> > > +
> > > +			prev =3D dst;
> > > +			dst +=3D h;
> > > +			dlen -=3D h;
> > > +			ctr++;
> > > +		}
> > > +	}
>=20
> [...]
> >=20
> > > +	struct crypto_shash *extract_kmd =3D ctx->extract_kmd;
> > > +	struct crypto_shash *expand_kmd =3D ctx->expand_kmd;
> > > +	struct rtattr *rta =3D (struct rtattr *)seed;
> > > +	SHASH_DESC_ON_STACK(desc, extract_kmd);
> > > +	u32 saltlen;
> > > +	unsigned int h =3D crypto_shash_digestsize(extract_kmd);
> > > +	int err;
> > > +	const uint8_t null_salt[CRYPTO_HKDF_MAX_DIGESTSIZE] =3D { 0 };
> >=20
> > static const
> >=20
>=20
> Why would I want to turn that buffer into a static variable? All we need =
it=20
> for is in case there is no salt provided.
>=20
> [...]
>=20
> > > +
> > > +	if (!RTA_OK(rta, slen))
> > > +		return -EINVAL;
> > > +	if (rta->rta_type !=3D 1)
> > > +		return -EINVAL;
> > > +	if (RTA_PAYLOAD(rta) < sizeof(saltlen))
> > > +		return -EINVAL;
> > > +	saltlen =3D *((u32 *)RTA_DATA(rta));
> >=20
> > I'm guessing you copied the weird "length as a rtattr payload" approach=
 from
> > the authenc template.  I think it's not necessary.  And it's overly
> > error-prone, as shown by the authenc template getting the parsing wrong=
 for
> > years and you making the exact same mistake again here...
> > (See https://patchwork.kernel.org/patch/10732803/)  How about just usin=
g a
> > u32 at the beginning without the 'rtattr' preceding it?
>=20
> I was not sure whether this approach would be acceptable. I very much wou=
ld=20
> love to have a u32 pre-pended only without the RTA business.
>=20
> I updated the implementation accordingly.
> >=20
> [...]
>=20
> >=20
> > > +	alg =3D &salg->base;
> >=20
> > Check here that the underlying algorithm really is "hmac(" something?
>=20
> I added a check for the presence of salg->setkey.
> >=20
> > Alternatively it may be a good idea to simplify usage by making the tem=
plate
> > just take the unkeyed hash directly, like "hkdf(sha512)".  And if any u=
sers
> > really need to specify a specific HMAC implementation then another temp=
late
> > usable as "hkdf_base(hmac(sha512))" could be added later.
> >=20
>=20
> I would not suggest this, because that rounds contrary to the concept of =
the=20
> kernel crypto API IMHO. The caller has to provide the wrapping cipher. It=
 is=20
> perfectly viable to allow a caller to invoke a specific keyed message dig=
est.
>=20

Sure, but it would not conform to the HKDF specification.  Are you sure it =
is
okay to specify an arbitrary keyed hash?

> [...]
>=20
> Thank you very much for your code review.
>=20
> Ciao
> Stephan
>=20
>=20

- Eric
