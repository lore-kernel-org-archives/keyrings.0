From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Tue, 10 Mar 2020 15:22:58 +0000
Subject: Re: [PATCH v8 1/8] lib: add ASN.1 encoder
Message-Id: <1583853778.5686.14.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200310050939.29251-1-James.Bottomley@HansenPartnership.com>
         <20200310050939.29251-2-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200310050939.29251-2-James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Mon, 2020-03-09 at 22:09 -0700, James Bottomley wrote:
> We have a need in the TPM2 trusted keys to return the ASN.1 form of
> the TPM key blob so it can be operated on by tools outside of the
> kernel.  The specific tools are the openssl_tpm2_engine, openconnect
> and the Intel tpm2-tss-engine.  To do that, we have to be able to
> read and write the same binary key format the tools use.  The current
> ASN.1 decoder does fine for reading, but we need pieces of an ASN.1
> encoder to write the key blob in binary compatible form.
> 
> For backwards compatibility, the trusted key reader code will still
> accept the two TPM2B quantities that it uses today, but the writer
> will only output the ASN.1 form.
> 
> The current implementation only encodes the ASN.1 bits we actually
> need.
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com
> >

Sorry, screwed up on tags here (forgot to add reviewed-by:).  I've
resent the entire patch set here:

https://lore.kernel.org/linux-integrity/20200310051607.30334-1-James.Bottomley@HansenPartnership.com/

James
