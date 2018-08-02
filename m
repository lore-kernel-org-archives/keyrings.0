From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Thu, 02 Aug 2018 18:57:41 +0000
Subject: Re: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key support based on CAAM.
Message-Id: <1533236261.12916.5.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20180723111432.26830-1-udit.agarwal@nxp.com>
         <8060.1533226481@warthog.procyon.org.uk>
In-Reply-To: <8060.1533226481@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>, Udit Agarwal <udit.agarwal@nxp.com>
Cc: zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com, denkenz@gmail.com, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, sahil.malhotra@nxp.com, ruchika.gupta@nxp.com, horia.geanta@nxp.com, aymen.sghaier@nxp.com

On Thu, 2018-08-02 at 17:14 +0100, David Howells wrote:
> Udit Agarwal <udit.agarwal@nxp.com> wrote:
> 
> > +=====
> > +Secure Key
> > +=====
> > +
> > +Secure key is the new type added to kernel key ring service.
> > +Secure key is a symmetric type key of minimum length 32 bytes
> > +and with maximum possible length to be 128 bytes. It is produced
> > +in kernel using the CAAM crypto engine. Userspace can only see
> > +the blob for the corresponding key. All the blobs are displayed
> > +or loaded in hex ascii.
> 
> To echo Mimi, this sounds suspiciously like it should have a generic
> interface, not one that's specifically tied to one piece of hardware
> -
> particularly if it's named with generic "secure".
> 
> Can you convert this into a "symmetric" type and make the backend
> pluggable?

This is a symmetric key backed by a piece of hardware, which is exactly
what trusted keys are, so if we're defining common infrastructure with
callouts, trusted keys should be part of it.

Additionally, when I look at the trusted key code, I have significant
qualms about using the TPM RNG exclusively in the same way CAAM wants
to use its own RNG.  What I think both should be doing is collecting
data from their local RNGs, mixing it into the kernel entropy pool and
using a kernel generated random number (just in case these RNGs
suddenly turn out to be less random than they should be).

James


