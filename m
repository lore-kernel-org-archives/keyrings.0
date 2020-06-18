From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Thu, 18 Jun 2020 19:45:14 +0000
Subject: Re: [PATCH v10 7/8] security: keys: trusted: add ability to specify arbitrary policy
Message-Id: <1592509514.15159.18.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200616160229.8018-1-James.Bottomley@HansenPartnership.com>
         <20200616160229.8018-8-James.Bottomley@HansenPartnership.com>
         <20200617234250.GJ62794@linux.intel.com>
         <1592440063.3515.42.camel@HansenPartnership.com>
         <20200618071200.GB6560@linux.intel.com>
In-Reply-To: <20200618071200.GB6560@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Thu, 2020-06-18 at 10:12 +0300, Jarkko Sakkinen wrote:
> On Wed, Jun 17, 2020 at 05:27:43PM -0700, James Bottomley wrote:
> > On Thu, 2020-06-18 at 02:42 +0300, Jarkko Sakkinen wrote:
> > > On Tue, Jun 16, 2020 at 09:02:28AM -0700, James Bottomley wrote:
> > > > This patch adds a policy= argument to key creation.  The policy
> > > > is
> > > > the standard tss policymaker format and each separate policy
> > > > line
> > > > must have a newline after it.
> > > 
> > > Never heard of policymaker before and did not find TCG spec for
> > > it.
> > 
> > It's not part of the spec.  Both the IBM and Intel TSSs define a
> > policymaker tool to help you build policy hashes.  The format is
> > simply
> > a set of numbers that if hashed a line at a time produce the policy
> > hash.
> 
> OK, so they both use this 'policymaker' format? Where is it
> documented?

I don't think it is except in the source code of the tools.  It's
basically a sequence of TPM2_PolicyXX statements laid out in binary end
to end one per line as the TPM2 command value says they are hashed.  I
can just say that if you prefer.  The example given is

TPM2_PolicyPCR(policydigest, selection)
TPM2_PolicyAuthValue()

So if you look in the manual, TPM2_PolicyPCR says the hash is
calculated as

H_policyAlg (policyDigest_old || TPM_CC_PolicyPCR || pcrs || digestTPM)

So the policymaker statement is

TPM_CC_PolicyPCR || pcrs || digestTPM

Which in hex is

0000017F 00000001000B 03000001303095B49BE85E381E5B20E557E46363EF55B0F43B132C2D8E3DE9AC436656F2

And TPM2_PolicyAuthValue simply says

H_policyAlg (policyDigest_old || TPM_CC_PolicyAuthValue )

So the policymaker statement is

TPM_CC_PolicyAuthValue

or in hex

0000016b

James
