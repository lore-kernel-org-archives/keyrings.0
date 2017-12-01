From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Fri, 01 Dec 2017 19:51:10 +0000
Subject: [PATCH tip/core/rcu 15/21] keyring: Remove now-redundant smp_read_barrier_depends()
Message-Id: <1512157876-24665-15-git-send-email-paulmck@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20171201195053.GA23494@linux.vnet.ibm.com>
In-Reply-To: <20171201195053.GA23494@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org

Now that the associative-array library properly heads dependency chains,
the various smp_read_barrier_depends() calls in security/keys/keyring.c
are no longer needed.  This commit therefore removes them.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: James Morris <james.l.morris@oracle.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: <keyrings@vger.kernel.org>
Cc: <linux-security-module@vger.kernel.org>
---
 security/keys/keyring.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index d0bccebbd3b5..41bcf57e96f2 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -713,7 +713,6 @@ static bool search_nested_keyrings(struct key *keyring,
 		 * doesn't contain any keyring pointers.
 		 */
 		shortcut = assoc_array_ptr_to_shortcut(ptr);
-		smp_read_barrier_depends();
 		if ((shortcut->index_key[0] & ASSOC_ARRAY_FAN_MASK) != 0)
 			goto not_this_keyring;
 
@@ -723,8 +722,6 @@ static bool search_nested_keyrings(struct key *keyring,
 	}
 
 	node = assoc_array_ptr_to_node(ptr);
-	smp_read_barrier_depends();
-
 	ptr = node->slots[0];
 	if (!assoc_array_ptr_is_meta(ptr))
 		goto begin_node;
@@ -736,7 +733,6 @@ static bool search_nested_keyrings(struct key *keyring,
 	kdebug("descend");
 	if (assoc_array_ptr_is_shortcut(ptr)) {
 		shortcut = assoc_array_ptr_to_shortcut(ptr);
-		smp_read_barrier_depends();
 		ptr = READ_ONCE(shortcut->next_node);
 		BUG_ON(!assoc_array_ptr_is_node(ptr));
 	}
@@ -744,7 +740,6 @@ static bool search_nested_keyrings(struct key *keyring,
 
 begin_node:
 	kdebug("begin_node");
-	smp_read_barrier_depends();
 	slot = 0;
 ascend_to_node:
 	/* Go through the slots in a node */
@@ -792,14 +787,12 @@ static bool search_nested_keyrings(struct key *keyring,
 
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
-- 
2.5.2

