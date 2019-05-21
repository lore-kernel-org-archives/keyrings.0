From: David Howells <dhowells@redhat.com>
Date: Tue, 21 May 2019 21:18:29 +0000
Subject: Re: [PATCH] crypto: af_alg - implement keyring support
Message-Id: <29983.1558473509@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <A3BC3B07-6446-4631-862A-F661FB9D63B9@holtmann.org> <20190521100034.9651-1-omosnace@redhat.com>
In-Reply-To: <A3BC3B07-6446-4631-862A-F661FB9D63B9@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: dhowells@redhat.com, Ondrej Mosnacek <omosnace@redhat.com>, linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, keyrings@vger.kernel.org, Stephan Mueller <smueller@chronox.de>, Milan Broz <gmazyland@gmail.com>, Ondrej Kozina <okozina@redhat.com>, Daniel Zatovic <dzatovic@redhat.com>

Marcel Holtmann <marcel@holtmann.org> wrote:

> why use the description instead the actual key id? I wonder if a single
> socket option and a struct providing the key type and key id might be more
> useful.

If the key becomes invalid in some way, you can call request_key() again if
you have the description to get a new key.  This is how afs and af_rxrpc do
things on the client side.

David
