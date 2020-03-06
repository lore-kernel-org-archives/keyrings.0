From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Fri, 06 Mar 2020 19:10:29 +0000
Subject: Re: [PATCH v7 1/6] lib: add ASN.1 encoder
Message-Id: <20200306191029.GI7472@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200305022744.12492-1-James.Bottomley@HansenPartnership.com>
 <20200305022744.12492-2-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200305022744.12492-2-James.Bottomley@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Wed, Mar 04, 2020 at 06:27:39PM -0800, James Bottomley wrote:
> We have a need in the TPM2 trusted keys to return the ASN.1 form of
> the TPM key blob so it can be operated on by tools outside of the
> kernel.  The specific tools are the openssl_tpm2_engine, openconnect
> and the Intel tpm2-tss-engine.  To do that, we have to be able to read
> and write the same binary key format the tools use.  The current ASN.1
> decoder does fine for reading, but we need pieces of an ASN.1 encoder
> to write the key blob in binary compatible form.
> 
> For backwards compatibility, the trusted key reader code will still
> accept the two TPM2B quantities that it uses today, but the writer
> will only output the ASN.1 form.
> 
> The current implementation only encodes the ASN.1 bits we actually need.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

For me this looks good (saw your other mail about spacing, no worries).

Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
