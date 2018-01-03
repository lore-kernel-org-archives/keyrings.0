From: "tip-bot for Paul E. McKenney" <tipbot@zytor.com>
Date: Wed, 03 Jan 2018 16:05:45 +0000
Subject: [tip:core/rcu] keyring: Remove now-redundant smp_read_barrier_depends()
Message-Id: <tip-d963007c7210deebef48c5e57aa4ca4cf9c059cd@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

Commit-ID:  d963007c7210deebef48c5e57aa4ca4cf9c059cd
Gitweb:     https://git.kernel.org/tip/d963007c7210deebef48c5e57aa4ca4cf9c059cd
Author:     Paul E. McKenney <paulmck@linux.vnet.ibm.com>
AuthorDate: Mon, 9 Oct 2017 12:19:27 -0700
Committer:  Paul E. McKenney <paulmck@linux.vnet.ibm.com>
CommitDate: Mon, 4 Dec 2017 10:53:14 -0800

keyring: Remove now-redundant smp_read_barrier_depends()

Now that the associative-array library properly heads dependency chains,
the various smp_read_barrier_depends() calls in security/keys/keyring.c
are no longer needed.  This commit therefore removes them.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: <keyrings@vger.kernel.org>
Cc: <linux-security-module@vger.kernel.org>
Reviewed-by: James Morris <james.l.morris@oracle.com>
---
 security/keys/keyring.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index d0bcceb..41bcf57 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -713,7 +713,6 @@ descend_to_keyring:
 		 * doesn't contain any keyring pointers.
 		 */
 		shortcut = assoc_array_ptr_to_shortcut(ptr);
-		smp_read_barrier_depends();
 		if ((shortcut->index_key[0] & ASSOC_ARRAY_FAN_MASK) != 0)
 			goto not_this_keyring;
 
@@ -723,8 +722,6 @@ descend_to_keyring:
 	}
 
 	node = assoc_array_ptr_to_node(ptr);
-	smp_read_barrier_depends();
-
 	ptr = node->slots[0];
 	if (!assoc_array_ptr_is_meta(ptr))
 		goto begin_node;
@@ -736,7 +733,6 @@ descend_to_node:
 	kdebug("descend");
 	if (assoc_array_ptr_is_shortcut(ptr)) {
 		shortcut = assoc_array_ptr_to_shortcut(ptr);
-		smp_read_barrier_depends();
 		ptr = READ_ONCE(shortcut->next_node);
 		BUG_ON(!assoc_array_ptr_is_node(ptr));
 	}
@@ -744,7 +740,6 @@ descend_to_node:
 
 begin_node:
 	kdebug("begin_node");
-	smp_read_barrier_depends();
 	slot = 0;
 ascend_to_node:
 	/* Go through the slots in a node */
@@ -792,14 +787,12 @@ ascend_to_node:
 
 	if (ptr && assoc_array_ptr_is_shortcut(ptr)) {
 		shortcut = assoc_array_ptr_to_shortcut(ptr);
-		smp_read_barrier_depends();
 		ptr = READ_ONCE(shortcut->back_pointer);
 		slot = shortcut->parent_slot;
 	}
 	if (!ptr)
 		goto not_this_keyring;
 	node = assoc_array_ptr_to_node(ptr);
-	smp_read_barrier_depends();
 	slot++;
 
 	/* If we've ascended to the root (zero backpointer), we must have just
