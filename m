From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 22 Nov 2017 17:03:14 +0000
Subject: Re: x509 parsing bug + fuzzing crypto in the userspace
Message-Id: <CACT4Y+YSZngVgt24DyQD1hrMyBF9uue=aGzKcWNA6CFDuCO=ug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAG_fn=XJZG_MJXXgos5jZmOThKho=uSvwgfhkMSYONZ04PKKaw@mail.gmail.com>
 <CACT4Y+b5n-G_+mjYHMzaibrMKAwXZ=SqsnK3f+Qu=uT8VN1yMQ@mail.gmail.com>
 <20171121204628.GA56006@google.com> <8790288.6NrG2qtxDg@tauon.chronox.de>
In-Reply-To: <8790288.6NrG2qtxDg@tauon.chronox.de>
To: Stephan Mueller <smueller@chronox.de>
Cc: Eric Biggers <ebiggers@google.com>, Alexander Potapenko <glider@google.com>, linux-crypto@vger.kernel.org, Kostya Serebryany <kcc@google.com>, keyrings@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>

On Wed, Nov 22, 2017 at 5:54 PM, Stephan Mueller <smueller@chronox.de> wrote:
> Am Dienstag, 21. November 2017, 21:46:28 CET schrieb Eric Biggers:
>
> Hi Eric,
>
>>
>> (There is probably more to improve for AF_ALG besides the algorithm names;
>> this is just what I happened to notice for now.)
>
> Just grepping may not cover all possibilities. Attached is a script that I use
> to invoke an array different tests for different cipher implementations. For
> now, it only covers C, ASM and CPU-based cipher implementations.

Hi Stephan,

I see it has lots of names hardcoded. Is it possible to extract
up-to-date list from kernel? Maybe at runtime from running kernel?

What's the max number of arguments for a template? I see there is at least 2:
  rfc4106(gcm_base(ctr(aes-aesni),ghash-clmulni))
can there be more?

Do you know answer to this question by any chance?
what's the relation between alg names and type ("aead", "hash", "rng",
"skcipher")? I remember I already looked at it before and could not
figure it out. Are all algorithms and templates partitioned between
types? Or they are orthogonal?

Thanks
