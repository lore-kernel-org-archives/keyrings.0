From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Fri, 03 Aug 2018 15:48:58 +0000
Subject: Re: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key support based on CAAM.
Message-Id: <1533311338.4140.3.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
References: <20180723111432.26830-1-udit.agarwal@nxp.com>
         <8060.1533226481@warthog.procyon.org.uk>
         <1533297482.4337.373.camel@linux.ibm.com>
         <1533306238.4140.1.camel@HansenPartnership.com>
         <1533307535.4337.415.camel@linux.ibm.com>
In-Reply-To: <1533307535.4337.415.camel@linux.ibm.com>
To: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, Udit Agarwal <udit.agarwal@nxp.com>
Cc: zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com, denkenz@gmail.com, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, sahil.malhotra@nxp.com, ruchika.gupta@nxp.com, horia.geanta@nxp.com, aymen.sghaier@nxp.com

On Fri, 2018-08-03 at 10:45 -0400, Mimi Zohar wrote:
> On Fri, 2018-08-03 at 07:23 -0700, James Bottomley wrote:
> > On Fri, 2018-08-03 at 07:58 -0400, Mimi Zohar wrote:
> > > On Thu, 2018-08-02 at 17:14 +0100, David Howells wrote:
> > > > Udit Agarwal <udit.agarwal@nxp.com> wrote:
> > > > 
> > > > > +=====
> > > > > +Secure Key
> > > > > +=====
> > > > > +
> > > > > +Secure key is the new type added to kernel key ring service.
> > > > > +Secure key is a symmetric type key of minimum length 32
> > > > > bytes
> > > > > +and with maximum possible length to be 128 bytes. It is
> > > > > produced
> > > > > +in kernel using the CAAM crypto engine. Userspace can only
> > > > > see
> > > > > +the blob for the corresponding key. All the blobs are
> > > > > displayed
> > > > > +or loaded in hex ascii.
> > > > 
> > > > To echo Mimi, this sounds suspiciously like it should have a
> > > > generic interface, not one that's specifically tied to one
> > > > piece of
> > > > hardware - particularly if it's named with generic "secure".
> > > > 
> > > > Can you convert this into a "symmetric" type and make the
> > > > backend
> > > > pluggable?
> > > 
> > > TPM 1.2 didn't support symmetric keys.  For this reason, the TPM
> > > "unseals" the random number, used as a symmetric key, and returns
> > > the
> > > "unsealed" data to the kernel.
> > > 
> > > Does anyone know if CAAM or TPM 2.0 have support for symmetric
> > > keys?
> > 
> > It depends what you mean by "support".  The answer is technically
> > yes,
> > it's the TPM2_EncryptDecrypt primitive.  However, the practical
> > answer
> > is that symmetric keys are mostly used for bulk operations and the
> > TPM
> > and its bus are way too slow to support that, so the only real,
> > practical use case is to have the TPM govern the release conditions
> > for
> > symmetric keys which are later used by a fast bulk
> > encryptor/decryptor
> > based in software.
> > 
> > >  If they have symmetric key support, there would be no need for
> > > the
> > > symmetric key ever to leave the device in the clear.  The device
> > > would unseal/decrypt data, such as an encrypted key.
> > > 
> > > The "symmetric" key type would be a generic interface for
> > > different
> > > devices.
> > 
> > It's possible, but it would only work for a non-bulk use case; do
> > we
> > have one of those?
> 
> "trusted" keys are currently being used to decrypt other keys (eg.
> encrypted, ecryptfs, ...).

Yes, but that's just double encryption: it serves no real security
purpose because at the end of the chain, the symmetric key is released
into kernel memory to use in software crypto.  Unless you're using a
high speed (and high cost) crypto accelerator with HSA, this will
always be the case for bulk crypto.

The other slight problem with this chain of crypto is that I can impose
conditions on the key release from the TPM (well TPM2, since TPM1.2 has
a very weak policy engine) but if we use intermediate steps, those
conditions might not be preserved, so I think the ideal would be a
trusted key being released directly to LUKS or ecryptfs because the TPM
can then verify the policy at actual unseal time.  I get that for the
ecryptfs case you might want one key per file for sharding and sharing,
and that's more like a bulk case because the TPM isn't going to keep up
with the number of unseal operations required.

James

