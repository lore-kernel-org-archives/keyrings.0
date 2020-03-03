From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 03 Mar 2020 20:06:14 +0000
Subject: Re: [PATCH v6 4/6] security: keys: trusted: use ASN.1 TPM2 key format for the blobs
Message-Id: <20200303200614.GD5775@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200302122759.5204-1-James.Bottomley@HansenPartnership.com>
 <20200302122759.5204-5-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200302122759.5204-5-James.Bottomley@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Mon, Mar 02, 2020 at 07:27:57AM -0500, James Bottomley wrote:
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

tpm_key (like you have tpm2_key prefix).

/Jarkko
