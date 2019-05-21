From: Marcel Holtmann <marcel@holtmann.org>
Date: Tue, 21 May 2019 10:47:23 +0000
Subject: Re: [PATCH] crypto: af_alg - implement keyring support
Message-Id: <A3BC3B07-6446-4631-862A-F661FB9D63B9@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190521100034.9651-1-omosnace@redhat.com>
In-Reply-To: <20190521100034.9651-1-omosnace@redhat.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, Stephan Mueller <smueller@chronox.de>, Milan Broz <gmazyland@gmail.com>, Ondrej Kozina <okozina@redhat.com>, Daniel Zatovic <dzatovic@redhat.com>

Hi Ondrej,

> This patch adds new socket options to AF_ALG that allow setting key from
> kernel keyring. For simplicity, each keyring key type (logon, user,
> trusted, encrypted) has its own socket option name and the value is just
> the key description string that identifies the key to be used. The key
> description doesn't need to be NULL-terminated, but bytes after the
> first zero byte are ignored.

why use the description instead the actual key id? I wonder if a single socket option and a struct providing the key type and key id might be more useful.

Regards

Marcel
