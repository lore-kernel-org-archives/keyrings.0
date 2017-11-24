From: Stephan Mueller <smueller@chronox.de>
Date: Fri, 24 Nov 2017 16:07:22 +0000
Subject: Re: x509 parsing bug + fuzzing crypto in the userspace
Message-Id: <17016039.XAXFsCgaqx@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAG_fn=XJZG_MJXXgos5jZmOThKho=uSvwgfhkMSYONZ04PKKaw@mail.gmail.com> <1748580.hh6WObTt7s@tauon.chronox.de> <CACT4Y+bJP=XWK=kvs03R7OV9fL1BYmGo9fw+e7N2GzQGb7wTAQ@mail.gmail.com>
In-Reply-To: <CACT4Y+bJP=XWK=kvs03R7OV9fL1BYmGo9fw+e7N2GzQGb7wTAQ@mail.gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Eric Biggers <ebiggers@google.com>, Alexander Potapenko <glider@google.com>, linux-crypto@vger.kernel.org, Kostya Serebryany <kcc@google.com>, keyrings@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>

Am Freitag, 24. November 2017, 16:53:26 CET schrieb Dmitry Vyukov:

Hi Dmitry,

> > You cannot talk to the inner ciphers. You only talk to one cipher that you
> > referred to with the name. Remember, the name is ONLY used to tell the
> > kernel which parts to put together during allocation. After the
> > allocation, you have only one cipher and interact with only one cipher of
> > the given type.
> I see. Makes sense. I guess an outer template can transitively setup
> inner algorithms if necessary.

Exactly. See crypto/gcm.c for example. This is a template to invoke a CTR and 
GHASH implementation. Thus it has no need for a key itself. Hence, a setkey 
is:

static int crypto_gcm_setkey(struct crypto_aead *aead, const u8 *key,
                             unsigned int keylen)
{
...
        err = crypto_skcipher_setkey(ctr, key, keylen);
...

Where ctr is the reference to the CTR block cipher that was allocated with 
gcm_base(...) or implicitly when using gcm(...) which internally turns into a 
gcm_base(...).


Ciao
Stephan
