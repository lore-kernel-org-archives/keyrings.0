From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 24 Nov 2017 13:49:49 +0000
Subject: Re: x509 parsing bug + fuzzing crypto in the userspace
Message-Id: <CACT4Y+Zp39AMymVXB8ZdGA1VRYwRVsouuEXdhY3nmP5oawcfEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAG_fn=XJZG_MJXXgos5jZmOThKho=uSvwgfhkMSYONZ04PKKaw@mail.gmail.com>
 <CACT4Y+ZSUWEni6SdmM5K-CsZshq77CNGdZedC0tYhcv6p=7Qvg@mail.gmail.com>
 <CACT4Y+bMAH1zK2v5XgF2Zz72ghOYAoMbef3+CjLO5HfTEfAEzg@mail.gmail.com> <3132962.8EQ63lqCxc@tauon.chronox.de>
In-Reply-To: <3132962.8EQ63lqCxc@tauon.chronox.de>
To: Stephan Mueller <smueller@chronox.de>
Cc: Eric Biggers <ebiggers@google.com>, Alexander Potapenko <glider@google.com>, linux-crypto@vger.kernel.org, Kostya Serebryany <kcc@google.com>, keyrings@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>

On Thu, Nov 23, 2017 at 1:35 PM, Stephan Mueller <smueller@chronox.de> wrote:
> Am Donnerstag, 23. November 2017, 12:34:54 CET schrieb Dmitry Vyukov:
>
> Hi Dmitry,
>
>> Btw, I've started doing some minimal improvements, did not yet sorted
>> out alg types/names, and fuzzer started scratching surface:
>>
>> WARNING: kernel stack regs has bad 'bp' value 77 Nov 23 2017 12:29:36 CET
>> general protection fault in af_alg_free_areq_sgls 54 Nov 23 2017 12:23:30
>> CET general protection fault in crypto_chacha20_crypt 100 Nov 23 2017
>> 12:29:48 CET suspicious RCU usage at ./include/trace/events/kmem.h:LINE 88
>> Nov 23 2017 12:29:15 CET
>
> This all looks strange. Where would RCU come into play with
> af_alg_free_areq_sgls?
>
> Do you have a reproducer?
>>
>> This strongly suggests that we need to dig deeper.
>
> Absolutely. That is why I started my fuzzer that turned up already quite some
> issues.

I've cooked syzkaller change that teaches it to generate more
algorithm names. Probably not idea, but much better than was before:
https://github.com/google/syzkaller/blob/ddf7b3e0655cf6dfeacfe509e477c1486d2cc7db/sys/linux/alg.go
(if you see any obvious issues there, feedback is welcome, I still did
not figure out completely difference between e.g. HASH/AHASH,
BLKCIPHER/ABLKCIPHER as most of them seem to be interchangable; this
was mostly based on try and trial approach).

All bugs with details will soon be reported by syzbot
(https://goo.gl/tpsmEJ) to kernel mailing lists with all details.

Stephan, thanks for your help!
