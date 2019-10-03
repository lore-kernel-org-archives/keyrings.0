From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 03 Oct 2019 21:57:43 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <20191003215743.GB30511@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190926171601.30404-1-jarkko.sakkinen@linux.intel.com>
 <1570024819.4999.119.camel@linux.ibm.com>
 <20191003114119.GF8933@linux.intel.com>
 <1570107752.4421.183.camel@linux.ibm.com>
 <20191003175854.GB19679@linux.intel.com>
 <1570128827.5046.19.camel@linux.ibm.com>
 <20191003215125.GA30511@linux.intel.com>
In-Reply-To: <20191003215125.GA30511@linux.intel.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Safford <david.safford@ge.com>, linux-integrity@vger.kernel.org, stable@vger.kernel.org, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Fri, Oct 04, 2019 at 12:51:25AM +0300, Jarkko Sakkinen wrote:
> On Thu, Oct 03, 2019 at 02:53:47PM -0400, Mimi Zohar wrote:
> > [Cc'ing David Safford]
> >=20
> > On Thu, 2019-10-03 at 20:58 +0300, Jarkko Sakkinen wrote:
> > > On Thu, Oct 03, 2019 at 09:02:32AM -0400, Mimi Zohar wrote:
> > > > On Thu, 2019-10-03 at 14:41 +0300, Jarkko Sakkinen wrote:
> > > > > On Wed, Oct 02, 2019 at 10:00:19AM -0400, Mimi Zohar wrote:
> > > > > > On Thu, 2019-09-26 at 20:16 +0300, Jarkko Sakkinen wrote:
> > > > > > > Only the kernel random pool should be used for generating ran=
dom numbers.
> > > > > > > TPM contributes to that pool among the other sources of entro=
py. In here it
> > > > > > > is not, agreed, absolutely critical because TPM is what is tr=
usted anyway
> > > > > > > but in order to remove tpm_get_random() we need to first remo=
ve all the
> > > > > > > call sites.
> > > > > >=20
> > > > > > At what point during boot is the kernel random pool available? =
=A0Does
> > > > > > this imply that you're planning on changing trusted keys as wel=
l?
> > > > >=20
> > > > > Well trusted keys *must* be changed to use it. It is not a choice
> > > > > because using a proprietary random number generator instead of de=
facto
> > > > > one in the kernel can be categorized as a *regression*.
> > > >=20
> > > > I really don't see how using the TPM random number for TPM trusted
> > > > keys would be considered a regression. =A0That by definition is a
> > > > trusted key. =A0If anything, changing what is currently being done =
would
> > > > be the regression.=A0
> > >=20
> > > It is really not a TPM trusted key. It trusted key that gets sealed w=
ith
> > > the TPM. The key itself is used in clear by kernel. The random number
> > > generator exists in the kernel to for a reason.
> > >=20
> > > It is without doubt a regression.
> >=20
> > You're misusing the term "regression" here. =A0A regression is something
> > that previously worked and has stopped working. =A0In this case, trusted
> > keys has always been based on the TPM random number generator. =A0Before
> > changing this, there needs to be some guarantees that the kernel
> > random number generator has a pool of random numbers early, on all
> > systems including embedded devices, not just servers.
>=20
> I'm not using the term regression incorrectly here. Wrong function
> was used to generate random numbers for the payload here. It is an
> obvious bug.

At the time when trusted keys was introduced I'd say that it was a wrong
design decision and badly implemented code. But you are right in that as
far that code is considered it would unfair to speak of a regression.

asym-tpm.c on the other hand this is fresh new code. There has been
*countless* of discussions over the years that random numbers should
come from multiple sources of entropy. There is no other categorization
than a bug for the tpm_get_random() there.

/Jarkko
