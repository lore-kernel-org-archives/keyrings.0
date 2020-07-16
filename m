From: Stephan Mueller <smueller@chronox.de>
Date: Thu, 16 Jul 2020 14:59:37 +0000
Subject: Re: [PATCH 0/1] crypto: af_alg - add extra parameters for DRBG interface
Message-Id: <4708215.a9HWlOh95j@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200713164857.1031117-1-lenaptr@google.com> <CABvBcwaB3RLuRWEzSoeADc4Jg28fK6mqwevaywLsZhvFgBi+BA@mail.gmail.com> <5740551.2l3rmUXbR5@tauon.chronox.de>
In-Reply-To: <5740551.2l3rmUXbR5@tauon.chronox.de>
To: Elena Petrova <lenaptr@google.com>, herbert@gondor.apana.org.au
Cc: "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, Eric Biggers <ebiggers@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>

Am Donnerstag, 16. Juli 2020, 16:49:52 CEST schrieb Stephan Mueller:

Hi Herbert,

(resent, adding Herbert to the list and fix the keyrings address)

> Am Donnerstag, 16. Juli 2020, 16:41:26 CEST schrieb Elena Petrova:
> 
> Hi Herbert,
> 
> > > > > With these issues, I would assume you are better off creating your
> > > > > own
> > > > > kernel module just like I did that externalizes the crypto API to
> > > > > user
> > > > > space but is only available on your test kernel and will not affect
> > > > > all
> > > > > other users.
> > > > 
> > > > I considered publishing my kernel driver on GitHub, but there appears
> > > > to
> > > > be
> > > > a sufficiently large number of users to justify having this
> > > > functionality
> > > > upstream.
> > > 
> > > So, I should then dust off my AF_ALG KPP and AF_ALG akcipher patches
> > > then?
> > > 
> > > :-D
> > 
> > Sure :)
> 
> Long time ago when I released the patches now found in [1] and [2] they
> where rejected as it was said, the official route to access the RSA/ECDSA
> and the DH/ECDH ciphers is through the keyring.
> 
> Obviously this interface of the keyring is not suitable for testing these
> algorithms. Considering the request that the kernel crypto API ciphers
> should be testable with arbitrary test vectors, would the dusted-off
> patches for AF_ALG KPP and akcipher be accepted?
> 
> Ciao
> Stephan
> 
> [1]
> https://github.com/smuellerDD/libkcapi/tree/master/kernel-patches/4.15-rc3/
> asym
> 
> [2]
> https://github.com/smuellerDD/libkcapi/tree/master/kernel-patches/4.15-rc3/
> kpp


Ciao
Stephan
