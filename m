From: James Prestwood <prestwoj@gmail.com>
Date: Thu, 27 Feb 2020 00:20:38 +0000
Subject: Re: [PATCH v5 4/6] security: keys: trusted: use ASN.1 TPM2 key format for the blobs
Message-Id: <f9b64fe39eb71a1560ca2d1887238d0b4f9f111a.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200130101812.6271-1-James.Bottomley@HansenPartnership.com>
         <20200130101812.6271-5-James.Bottomley@HansenPartnership.com>
         <5c593b6f23ae41e90e6b3799141ea68944bb4034.camel@gmail.com>
         <1582761736.4245.12.camel@HansenPartnership.com>
In-Reply-To: <1582761736.4245.12.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

> > I have been using your set of patches in order to get this ASN.1
> > parser/definition. I am implementing an asymmetric key parser/type
> > TPM2
> > keys for enc/dec/sign/verify using keyctl. Note that this
> > implementation goes in crypto/asymmetric_keys/, and your patches
> > sit
> > in
> > security/keys/trusted-keys/.
> > 
> > Currently I am just including "../../security/keys/trusted-
> > keys/{tpm2key.asn1.h,tpm2-policy.h}" in order to use the ASN.1
> > parser
> > to verify my keys, but this obviously isn't going to fly.
> > 
> > Do you (or anyone) have any ideas as to how both trusted keys and
> > asymmetric keys could share this ASN.1 parser/definition? Some
> > common
> > area that both security and crypto could include? Or maybe there is
> > some common way the kernel does things like this?
> 
> Actually TPM2 asymmetric keys was also on my list.  I was going to
> use
> the existing template and simply move it somewhere everyone could
> use. 
> I also think you need the policy parser pieces because at least one
> implementation we'd need to be compatible with supports key policy.

In terms of policy, I haven't looked into that at all for asymmetric
keys. I do already have enc/dec/sign/verify asymmetric key operations
all working, and used your ASN1 template for parsing (just copied it
into asymmetric_keys for now). Since the asymmetric operations use HMAC
sessions I didn't see much carry over from your patches (but this could
change if policy stuff gets introduced).

This will go in the eventual RFC soon but while I have you here:

I also implemented key wrapping. Exposing this as a keyctl API may take
some rework, hopefully with some help from others in this subsystem. As
it stand now you have to padd a key pair, then do a (new) pkey_wrap
operation on it. This returns a DER with the wrapped TPM2 key. This
required modifying the public_key type, which I really did not like
since it now depends on TPM. Not sure if the route I went is gonna fly
without tweaking, but this is all new to me :) Again, some guidance for
how this should be is needed.

Before I send these patches I need to get some testing done on real
TPM2 hardware. So far its just been emulation. But these patches should
be coming very soon.

Thanks,
James


 

> 
> Regards,
> 
> James
> 
