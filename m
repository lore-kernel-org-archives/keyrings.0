From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Wed, 18 Dec 2019 23:10:52 +0000
Subject: Re: [PATCH v2 2/8] lib: add asn.1 encoder
Message-Id: <1576710652.3396.18.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1576069352.2812.1.camel@HansenPartnership.com>
         <1575984010.3459.4.camel@HansenPartnership.com>
         <1575936272.31378.50.camel@HansenPartnership.com>
         <1575936367.31378.52.camel@HansenPartnership.com>
         <932257121039494734d97e290abb9159b1f5ca28.camel@infradead.org>
         <10037.1575986929@warthog.procyon.org.uk>
         <1576004020.3647.13.camel@HansenPartnership.com>
         <35B37965-359E-40E0-8F44-836A56EC4756@infradead.org>
         <26946.1576666216@warthog.procyon.org.uk>
In-Reply-To: <26946.1576666216@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, keyrings@vger.kernel.org

On Wed, 2019-12-18 at 10:50 +0000, David Howells wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > +/**
> > + * asn1_encode_octet_string - encode an ASN.1 OCTET STRING
> > + * @data: pointer to encode at
> > + * @data_len: bytes remaining in @data buffer
> > + * @string: string to be encoded
> > + * @len: length of string
> > + *
> > + * Note ASN.1 octet strings may contain zeros, so the length is
> > obligatory.
> > + */
> > +int asn1_encode_octet_string(unsigned char **data, int *data_len,
> > +			     const unsigned char *string, u32 len)
> 
> I wonder if it makes more sense to pass in an end pointer and return
> the new data pointer (or an error), ie.:
> 
> unsigned char *asn1_encode_octet_string(unsigned char *data,
> 				        unsigned char *data_end,
> 					const unsigned char *string,
> u32 len)

On the first point: people are prone to get off by one confusion on
data_end pointers (should they point to the last byte in the buffer or
one beyond).  If I look at how I use the API, I've no real use for
either length remaining or the end pointer, so I think it makes no
difference to the consumer, it's just stuff you have to do for the API.
 If I look at the internal API use, we definitely need the length
remaining, so I've a marginal preference for that format, but since
it's easy to work out it is very marginal.

> Further, I wonder - does it actually make more sense to encode
> backwards, ie. start at the end of the buffer and do the last element
> first, working towards the front.

Heh, let me ask you this: do you use a reverse polish notation
calculator ... The problem is that it makes the ASN.1 hard to construct
 for the API user and hard to read for the reviewer because of the
order reversal.  Debugging is going to be a pain because you're going
to get the output of asn1parse and have to read it backwards to see
where the problems are.

> The disadvantage being that the data start would likely not be
> coincident with the buffer start.

This would be a big issue: in several routines I allocate a buffer,
fill it with ASN.1 and pass it back and the receiving routine has to
free it.  Now the buffer won't be freeable by the pointer I pass back
because that may not be where the allocation was done.

For these two reasons, I'd like to keep the work forwards behaviour. 
I'm reasonably ambivalent on the end pointer with a marginal preference
for passing in the length remaining instead.

James
