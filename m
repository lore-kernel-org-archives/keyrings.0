From: Nick Desaulniers <nick.desaulniers@gmail.com>
Date: Sun, 04 Mar 2018 06:50:37 +0000
Subject: [PATCH] certs/blacklist: fix const confusion
Message-Id: <20180304065038.28373-1-nick.desaulniers@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: dhowells@redhat.com
Cc: Andi Kleen <ak@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, Nick Desaulniers <nick.desaulniers@gmail.com>, David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org

Fixes commit 2be04df5668d ("certs/blacklist_nohashes.c: fix const confusion
in certs blacklist")

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
 certs/blacklist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/blacklist.h b/certs/blacklist.h
index 150d82da8e99..1efd6fa0dc60 100644
--- a/certs/blacklist.h
+++ b/certs/blacklist.h
@@ -1,3 +1,3 @@
 #include <linux/kernel.h>
 
-extern const char __initdata *const blacklist_hashes[];
+extern const char __initconst *const blacklist_hashes[];
-- 
2.14.1

