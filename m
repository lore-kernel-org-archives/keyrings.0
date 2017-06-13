From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 13 Jun 2017 06:18:30 +0000
Subject: [PATCH] parisc: use compat_sys_keyctl()
Message-Id: <20170613061830.18013-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-parisc@vger.kernel.org
Cc: "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, keyrings@vger.kernel.org, Eric Biggers <ebiggers@google.com>

From: Eric Biggers <ebiggers@google.com>

Architectures with a compat syscall table must put compat_sys_keyctl()
in it, not sys_keyctl().  The parisc architecture was not doing this;
fix it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/parisc/kernel/syscall_table.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/kernel/syscall_table.S b/arch/parisc/kernel/syscall_table.S
index 44aeaa9c039f..6308749359e4 100644
--- a/arch/parisc/kernel/syscall_table.S
+++ b/arch/parisc/kernel/syscall_table.S
@@ -361,7 +361,7 @@
 	ENTRY_SAME(ni_syscall)	/* 263: reserved for vserver */
 	ENTRY_SAME(add_key)
 	ENTRY_SAME(request_key)		/* 265 */
-	ENTRY_SAME(keyctl)
+	ENTRY_COMP(keyctl)
 	ENTRY_SAME(ioprio_set)
 	ENTRY_SAME(ioprio_get)
 	ENTRY_SAME(inotify_init)
-- 
2.13.1

