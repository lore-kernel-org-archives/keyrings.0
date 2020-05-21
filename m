From: Xu Wang <vulab@iscas.ac.cn>
Date: Thu, 21 May 2020 06:32:26 +0000
Subject: [PATCH] scrpits: Remove unneeded assignment parentheses
Message-Id: <20200521063226.7434-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: dhowells@redhat.com, dwmw2@infradead.org, keyrings@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Remove unneeded assignment parentheses.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 scripts/extract-cert.c | 2 +-
 scripts/sign-file.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/extract-cert.c b/scripts/extract-cert.c
index b071bf476fea..8005911926b8 100644
--- a/scripts/extract-cert.c
+++ b/scripts/extract-cert.c
@@ -61,7 +61,7 @@ static void drain_openssl_errors(void)
 
 #define ERR(cond, fmt, ...)				\
 	do {						\
-		bool __cond = (cond);			\
+		bool __cond = cond;			\
 		display_openssl_errors(__LINE__);	\
 		if (__cond) {				\
 			err(1, fmt, ## __VA_ARGS__);	\
diff --git a/scripts/sign-file.c b/scripts/sign-file.c
index fbd34b8e8f57..9ea08b07a0aa 100644
--- a/scripts/sign-file.c
+++ b/scripts/sign-file.c
@@ -104,7 +104,7 @@ static void drain_openssl_errors(void)
 
 #define ERR(cond, fmt, ...)				\
 	do {						\
-		bool __cond = (cond);			\
+		bool __cond = cond;			\
 		display_openssl_errors(__LINE__);	\
 		if (__cond) {				\
 			err(1, fmt, ## __VA_ARGS__);	\
-- 
2.17.1
