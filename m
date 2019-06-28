From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Fri, 28 Jun 2019 04:19:48 +0000
Subject: Re: [PATCH] crypto: asymmetric_keys - select CRYPTO_HASH where needed
Message-Id: <20190628041948.b3nxdepx4gvoauh3@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190618121400.4016776-1-arnd@arndb.de>
In-Reply-To: <20190618121400.4016776-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Howells <dhowells@redhat.com>, "David S. Miller" <davem@davemloft.net>, Marcel Holtmann <marcel@holtmann.org>, Denis Kenzior <denkenz@gmail.com>, James Morris <james.morris@microsoft.com>, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jun 18, 2019 at 02:13:47PM +0200, Arnd Bergmann wrote:
> Build testing with some core crypto options disabled revealed
> a few modules that are missing CRYPTO_HASH:
> 
> crypto/asymmetric_keys/x509_public_key.o: In function `x509_get_sig_params':
> x509_public_key.c:(.text+0x4c7): undefined reference to `crypto_alloc_shash'
> x509_public_key.c:(.text+0x5e5): undefined reference to `crypto_shash_digest'
> crypto/asymmetric_keys/pkcs7_verify.o: In function `pkcs7_digest.isra.0':
> pkcs7_verify.c:(.text+0xab): undefined reference to `crypto_alloc_shash'
> pkcs7_verify.c:(.text+0x1b2): undefined reference to `crypto_shash_digest'
> pkcs7_verify.c:(.text+0x3c1): undefined reference to `crypto_shash_update'
> pkcs7_verify.c:(.text+0x411): undefined reference to `crypto_shash_finup'
> 
> This normally doesn't show up in randconfig tests because there is
> a large number of other options that select CRYPTO_HASH.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  crypto/asymmetric_keys/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
