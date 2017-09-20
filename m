From: Stephan Mueller <smueller@chronox.de>
Date: Wed, 20 Sep 2017 14:06:48 +0000
Subject: Re: [PATCH v6] security/keys: rewrite all of big_key crypto
Message-Id: <1882458.VgLOd8kIdz@tauon.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHmME9rjrz2Pn39ay3myApBeBtQAPNt0C+NvmFoV28NeT4_zLg@mail.gmail.com> <2545404.XUVGGHhd0i@tauon.chronox.de> <CAHmME9pLF7cdm3RuOa-k8knsikNwU-5BVsnoHNEYw-xpuhW0tg@mail.gmail.com>
In-Reply-To: <CAHmME9pLF7cdm3RuOa-k8knsikNwU-5BVsnoHNEYw-xpuhW0tg@mail.gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, kernel-hardening@lists.openwall.com, LKML <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers3@gmail.com>, Herbert Xu <herbert@gondor.apana.org.au>, Kirill Marinushkin <k.marinushkin@gmail.com>, security@kernel.org, stable@vger.kernel.org

Am Mittwoch, 20. September 2017, 16:01:21 CEST schrieb Jason A. Donenfeld:

Hi Jason,

> 
> Section 3 shows an attack with repeated nonces, which we don't do here.

Maybe I miss a point here, but zero IVs is no repetition of nonces?


Ciao
Stephan
