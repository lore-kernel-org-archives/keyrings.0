From: James Bottomley <jejb@linux.vnet.ibm.com>
Date: Mon, 12 Mar 2018 21:55:35 +0000
Subject: Re: [tpmdd-devel] in-kernel user of ecdsa
Message-Id: <1520891735.4522.45.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <0f698592-8ade-14d4-7891-1c35501c6285@microchip.com>
         <1520878158.4522.31.camel@linux.vnet.ibm.com>
         <31045526.HZb3ddfbbg@tauon.chronox.de>
In-Reply-To: <31045526.HZb3ddfbbg@tauon.chronox.de>
To: Stephan Mueller <smueller@chronox.de>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>, David Howells <dhowells@redhat.com>, dwmw2@infradead.org, keyrings@vger.kernel.org, "bluez mailin list (linux-bluetooth@vger.kernel.org)" <linux-bluetooth@vger.kernel.org>, linux-security-module@vger.kernel.org, tpmdd-devel@lists.sourceforge.net, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>

On Mon, 2018-03-12 at 20:56 +0100, Stephan Mueller wrote:
> Am Montag, 12. März 2018, 19:09:18 CET schrieb James Bottomley:
> 
> Hi James,
> 
> > 
> > On Mon, 2018-03-12 at 19:07 +0200, Tudor Ambarus wrote:
> > > 
> > > Hi,
> > > 
> > > Would you consider using ECDSA in the kernel module signing
> > > facility? When compared with RSA, ECDSA has shorter keys, the key
> > > generation process is faster, the sign operation is faster, but
> > > the verify operation is slower than with RSA.
> > 
> > You missed the keyrings list, which is where the module signing
> > utility is discussed.
> > 
> > First question is, have you actually tried?  It looks like sign-
> > file doesn't do anything RSA specific so if you give it an EC X.509
> > certificate it will produce an ECDSA signature.
> > 
> > I think our kernel internal x509 parsers don't have the EC OIDs, so
> > signature verification will fail; but, especially since we have the
> > rest of the EC machinery in the crypto subsystem, that looks to be
> > simply fixable.
> 
> ECDSA is not implemented currently in the kernel crypto API.

an ECDSA signature is produced as a ECDH operation using the DSA
algorithm instead of KDFe, so it's trivial with what we have; signature
verification involves a separate point addition but we have all the
primitives for this in crypto/ecc.c so adding it isn't really
difficult, is it?

James

