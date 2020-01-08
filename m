From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Wed, 08 Jan 2020 16:19:52 +0000
Subject: Re: [PATCH v4 3/9] security: keys: trusted fix tpm2 authorizations
Message-Id: <cf4a3681f3559ae73a97d10625c0535858a3c01e.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20191230173802.8731-1-James.Bottomley@HansenPartnership.com>
         <20191230173802.8731-4-James.Bottomley@HansenPartnership.com>
         <c03eb4a8aa3627f58bc45bbc23a4dcd660dc6e2f.camel@linux.intel.com>
         <1578359313.3251.28.camel@HansenPartnership.com>
In-Reply-To: <1578359313.3251.28.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Mon, 2020-01-06 at 17:08 -0800, James Bottomley wrote:
> > Even if for good reasons, you should be explicit when you make an API
> > change that is not backwards compatible.
> 
> This change should be backwards compatible.  I've got a set of TPMs,
> one of which works both before and after and another which doesn't work
> before but does after, so all it does is increase the set of TPMs that
> work with the authorizations i.e. if the TPM worked before, it
> continues to work after.
> 
> I think what happens in the TPMs that work before is that they
> explicily remove trailing zeros and ones that don't work before don't. 
> 
> Actually, the before form (20 hex bytes) still works in the after case
> ... I'll make that clear in the commit message.

OK, got it, thanks! Yeah, obviously would not hurt to be bit more
explicit.

/Jarkko
