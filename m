From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Tue, 07 Jan 2020 21:01:14 +0000
Subject: Re: [PATCH] ima: make ASYMMETRIC_PUBLIC_KEY_SUBTYPE 'bool'
Message-Id: <1578430874.4288.2.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200107203041.843060-1-arnd@arndb.de>
In-Reply-To: <20200107203041.843060-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>, David Howells <dhowells@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 2020-01-07 at 21:30 +0100, Arnd Bergmann wrote:
> The asymmetric key subtype is only used by the key subsystem that
> cannot itself be a loadable module, so when
> ASYMMETRIC_PUBLIC_KEY_SUBTYPE is set to =m, it just does not get
> used. It also produces a compile-time
> warning:
> 
> WARNING: modpost: missing MODULE_LICENSE() in
> security/integrity/ima/ima_asymmetric_keys.o
> 
> Make this a 'bool' symbol to avoid both problems.
> 
> Fixes: 88e70da170e8 ("IMA: Define an IMA hook to measure keys")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  crypto/asymmetric_keys/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/crypto/asymmetric_keys/Kconfig
> b/crypto/asymmetric_keys/Kconfig
> index 1f1f004dc757..f2846293e4d5 100644
> --- a/crypto/asymmetric_keys/Kconfig
> +++ b/crypto/asymmetric_keys/Kconfig
> @@ -11,7 +11,7 @@ menuconfig ASYMMETRIC_KEY_TYPE
>  if ASYMMETRIC_KEY_TYPE
>  
>  config ASYMMETRIC_PUBLIC_KEY_SUBTYPE
> -	tristate "Asymmetric public-key crypto algorithm subtype"
> +	bool "Asymmetric public-key crypto algorithm subtype"

I believe the crypto guys do like stuff to be modular.

However, we've already implemented this solution:

https://lore.kernel.org/linux-integrity/20200107194350.3782-2-nramas@linux.microsoft.com/

To solve the problem via an intermediate boolean config variable.

James
