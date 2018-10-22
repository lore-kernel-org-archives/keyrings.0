From: Mark J Cox <mjc@redhat.com>
Date: Mon, 22 Oct 2018 13:51:21 +0000
Subject: Re: [PATCH v2 3/4] sign-file: add generic built-in engine key support
Message-Id: <alpine.LFD.2.21.1810221450450.6485@hatman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1540205215.2815.10.camel@HansenPartnership.com>
In-Reply-To: <1540205215.2815.10.camel@HansenPartnership.com>
To: keyrings@vger.kernel.org

Needs revision; OPENSSL_config() is deprecated in OpenSSL 1.1.0+

Mark

On Mon, 22 Oct 2018, James Bottomley wrote:

> The current engine code only supports a non-standard pkcs11 engine
> module.  Add code to support any standard engine key module, but leave
> the non-standard code alone because it would likely fail to function
> with the correct UI_method of collecting the password.
>
> Note that in order to use built-in engines, you have to have the
> engine included in the openssl.cnf file
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
> scripts/sign-file.c | 39 +++++++++++++++++++++++++++++++++++++--
> 1 file changed, 37 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index 49f1cf456254..de8d9bb5e657 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -28,6 +28,7 @@
> #include <openssl/pem.h>
> #include <openssl/err.h>
> #include <openssl/engine.h>
> +#include <openssl/conf.h>
>
> /*
>  * Use CMS if we have openssl-1.0.0 or newer available - otherwise we have to
> @@ -122,15 +123,29 @@ static int pem_pw_cb(char *buf, int len, int w, void *v)
> 	return pwlen;
> }
>
> +static int ui_read(UI *ui, UI_STRING *uis)
> +{
> +    if (UI_get_string_type(uis) = UIT_PROMPT) {
> +        char password[64];
> +
> +        pem_pw_cb(password, sizeof(password), 0, NULL);
> +        UI_set_result(ui, uis, password);
> +
> +        return 1;
> +    }
> +    return 0;
> +}
> +
> static EVP_PKEY *read_private_key(const char *private_key_name)
> {
> 	EVP_PKEY *private_key;
>
> +	ENGINE_load_builtin_engines();
> +	OPENSSL_config(NULL);
> +	ERR_clear_error();
> 	if (!strncmp(private_key_name, "pkcs11:", 7)) {
> 		ENGINE *e;
>
> -		ENGINE_load_builtin_engines();
> -		ERR_clear_error();
> 		e = ENGINE_by_id("pkcs11");
> 		ERR(!e, "Load PKCS#11 ENGINE");
> 		if (ENGINE_init(e))
> @@ -145,11 +160,31 @@ static EVP_PKEY *read_private_key(const char *private_key_name)
> 		ERR(!private_key, "%s", private_key_name);
> 	} else {
> 		BIO *b;
> +		ENGINE *e;
>
> 		b = BIO_new_file(private_key_name, "rb");
> 		ERR(!b, "%s", private_key_name);
> 		private_key = PEM_read_bio_PrivateKey(b, NULL, pem_pw_cb,
> 						      NULL);
> +		for (e = ENGINE_get_first(); !private_key && e != NULL;
> +		     e = ENGINE_get_next(e)) {
> +			UI_METHOD *ui;
> +
> +			if (!ENGINE_get_load_privkey_function(e))
> +				continue;
> +
> +			ui = UI_create_method("sign-file");
> +			if (!ui)
> +				continue;
> +
> +			UI_method_set_reader(ui, ui_read);
> +			private_key = ENGINE_load_private_key(e, private_key_name,
> +							      ui, NULL);
> +			UI_destroy_method(ui);
> +			if (private_key)
> +				ERR_clear_error(); /* initial key read failed */
> +		}
> +
> 		ERR(!private_key, "%s", private_key_name);
> 		BIO_free(b);
> 	}
>
