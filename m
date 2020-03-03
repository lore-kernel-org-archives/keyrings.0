From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Tue, 03 Mar 2020 19:22:08 +0000
Subject: Re: [PATCH v6 1/6] lib: add ASN.1 encoder
Message-Id: <20200303192208.GA5775@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200302122759.5204-1-James.Bottomley@HansenPartnership.com>
 <20200302122759.5204-2-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200302122759.5204-2-James.Bottomley@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Mon, Mar 02, 2020 at 07:27:54AM -0500, James Bottomley wrote:
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
> 
> ---
> 
> v2: updated API to use indefinite length, and made symbol exports gpl
> v3: add data length error handling
> v4: use end_data instead of data_len pointer
> v5: mention tools and space out code
> ---
>  include/linux/asn1_encoder.h |  32 ++++
>  lib/Makefile                 |   2 +-
>  lib/asn1_encoder.c           | 431 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 464 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/asn1_encoder.h
>  create mode 100644 lib/asn1_encoder.c
> 
> diff --git a/include/linux/asn1_encoder.h b/include/linux/asn1_encoder.h
> new file mode 100644
> index 000000000000..08cd0c2ad34f
> --- /dev/null
> +++ b/include/linux/asn1_encoder.h
> @@ -0,0 +1,32 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef _LINUX_ASN1_ENCODER_H
> +#define _LINUX_ASN1_ENCODER_H
> +
> +#include <linux/types.h>
> +#include <linux/asn1.h>
> +#include <linux/asn1_ber_bytecode.h>
> +#include <linux/bug.h>
> +
> +#define asn1_oid_len(oid) (sizeof(oid)/sizeof(u32))
> +unsigned char *
> +asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
> +		    s64 integer);
> +unsigned char *
> +asn1_encode_oid(unsigned char *data, const unsigned char *end_data,
> +		u32 oid[], int oid_len);
> +unsigned char *
> +asn1_encode_tag(unsigned char *data, const unsigned char *end_data,
> +		u32 tag, const unsigned char *string, int len);
> +unsigned char *
> +asn1_encode_octet_string(unsigned char *data,
> +			 const unsigned char *end_data,
> +			 const unsigned char *string, u32 len);
> +unsigned char *
> +asn1_encode_sequence(unsigned char *data, const unsigned char *end_data,
> +		     const unsigned char *seq, int len);
> +unsigned char *
> +asn1_encode_boolean(unsigned char *data, const unsigned char *end_data,
> +		    bool val);
> +
> +#endif
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
> diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
> new file mode 100644
> index 000000000000..c7493667656e
> --- /dev/null
> +++ b/lib/asn1_encoder.c
> @@ -0,0 +1,431 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Simple encoder primitives for ASN.1 BER/DER/CER
> + *
> + * Copyright (C) 2019 James.Bottomley@HansenPartnership.com
> + */
> +
> +#include <linux/asn1_encoder.h>
> +#include <linux/bug.h>
> +#include <linux/string.h>
> +#include <linux/module.h>
> +
> +/**
> + * asn1_encode_integer() - encode positive integer to ASN.1
> + * @data:	pointer to the pointer to the data
> + * @end_data:	end of data pointer, points one beyond last usable byte in @data
> + * @integer:	integer to be encoded
> + *
> + * This is a simplified encoder: it only currently does
> + * positive integers, but it should be simple enough to add the
> + * negative case if a use comes along.
> + */
> +unsigned char *
> +asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
> +		    s64 integer)
> +{
> +	unsigned char *d = &data[2];

So what magic does index 2 contain?

> +	int i;
> +	bool found = false;
> +	int data_len = end_data - data;

I'd reorder these:

int data_len = end_data - data;
unsigned char *d = &data[2];
bool found = false;
int i;

Reordering makes easier to comprehend the declarations.

> +
> +	if (WARN(integer < 0,
> +		 "BUG: integer encode only supports positive integers"))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (IS_ERR(data))
> +		return data;
> +
> +	/* need at least 3 bytes for tag, length and integer encoding */
> +	if (data_len < 3)
> +		return ERR_PTR(-EINVAL);
> +
> +	/* remaining length where at d (the start of the integer encoding) */
> +	data_len -= 2;
> +
> +	data[0] = _tag(UNIV, PRIM, INT);
> +	if (integer = 0) {
> +		*d++ = 0;
> +		goto out;
> +	}
> +
> +	for (i = sizeof(integer); i > 0 ; i--) {
> +		int byte = integer >> (8*(i-1));

Spacing (according to the kernel coding style) is wrong here.

/Jarkko
