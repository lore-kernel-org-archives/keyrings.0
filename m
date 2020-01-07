From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 07 Jan 2020 22:06:05 +0000
Subject: Re: [PATCH] ima: make ASYMMETRIC_PUBLIC_KEY_SUBTYPE 'bool'
Message-Id: <CAK8P3a2GbfvgWep1JGNUX7c8jrtQs40PgUfq5C3d_zYuBK5nmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200107203041.843060-1-arnd@arndb.de> <1578430874.4288.2.camel@HansenPartnership.com>
In-Reply-To: <1578430874.4288.2.camel@HansenPartnership.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org, "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" <linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Jan 7, 2020 at 10:01 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2020-01-07 at 21:30 +0100, Arnd Bergmann wrote:

> >  config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> > -     tristate "Asymmetric public-key crypto algorithm subtype"
> > +     bool "Asymmetric public-key crypto algorithm subtype"
>
> I believe the crypto guys do like stuff to be modular.
>
> However, we've already implemented this solution:
>
> https://lore.kernel.org/linux-integrity/20200107194350.3782-2-nramas@linux.microsoft.com/
>
> To solve the problem via an intermediate boolean config variable.

Ok, that looks good to me.

    Arnd
