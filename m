From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 18 Sep 2017 18:38:29 +0000
Subject: [PATCH] KEYS: restrict /proc/keys by credentials at open time
Message-Id: <20170918183829.114384-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Michael Halcrow <mhalcrow@google.com>, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>

From: Eric Biggers <ebiggers@google.com>

When checking for permission to view keys whilst reading from
/proc/keys, we should use the credentials with which the /proc/keys file
was opened.  This is because, in a classic type of exploit, it can be
possible to bypass checks for the *current* credentials by passing the
file descriptor to a suid program.

Following commit 34dbbcdbf633 ("Make file credentials available to the
seqfile interfaces") we can finally fix it.  So let's do it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/proc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/security/keys/proc.c b/security/keys/proc.c
index bf08d02b6646..de834309d100 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -187,7 +187,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
 	struct keyring_search_context ctx = {
 		.index_key.type		= key->type,
 		.index_key.description	= key->description,
-		.cred			= current_cred(),
+		.cred			= m->file->f_cred,
 		.match_data.cmp		= lookup_user_key_possessed,
 		.match_data.raw_data	= key,
 		.match_data.lookup_type	= KEYRING_SEARCH_LOOKUP_DIRECT,
@@ -207,11 +207,7 @@ static int proc_keys_show(struct seq_file *m, void *v)
 		}
 	}
 
-	/* check whether the current task is allowed to view the key (assuming
-	 * non-possession)
-	 * - the caller holds a spinlock, and thus the RCU read lock, making our
-	 *   access to __current_cred() safe
-	 */
+	/* check whether the current task is allowed to view the key */
 	rc = key_task_permission(key_ref, ctx.cred, KEY_NEED_VIEW);
 	if (rc < 0)
 		return 0;
-- 
2.14.1.690.gbb1197296e-goog

