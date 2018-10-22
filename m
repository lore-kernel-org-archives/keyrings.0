From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 22 Oct 2018 10:44:59 +0000
Subject: [PATCH v2 1/4] sign-file: stop referring to the code as main.c
Message-Id: <1540205099.2815.8.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

All errors in sign-file print out a line number in main.c.  Fix this
by using the proper __FILE__ designation.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
---
 scripts/sign-file.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index fbd34b8e8f57..563419bc2837 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -76,7 +76,7 @@ void format(void)
 	exit(2);
 }
 
-static void display_openssl_errors(int l)
+static void display_openssl_errors(const char *f, int l)
 {
 	const char *file;
 	char buf[120];
@@ -84,7 +84,7 @@ static void display_openssl_errors(int l)
 
 	if (ERR_peek_error() = 0)
 		return;
-	fprintf(stderr, "At main.c:%d:\n", l);
+	fprintf(stderr, "At %s:%d:\n", f, l);
 
 	while ((e = ERR_get_error_line(&file, &line))) {
 		ERR_error_string(e, buf);
@@ -105,7 +105,7 @@ static void drain_openssl_errors(void)
 #define ERR(cond, fmt, ...)				\
 	do {						\
 		bool __cond = (cond);			\
-		display_openssl_errors(__LINE__);	\
+		display_openssl_errors(__FILE__, __LINE__);\
 		if (__cond) {				\
 			err(1, fmt, ## __VA_ARGS__);	\
 		}					\
@@ -299,7 +299,7 @@ int main(int argc, char **argv)
 
 		/* Digest the module data. */
 		OpenSSL_add_all_digests();
-		display_openssl_errors(__LINE__);
+		display_openssl_errors(__FILE__, __LINE__);
 		digest_algo = EVP_get_digestbyname(hash_algo);
 		ERR(!digest_algo, "EVP_get_digestbyname");
 
-- 
2.16.4
