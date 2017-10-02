From: Tudor Ambarus <tudor.ambarus@microchip.com>
Date: Mon, 02 Oct 2017 14:15:35 +0000
Subject: Re: [PATCH v8 0/4] crypto: add algif_akcipher user space API
Message-Id: <43d74317-5c5c-d1da-d4a1-185416053e8a@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <26359147.tCiuJ5s8mz@positron.chronox.de>
In-Reply-To: <26359147.tCiuJ5s8mz@positron.chronox.de>
To: =?UTF-8?Q?Stephan_M=c3=bcller?= <smueller@chronox.de>, "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, Marcel Holtmann <marcel@holtmann.org>, Mat Martineau <mathew.j.martineau@linux.intel.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, "David S . Miller" <davem@davemloft.net>, balrogg@googlemail.com
Cc: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, gilad@benyossef.com

Hi, all,

On 08/10/2017 09:39 AM, Stephan M=C3=BCller wrote:
> Hi,
>=20
> This patch set adds the AF_ALG user space API to externalize the
> asymmetric cipher API recently added to the kernel crypto API.

Do we have enough pros and cons so we can decide which interface to use
for exporting akcipher/kpp to user-space?

I'm willing to invest some time to make this happen.

Cheers,
ta
