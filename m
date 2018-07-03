From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Tue, 03 Jul 2018 16:12:32 +0000
Subject: Re: [PATCH] sign-file: remove open coding of ERR_clear_error()
Message-Id: <1530634352.3142.14.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

On Mon, 2018-02-12 at 08:27 -0800, James Bottomley wrote:
> drain_openssl_errors() is nothing more than an open coding of
> ERR_clear_error().  Use the correct API everywhere.

Ping on this ... it's a simple clean up and it's been four months.

James


> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com
> >
> ---
>  scripts/sign-file.c | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index 563419bc2837..49f1cf456254 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -92,16 +92,6 @@ static void display_openssl_errors(const char *f,
> int l)
>  	}
>  }
>  
> -static void drain_openssl_errors(void)
> -{
> -	const char *file;
> -	int line;
> -
> -	if (ERR_peek_error() = 0)
> -		return;
> -	while (ERR_get_error_line(&file, &line)) {}
> -}
> -
>  #define ERR(cond, fmt, ...)				\
>  	do {						\
>  		bool __cond = (cond);			\
> @@ -140,11 +130,11 @@ static EVP_PKEY *read_private_key(const char
> *private_key_name)
>  		ENGINE *e;
>  
>  		ENGINE_load_builtin_engines();
> -		drain_openssl_errors();
> +		ERR_clear_error();
>  		e = ENGINE_by_id("pkcs11");
>  		ERR(!e, "Load PKCS#11 ENGINE");
>  		if (ENGINE_init(e))
> -			drain_openssl_errors();
> +			ERR_clear_error();
>  		else
>  			ERR(1, "ENGINE_init");
>  		if (key_pass)

