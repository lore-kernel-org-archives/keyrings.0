From: Mark J Cox <mjc@redhat.com>
Date: Wed, 17 Oct 2018 14:15:34 +0000
Subject: [PATCH v2] support other engines for module signing
Message-Id: <alpine.LFD.2.21.1810171514270.4574@hatman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Allow sign-file to use any available OpenSSL engine for signing
by specifying the "-e engine" option.

Signed-off-by: Mark J Cox <mjc@redhat.com>

--- sign-file.c-orig	2018-10-17 14:56:38.219217362 +0100
+++ sign-file.c	2018-10-17 15:13:28.723031723 +0100
@@ -70,7 +70,7 @@ static __attribute__((noreturn))
  void format(void)
  {
  	fprintf(stderr,
-		"Usage: scripts/sign-file [-dp] <hash algo> <key> <x509> <module> [<dest>]\n");
+		"Usage: scripts/sign-file [-dp] [-e engine] <hash algo> <key> <x509> <module> [<dest>]\n");
  	fprintf(stderr,
  		"       scripts/sign-file -s <raw sig> <hash algo> <x509> <module> [<dest>]\n");
  	exit(2);
@@ -132,17 +132,20 @@ static int pem_pw_cb(char *buf, int len,
  	return pwlen;
  }

-static EVP_PKEY *read_private_key(const char *private_key_name)
+static EVP_PKEY *read_private_key(char *engine_name, const char *private_key_name)
  {
  	EVP_PKEY *private_key;

  	if (!strncmp(private_key_name, "pkcs11:", 7)) {
+	    engine_name = "pkcs11";
+	}
+	if (engine_name) {
  		ENGINE *e;

  		ENGINE_load_builtin_engines();
  		drain_openssl_errors();
-		e = ENGINE_by_id("pkcs11");
-		ERR(!e, "Load PKCS#11 ENGINE");
+		e = ENGINE_by_id(engine_name);
+		ERR(!e, "Load %s ENGINE", engine_name);
  		if (ENGINE_init(e))
  			drain_openssl_errors();
  		else
@@ -210,7 +213,7 @@ int main(int argc, char **argv)
  {
  	struct module_signature sig_info = { .id_type = PKEY_ID_PKCS7 };
  	char *hash_algo = NULL;
-	char *private_key_name = NULL, *raw_sig_name = NULL;
+	char *private_key_name = NULL, *raw_sig_name = NULL, *engine_name = NULL;
  	char *x509_name, *module_name, *dest_name;
  	bool save_sig = false, replace_orig;
  	bool sign_only = false;
@@ -242,7 +245,7 @@ int main(int argc, char **argv)
  #endif

  	do {
-		opt = getopt(argc, argv, "sdpk");
+		opt = getopt(argc, argv, "sdpke:");
  		switch (opt) {
  		case 's': raw_sig = true; break;
  		case 'p': save_sig = true; break;
@@ -250,6 +253,7 @@ int main(int argc, char **argv)
  #ifndef USE_PKCS7
  		case 'k': use_keyid = CMS_USE_KEYID; break;
  #endif
+		case 'e': engine_name = optarg; break;
  		case -1: break;
  		default: format();
  		}
@@ -294,7 +298,7 @@ int main(int argc, char **argv)
  		/* Read the private key and the X.509 cert the PKCS#7 message
  		 * will point to.
  		 */
-		private_key = read_private_key(private_key_name);
+		private_key = read_private_key(engine_name, private_key_name);
  		x509 = read_x509(x509_name);

  		/* Digest the module data. */
