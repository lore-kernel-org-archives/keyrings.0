From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Tue, 10 Dec 2019 18:53:40 +0000
Subject: Re: [PATCH v2 2/8] lib: add asn.1 encoder
Message-Id: <1576004020.3647.13.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1575984010.3459.4.camel@HansenPartnership.com>
         <1575936272.31378.50.camel@HansenPartnership.com>
         <1575936367.31378.52.camel@HansenPartnership.com>
         <932257121039494734d97e290abb9159b1f5ca28.camel@infradead.org>
         <10037.1575986929@warthog.procyon.org.uk>
In-Reply-To: <10037.1575986929@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, keyrings@vger.kernel.org

On Tue, 2019-12-10 at 14:08 +0000, David Howells wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > > Didn't you say you were going to make it return an error when it
> > > ran out of space or was asked to encode a negative number?
> > 
> > it follows the pattern of all the other functions in that it dumps
> > a kernel warning on problems and bails.
> 
> I don't see any bounds checking there, let alone anything that dumps
> a kernel warning and bails 

It's in the if (WARN part of asn1_encode_integer.

> - except if the length is so large that the ASN.1 cannot be
> constructed.  That said, there is a check in patch 4.

However, I think you'd like both a length and a buffer length to each
function to cope with definite length encoding overflows?  I can do
that.

> > ... as long as the buffer doesn't overflow.
> 
> Yes, but that's Dave's point.
> 
> [from patch 4]
> 
> > +	 * Assume both ovtet strings will encode to a 2 byte
> > definite length
> 
> octet, btw.

Heh, yes, noticed that mere seconds after I pressed send ...

> At least I've found a preliminary bounds check there
> 
> > +	 */
> > +	if (WARN(work - scratch + pub_len + priv_len + 8 >
> > SCRATCH_SIZE,
> > +		 "BUG: scratch buffer is too small"))
> > +		return -EINVAL;
> 
> which I presume makes the correct calculation.
> 
> I thought TPM comms were slow - slow enough that putting bounds
> checking in your asn1_encode_* routines will be insignificant.

Yes, I'm not bothered about timings.  I can add bounds checking on the
buffer length like the integer case.  For the other routines, I'll make
it decrement the data length in place as it increments the data pointer

> Further, you're promoting this ASN.1 encoder as a general library
> within the kernel, presumably so that other people can make use of
> it.

Well, I did notice the TPM 1.2 asymmetric key code rolled its own ASN.1
encoding, yes.

>   Please therefore put bounds checking and error handling in it.  And
> please *don't* just produce broken ASN.1 when something goes wrong.

OK, I'll make it return an error and add a wrapper for my use case that
warns on error and causes the function to bail.

James
