From: Stephan Mueller <smueller@chronox.de>
Date: Mon, 12 Mar 2018 19:56:56 +0000
Subject: Re: [tpmdd-devel] in-kernel user of ecdsa
Message-Id: <31045526.HZb3ddfbbg@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <keyrings.vger.kernel.org>
References: <0f698592-8ade-14d4-7891-1c35501c6285@microchip.com> <1520878158.4522.31.camel@linux.vnet.ibm.com>
In-Reply-To: <1520878158.4522.31.camel@linux.vnet.ibm.com>
To: James Bottomley <jejb@linux.vnet.ibm.com>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>, David Howells <dhowells@redhat.com>, dwmw2@infradead.org, keyrings@vger.kernel.org, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, linux-security-module@vger.kernel.org, tpmdd-devel@lists.sourceforge.net, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>

Am Montag, 12. M=E4rz 2018, 19:09:18 CET schrieb James Bottomley:

Hi James,

> On Mon, 2018-03-12 at 19:07 +0200, Tudor Ambarus wrote:
> > Hi,
> >=20
> > Would you consider using ECDSA in the kernel module signing facility?
> > When compared with RSA, ECDSA has shorter keys, the key generation
> > process is faster, the sign operation is faster, but the verify
> > operation is slower than with RSA.
>=20
> You missed the keyrings list, which is where the module signing utility
> is discussed.
>=20
> First question is, have you actually tried?  It looks like sign-file
> doesn't do anything RSA specific so if you give it an EC X.509
> certificate it will produce an ECDSA signature.
>=20
> I think our kernel internal x509 parsers don't have the EC OIDs, so
> signature verification will fail; but, especially since we have the
> rest of the EC machinery in the crypto subsystem, that looks to be
> simply fixable.

ECDSA is not implemented currently in the kernel crypto API.
>=20
> James



Ciao
Stephan


