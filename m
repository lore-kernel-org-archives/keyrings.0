From: Stephan =?ISO-8859-1?Q?M=FCller?= <smueller@chronox.de>
Date: Wed, 11 Jul 2018 15:47:06 +0000
Subject: Re: [PATCH v2] crypto: DH - add public key verification test
Message-Id: <2287917.LmQDtKU9XD@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <2573864.V43BhLOfag@positron.chronox.de>
In-Reply-To: <2573864.V43BhLOfag@positron.chronox.de>
To: keyrings@vger.kernel.org

Am Mittwoch, 11. Juli 2018, 06:10:59 CEST schrieb Eric Biggers:

Hi Eric,

> You forgot to update the self-tests in the kernel, so they're failing now,
> as you *did* change the interface (the "key" is encoded differently now).

I was actually looking for failing self tests. But accidentally I disabled the 
self tests in my test bed which I just saw now. :-(

I will provide a fix shortly.

Ciao
Stephan


