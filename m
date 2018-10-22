From: ndesaulniers@google.com
Date: Mon, 22 Oct 2018 23:43:57 +0000
Subject: [PATCH v2] [PATCH] KEYS: trusted: fix -Wvarags warning
Message-Id: <20181022234357.82217-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <0147a993d4a94426afa469a8dcc4e5d7@AcuMS.aculab.com>
In-Reply-To: <0147a993d4a94426afa469a8dcc4e5d7@AcuMS.aculab.com>
To: dhowells@redhat.com, jejb@linux.vnet.ibm.com
Cc: natechancellor@gmail.com, David.Laight@aculab.com, denkenz@gmail.com, Nick Desaulniers <ndesaulniers@google.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Mimi Zohar <zohar@linux.vnet.ibm.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org

Fixes the warning reported by Clang:
security/keys/trusted.c:146:17: warning: passing an object that
undergoes default
      argument promotion to 'va_start' has undefined behavior [-Wvarargs]
        va_start(argp, h3);
                       ^
security/keys/trusted.c:126:37: note: parameter of type 'unsigned
char' is declared here
unsigned char *h2, unsigned char h3, ...)
                               ^
Specifically, it seems that both the C90 (4.8.1.1) and C11 (7.16.1.4)
standards explicitly call this out as undefined behavior:

The parameter parmN is the identifier of the rightmost parameter in
the variable parameter list in the function definition (the one just
before the ...). If the parameter parmN is declared with ... or with a
type that is not compatible with the type that results after
application of the default argument promotions, the behavior is
undefined.

Link: https://github.com/ClangBuiltLinux/linux/issues/41
Link: https://www.eskimo.com/~scs/cclass/int/sx11c.html
Suggested-by: David Laight <David.Laight@aculab.com>
Suggested-by: Denis Kenzior <denkenz@gmail.com>
Suggested-by: James Bottomley <jejb@linux.vnet.ibm.com>
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
v1 -> v2:
* Don't reorder args, just use default function promotion type
of unsigned int.
* Add !! boolean cast as per Denis in
https://lkml.org/lkml/2018/10/12/838.
* Tested with gcc-8 and clang-8.

 include/keys/trusted.h  | 2 +-
 security/keys/trusted.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/keys/trusted.h b/include/keys/trusted.h
index adbcb6817826..0071298b9b28 100644
--- a/include/keys/trusted.h
+++ b/include/keys/trusted.h
@@ -38,7 +38,7 @@ enum {
 
 int TSS_authhmac(unsigned char *digest, const unsigned char *key,
 			unsigned int keylen, unsigned char *h1,
-			unsigned char *h2, unsigned char h3, ...);
+			unsigned char *h2, unsigned int h3, ...);
 int TSS_checkhmac1(unsigned char *buffer,
 			  const uint32_t command,
 			  const unsigned char *ononce,
diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index ff6789365a12..335ce6d1cf6b 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -123,7 +123,7 @@ static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
  */
 int TSS_authhmac(unsigned char *digest, const unsigned char *key,
 			unsigned int keylen, unsigned char *h1,
-			unsigned char *h2, unsigned char h3, ...)
+			unsigned char *h2, unsigned int h3, ...)
 {
 	unsigned char paramdigest[SHA1_DIGEST_SIZE];
 	struct sdesc *sdesc;
@@ -139,7 +139,7 @@ int TSS_authhmac(unsigned char *digest, const unsigned char *key,
 		return PTR_ERR(sdesc);
 	}
 
-	c = h3;
+	c = !!h3;
 	ret = crypto_shash_init(&sdesc->shash);
 	if (ret < 0)
 		goto out;
-- 
2.19.1.568.g152ad8e336-goog
