From: Andi Kleen <andi@firstfloor.org>
Date: Fri, 22 Dec 2017 00:13:35 +0000
Subject: [PATCH] Fix const confusion in certs blacklist
Message-Id: <20171222001335.1987-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

const must be marked __initconst, not __initdata.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 certs/blacklist_nohashes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/blacklist_nohashes.c b/certs/blacklist_nohashes.c
index 73fd99098ad7..753b703ef0ef 100644
--- a/certs/blacklist_nohashes.c
+++ b/certs/blacklist_nohashes.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "blacklist.h"
 
-const char __initdata *const blacklist_hashes[] = {
+const char __initconst *const blacklist_hashes[] = {
 	NULL
 };
-- 
2.15.0

