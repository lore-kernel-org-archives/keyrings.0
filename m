From: Dmitry Vyukov <dvyukov@google.com>
Date: Tue, 28 Nov 2017 09:59:04 +0000
Subject: Re: x509 parsing bug + fuzzing crypto in the userspace
Message-Id: <CACT4Y+brFOoj25PcGv+d6fy6zcysXOYg3Awat5LQR+CCmFtmxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAG_fn=XJZG_MJXXgos5jZmOThKho=uSvwgfhkMSYONZ04PKKaw@mail.gmail.com>
 <1838350.iOjUKSrnbm@tauon.chronox.de> <CACT4Y+ZQfNxO+gTX3QRcMDeQW7ECpeAvv92sf-0=s_8cAD8n0g@mail.gmail.com>
 <1684405.FoYHGhiAJd@tauon.chronox.de>
In-Reply-To: <1684405.FoYHGhiAJd@tauon.chronox.de>
To: Stephan Mueller <smueller@chronox.de>
Cc: Eric Biggers <ebiggers@google.com>, Alexander Potapenko <glider@google.com>, linux-crypto@vger.kernel.org, Kostya Serebryany <kcc@google.com>, keyrings@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>

On Fri, Nov 24, 2017 at 5:31 PM, Stephan Mueller <smueller@chronox.de> wrote:
> Am Freitag, 24. November 2017, 17:25:55 CET schrieb Dmitry Vyukov:
>
> Hi Dmitry,
>
>> Eric also pointed me to grep. But I can't say the code is intuitive.
>> I've spent way more time than I expected to just get a list of all
>> algorithms with their types. Say, in some cases algorithm descriptions
>> do not specify their type, it's somehow plumbed somewhere later.
>> Getting the list at runtime allowed me to get relevant ones with
>> proper types.
>
> Hehe, getting the list of ciphers in the script I sent the other day took me a
> long time.
>
> Maybe you leave it for now and come back later for a good grepping code to
> search the sources.


First bugs uncovered by the change started popping up:
https://groups.google.com/forum/#!forum/syzkaller-bugs
More coming!
