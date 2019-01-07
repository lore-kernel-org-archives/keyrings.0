From: Vitaly Chikunov <vt@altlinux.org>
Date: Mon, 07 Jan 2019 08:07:10 +0000
Subject: Re: [RFC PATCH 4/4] crypto: Add EC-RDSA algorithm
Message-Id: <20190107080710.r4bh7gkqdysxmlnn@sole.flsd.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190106133608.820-1-vt@altlinux.org>
 <20190106133608.820-5-vt@altlinux.org>
 <1893001.R2IGJoHzOM@positron.chronox.de>
In-Reply-To: <1893001.R2IGJoHzOM@positron.chronox.de>
To: Stephan =?utf-8?Q?M=C3=BCller?= <smueller@chronox.de>
Cc: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, Mimi Zohar <zohar@linux.vnet.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

Stephan,

On Sun, Jan 06, 2019 at 07:11:50PM +0100, Stephan M=C3=BCller wrote:
> Am Sonntag, 6. Januar 2019, 14:36:08 CET schrieb Vitaly Chikunov:
>=20
> > Add Elliptic Curve Russian Digital Signature Algorithm (GOST R
> > 34.10-2012, RFC 7091, ISO/IEC 14888-3) is one of the Russian (and since
> > 2018 the CIS countries) cryptographic standard algorithms (called GOST
> > algorithms). Only signature verification is supported, with intent to be
> > used in the IMA.
>=20
> Do you happen to have test vectors for the testmgr?

Yes, I will add this.

> > +/* Parse DER encoded subjectPublicKey. */
> > +static int ecrdsa_set_pub_key(struct crypto_akcipher *tfm, const void =
*ber,
> > +			      unsigned int len)
> > +{
> > +	struct ecrdsa_ctx *ctx =3D akcipher_tfm_ctx(tfm);
> > +	unsigned int ndigits;
> > +	const u8 *k =3D ber;
> > +	unsigned int offset;
> > +
> > +	/* First chance to zero ctx */
> > +	memset(ctx, 0, sizeof(*ctx));
> > +
> > +	if (len < 3 ||
> > +	    k[0] !=3D 0x04 || /* OCTET STRING */
> > +	    (k[1] < 0x80 && len !=3D k[1] + 2) ||
> > +	    (k[1] =3D 0x81 && len !=3D k[2] + 3) ||
> > +	    k[1] > 0x81)
> > +		return -EBADMSG;
> > +	offset =3D (k[1] < 0x80)? 2 : 3;
> > +	k +=3D offset;
> > +	len -=3D offset;
>=20
> Why do you manually parse the ASN.1 structure instead of using the ASN.1 =

> parser?

I am not sure this worth effort and will not be most degenerate use of
asn1_ber_decoder, since 1) I only need to parse one type in each case:
OCTET STRING string above code, and OIDs in below code; 2) this data is
said to be in DER format, which asn1_ber_decoder can not enforce. Surely
this will also produce more code and files.

> > +/* Parse DER encoded SubjectPublicKeyInfo.AlgorithmIdentifier.paramete=
rs.
> > */ +static int ecrdsa_set_params(struct crypto_akcipher *tfm, enum OID
> > algo, +			     const void *params, unsigned int paramlen)
> > +{
> > +	struct ecrdsa_ctx *ctx =3D akcipher_tfm_ctx(tfm);
> > +	const u8 *p =3D params;
> > +	int i;
> > +
> > +	if (algo =3D OID_gost2012PublicKey256) {
> > +		ctx->digest	=3D "streebog256";
> > +		ctx->digest_oid	=3D OID_gost2012Digest256;
> > +		ctx->digest_len	=3D 256 / 8;
> > +	} else if (algo =3D OID_gost2012PublicKey512) {
> > +		ctx->digest	=3D "streebog512";
> > +		ctx->digest_oid	=3D OID_gost2012Digest512;
> > +		ctx->digest_len	=3D 512 / 8;
> > +	} else
> > +		return -ENOPKG;
> > +	ctx->curve =3D NULL;
> > +	ctx->curve_oid =3D 0;
> > +	ctx->algo_oid =3D algo;
> > +
> > +	for (i =3D 0; i < paramlen; i +=3D p[i + 1] + 2) {
> > +		const struct ecc_curve *curve;
> > +		enum OID oid;
> > +
> > +		if (paramlen - i < 2 ||
> > +		    p[i] !=3D 0x06 || /* OBJECT IDENTIFIER */
>=20
> Same here and in the following
>=20
> > +		    p[i + 1] > paramlen - i - 2)
> > +			return -EBADMSG;
> > +		oid =3D look_up_OID(p + i + 2, p[i + 1]);

> > +MODULE_ALIAS_CRYPTO("ecrdsa");
>=20
> I do not think you need that alias as the module name already will be nam=
ed=20
> this way. I guess you rather should add ecrdsa-generic as module alias.

Thanks!
