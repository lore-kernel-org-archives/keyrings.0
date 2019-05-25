From: Eric Biggers <ebiggers@kernel.org>
Date: Sat, 25 May 2019 03:10:29 +0000
Subject: Re: [PATCH] crypto: af_alg - implement keyring support
Message-Id: <20190525031028.GA18491@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190521100034.9651-1-omosnace@redhat.com>
In-Reply-To: <20190521100034.9651-1-omosnace@redhat.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, keyrings@vger.kernel.org, David Howells <dhowells@redhat.com>, Stephan Mueller <smueller@chronox.de>, Milan Broz <gmazyland@gmail.com>, Ondrej Kozina <okozina@redhat.com>, Daniel Zatovic <dzatovic@redhat.com>

On Tue, May 21, 2019 at 12:00:34PM +0200, Ondrej Mosnacek wrote:
> This patch adds new socket options to AF_ALG that allow setting key from
> kernel keyring. For simplicity, each keyring key type (logon, user,
> trusted, encrypted) has its own socket option name and the value is just
> the key description string that identifies the key to be used. The key
> description doesn't need to be NULL-terminated, but bytes after the
> first zero byte are ignored.
> 
> Note that this patch also adds three socket option names that are
> already defined and used in libkcapi [1], but have never been added to
> the kernel...
> 
> Tested via libkcapi with keyring patches [2] applied (user and logon key
> types only).
> 
> [1] https://github.com/smuellerDD/libkcapi
> [2] https://github.com/WOnder93/libkcapi/compare/f283458...1fb501c
> 
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>

The "interesting" thing about this is that given a key to which you have only
Search permission, you can request plaintext-ciphertext pairs with it using any
algorithm from the kernel's crypto API.  So if there are any really broken
algorithms and they happen to take the correct length key, you can effectively
read the key.  That's true even if you don't have Read permission on the key
and/or the key is of the "logon" type which doesn't have a ->read() method.

Since this is already also true for dm-crypt and maybe some other features in
the kernel, and there will be a new API for fscrypt that doesn't rely on "logon"
keys with Search access thus avoiding this problem and many others
(https://patchwork.kernel.org/cover/10951999/), I don't really care much whether
this patch is applied.  But I wonder whether this is something you've actually
considered, and what security properties you think you are achieving by using
the Linux keyrings.

- Eric
