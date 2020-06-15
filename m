From: Xingxing Su <suxingxing@loongson.cn>
Date: Mon, 15 Jun 2020 03:53:40 +0000
Subject: [PATCH] certs/blacklist_hashes.c: Use __initconst for const init definition
Message-Id: <1592193220-7460-1-git-send-email-suxingxing@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: dhowells@redhat.com, dwmw2@infradead.org
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, yangtiezhu@loongson.cn, lixuefeng@loongson.cn

Fix the following checkpatch error:

ERROR: Use of const init definition must use __initconst
#4: FILE: certs/blacklist_hashes.c:4:
+const char __initdata *const blacklist_hashes[] = {

Signed-off-by: Xingxing Su <suxingxing@loongson.cn>
---
 certs/blacklist_hashes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/blacklist_hashes.c b/certs/blacklist_hashes.c
index 3448923..d5961aa 100644
--- a/certs/blacklist_hashes.c
+++ b/certs/blacklist_hashes.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "blacklist.h"
 
-const char __initdata *const blacklist_hashes[] = {
+const char __initconst *const blacklist_hashes[] = {
 #include CONFIG_SYSTEM_BLACKLIST_HASH_LIST
 	, NULL
 };
-- 
2.1.0
