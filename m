From: Yihao Wu <wuyihao@linux.alibaba.com>
Date: Sun, 01 Sep 2019 10:34:51 +0000
Subject: [PATCH 2/2 v2] sign-file: detect existing signature and handle it
Message-Id: <a1a7ed84-972b-2630-952f-d5abe96c1d84@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

With -f option, we can delete signature of a module before signing it
again. Without -f option, sign-file forbids us from signing again. Also,
when -d/-p is specified, the p7s file will be the signature of just the
kernel module itself, instead of the module plus the old signature.

Signed-off-by: Yihao Wu <wuyihao@linux.alibaba.com>
---
v1->v2: Replace the assistant temp ~raw~ file to a BIO_s_mem

 scripts/sign-file.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index bb8fff025a95..bf5d821db36b 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -20,6 +20,7 @@
 #include <stdbool.h>
 #include <string.h>
 #include <getopt.h>
+#include <unistd.h>
 #include <err.h>
 #include <arpa/inet.h>
 #include <openssl/opensslv.h>
@@ -282,11 +283,15 @@ int main(int argc, char **argv)
 	char *hash_algo = NULL;
 	char *private_key_name = NULL, *raw_sig_name = NULL;
 	char *x509_name, *module_name, *dest_name;
+	char *mem_buf;
+	long mem_buf_len;
 	bool save_sig = false, replace_orig;
 	bool sign_only = false;
 	bool raw_sig = false;
+	bool overwrite_sig = false;
+	bool has_sig = false;
 	unsigned char buf[4096];
-	unsigned long module_size, sig_size;
+	unsigned long module_size, sig_size, left;
 	unsigned int use_signed_attrs;
 	const EVP_MD *digest_algo;
 	EVP_PKEY *private_key;
@@ -297,7 +302,7 @@ int main(int argc, char **argv)
 	PKCS7 *pkcs7 = NULL;
 #endif
 	X509 *x509;
-	BIO *bd, *bm;
+	BIO *bd, *bm, *br;
 	int opt, n;
 	OpenSSL_add_all_algorithms();
 	ERR_load_crypto_strings();
@@ -312,7 +317,7 @@ int main(int argc, char **argv)
 #endif
 
 	do {
-		opt = getopt(argc, argv, "sdpk");
+		opt = getopt(argc, argv, "sdpkf");
 		switch (opt) {
 		case 's': raw_sig = true; break;
 		case 'p': save_sig = true; break;
@@ -320,6 +325,7 @@ int main(int argc, char **argv)
 #ifndef USE_PKCS7
 		case 'k': use_keyid = CMS_USE_KEYID; break;
 #endif
+		case 'f': overwrite_sig = true; break;
 		case -1: break;
 		default: format();
 		}
@@ -355,11 +361,35 @@ int main(int argc, char **argv)
 		exit(3);
 	}
 #endif
+	has_sig = check_module_sig(module_name, &module_size);
 
 	/* Open the module file */
 	bm = BIO_new_file(module_name, "rb");
 	ERR(!bm, "%s", module_name);
 
+	/* Read the raw kernel module into a memory BIO */
+	br = BIO_new(BIO_s_mem());
+	ERR(!br, "%s", "BIO_s_mem");
+
+	left = module_size;
+	while ((n = BIO_read(bm, buf, sizeof(buf) < left ?
+				      sizeof(buf) : left)),
+	       n > 0) {
+		ERR(BIO_write(br, buf, n) < 0, "%s", dest_name);
+		left -= n;
+	}
+	BIO_free(bm);
+	ERR(n < 0, "%s", module_name);
+
+	/* Convert raw module BIO to a read-only one.
+	 * So that we can read it twice from the start
+	 */
+	mem_buf_len = BIO_get_mem_data(br, &mem_buf);
+	bm = BIO_new_mem_buf(mem_buf, mem_buf_len);
+	ERR(!bm, "%s", module_name);
+	BIO_set_close(br, BIO_NOCLOSE);
+	BIO_free(br);
+
 	if (!raw_sig) {
 		/* Read the private key and the X.509 cert the PKCS#7 message
 		 * will point to.
@@ -419,6 +449,11 @@ int main(int argc, char **argv)
 		}
 	}
 
+	if (has_sig && !overwrite_sig) {
+		fprintf(stderr, "Signature exists, use -f to overwrite.\n");
+		exit(1);
+	}
+
 	/* Open the destination file now so that we can shovel the module data
 	 * across as we read it.
 	 */
@@ -433,7 +468,6 @@ int main(int argc, char **argv)
 	}
 	BIO_free(bm);
 	ERR(n < 0, "%s", module_name);
-	module_size = BIO_number_written(bd);
 
 	if (!raw_sig) {
 #ifndef USE_PKCS7
-- 
2.21.0
