From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Tue, 03 Mar 2020 20:49:30 +0000
Subject: Re: [PATCH v6 1/6] lib: add ASN.1 encoder
Message-Id: <1583268570.3638.15.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200302122759.5204-1-James.Bottomley@HansenPartnership.com>
         <20200302122759.5204-2-James.Bottomley@HansenPartnership.com>
         <20200303192208.GA5775@linux.intel.com>
In-Reply-To: <20200303192208.GA5775@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Tue, 2020-03-03 at 21:22 +0200, Jarkko Sakkinen wrote:
> On Mon, Mar 02, 2020 at 07:27:54AM -0500, James Bottomley wrote:
[...]
> > diff --git a/lib/asn1_encoder.c b/lib/asn1_encoder.c
> > new file mode 100644
> > index 000000000000..c7493667656e
> > --- /dev/null
> > +++ b/lib/asn1_encoder.c
> > @@ -0,0 +1,431 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Simple encoder primitives for ASN.1 BER/DER/CER
> > + *
> > + * Copyright (C) 2019 James.Bottomley@HansenPartnership.com
> > + */
> > +
> > +#include <linux/asn1_encoder.h>
> > +#include <linux/bug.h>
> > +#include <linux/string.h>
> > +#include <linux/module.h>
> > +
> > +/**
> > + * asn1_encode_integer() - encode positive integer to ASN.1
> > + * @data:	pointer to the pointer to the data
> > + * @end_data:	end of data pointer, points one beyond last
> > usable byte in @data
> > + * @integer:	integer to be encoded
> > + *
> > + * This is a simplified encoder: it only currently does
> > + * positive integers, but it should be simple enough to add the
> > + * negative case if a use comes along.
> > + */
> > +unsigned char *
> > +asn1_encode_integer(unsigned char *data, const unsigned char
> > *end_data,
> > +		    s64 integer)
> > +{
> > +	unsigned char *d = &data[2];
> 
> So what magic does index 2 contain?

ASN.1 has the form <tag> <length> <content> so a small integer has one
byte for the _tag(UNIV, PRIM, INT), one byte for the length, which must
be between 1 and 4, so the actual integer itself starts at 2.

> > +	int i;
> > +	bool found = false;
> > +	int data_len = end_data - data;
> 
> I'd reorder these:
> 
> int data_len = end_data - data;
> unsigned char *d = &data[2];
> bool found = false;
> int i;

Ah, reverse Christmas tree ... I can do that.

> Reordering makes easier to comprehend the declarations.
> 
> > +
> > +	if (WARN(integer < 0,
> > +		 "BUG: integer encode only supports positive
> > integers"))
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (IS_ERR(data))
> > +		return data;
> > +
> > +	/* need at least 3 bytes for tag, length and integer
> > encoding */
> > +	if (data_len < 3)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	/* remaining length where at d (the start of the integer
> > encoding) */
> > +	data_len -= 2;
> > +
> > +	data[0] = _tag(UNIV, PRIM, INT);
> > +	if (integer = 0) {
> > +		*d++ = 0;
> > +		goto out;
> > +	}
> > +
> > +	for (i = sizeof(integer); i > 0 ; i--) {
> > +		int byte = integer >> (8*(i-1));
> 
> Spacing (according to the kernel coding style) is wrong here.

OK, will add spaces around the brackets and the operations.

James
