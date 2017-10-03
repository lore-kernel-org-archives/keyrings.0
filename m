From: Mat Martineau <mathew.j.martineau@linux.intel.com>
Date: Tue, 03 Oct 2017 00:09:02 +0000
Subject: Re: [PATCH v8 0/4] crypto: add algif_akcipher user space API
Message-Id: <alpine.OSX.2.21.1710021601120.10266@mjmartin-mac01.sea.intel.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0-1980401826-1506985467=:10266"
List-Id: <keyrings.vger.kernel.org>
References: <26359147.tCiuJ5s8mz@positron.chronox.de> <43d74317-5c5c-d1da-d4a1-185416053e8a@microchip.com>
In-Reply-To: <43d74317-5c5c-d1da-d4a1-185416053e8a@microchip.com>
To: Tudor Ambarus <tudor.ambarus@microchip.com>, David Howells <dhowells@redhat.com>
Cc: =?ISO-8859-15?Q?Stephan_M=FCller?= <smueller@chronox.de>, Herbert Xu <herbert@gondor.apana.org.au>, Marcel Holtmann <marcel@holtmann.org>, David Woodhouse <dwmw2@infradead.org>, "David S . Miller" <davem@davemloft.net>, balrogg@googlemail.com, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, gilad@benyossef.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1980401826-1506985467=:10266
Content-Type: text/plain; charset="iso-8859-15"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-ID: <alpine.OSX.2.21.1710021604311.10266@mjmartin-mac01.sea.intel.com>


Hi Tudor -

On Mon, 2 Oct 2017, Tudor Ambarus wrote:

> Hi, all,
>
> On 08/10/2017 09:39 AM, Stephan M=FCller wrote:
>> Hi,
>>=20
>> This patch set adds the AF_ALG user space API to externalize the
>> asymmetric cipher API recently added to the kernel crypto API.
>
> Do we have enough pros and cons so we can decide which interface to use
> for exporting akcipher/kpp to user-space?
>
> I'm willing to invest some time to make this happen.

David Howells has a branch implementing asymmetric crypto operations using =

keyctl:

https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?=
h=3Dkeys-asym-keyctl

That's based on v4.8-rc1, but I've been merging it with more recent=20
kernels, and it's been working fine:

https://git.kernel.org/pub/scm/linux/kernel/git/martineau/linux.git/log/?h=
=3Dell-key-crypto

As far as I know, these keyctl operations are not upstream yet because=20
there isn't yet a hardware (TPM) asymmetric key subtype that would allow=20
the key subsystem to choose between akcipher or TPM crypto depending on=20
the key subtype in use.

I'd like to see the functionality merged even with only akcipher support.=20
The only issue I've had with the existing patch set is that RSA=20
verification can't unpad certain results before comparing because the=20
necessary functionality was removed from rsa-pkcs1pad in the kernel. This=20
isn't a limitation of the keyctl patch set, though.

A handful of the people on this thread had agreed to move ahead with the=20
keyctl API because it could handle key material well and choose between=20
crypto engines (including engines that did not support software fallback)=20
- that's when David put together his patches. David, is there help you=20
could use with the hardware asymmetric key subtype or other aspects of=20
keyctl crypto?

--
Mat Martineau
Intel OTC
--0-1980401826-1506985467=:10266--
