From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 03 Oct 2019 11:41:19 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <20191003114119.GF8933@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <20190926171601.30404-1-jarkko.sakkinen@linux.intel.com>
 <1570024819.4999.119.camel@linux.ibm.com>
In-Reply-To: <1570024819.4999.119.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, stable@vger.kernel.org, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>, "open list:CRYPTO API" <linux-crypto@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

On Wed, Oct 02, 2019 at 10:00:19AM -0400, Mimi Zohar wrote:
> On Thu, 2019-09-26 at 20:16 +0300, Jarkko Sakkinen wrote:
> > Only the kernel random pool should be used for generating random number=
s.
> > TPM contributes to that pool among the other sources of entropy. In her=
e it
> > is not, agreed, absolutely critical because TPM is what is trusted anyw=
ay
> > but in order to remove tpm_get_random() we need to first remove all the
> > call sites.
>=20
> At what point during boot is the kernel random pool available? =A0Does
> this imply that you're planning on changing trusted keys as well?

Well trusted keys *must* be changed to use it. It is not a choice
because using a proprietary random number generator instead of defacto
one in the kernel can be categorized as a *regression*.

Also, TEE trusted keys cannot use the TPM option.

If it was not initialized early enough we would need fix that too.

I don't think there should be a problem anyway since encrypted keys is
already using get_random_bytes().

/Jarkko
