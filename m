From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Tue, 07 Jan 2020 00:17:40 +0000
Subject: Re: [PATCH v4 1/9] lib: add asn.1 encoder
Message-Id: <1578356260.3251.23.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
         <20191230173802.8731-2-James.Bottomley@HansenPartnership.com>
         <4aaebeb73ba23aa0cf9fef16e0abcb0f2329a4d1.camel@linux.intel.com>
In-Reply-To: <4aaebeb73ba23aa0cf9fef16e0abcb0f2329a4d1.camel@linux.intel.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Mon, 2020-01-06 at 20:09 +0200, Jarkko Sakkinen wrote:
> On Mon, 2019-12-30 at 09:37 -0800, James Bottomley wrote:
> > We have a need in the TPM trusted keys to return the ASN.1 form of
> > the TPM key blob so it can be operated on by tools outside of the
> > kernel. To do that, we have to be able to read and write the key
> > format.  The current ASN.1 decoder does fine for reading, but we
> > need pieces of an ASN.1 encoder to return the key blob.
> > 
> > The current implementation only encodes the ASN.1 bits we actually
> > need.
> > 
> > Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.c
> > om>
> 
> Please be explicit with the external tools. You must have specific
> tools in mind that you use. The abstraction level is unacceptable.

There are three current tools that use the ASN.1 format: the
openssl_tpm2_engine:

https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/

Openconnect:

http://git.infradead.org/users/dwmw2/openconnect.git

And the Intel TSS implementation of the openssl engine:

https://github.com/tpm2-software/tpm2-tss-engine



[...]
> > --- /dev/null
> > +++ b/lib/asn1_encoder.c
> > @@ -0,0 +1,391 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Simple encoder primitives for ASN.1 BER/DER/CER
> > + *
> > + * Copyright (C) 2019 James.Bottomley@HansenPartnership.com
> 
> How much explicit copyright statements really matter for new code?
> This is something that bothers me when reviewing patches as GIT log
> itself should be able to acknowledge the copyright implicitly.

This is actually the recommended statutory form of the US Copyright
Act:

https://www.copyright.gov/title17/92chap4.html

The Berne convention subsequently mandated that copyright should
subsist without the notice being required (and this became the law in
the US in 1989 meaning that for works after this date in the US, lack
of copyright notice can't be used as evidence of no copyright in the
file) but this is unevenly adhered to in the rest of the world, so the
US Copyright office recommends the notice should still be present.

The McHardy cases showed us the difficulty of convincing courts to
believe technology like git over simple statements in files, so it's
still best practice for all files in the kernel to have a copyright
notice just in case.

> > + */
> > +
> > +#include <linux/asn1_encoder.h>
> > +#include <linux/bug.h>
> > +#include <linux/string.h>
> > +#include <linux/module.h>
> > +
> > +/**
> > + * asn1_encode_integer - encode positive integer to ASN.1
> 
> Parentheses missing [1].
> 
> > + * @data: pointer to the pointer to the data
> > + * @end_data: end of data pointer, points one beyond last usable
> > byte in @data
> > + * @integer: integer to be encoded
> 
> Please align [1].

Will fix both.

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
> > +	int i;
> > +	bool found = false;
> > +	int data_len = end_data - data;
> > +
> > +	if (WARN(integer < 0,
> > +		 "BUG: integer encode only supports positive
> > integers"))
> 
> Please replace with WARN_ON(). Maintaining custom log messages here
> is senseless as this could only emit from a programming error.

I've got to say, having tripped a few of these, that I do like the
explicit message telling me why the warn on triggered and what I need
to do about it.  But I do admit it's only a minor inconvenience to
trace the WARN_ON back throught the file.

> > +		return ERR_PTR(-EINVAL);
> > +
> > +	if (IS_ERR(data))
> > +		return data;
> > +
> > +	if (data_len < 3)
> > +		return ERR_PTR(-EINVAL);
> > +
> > +	data_len -= 2;
> 
> What is point of this (please add a comment to the source code since
> it was not obvious)? Also, why not have this substracted in the
> initialization.

All ASN.1 elements begin with a tag and a length.  An integer must also
have a value, so it must be at least 3 bytes.  The reason for
subtracting 2 is that we insert the tag, save the length and begin
coding the integer in the for loop.

If I start data_len = end_data - data - 2 I then have to explain that
the if (data_len < 1) in fact means we need three bytes available
instead of its being obvious.

> 
> > +
> > +	data[0] = _tag(UNIV, PRIM, INT);
> 
> Empty line.

Yes, I'll try to do more spacing.

[...]
> This patch is full of overly packed code. Please just make
> it more spacy and readable.
> 
> > +	*(data++) = _tag(UNIV, PRIM, BOOL);
> > +	data_len--;
> > +	asn1_encode_length(&data, &data_len, 1);
> > +	*(data++) = val ? 1 : 0;
> 
> Please do not use ternary operator but instead:
> 
> if (*data)
> 	*(data++) = 1;
> else
> 	*(data++) = 0;

If (val) but yes, I can do that.

James
