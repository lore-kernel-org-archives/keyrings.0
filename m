From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 03 Oct 2019 17:58:54 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <20191003175854.GB19679@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190926171601.30404-1-jarkko.sakkinen@linux.intel.com>
 <1570024819.4999.119.camel@linux.ibm.com>
 <20191003114119.GF8933@linux.intel.com>
 <1570107752.4421.183.camel@linux.ibm.com>
In-Reply-To: <1570107752.4421.183.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, stable@vger.kernel.org, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Thu, Oct 03, 2019 at 09:02:32AM -0400, Mimi Zohar wrote:
> On Thu, 2019-10-03 at 14:41 +0300, Jarkko Sakkinen wrote:
> > On Wed, Oct 02, 2019 at 10:00:19AM -0400, Mimi Zohar wrote:
> > > On Thu, 2019-09-26 at 20:16 +0300, Jarkko Sakkinen wrote:
> > > > Only the kernel random pool should be used for generating random nu=
mbers.
> > > > TPM contributes to that pool among the other sources of entropy. In=
 here it
> > > > is not, agreed, absolutely critical because TPM is what is trusted =
anyway
> > > > but in order to remove tpm_get_random() we need to first remove all=
 the
> > > > call sites.
> > >=20
> > > At what point during boot is the kernel random pool available? =A0Does
> > > this imply that you're planning on changing trusted keys as well?
> >=20
> > Well trusted keys *must* be changed to use it. It is not a choice
> > because using a proprietary random number generator instead of defacto
> > one in the kernel can be categorized as a *regression*.
>=20
> I really don't see how using the TPM random number for TPM trusted
> keys would be considered a regression. =A0That by definition is a
> trusted key. =A0If anything, changing what is currently being done would
> be the regression.=A0

It is really not a TPM trusted key. It trusted key that gets sealed with
the TPM. The key itself is used in clear by kernel. The random number
generator exists in the kernel to for a reason.

It is without doubt a regression.

/Jarkko
