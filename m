From: Ken Goldman <kgold@linux.ibm.com>
Date: Sun, 12 Jul 2020 21:38:16 +0000
Subject: Re: [PATCH v5 4/6] security: keys: trusted: use ASN.1 TPM2 key format for the blobs
Message-Id: <34d5fef9-1baf-83a8-3e54-5065ea96f412@linux.ibm.com>
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
 <3feaa7a3265b472bb3694045448fc44368f1fb99.camel@gmail.com>
In-Reply-To: <3feaa7a3265b472bb3694045448fc44368f1fb99.camel@gmail.com>
To: James Prestwood <prestwoj@gmail.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org

On 2/27/2020 3:57 PM, James Prestwood wrote:
> I am learning lots from this discussion, so thank you. I had assumed
> that the parent key crypto had to match the child key, RSA vs EC, but
> sounds like that is not the case. And yes, this sounds like a much
> better way to go now that I have a bit more info on it.

I know this old.  Just FYI:

The TPM WG debated this for a while, but decided that the TPM should not
enforce parent / child algorithm matching.  It's for the application to 
decide.

I also note that parent keys wrap their child keys using a symmetric
key, typically AES, not an RSA or ECC key.  The load time would be the 
same for an ECC or RSA parent, because it's not using the asymmetric
key.

This different from TPM 1.2, which always uses parent RSA wrapping.

The asymmetric key is used for:

1 - import (key backup, using externally generated keys)
2 - Salted sessions

While both are useful, they're not typically used in a
critical path.
