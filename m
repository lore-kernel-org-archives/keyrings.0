From: Milan Broz <gmazyland@gmail.com>
Date: Thu, 30 May 2019 07:39:15 +0000
Subject: Re: [PATCH] crypto: af_alg - implement keyring support
Message-Id: <e492858e-a93b-cee9-b50a-e61e23ce9f90@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190521100034.9651-1-omosnace@redhat.com>
In-Reply-To: <20190521100034.9651-1-omosnace@redhat.com>
To: Ondrej Mosnacek <omosnace@redhat.com>, linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
Cc: keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, Stephan Mueller <smueller@chronox.de>, Ondrej Kozina <okozina@redhat.com>, Daniel Zatovic <dzatovic@redhat.com>

Hi,

On 21/05/2019 12:00, Ondrej Mosnacek wrote:
> This patch adds new socket options to AF_ALG that allow setting key from
> kernel keyring. For simplicity, each keyring key type (logon, user,
> trusted, encrypted) has its own socket option name and the value is just
> the key description string that identifies the key to be used. The key
> description doesn't need to be NULL-terminated, but bytes after the
> first zero byte are ignored.

There is one nasty problem with this approach (we hit the same in dmcrypt now).

These lines cause hard module dependence on trusted.ko and encrypted.ko
modules (key_type_* are exported symbols):

 +static const struct alg_keyring_type alg_keyring_type_trusted = {
 +	.key_type = &key_type_trusted,...
...
 +	.key_type = &key_type_encrypted,

I do not think this is what we actually want - the dependence should be dynamic,
the modules should be loaded per-request...

I asked David Howells, and seems kernel keyring does not have such
interface yet. (There is an internal lookup function already though.)

So until such a lookup interface is present, and the patch is ported to it,
I think this patch adds module dependency that should not be there.

Milan
