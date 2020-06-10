From: "Luis R. Rodriguez" <mcgrof@kernel.org>
Date: Wed, 10 Jun 2020 15:49:20 +0000
Subject: [PATCH 2/5] kmod: Remove redundant "be an" in the comment
Message-Id: <20200610154923.27510-3-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200610154923.27510-1-mcgrof@kernel.org>
In-Reply-To: <20200610154923.27510-1-mcgrof@kernel.org>
To: gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk, philipp.reisner@linbit.com, lars.ellenberg@linbit.com, axboe@kernel.dk, bfields@fieldses.org, chuck.lever@oracle.com, roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org, dhowells@redhat.com, jarkko.sakkinen@linux.intel.com, jmorris@namei.org, serge@hallyn.com, christian.brauner@ubuntu.com
Cc: slyfox@gentoo.org, ast@kernel.org, keescook@chromium.org, josh@joshtriplett.org, ravenexp@gmail.com, chainsaw@gentoo.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, bridge@lists.linux-foundation.org, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>, Luis Chamberlain <mcgrof@kernel.org>

From: Tiezhu Yang <yangtiezhu@loongson.cn>

There exists redundant "be an" in the comment, remove it.

Acked-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 kernel/kmod.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/kmod.c b/kernel/kmod.c
index 37c3c4b97b8e..3cd075ce2a1e 100644
--- a/kernel/kmod.c
+++ b/kernel/kmod.c
@@ -36,9 +36,8 @@
  *
  * If you need less than 50 threads would mean we're dealing with systems
  * smaller than 3200 pages. This assumes you are capable of having ~13M memory,
- * and this would only be an be an upper limit, after which the OOM killer
- * would take effect. Systems like these are very unlikely if modules are
- * enabled.
+ * and this would only be an upper limit, after which the OOM killer would take
+ * effect. Systems like these are very unlikely if modules are enabled.
  */
 #define MAX_KMOD_CONCURRENT 50
 static atomic_t kmod_concurrent_max = ATOMIC_INIT(MAX_KMOD_CONCURRENT);
-- 
2.26.2
