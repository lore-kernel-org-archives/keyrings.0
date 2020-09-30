From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 30 Sep 2020 15:35:04 +0000
Subject: Re: [PATCH v13 4/5] security: keys: trusted: use ASN.1 TPM2 key format for the blobs
Message-Id: <20200930153504.GB52739@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200922022809.7105-1-James.Bottomley@HansenPartnership.com>
 <20200922022809.7105-5-James.Bottomley@HansenPartnership.com>
 <20200930111102.GB5145@linux.intel.com>
 <b8de8923e026525589c97b3cb7691a557c0a292f.camel@HansenPartnership.com>
In-Reply-To: <b8de8923e026525589c97b3cb7691a557c0a292f.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>

On Wed, Sep 30, 2020 at 07:49:51AM -0700, James Bottomley wrote:
> On Wed, 2020-09-30 at 14:11 +0300, Jarkko Sakkinen wrote:
> > On Mon, Sep 21, 2020 at 07:28:08PM -0700, James Bottomley wrote:
> > > Modify the TPM2 key format blob output to export and import in the
> > > ASN.1 form for TPM2 sealed object keys.  For compatibility with
> > > prior trusted keys, the importer will also accept two TPM2B
> > > quantities representing the public and private parts of the
> > > key.  However, the export via keyctl pipe will only output the
> > > ASN.1 format.
> > > 
> > > The benefit of the ASN.1 format is that it's a standard and thus
> > > the exported key can be used by userspace tools
> > > (openssl_tpm2_engine, openconnect and tpm2-tss-engine).  The format
> > > includes policy specifications, thus it gets us out of having to
> > > construct policy handles in userspace and the format includes the
> > > parent meaning you don't have to keep passing it in each time.
> > > 
> > > This patch only implements basic handling for the ASN.1 format, so
> > > keys with passwords but no policy.
> > > 
> > > Signed-off-by: James Bottomley <
> > > James.Bottomley@HansenPartnership.com>
> > 
> > I did the test for 3/5 with this patch applied (actually all patches
> > in this series) so I can safely
> > 
> > Tested-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > 
> > I have one wish though before giving reviewed-by.
> > 
> > In my recent trusted keys fixes I took the convention trusted_tpm_*
> > for TPM trusted keys functions. I think we should start doing that
> > for all functions:
> > 
> > 1. For interface functions trusted_tpm_*
> > 2. TPM1: trusted_tpm1_*
> > 2. TPM2: trusted_tpm2_*
> 
> I'm not such a fan of this: we've discussed moving some of the
> functions around because we expect to grow consumers.  We really don't
> want to be having to rename everything as we move it, so I'd far prefer
> the name were related to the function rather than the location in the
> kernel tree.

OK, I see you point here. The trusted_tpm_* functions that I added are
directly bound to the specifict trusted keys implementation,  so it is
a different situation.

> > This is to manage chaos with TEE Trusted Keys in future and make the
> > distinction with TPM subsystem functions, and make it easier to grep
> > and trace this stuff with the various tracing tools.
> > 
> > This anyway needs one more rebase on top of the fixes that I did.
> > 
> > BTW, what is the situation with the ARM compilation issue?
> 
> It was fixed in this incarnation.

OK, great.

/Jarkko
