From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Sat, 27 Oct 2018 14:10:48 +0000
Subject: Re: [PATCH v2 3/4] sign-file: add generic built-in engine key support
Message-Id: <1540649448.2896.5.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <1540205215.2815.10.camel@HansenPartnership.com>
In-Reply-To: <1540205215.2815.10.camel@HansenPartnership.com>
To: keyrings@vger.kernel.org

On Mon, 2018-10-22 at 15:08 +0100, Mark J Cox wrote:
> > On Mon, 2018-10-22 at 14:51 +0100, Mark J Cox wrote:
> > > Needs revision; OPENSSL_config() is deprecated in OpenSSL 1.1.0+
> > 
> > It's deprecated but still functional.  I have a todo to find out
> > what
> > its replacement is.
> 
> CONF_modules_load().  The patch really ought to be updated and not
> drop deprecation warnings as many OS now include OpenSSL 1.1.0+

Actually, it doesn't seem to be ... CONF_modules_load() seems to be
another API screw up.  If you look at how openssl/apps/apps.c does it,
it's a rather nasty open coding of OPENSSL_config(NULL).

It looks like the new replacement is OPENSSL_init_crypto() with a flag.
 Unfortunately this one is 1.1.0 only, so I'll have to make the whole
thing #ifdef hell.

James

---

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index ca45cfc6ca6a..2de66ced9575 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -165,10 +165,11 @@ static EVP_PKEY *read_private_key(const char *private_key_name)
 	EVP_PKEY *private_key;
 	ENGINE *e;
 
-
+#if OPENSSL_VERSION_NUMBER < 0x10100000
 	ENGINE_load_builtin_engines();
 	OPENSSL_config(NULL);
 	ERR_clear_error();
+#endif
 	if (!engine && !strncmp(private_key_name, "pkcs11:", 7))
 		engine = "pkcs11";
 
@@ -190,6 +191,7 @@ static EVP_PKEY *read_private_key(const char *private_key_name)
 						      NULL);
 		for (e = ENGINE_get_first(); !private_key && e != NULL;
 		     e = ENGINE_get_next(e)) {
+		  printf("ENGINE: %s\n", ENGINE_get_name(e));
 			private_key = read_engine_key(private_key_name, e);
 		}
 
@@ -262,9 +264,14 @@ int main(int argc, char **argv)
 	X509 *x509;
 	BIO *bd, *bm;
 	int opt, n;
+#if OPENSSL_VERSION_NUMBER < 0x10100000
 	OpenSSL_add_all_algorithms();
 	ERR_load_crypto_strings();
 	ERR_clear_error();
+#else
+	OPENSSL_init_crypto(OPENSSL_INIT_ENGINE_ALL_BUILTIN
+			    | OPENSSL_INIT_LOAD_CONFIG, NULL);
+#endif
 
 	key_pass = getenv("KBUILD_SIGN_PIN");
 
@@ -332,7 +339,9 @@ int main(int argc, char **argv)
 		x509 = read_x509(x509_name);
 
 		/* Digest the module data. */
+#if OPENSSL_VERSION_NUMBER < 0x10100000
 		OpenSSL_add_all_digests();
+#endif
 		display_openssl_errors(__FILE__, __LINE__);
 		digest_algo = EVP_get_digestbyname(hash_algo);
 		ERR(!digest_algo, "EVP_get_digestbyname");
