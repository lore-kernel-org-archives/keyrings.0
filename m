From: James Prestwood <prestwoj@gmail.com>
Date: Mon, 02 Mar 2020 19:00:54 +0000
Subject: Re: [PATCH v5 4/6] security: keys: trusted: use ASN.1 TPM2 key format for the blobs
Message-Id: <0795de67c8b9fc3a22beb61a327d1a5397a978c4.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
         <20200130101812.6271-5-James.Bottomley@HansenPartnership.com>
         <5c593b6f23ae41e90e6b3799141ea68944bb4034.camel@gmail.com>
         <1582761736.4245.12.camel@HansenPartnership.com>
         <f9b64fe39eb71a1560ca2d1887238d0b4f9f111a.camel@gmail.com>
         <1582764844.4245.29.camel@HansenPartnership.com>
         <17e025e222cb6aefb5680d6cdad64a9ecf76fa97.camel@gmail.com>
         <1582834760.18538.15.camel@HansenPartnership.com>
In-Reply-To: <1582834760.18538.15.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

Hi James,

> > > 
> > > There's a related patch that introduces HMAC and encryption
> > > sessions for pretty much everything in the TPM:
> > > 
> > > 
> > 
> > 
https://lore.kernel.org/r/1568031408.6613.29.camel@HansenPartnership
> > .
> > com
> > > 
> > > I didn't resend this time around because of patch overload, and
> > > anyway, the last patch needs updating for the current policy c
> > 

You had mentioned the need for updating, but these (or at least patch
1) failed to apply to v5.5. Looks like some headers had been shifted
around since then. Could you rebase these when you get a chance? That
way I can refactor my patches to use your session stuff.

Its hard to to be completely certain but I think all I need is patch
6/12. If that could be made to be a standalone patch and not depend on
the previous sets that could work too.

Thanks,
James
