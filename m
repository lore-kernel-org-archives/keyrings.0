From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 29 Jul 2020 03:18:45 +0000
Subject: [PATCH] extract-cert: add static to local data
Message-Id: <20200729031845.38333-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

Fix the following warning from sparse:

  scripts/extract-cert.c:74:5: warning: symbol 'kbuild_verbose' was not declared. Should it be static?

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/extract-cert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/extract-cert.c b/scripts/extract-cert.c
index b071bf476fea..3bc48c726c41 100644
--- a/scripts/extract-cert.c
+++ b/scripts/extract-cert.c
@@ -71,7 +71,7 @@ static void drain_openssl_errors(void)
 static const char *key_pass;
 static BIO *wb;
 static char *cert_dst;
-int kbuild_verbose;
+static int kbuild_verbose;
 
 static void write_cert(X509 *x509)
 {
-- 
2.25.1
