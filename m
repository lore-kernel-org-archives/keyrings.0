From: David Howells <dhowells@redhat.com>
Date: Wed, 18 Dec 2019 10:50:16 +0000
Subject: Re: [PATCH v2 2/8] lib: add asn.1 encoder
Message-Id: <26946.1576666216@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1576069352.2812.1.camel@HansenPartnership.com> <1575984010.3459.4.camel@HansenPartnership.com> <1575936272.31378.50.camel@HansenPartnership.com> <1575936367.31378.52.camel@HansenPartnership.com> <932257121039494734d97e290abb9159b1f5ca28.camel@infradead.org> <10037.1575986929@warthog.procyon.org.uk> <1576004020.3647.13.camel@HansenPartnership.com> <35B37965-359E-40E0-8F44-836A56EC4756@infradead.org>
In-Reply-To: <1576069352.2812.1.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: dhowells@redhat.com, David Woodhouse <dwmw2@infradead.org>, linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, keyrings@vger.kernel.org

James Bottomley <James.Bottomley@HansenPartnership.com> wrote:

> +/**
> + * asn1_encode_octet_string - encode an ASN.1 OCTET STRING
> + * @data: pointer to encode at
> + * @data_len: bytes remaining in @data buffer
> + * @string: string to be encoded
> + * @len: length of string
> + *
> + * Note ASN.1 octet strings may contain zeros, so the length is obligatory.
> + */
> +int asn1_encode_octet_string(unsigned char **data, int *data_len,
> +			     const unsigned char *string, u32 len)

I wonder if it makes more sense to pass in an end pointer and return the new
data pointer (or an error), ie.:

unsigned char *asn1_encode_octet_string(unsigned char *data,
				        unsigned char *data_end,
					const unsigned char *string, u32 len)

Further, I wonder - does it actually make more sense to encode backwards,
ie. start at the end of the buffer and do the last element first, working
towards the front.

The disadvantage being that the data start would likely not be coincident with
the buffer start.

David
