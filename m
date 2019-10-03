From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Thu, 03 Oct 2019 18:02:01 +0000
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-Id: <20191003180201.GC19679@linux.intel.com>
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
> That isn't a valid justification for changing the original definition
> of trusted keys. =A0Just as the kernel supports different methods of
> implementing the same function on different architectures, trusted
> keys will need to support different methods of generating a random
> number. =A0=A0

This is completely incorrect deduction. The random number generator
inside the kernel is there to gather entropy from different sources.
You would exploit trusted keys to potential weaknesses of a single
entropy source by doing that.

Of course in TEE platform, TEE can be one of the entropy sources but
there is no reason to weaken the security by using it as the only
sources.

/Jarkko
