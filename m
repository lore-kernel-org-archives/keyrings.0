From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Fri, 18 Sep 2020 23:40:15 +0000
Subject: Re: [PATCH v11 1/3] security: keys: trusted: add PCR policy to TPM2 keys
Message-Id: <1600472415.10078.30.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200912173938.9714-1-James.Bottomley@HansenPartnership.com>
         <20200912173938.9714-2-James.Bottomley@HansenPartnership.com>
         <20200914193712.GA3612@linux.intel.com>
In-Reply-To: <20200914193712.GA3612@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Mon, 2020-09-14 at 22:37 +0300, Jarkko Sakkinen wrote:
> No sure why this is v11. I don't think we have reviewed this series
> that many times.

It was originally with the other patch set from the very beginning, so
it's definitely been sent 11 times.

> On Sat, Sep 12, 2020 at 10:39:36AM -0700, James Bottomley wrote:
> > This commit adds the ability to specify a PCR lock policy to TPM2
> > keys.  There is a complexity in that the creator of the key must
> > chose either to use a PCR lock policy or to use authentication.  At
> > the current time they can't use both due to a complexity with the
> > way authentication works when policy registers are in use.  The way
> > to construct a pcrinfo statement for a key is simply to use the
> > TPMS_PCR_SELECT structure to specify the PCRs and follow this by a
> > hash of all their values in order of ascending PCR number.
> > 
> > For simplicity, we require the policy name hash and the hash used
> > for the PCRs to be the same.  Thus to construct a policy around the
> > value
> 
> It would be better to write "name hash algorithm" and "policy hash
> algorithm".

For simplicity we require the hash of the PCRs to use the same
algorithm as the policy hash

> > of the resettable PCR 16 using the sha1 bank, first reset the pcr
> > to
> 
>                                                                 ~~~
> 								PCR
> 
> > zero giving a hash of all zeros as:
> > 
> > 6768033e216468247bd031a0a2d9876d79818f8f
> > 
> > Then the TPMS_PCR_SELECT value for PCR 16 is
> > 
> > 03000001
> > 
> > So create a new 32 byte key with a policy policy locking the key to
> > this value of PCR 16 with a parent key of 81000001 would be:
> > 
> > keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha1
> > pcrinfo0000016768033e216468247bd031a0a2d9876d79818f8f" @u
> > 
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > om>
> > 
> 
> Extra newline.

git am just elides this, but I can fix it and the other phrases up.]

[...]
> > 
> > +int tpm2_key_policy(void *context, size_t hdrlen,
> > +		  unsigned char tag,
> > +		  const void *value, size_t vlen)
> > +{
> > +	struct tpm2_key_context *ctx = context;
> > +
> > +	ctx->policies[ctx->policy_count] = value;
> > +	ctx->policy_len[ctx->policy_count++] = vlen;
> > +
> > +	return 0;
> > +}
> 
> As non-static symbols, and in general to make the code more
> understandable, must be documeted.

Will add docbook comment.

James
