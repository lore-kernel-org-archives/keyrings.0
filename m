From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Thu, 27 Feb 2020 00:02:16 +0000
Subject: Re: [PATCH v5 4/6] security: keys: trusted: use ASN.1 TPM2 key format for the blobs
Message-Id: <1582761736.4245.12.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
         <20200130101812.6271-5-James.Bottomley@HansenPartnership.com>
         <5c593b6f23ae41e90e6b3799141ea68944bb4034.camel@gmail.com>
In-Reply-To: <5c593b6f23ae41e90e6b3799141ea68944bb4034.camel@gmail.com>
To: James Prestwood <prestwoj@gmail.com>, linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On Mon, 2020-02-03 at 08:54 -0800, James Prestwood wrote:
> Hi James,
> 
> <snip>
> 
> > diff --git a/security/keys/trusted-keys/tpm2key.asn1
> > b/security/keys/trusted-keys/tpm2key.asn1
> > new file mode 100644
> > index 000000000000..f930fd812db3
> > --- /dev/null
> > +++ b/security/keys/trusted-keys/tpm2key.asn1
> > @@ -0,0 +1,23 @@
> > +---
> > +--- Note: This isn't quite the definition in the standard
> > +---       However, the Linux asn.1 parser doesn't understand
> > +---       [2] EXPLICIT SEQUENCE OF OPTIONAL
> > +---       So there's an extra intermediate TPMPolicySequence
> > +---       definition to work around this
> > +
> > +TPMKey ::= SEQUENCE {
> > +	type		OBJECT IDENTIFIER ({tpmkey_type}),
> > +	emptyAuth	[0] EXPLICIT BOOLEAN OPTIONAL,
> > +	policy		[1] EXPLICIT TPMPolicySequence
> > OPTIONAL,
> > +	secret		[2] EXPLICIT OCTET STRING OPTIONAL,
> > +	parent		INTEGER ({tpmkey_parent}),
> > +	pubkey		OCTET STRING ({tpmkey_pub}),
> > +	privkey		OCTET STRING ({tpmkey_priv})
> > +	}
> > +
> > +TPMPolicySequence ::= SEQUENCE OF TPMPolicy
> > +
> > +TPMPolicy ::= SEQUENCE {
> > +	commandCode		[0] EXPLICIT INTEGER
> > ({tpmkey_code}),
> > +	commandPolicy		[1] EXPLICIT OCTET STRING
> > ({tpmkey_policy})
> > +	}
> 
> I have been using your set of patches in order to get this ASN.1
> parser/definition. I am implementing an asymmetric key parser/type
> TPM2
> keys for enc/dec/sign/verify using keyctl. Note that this
> implementation goes in crypto/asymmetric_keys/, and your patches sit
> in
> security/keys/trusted-keys/.
> 
> Currently I am just including "../../security/keys/trusted-
> keys/{tpm2key.asn1.h,tpm2-policy.h}" in order to use the ASN.1 parser
> to verify my keys, but this obviously isn't going to fly.
> 
> Do you (or anyone) have any ideas as to how both trusted keys and
> asymmetric keys could share this ASN.1 parser/definition? Some common
> area that both security and crypto could include? Or maybe there is
> some common way the kernel does things like this?

Actually TPM2 asymmetric keys was also on my list.  I was going to use
the existing template and simply move it somewhere everyone could use. 
I also think you need the policy parser pieces because at least one
implementation we'd need to be compatible with supports key policy.

Regards,

James
