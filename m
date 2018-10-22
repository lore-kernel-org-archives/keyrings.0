From: Mark J Cox <mjc@redhat.com>
Date: Mon, 22 Oct 2018 14:02:45 +0000
Subject: Re: [PATCH v2 4/4] sign-file: add explicit engine specification
Message-Id: <alpine.LFD.2.21.1810221500590.6485@hatman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1540205281.2815.12.camel@HansenPartnership.com>
In-Reply-To: <1540205281.2815.12.camel@HansenPartnership.com>
To: keyrings@vger.kernel.org

I've not tested PKCS11.  For the specific case of Thales/nCipher this 
works the same as my patch and therefore

Tested-by: Mark J Cox <mjc@redhat.com>

Mark

On Mon, 22 Oct 2018, James Bottomley wrote:

> This commit adds an optional -e <engine> argument to sign file.  Now
> that we have the explicit engine addition, the original pkcs11 token
> implementation can also be merged into this code (using UI methods for
> getting the key instead of the engine control command).  To keep the
> code functioning the same way (no need to specify the pkcs11 engine if
> the key file begins pkcs11:) an explicit check will set the engine to
> pkcs11 if a pkcs11 key specifier is detected.
>
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> ---
> scripts/sign-file.c | 63 ++++++++++++++++++++++++++++++-----------------------
> 1 file changed, 36 insertions(+), 27 deletions(-)
>
> diff --git a/scripts/sign-file.c b/scripts/sign-file.c
> index de8d9bb5e657..ca45cfc6ca6a 100644
> --- a/scripts/sign-file.c
> +++ b/scripts/sign-file.c
> @@ -71,7 +71,7 @@ static __attribute__((noreturn))
> void format(void)
> {
> 	fprintf(stderr,
> -		"Usage: scripts/sign-file [-dp] <hash algo> <key> <x509> <module> [<dest>]\n");
> +		"Usage: scripts/sign-file [-e engine][-dp] <hash algo> <key> <x509> <module> [<dest>]\n");
> 	fprintf(stderr,
> 		"       scripts/sign-file -s <raw sig> <hash algo> <x509> <module> [<dest>]\n");
> 	exit(2);
> @@ -103,6 +103,8 @@ static void display_openssl_errors(const char *f, int l)
> 	} while(0)
>
> static const char *key_pass;
> +static char *engine;
> +
>
> static int pem_pw_cb(char *buf, int len, int w, void *v)
> {
> @@ -136,31 +138,51 @@ static int ui_read(UI *ui, UI_STRING *uis)
>     return 0;
> }
>
> +static EVP_PKEY *read_engine_key(const char *private_key_name, ENGINE *e)
> +
> +{
> +	UI_METHOD *ui;
> +	EVP_PKEY *private_key;
> +
> +	if (!ENGINE_get_load_privkey_function(e))
> +		return NULL;
> +
> +	ui = UI_create_method("sign-file");
> +	if (!ui)
> +		return NULL;
> +
> +	UI_method_set_reader(ui, ui_read);
> +	private_key = ENGINE_load_private_key(e, private_key_name,
> +					      ui, NULL);
> +	UI_destroy_method(ui);
> +	if (private_key)
> +		ERR_clear_error(); /* initial key read failed */
> +	return private_key;
> +}
> +
> static EVP_PKEY *read_private_key(const char *private_key_name)
> {
> 	EVP_PKEY *private_key;
> +	ENGINE *e;
> +
>
> 	ENGINE_load_builtin_engines();
> 	OPENSSL_config(NULL);
> 	ERR_clear_error();
> -	if (!strncmp(private_key_name, "pkcs11:", 7)) {
> -		ENGINE *e;
> +	if (!engine && !strncmp(private_key_name, "pkcs11:", 7))
> +		engine = "pkcs11";
>
> -		e = ENGINE_by_id("pkcs11");
> -		ERR(!e, "Load PKCS#11 ENGINE");
> +	if (engine) {
> +		e = ENGINE_by_id(engine);
> +		ERR(!e, "Load %s ENGINE", engine);
> 		if (ENGINE_init(e))
> 			ERR_clear_error();
> 		else
> 			ERR(1, "ENGINE_init");
> -		if (key_pass)
> -			ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0),
> -			    "Set PKCS#11 PIN");
> -		private_key = ENGINE_load_private_key(e, private_key_name,
> -						      NULL, NULL);
> +		private_key = read_engine_key(private_key_name, e);
> 		ERR(!private_key, "%s", private_key_name);
> 	} else {
> 		BIO *b;
> -		ENGINE *e;
>
> 		b = BIO_new_file(private_key_name, "rb");
> 		ERR(!b, "%s", private_key_name);
> @@ -168,21 +190,7 @@ static EVP_PKEY *read_private_key(const char *private_key_name)
> 						      NULL);
> 		for (e = ENGINE_get_first(); !private_key && e != NULL;
> 		     e = ENGINE_get_next(e)) {
> -			UI_METHOD *ui;
> -
> -			if (!ENGINE_get_load_privkey_function(e))
> -				continue;
> -
> -			ui = UI_create_method("sign-file");
> -			if (!ui)
> -				continue;
> -
> -			UI_method_set_reader(ui, ui_read);
> -			private_key = ENGINE_load_private_key(e, private_key_name,
> -							      ui, NULL);
> -			UI_destroy_method(ui);
> -			if (private_key)
> -				ERR_clear_error(); /* initial key read failed */
> +			private_key = read_engine_key(private_key_name, e);
> 		}
>
> 		ERR(!private_key, "%s", private_key_name);
> @@ -267,7 +275,7 @@ int main(int argc, char **argv)
> #endif
>
> 	do {
> -		opt = getopt(argc, argv, "sdpk");
> +		opt = getopt(argc, argv, "sdpke:");
> 		switch (opt) {
> 		case 's': raw_sig = true; break;
> 		case 'p': save_sig = true; break;
> @@ -275,6 +283,7 @@ int main(int argc, char **argv)
> #ifndef USE_PKCS7
> 		case 'k': use_keyid = CMS_USE_KEYID; break;
> #endif
> +		case 'e': engine = optarg; break;
> 		case -1: break;
> 		default: format();
> 		}
>
