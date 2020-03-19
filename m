From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Thu, 19 Mar 2020 20:07:37 +0000
Subject: Re: [PATCH v8 1/8] lib: add ASN.1 encoder
Message-Id: <1584648457.3610.42.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1584639086.3610.28.camel@HansenPartnership.com>
         <20200310051607.30334-2-James.Bottomley@HansenPartnership.com>
         <20200310051607.30334-1-James.Bottomley@HansenPartnership.com>
         <3180269.1584636439@warthog.procyon.org.uk>
         <3192644.1584645125@warthog.procyon.org.uk>
In-Reply-To: <3192644.1584645125@warthog.procyon.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Thu, 2020-03-19 at 19:12 +0000, David Howells wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > > I wonder if it's worth appending a note to the comment that if
> > > indefinite length encoding is selected, then the result is not
> > > DER-compliant and may not be CER-compliant since you're
> > > advertising BER/DER/CER.
> > 
> > We only encode definite length currently, so the comment is
> > superfluous (and probably confusing if you don't know the
> > difference between DER/BER and CER).  Let's add something like this
> > iff we ever start to use indefinite lengths in the encoder.
> 
> Your code appears to actually do indefinite length encoding if -1 is
> passed as len to asn1_encode_tag().  The kdoc says:
> 
> 	To encode in place pass a NULL @string and -1 for @len; all
> this will do is add an indefinite length tag and update the data
> pointer to the place where the tag contents should be placed.
> 
> Granted, your patches might not use it, but you're making a generic
> ASN.1 encoder library.

That was a thing the other David asked for.  But actually, I think the
comment is a lie:  the first time around we encode a definite length
for the max buffer size and on the recode we do the length for the
actual buffer size, so we never actually place an indefinite length tag
there ... I think David wanted us to, to keep the ASN.1 always legal,
but the max len thing does that too so I must have changed it without
updating the comment, I'll fix that.

James
