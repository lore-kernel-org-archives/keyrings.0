From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 30 May 2019 13:22:50 +0000
Subject: Re: [PATCH] crypto: af_alg - implement keyring support
Message-Id: <20190530132250.gsbpj3ay4ah4ojw2@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190521100034.9651-1-omosnace@redhat.com>
 <20190530071400.jpadh2fjjaqzyw6m@gondor.apana.org.au>
 <CAFqZXNt0NP090oKtF3Zsq4bvvZ7peH8YNBa-9hiqk_AAXgc0kQ@mail.gmail.com>
In-Reply-To: <CAFqZXNt0NP090oKtF3Zsq4bvvZ7peH8YNBa-9hiqk_AAXgc0kQ@mail.gmail.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, Stephan Mueller <smueller@chronox.de>, Milan Broz <gmazyland@gmail.com>, Ondrej Kozina <okozina@redhat.com>, Daniel Zatovic <dzatovic@redhat.com>

On Thu, May 30, 2019 at 01:35:06PM +0200, Ondrej Mosnacek wrote:
>
> Because libkcapi already assumes these values [1] and has code that
> uses them. Reserving will allow existing builds of libkcapi to work
> correctly once the functionality actually lands in the kernel (if that
> ever happens). Of course, it is libkcapi's fault to assume values for
> these symbols (in released code) before they are commited in the
> kernel, but it seemed easier to just add them along with this patch
> rather than creating a confusing situation.
> 
> [1] https://github.com/smuellerDD/libkcapi/blob/master/lib/internal.h#L54

OK but please just leave a gap (or a comment) rather than actually
adding these reserved symbols to the kernel.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
