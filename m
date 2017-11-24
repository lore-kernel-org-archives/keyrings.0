From: Stephan Mueller <smueller@chronox.de>
Date: Fri, 24 Nov 2017 16:31:35 +0000
Subject: Re: x509 parsing bug + fuzzing crypto in the userspace
Message-Id: <1684405.FoYHGhiAJd@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAG_fn=XJZG_MJXXgos5jZmOThKho=uSvwgfhkMSYONZ04PKKaw@mail.gmail.com> <1838350.iOjUKSrnbm@tauon.chronox.de> <CACT4Y+ZQfNxO+gTX3QRcMDeQW7ECpeAvv92sf-0=s_8cAD8n0g@mail.gmail.com>
In-Reply-To: <CACT4Y+ZQfNxO+gTX3QRcMDeQW7ECpeAvv92sf-0=s_8cAD8n0g@mail.gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Eric Biggers <ebiggers@google.com>, Alexander Potapenko <glider@google.com>, linux-crypto@vger.kernel.org, Kostya Serebryany <kcc@google.com>, keyrings@vger.kernel.org, Andrey Konovalov <andreyknvl@google.com>

Am Freitag, 24. November 2017, 17:25:55 CET schrieb Dmitry Vyukov:

Hi Dmitry,

> Eric also pointed me to grep. But I can't say the code is intuitive.
> I've spent way more time than I expected to just get a list of all
> algorithms with their types. Say, in some cases algorithm descriptions
> do not specify their type, it's somehow plumbed somewhere later.
> Getting the list at runtime allowed me to get relevant ones with
> proper types.

Hehe, getting the list of ciphers in the script I sent the other day took me a 
long time.

Maybe you leave it for now and come back later for a good grepping code to 
search the sources.

Ciao
Stephan
