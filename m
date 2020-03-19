From: Eric Biggers <ebiggers@kernel.org>
Date: Thu, 19 Mar 2020 19:16:08 +0000
Subject: Re: [PATCH v8 1/8] lib: add ASN.1 encoder
Message-Id: <20200319191608.GC86395@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200310051607.30334-1-James.Bottomley@HansenPartnership.com>
 <20200310051607.30334-2-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200310051607.30334-2-James.Bottomley@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Mon, Mar 09, 2020 at 10:16:00PM -0700, James Bottomley wrote:
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
[...]
> diff --git a/lib/Makefile b/lib/Makefile
> index 611872c06926..1a9169ef2bed 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -237,7 +237,7 @@ obj-$(CONFIG_INTERVAL_TREE_TEST) += interval_tree_test.o
>  
>  obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
>  
> -obj-$(CONFIG_ASN1) += asn1_decoder.o
> +obj-$(CONFIG_ASN1) += asn1_decoder.o asn1_encoder.o
>  
>  obj-$(CONFIG_FONT_SUPPORT) += fonts/
>  

Shouldn't there be separate kconfig options CONFIG_ASN1_DECODER and
CONFIG_ASN1_ENCODER so that the kernel doesn't get bloated for most users, who
will only need the decoder?

- Eric
