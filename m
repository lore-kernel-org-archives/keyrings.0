From: Eric Biggers <ebiggers@kernel.org>
Date: Sat, 12 Jan 2019 05:12:54 +0000
Subject: Re: [PATCH 4/6] crypto: hkdf - RFC5869 Key Derivation Function
Message-Id: <20190112051252.GA639@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-3"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190103143227.9138-1-jlee@suse.com>
 <20190109082103.GA8586@sol.localdomain>
 <9733066.Vrs4h5eWcW@positron.chronox.de>
 <2423373.Zd5ThvQH5g@positron.chronox.de>
In-Reply-To: <2423373.Zd5ThvQH5g@positron.chronox.de>
To: Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, James Bottomley <James.Bottomley@hansenpartnership.com>, Andy Lutomirski <luto@amacapital.net>, "Lee, Chun-Yi" <joeyli.kernel@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, keyrings@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Chen Yu <yu.c.chen@intel.com>, Oliver Neukum <oneukum@suse.com>, Ryan Chen <yu.chen.surf@gmail.com>, David Howells <dhowells@redhat.com>, Giovanni Gherdovich <ggherdovich@suse.cz>, Randy Dunlap <rdunlap@infradead.org>, Jann Horn <jannh@google.com>, Andy Lutomirski <luto@kernel.org>, linux-crypto@vger.kernel.org

Hi Stephan,

On Fri, Jan 11, 2019 at 08:10:39PM +0100, Stephan M=FCller wrote:
> The RFC5869 compliant Key Derivation Function is implemented as a
> random number generator considering that it behaves like a deterministic
> RNG.
>=20

Thanks for the proof of concept!  I guess it ended up okay.  But can you ex=
plain
more the benefits of using the crypto_rng interface, as opposed to just some
crypto_hkdf_*() helper functions that are exported for modules to use?

> The extract and expand phases use different instances of the underlying
> keyed message digest cipher to ensure that while the extraction phase
> generates a new key for the expansion phase, the cipher for the
> expansion phase can still be used. This approach is intended to aid
> multi-threaded uses cases.

I think you partially misunderstood what I was asking for.  One HMAC tfm is
sufficient as long as HKDF-Expand is separated from HKDF-Extract, which you=
've
done.  So just use one HMAC tfm, and in crypto_hkdf_seed() key it with the
'salt', and then afterwards with the 'prk'.

Also everywhere in this patchset, please avoid using the word "cipher" to r=
efer
to algorithms that are not encryption/decryption.  I know a lot of the cryp=
to
API docs do this, but I think it is a mistake and confusing.  Hash algorith=
ms
and KDFs are not "ciphers".

>=20
> Signed-off-by: Stephan Mueller <smueller@chronox.de>
> ---
>  crypto/Kconfig  |   6 +
>  crypto/Makefile |   1 +
>  crypto/hkdf.c   | 290 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 297 insertions(+)
>  create mode 100644 crypto/hkdf.c
>=20
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index cc80d89e0cf5..0eee5e129fa3 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -568,6 +568,12 @@ config CRYPTO_KDF
>  	  Support for KDF compliant to SP800-108. All three types of
>  	  KDF specified in SP800-108 are implemented.
> =20
> +config CRYPTO_HKDF
> +	tristate "HMAC-based Extract-and expand Key Derivation Function"
> +	select CRYPTO_RNG
> +	help
> +	  Support for KDF compliant to RFC5869.
> +

Make the description
"HMAC-based Extract-and-Expand Key Derivation Function (HKDF)"?
There is a missing dash, and probably the acronym "HKDF" should be in there.

>  config CRYPTO_XCBC
>  	tristate "XCBC support"
>  	select CRYPTO_HASH
> diff --git a/crypto/Makefile b/crypto/Makefile
> index 69a0bb64b0ac..6bbb0a4dea13 100644
> --- a/crypto/Makefile
> +++ b/crypto/Makefile
> @@ -59,6 +59,7 @@ crypto_user-$(CONFIG_CRYPTO_STATS) +=3D crypto_user_sta=
t.o
>  obj-$(CONFIG_CRYPTO_CMAC) +=3D cmac.o
>  obj-$(CONFIG_CRYPTO_HMAC) +=3D hmac.o
>  obj-$(CONFIG_CRYPTO_KDF) +=3D kdf.o
> +obj-$(CONFIG_CRYPTO_HKDF) +=3D hkdf.o
>  obj-$(CONFIG_CRYPTO_VMAC) +=3D vmac.o
>  obj-$(CONFIG_CRYPTO_XCBC) +=3D xcbc.o
>  obj-$(CONFIG_CRYPTO_NULL2) +=3D crypto_null.o
> diff --git a/crypto/hkdf.c b/crypto/hkdf.c
> new file mode 100644
> index 000000000000..35a975ed64a8
> --- /dev/null
> +++ b/crypto/hkdf.c
> @@ -0,0 +1,290 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * RFC 5869 Key-derivation function
> + *

People don't know what RFC xyz is.  Please be more explicit than just the R=
FC
number, e.g.

"HKDF: HMAC-based Extract-and-Expand Key Derivation Function (RFC 5869)"

> + * Copyright (C) 2019, Stephan Mueller <smueller@chronox.de>
> + */
> +
> +/*
> + * The HKDF extract phase is applied with crypto_rng_reset().
> + * The HKDF expand phase is applied with crypto_rng_generate().
> + *
> + * NOTE: In-place cipher operations are not supported.
> + */

What does an "in-place cipher operation" mean in this context?  That the 'i=
nfo'
buffer must not overlap the 'dst' buffer?  Maybe crypto_rng_generate() shou=
ld
check that for all crypto_rngs?  Or is it different for different crypto_rn=
gs?

> +
> +#include <linux/module.h>
> +#include <crypto/rng.h>
> +#include <crypto/internal/rng.h>
> +#include <crypto/hash.h>
> +#include <crypto/internal/hash.h>
> +#include <linux/rtnetlink.h>
> +
> +struct crypto_hkdf_ctx {
> +	struct crypto_shash *extract_kmd;
> +	struct crypto_shash *expand_kmd;
> +};
> +
> +#define CRYPTO_HKDF_MAX_DIGESTSIZE	64
> +
> +/*
> + * HKDF expand phase
> + */
> +static int crypto_hkdf_random(struct crypto_rng *rng,
> +			      const u8 *info, unsigned int infolen,
> +			      u8 *dst, unsigned int dlen)

Why call it crypto_hkdf_random() instead of crypto_hkdf_generate()?  The la=
tter
would match rng_alg::generate.

> +{
> +	struct crypto_hkdf_ctx *ctx =3D crypto_tfm_ctx(crypto_rng_tfm(rng));

const

> +	struct crypto_shash *expand_kmd =3D ctx->expand_kmd;
> +	SHASH_DESC_ON_STACK(desc, expand_kmd);

> +	unsigned int h =3D crypto_shash_digestsize(expand_kmd);

const

> +	int err =3D 0;
> +	u8 *dst_orig =3D dst;
> +	const u8 *prev =3D NULL;

> +	uint8_t ctr =3D 0x01;

u8 instead of uint8_t

> +
> +	if (dlen > h * 255)
> +		return -EINVAL;
> +
> +	desc->tfm =3D expand_kmd;

> +	desc->flags =3D crypto_shash_get_flags(expand_kmd) &
> +		      CRYPTO_TFM_REQ_MAY_SLEEP;

This line setting desc->flags doesn't make sense.  How is the user meant to
control whether crypto_rng_generate() can sleep or not?  Or can it always s=
leep?
Either way this part is wrong since the user can't get access to the HMAC t=
fm to
set this flag being checked for.

> +
> +	/* T(1) and following */
> +	while (dlen) {
> +		err =3D crypto_shash_init(desc);
> +		if (err)
> +			goto out;
> +
> +		if (prev) {
> +			err =3D crypto_shash_update(desc, prev, h);
> +			if (err)
> +				goto out;
> +		}
> +
> +		if (info) {
> +			err =3D crypto_shash_update(desc, info, infolen);
> +			if (err)
> +				goto out;
> +		}
> +
> +		if (dlen < h) {
> +			u8 tmpbuffer[CRYPTO_HKDF_MAX_DIGESTSIZE];
> +
> +			err =3D crypto_shash_finup(desc, &ctr, 1, tmpbuffer);
> +			if (err)
> +				goto out;
> +			memcpy(dst, tmpbuffer, dlen);
> +			memzero_explicit(tmpbuffer, h);
> +			goto out;
> +		} else {

No need for the 'else'.

> +			err =3D crypto_shash_finup(desc, &ctr, 1, dst);
> +			if (err)
> +				goto out;
> +
> +			prev =3D dst;
> +			dst +=3D h;
> +			dlen -=3D h;
> +			ctr++;
> +		}
> +	}
> +
> +out:
> +	if (err)
> +		memzero_explicit(dst_orig, dlen);
> +	shash_desc_zero(desc);
> +	return err;
> +}
> +
> +/*
> + * HKDF extract phase.
> + *
> + * The seed is defined to be a concatenation of the salt and the IKM.
> + * The data buffer is pre-pended by an rtattr which provides an u32 value
> + * with the length of the salt. Thus, the buffer length - salt length is=
 the
> + * IKM length.
> + */
> +static int crypto_hkdf_seed(struct crypto_rng *rng,
> +			    const u8 *seed, unsigned int slen)
> +{
> +	struct crypto_hkdf_ctx *ctx =3D crypto_tfm_ctx(crypto_rng_tfm(rng));

const

> +	struct crypto_shash *extract_kmd =3D ctx->extract_kmd;
> +	struct crypto_shash *expand_kmd =3D ctx->expand_kmd;
> +	struct rtattr *rta =3D (struct rtattr *)seed;
> +	SHASH_DESC_ON_STACK(desc, extract_kmd);
> +	u32 saltlen;
> +	unsigned int h =3D crypto_shash_digestsize(extract_kmd);
> +	int err;
> +	const uint8_t null_salt[CRYPTO_HKDF_MAX_DIGESTSIZE] =3D { 0 };

static const

> +	u8 prk[CRYPTO_HKDF_MAX_DIGESTSIZE] =3D { 0 };

No need to initialize this.

> +
> +	/* Require aligned buffer to directly read out saltlen below */
> +	if (WARN_ON((unsigned long)seed & (sizeof(saltlen) - 1)))
> +		return -EINVAL;
> +
> +	if (!RTA_OK(rta, slen))
> +		return -EINVAL;
> +	if (rta->rta_type !=3D 1)
> +		return -EINVAL;
> +	if (RTA_PAYLOAD(rta) < sizeof(saltlen))
> +		return -EINVAL;
> +	saltlen =3D *((u32 *)RTA_DATA(rta));

I'm guessing you copied the weird "length as a rtattr payload" approach fro=
m the
authenc template.  I think it's not necessary.  And it's overly error-prone=
, as
shown by the authenc template getting the parsing wrong for years and you m=
aking
the exact same mistake again here...
(See https://patchwork.kernel.org/patch/10732803/)  How about just using a =
u32
at the beginning without the 'rtattr' preceding it?

Also it should use get_unaligned() so there is no alignment requirement the
caller has to comply with.

> +
> +	seed +=3D RTA_ALIGN(rta->rta_len);
> +	slen -=3D RTA_ALIGN(rta->rta_len);
> +
> +	if (slen < saltlen)
> +		return -EINVAL;
> +

> +	desc->tfm =3D extract_kmd;

desc->flags needs to be set.

> +
> +	/* Set the salt as HMAC key */
> +	if (saltlen)
> +		err =3D crypto_shash_setkey(extract_kmd, seed, saltlen);
> +	else
> +		err =3D crypto_shash_setkey(extract_kmd, null_salt, h);
> +	if (err)
> +		return err;
> +
> +	/* Extract the PRK */
> +	err =3D crypto_shash_digest(desc, seed + saltlen, slen - saltlen, prk);
> +	if (err)
> +		goto err;
> +
> +	/* Set the PRK for the expand phase */
> +	err =3D crypto_shash_setkey(expand_kmd, prk, h);
> +	if (err)
> +		goto err;
> +
> +err:
> +	shash_desc_zero(desc);
> +	memzero_explicit(prk, h);
> +	return err;
> +}
> +
> +static int crypto_hkdf_init_tfm(struct crypto_tfm *tfm)
> +{
> +	struct crypto_instance *inst =3D crypto_tfm_alg_instance(tfm);
> +	struct crypto_shash_spawn *spawn =3D crypto_instance_ctx(inst);
> +	struct crypto_hkdf_ctx *ctx =3D crypto_tfm_ctx(tfm);
> +	struct crypto_shash *extract_kmd =3D NULL, *expand_kmd =3D NULL;
> +	unsigned int ds;
> +
> +	extract_kmd =3D crypto_spawn_shash(spawn);
> +	if (IS_ERR(extract_kmd))
> +		return PTR_ERR(extract_kmd);
> +
> +	expand_kmd =3D crypto_spawn_shash(spawn);
> +	if (IS_ERR(expand_kmd)) {
> +		crypto_free_shash(extract_kmd);
> +		return PTR_ERR(expand_kmd);
> +	}
> +
> +	ds =3D crypto_shash_digestsize(extract_kmd);
> +	/* Hashes with no digest size are not allowed for KDFs. */
> +	if (!ds || ds > CRYPTO_HKDF_MAX_DIGESTSIZE) {
> +		crypto_free_shash(extract_kmd);
> +		crypto_free_shash(expand_kmd);
> +		return -EOPNOTSUPP;
> +	}

The digest size should be validated when instantiating the template, not he=
re.

> +
> +	ctx->extract_kmd =3D extract_kmd;
> +	ctx->expand_kmd =3D expand_kmd;
> +
> +	return 0;
> +}
> +
> +static void crypto_hkdf_exit_tfm(struct crypto_tfm *tfm)
> +{
> +	struct crypto_hkdf_ctx *ctx =3D crypto_tfm_ctx(tfm);
> +
> +	crypto_free_shash(ctx->extract_kmd);
> +	crypto_free_shash(ctx->expand_kmd);
> +}
> +
> +static void crypto_kdf_free(struct rng_instance *inst)
> +{
> +	crypto_drop_spawn(rng_instance_ctx(inst));
> +	kfree(inst);
> +}
> +
> +static int crypto_hkdf_create(struct crypto_template *tmpl, struct rtatt=
r **tb)
> +{
> +	struct rng_instance *inst;
> +	struct crypto_alg *alg;
> +	struct shash_alg *salg;
> +	int err;
> +	unsigned int ds, ss;
> +
> +	err =3D crypto_check_attr_type(tb, CRYPTO_ALG_TYPE_RNG);
> +	if (err)
> +		return err;
> +
> +	salg =3D shash_attr_alg(tb[1], 0, 0);
> +	if (IS_ERR(salg))
> +		return PTR_ERR(salg);
> +
> +	ds =3D salg->digestsize;
> +	ss =3D salg->statesize;

I don't see what the 'statesize' is needed for.

> +	alg =3D &salg->base;

Check here that the underlying algorithm really is "hmac(" something?

Alternatively it may be a good idea to simplify usage by making the template
just take the unkeyed hash directly, like "hkdf(sha512)".  And if any users
really need to specify a specific HMAC implementation then another template
usable as "hkdf_base(hmac(sha512))" could be added later.

> +
> +	inst =3D rng_alloc_instance("hkdf", alg);
> +	err =3D PTR_ERR(inst);
> +	if (IS_ERR(inst))
> +		goto out_put_alg;
> +
> +	err =3D crypto_init_shash_spawn(rng_instance_ctx(inst), salg,
> +				      rng_crypto_instance(inst));
> +	if (err)
> +		goto out_free_inst;

This error path calls crypto_drop_spawn() without a prior successful
crypto_init_spawn().

> +
> +	inst->alg.base.cra_priority	=3D alg->cra_priority;
> +	inst->alg.base.cra_blocksize	=3D alg->cra_blocksize;
> +	inst->alg.base.cra_alignmask	=3D alg->cra_alignmask;
> +
> +	inst->alg.generate		=3D crypto_hkdf_random;
> +	inst->alg.seed			=3D crypto_hkdf_seed;
> +	inst->alg.seedsize		=3D ds;

What does the seedsize mean here, given that crypto_hkdf_seed() actually ta=
kes a
variable length seed?

> +
> +	inst->alg.base.cra_init		=3D crypto_hkdf_init_tfm;
> +	inst->alg.base.cra_exit		=3D crypto_hkdf_exit_tfm;

> +	inst->alg.base.cra_ctxsize	=3D ALIGN(sizeof(struct crypto_hkdf_ctx) +
> +					  ss * 2, crypto_tfm_ctx_alignment());

Why isn't this simply sizeof(struct crypto_hkdf_ctx)?

> +
> +	inst->free			=3D crypto_kdf_free;
> +
> +	err =3D rng_register_instance(tmpl, inst);
> +
> +	if (err) {
> +out_free_inst:
> +		crypto_kdf_free(inst);
> +	}
> +
> +out_put_alg:
> +	crypto_mod_put(alg);
> +	return err;
> +}
> +
> +static struct crypto_template crypto_hkdf_tmpl =3D {
> +	.name =3D "hkdf",
> +	.create =3D crypto_hkdf_create,
> +	.module =3D THIS_MODULE,
> +};
> +
> +static int __init crypto_hkdf_init(void)
> +{
> +	return crypto_register_template(&crypto_hkdf_tmpl);
> +}
> +
> +static void __exit crypto_hkdf_exit(void)
> +{
> +	crypto_unregister_template(&crypto_hkdf_tmpl);
> +}
> +
> +module_init(crypto_hkdf_init);
> +module_exit(crypto_hkdf_exit);
> +
> +MODULE_LICENSE("GPL");

MODULE_LICENSE("GPL") means GPLv2+ but the SPDX header says GPLv2 only.

> +MODULE_AUTHOR("Stephan Mueller <smueller@chronox.de>");
> +MODULE_DESCRIPTION("Key Derivation Function according to RFC 5869");

Mention "HKDF" in the module description?

> +MODULE_ALIAS_CRYPTO("hkdf");
> --=20
> 2.20.1

Thanks!

- Eric
