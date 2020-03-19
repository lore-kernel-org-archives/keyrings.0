From: David Howells <dhowells@redhat.com>
Date: Thu, 19 Mar 2020 16:47:19 +0000
Subject: Re: [PATCH v8 1/8] lib: add ASN.1 encoder
Message-Id: <3180269.1584636439@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200310051607.30334-2-James.Bottomley@HansenPartnership.com> <20200310051607.30334-1-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20200310051607.30334-2-James.Bottomley@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: dhowells@redhat.com, linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> + * Copyright (C) 2019 James.Bottomley@HansenPartnership.com

2020?

> +unsigned char *
> +asn1_encode_integer(unsigned char *data, const unsigned char *end_data,
> +		    s64 integer);

I wonder if we should actually use u8 rather than unsigned char for data
pointers like this.  That applies to asn1_ber_decoder() also.

You should be able to precalculate the length from fls64() or ilog2(), e.g.:

	static size_t asn1_uint_len(unsigned long long integer)
	{
		size_t l = integer ? fls64(integer) : 1;
		return l / 8 + 1;
	}

See attached toy program.

> +/**
> + * asn1_encode_tag() - add a tag for optional or explicit value
> + * @data:	pointer to place tag at
> + * @end_data:	end of data pointer, points one beyond last usable byte in @data
> + * @tag:	tag to be placed
> + * @string:	the data to be tagged
> + * @len:	the length of the data to be tagged
> + *
> + * Note this currently only handles short form tags < 31.  To encode
> + * in place pass a NULL @string and -1 for @len; all this will do is
> + * add an indefinite length tag and update the data pointer to the
> + * place where the tag contents should be placed.  After the data is
> + * placed, repeat the prior statement but now with the known length.
> + * In order to avoid having to keep both before and after pointers,
> + * the repeat expects to be called with @data pointing to where the
> + * first encode placed it.
> + */

I wonder if it's worth appending a note to the comment that if indefinite
length encoding is selected, then the result is not DER-compliant and may not
be CER-compliant since you're advertising BER/DER/CER.

> +	if (*data_len < 1)
> +		return -EINVAL;

ENOBUFS?  I guess it doesn't really matter.

David
---
#include <stdio.h>

static inline int fls64(unsigned long long x)
{
	int bitpos = -1;
	/*
	 * AMD64 says BSRQ won't clobber the dest reg if x==0; Intel64 says the
	 * dest reg is undefined if x==0, but their CPU architect says its
	 * value is written to set it to the same as before.
	 */
	asm("bsrq %1,%q0"
	    : "+r" (bitpos)
	    : "rm" (x));
	return bitpos + 1;
}

static const unsigned long long vals[] = {
	0x1000000, 0xffffff, 0x800000, 0x7fffff,
	0x100000, 0xfffff, 0x80000, 0x7ffff,
	0x10000, 0xffff, 0x8000, 0x7fff,
	0x1000, 0xfff, 0x800, 0x7ff,
	0x100, 0xff, 0x80, 0x7f,
	3, 2, 1, 0
};

static size_t asn1_uint_len(unsigned long long integer)
{
	size_t l = integer ? fls64(integer) : 1;
	return l / 8 + 1;
}

int main()
{
	const unsigned long long *p = vals;
	unsigned long long integer;

	do {
		integer = *p++;
		printf("len: %16llx -> %zu\n", integer, asn1_uint_len(integer));
	} while (integer);
}
