From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 09 Mar 2020 22:08:23 +0000
Subject: Re: [PATCH v7 4/6] security: keys: trusted: use ASN.1 TPM2 key format for the blobs
Message-Id: <1583791703.6009.3.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200305022744.12492-1-James.Bottomley@HansenPartnership.com>
         <20200305022744.12492-5-James.Bottomley@HansenPartnership.com>
         <20200307220026.GA122868@linux.intel.com>
         <1583762386.3429.6.camel@HansenPartnership.com>
In-Reply-To: <1583762386.3429.6.camel@HansenPartnership.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Mon, 2020-03-09 at 06:59 -0700, James Bottomley wrote:
> On Sun, 2020-03-08 at 00:00 +0200, Jarkko Sakkinen wrote:
> > On Wed, Mar 04, 2020 at 06:27:42PM -0800, James Bottomley wrote:
> > > Modify the TPM2 key format blob output to export and import in
> > > the ASN.1 form for TPM2 sealed object keys.  For compatibility
> > > with prior trusted keys, the importer will also accept two TPM2B
> > > quantities representing the public and private parts of the
> > > key.  However, the export via keyctl pipe will only output the
> > > ASN.1 format.
> > > 
> > > The benefit of the ASN.1 format is that it's a standard and thus
> > > the exported key can be used by userspace tools
> > > (openssl_tpm2_engine, openconnect and tpm2-tss-engine).  The
> > > format includes policy specifications, thus it gets us out of
> > > having to construct policy handles in userspace and the format
> > > includes the parent meaning you don't have to keep passing it in
> > > each time.
> > > 
> > > This patch only implements basic handling for the ASN.1 format,
> > > so keys with passwords but no policy.
> > > 
> > > Signed-off-by: James Bottomley
> > > <James.Bottomley@HansenPartnership.com>
> > 
> > Not yet sure but I get
> > 
> > keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha1
> > pcrinfo000001 6768033e216468247bd031a0a2d9876d79818f8f" @u
> > add_key: No such device
> 
> What's the last hex string?  Is there supposed to be a command
> preceding it (like blobauth since there's 40 hex chars?).
> 
> > After applying 1/6-4/6.
> 
> As you guessed for most of the rebases I've been testing the whole
> set of patches.  Let me wind back to 4/6 and have a look.
> 
> > At this point I'm assuming that I've made mistake somewhere, which
> > is entirely possible.
> 
> Heh, don't bet on it, I should be able to reconstruct the environment
> today and try it out.

OK, I got the environment constructed, and everything seems to work
fine for me.

However, there is still a problem with the patch.  It appears in going
from v4->v5 two additional patches got folded into this one:

[PATCH v4 5/9] security: keys: trusted: Make sealed key properly
 interoperable
[PATCH v4 6/9] security: keys: trusted: add PCR policy to TPM2 keys

I'll see if I can disentangle them otherwise the commit log saying we
don't add policy is completely wrong.

James
