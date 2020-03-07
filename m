From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Sat, 07 Mar 2020 22:00:26 +0000
Subject: Re: [PATCH v7 4/6] security: keys: trusted: use ASN.1 TPM2 key format for the blobs
Message-Id: <20200307220026.GA122868@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200305022744.12492-1-James.Bottomley@HansenPartnership.com>
 <20200305022744.12492-5-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200305022744.12492-5-James.Bottomley@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Wed, Mar 04, 2020 at 06:27:42PM -0800, James Bottomley wrote:
> Modify the TPM2 key format blob output to export and import in the
> ASN.1 form for TPM2 sealed object keys.  For compatibility with prior
> trusted keys, the importer will also accept two TPM2B quantities
> representing the public and private parts of the key.  However, the
> export via keyctl pipe will only output the ASN.1 format.
> 
> The benefit of the ASN.1 format is that it's a standard and thus the
> exported key can be used by userspace tools (openssl_tpm2_engine,
> openconnect and tpm2-tss-engine).  The format includes policy
> specifications, thus it gets us out of having to construct policy
> handles in userspace and the format includes the parent meaning you
> don't have to keep passing it in each time.
> 
> This patch only implements basic handling for the ASN.1 format, so
> keys with passwords but no policy.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

Not yet sure but I get

keyctl add trusted kmk "new 32 keyhandle=0x81000001 hash=sha1 pcrinfo000001 6768033e216468247bd031a0a2d9876d79818f8f" @u
add_key: No such device

After applying 1/6-4/6.

At this point I'm assuming that I've made mistake somewhere, which is
entirely possible.

/Jarkko
