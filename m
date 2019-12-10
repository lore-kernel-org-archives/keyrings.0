From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Tue, 10 Dec 2019 13:20:10 +0000
Subject: Re: [PATCH v2 2/8] lib: add asn.1 encoder
Message-Id: <1575984010.3459.4.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1575936272.31378.50.camel@HansenPartnership.com>
         <1575936367.31378.52.camel@HansenPartnership.com>
         <932257121039494734d97e290abb9159b1f5ca28.camel@infradead.org>
In-Reply-To: <932257121039494734d97e290abb9159b1f5ca28.camel@infradead.org>
To: David Woodhouse <dwmw2@infradead.org>, linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, keyrings@vger.kernel.org

On Tue, 2019-12-10 at 08:18 +0000, David Woodhouse wrote:
> On Mon, 2019-12-09 at 16:06 -0800, James Bottomley wrote:
> > +/**
> > + * asn1_encode_integer - encode positive integer to ASN.1
> > + * @_data: pointer to the pointer to the data
> > + * @integer: integer to be encoded
> > + * @len: length of buffer
> > + *
> > + * This is a simplified encoder: it only currently does
> > + * positive integers, but it should be simple enough to add the 
> > + * negative case if a use comes along.
> > + */
> > +void asn1_encode_integer(unsigned char **_data, s64 integer, int
> > len)
> > +{
> > +       unsigned char *data = *_data, *d = &data[2];
> > +       int i;
> > +       bool found = false;
> > +
> > +       if (WARN(integer < 0,
> > +                "BUG: asn1_encode_integer only supports positive
> > integers"))
> > +               return;
> > +
> > +       if (WARN(len < 3,
> > +                "BUG: buffer for integers must have at least 3
> > bytes"))
> > +               return;
> > +
> > +       len =- 2;
> > +
> > +       data[0] = _tag(UNIV, PRIM, INT);
> > +       if (integer = 0) {
> > +               *d++ = 0;
> > +               goto out;
> > +       }
> > +       for (i = sizeof(integer); i > 0 ; i--) {
> > +               int byte = integer >> (8*(i-1));
> > +
> > +               if (!found && byte = 0)
> > +                       continue;
> > +               found = true;
> > +               if (byte & 0x80) {
> > +                       /*
> > +                        * no check needed here, we already know we
> > +                        * have len >= 1
> > +                        */
> > +                       *d++ = 0;
> > +                       len--;
> > +               }
> > +               if (WARN(len = 0,
> > +                        "BUG buffer too short in
> > asn1_encode_integer"))
> > +                       return;
> > +               *d++ = byte;
> > +               len--;
> > +       }
> > + out:
> > +       data[1] = d - data - 2;
> > +       *_data = d;
> > +}
> > +EXPORT_SYMBOL_GPL(asn1_encode_integer);
> 
> 
> Didn't you say you were going to make it return an error when it ran
> out of space or was asked to encode a negative number?

it follows the pattern of all the other functions in that it dumps a
kernel warning on problems and bails.  I don't really want to add error
handling for my use case, since it's not expected to have any problems.
 My main problem case is a malicious user tricking the kernel into
trying to overflow the output buffer and in that case I don't really
care that the ASN.1 output will be malformed as long as the buffer
doesn't overflow.

James

> There are other encoding functions which you haven't yet added the
> buffer length field to, and they'll want to be able to return -ENOSPC
> too.
