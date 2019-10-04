From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 04 Oct 2019 18:20:07 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <20191004182007.GA6945@linux.intel.com>
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
 <20191003215743.GB30511@linux.intel.com>
 <1570140491.5046.33.camel@linux.ibm.com>
In-Reply-To: <1570140491.5046.33.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Safford <david.safford@ge.com>, linux-integrity@vger.kernel.org, stable@vger.kernel.org, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Thu, Oct 03, 2019 at 06:08:11PM -0400, Mimi Zohar wrote:
> > At the time when trusted keys was introduced I'd say that it was a wrong
> > design decision and badly implemented code. But you are right in that as
> > far that code is considered it would unfair to speak of a regression.
> >=20
> > asym-tpm.c on the other hand this is fresh new code. There has been
> > *countless* of discussions over the years that random numbers should
> > come from multiple sources of entropy. There is no other categorization
> > than a bug for the tpm_get_random() there.
>=20
> This week's LWN article on "5.4 Merge window, part 2" discusses "boot-
> time entropy". =A0This article couldn't have been more perfectly timed.

Do not see any obvious relation to this dicussion. Are you saying that
you should not use the defacto kernel API's but instead bake your own
hacks because even defacto stuff bumps into issues from time to time?

And BTW, at the time you call tpm_get_random(), TPM driver is already
contributing to the entropy pool (registered as hwrng).

/Jarkko
