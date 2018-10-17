From: Mark J Cox <mjc@redhat.com>
Date: Wed, 17 Oct 2018 10:43:22 +0000
Subject: [PATCH] support other engines for module signing
Message-Id: <alpine.LFD.2.21.1810171142300.20697@hatman>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Allow sign-file to use any available OpenSSL engine, not limited
to PKCS-11 by using "enginename:keyname" syntax.  We have to do a
special case for pkcs11 key name passing.

Signed-off-by: Mark J Cox <mjc@redhat.com>

--- sign-file.c-orig	2018-10-17 10:53:13.726064233 +0100
+++ sign-file.c	2018-10-17 11:25:29.286285382 +0100
@@ -135,24 +135,30 @@ static int pem_pw_cb(char *buf, int len,
  static EVP_PKEY *read_private_key(const char *private_key_name)
  {
  	EVP_PKEY *private_key;
+	char *enginecolon;

-	if (!strncmp(private_key_name, "pkcs11:", 7)) {
+	if ((enginecolon = strchr(private_key_name,':'))) {
  		ENGINE *e;
+		char *keyname = enginecolon+1;
+		char *enginename = strndup(private_key_name, enginecolon-private_key_name);

  		ENGINE_load_builtin_engines();
  		drain_openssl_errors();
-		e = ENGINE_by_id("pkcs11");
-		ERR(!e, "Load PKCS#11 ENGINE");
+		e = ENGINE_by_id(enginename);
+		ERR(!e, "Load ENGINE %s", enginename);
  		if (ENGINE_init(e))
  			drain_openssl_errors();
  		else
  			ERR(1, "ENGINE_init");
  		if (key_pass)
  			ERR(!ENGINE_ctrl_cmd_string(e, "PIN", key_pass, 0),
-			    "Set PKCS#11 PIN");
-		private_key = ENGINE_load_private_key(e, private_key_name,
+			    "Set ENGINE PIN");
+		/* if the engine is pkcs11: then keep that bit in keyname */
+		if (!strncmp(private_key_name, "pkcs11:", 7))
+		    keyname = (char *)private_key_name;
+		private_key = ENGINE_load_private_key(e, keyname,
  						      NULL, NULL);
-		ERR(!private_key, "%s", private_key_name);
+		ERR(!private_key, "%s", keyname);
  	} else {
  		BIO *b;
