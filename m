From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 12 Feb 2018 16:27:58 +0000
Subject: [PATCH] sign-file: remove open coding of ERR_clear_error()
Message-Id: <1518452878.3114.3.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

drain_openssl_errors() is nothing more than an open coding of
ERR_clear_error().  Use the correct API everywhere.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 scripts/sign-file.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index 563419bc2837..49f1cf456254 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -92,16 +92,6 @@ static void display_openssl_errors(const char *f, int l)
 	}
 }
 
-static void drain_openssl_errors(void)
-{
-	const char *file;
-	int line;
-
-	if (ERR_peek_error() = 0)
-		return;
-	while (ERR_get_error_line(&file, &line)) {}
-}
-
 #define ERR(cond, fmt, ...)				\
 	do {						\
 		bool __cond = (cond);			\
@@ -140,11 +130,11 @@ static EVP_PKEY *read_private_key(const char *private_key_name)
 		ENGINE *e;
 
 		ENGINE_load_builtin_engines();
-		drain_openssl_errors();
+		ERR_clear_error();
 		e = ENGINE_by_id("pkcs11");
 		ERR(!e, "Load PKCS#11 ENGINE");
 		if (ENGINE_init(e))
-			drain_openssl_errors();
+			ERR_clear_error();
 		else
 			ERR(1, "ENGINE_init");
 		if (key_pass)
-- 
2.12.3
