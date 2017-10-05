From: "Serge E. Hallyn" <serge@hallyn.com>
Date: Thu, 05 Oct 2017 15:39:14 +0000
Subject: Re: [PATCH] security/keys: BIG_KEY requires CONFIG_CRYPTO
Message-Id: <20171005153914.GA19269@mail.hallyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171004102722.1834761-1-arnd@arndb.de>
In-Reply-To: <20171004102722.1834761-1-arnd@arndb.de>
To: linux-security-module@vger.kernel.org

Quoting Arnd Bergmann (arnd@arndb.de):
> The recent rework introduced a possible randconfig build failure
> when CONFIG_CRYPTO configured to only allow modules:
> 
> security/keys/big_key.o: In function `big_key_crypt':
> big_key.c:(.text+0x29f): undefined reference to `crypto_aead_setkey'
> security/keys/big_key.o: In function `big_key_init':
> big_key.c:(.init.text+0x1a): undefined reference to `crypto_alloc_aead'
> big_key.c:(.init.text+0x45): undefined reference to `crypto_aead_setauthsize'
> big_key.c:(.init.text+0x77): undefined reference to `crypto_destroy_tfm'
> crypto/gcm.o: In function `gcm_hash_crypt_remain_continue':
> gcm.c:(.text+0x167): undefined reference to `crypto_ahash_finup'
> crypto/gcm.o: In function `crypto_gcm_exit_tfm':
> gcm.c:(.text+0x847): undefined reference to `crypto_destroy_tfm'
> 
> When we 'select CRYPTO' like the other users, we always get a
> configuration that builds.
> 
> Fixes: 428490e38b2e ("security/keys: rewrite all of big_key crypto")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Seems sensible, thanks.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
>  security/keys/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/security/keys/Kconfig b/security/keys/Kconfig
> index 91eafada3164..6462e6654ccf 100644
> --- a/security/keys/Kconfig
> +++ b/security/keys/Kconfig
> @@ -45,6 +45,7 @@ config BIG_KEYS
>  	bool "Large payload keys"
>  	depends on KEYS
>  	depends on TMPFS
> +	select CRYPTO
>  	select CRYPTO_AES
>  	select CRYPTO_GCM
>  	help
> -- 
> 2.9.0
