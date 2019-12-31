From: David Howells <dhowells@redhat.com>
Date: Tue, 31 Dec 2019 15:24:48 +0000
Subject: [PATCH 1/3] keys: Fix request_key() cache
Message-Id: <157780588822.25571.7926816048227538205.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-afs@lists.infradead.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com

When the key cached by request_key() and co. is cleaned up on exit(), the
code looks in the wrong task_struct, and so clears the wrong cache.  This
leads to anomalies in key refcounting when doing, say, a kernel build on an
afs volume, that then trigger kasan to report a use-after-free when the key
is viewed in /proc/keys.

Fix this by making exit_creds() look in the passed-in task_struct rather
than in current (the task_struct cleanup code is deferred by RCU and
potentially run in another task).

Fixes: 7743c48e54ee ("keys: Cache result of request_key*() temporarily in task_struct")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 kernel/cred.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cred.c b/kernel/cred.c
index c0a4c12d38b2..56395be1c2a8 100644
--- a/kernel/cred.c
+++ b/kernel/cred.c
@@ -175,8 +175,8 @@ void exit_creds(struct task_struct *tsk)
 	put_cred(cred);
 
 #ifdef CONFIG_KEYS_REQUEST_CACHE
-	key_put(current->cached_requested_key);
-	current->cached_requested_key = NULL;
+	key_put(tsk->cached_requested_key);
+	tsk->cached_requested_key = NULL;
 #endif
 }
 
