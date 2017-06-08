From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Jun 2017 13:47:34 +0000
Subject: [PATCH 02/23] security: use READ_ONCE instead of deprecated ACCESS_ONCE
Message-Id: <149692965438.11452.17954613433247309012.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
In-Reply-To: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Davidlohr Bueso <dave@stgolabs.net>

With the new standardized functions, we can replace all ACCESS_ONCE()
calls across relevant security/keyrings/.

ACCESS_ONCE() does not work reliably on non-scalar types. For example
gcc 4.6 and 4.7 might remove the volatile tag for such accesses during
the SRA (scalar replacement of aggregates) step:

https://gcc.gnu.org/bugzilla/show_bug.cgi?idX145

Update the new calls regardless of if it is a scalar type, this is
cleaner than having three alternatives.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/keyring.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 4d1678e4586f..de81793f9920 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -706,7 +706,7 @@ static bool search_nested_keyrings(struct key *keyring,
 	 * Non-keyrings avoid the leftmost branch of the root entirely (root
 	 * slots 1-15).
 	 */
-	ptr = ACCESS_ONCE(keyring->keys.root);
+	ptr = READ_ONCE(keyring->keys.root);
 	if (!ptr)
 		goto not_this_keyring;
 
@@ -720,7 +720,7 @@ static bool search_nested_keyrings(struct key *keyring,
 		if ((shortcut->index_key[0] & ASSOC_ARRAY_FAN_MASK) != 0)
 			goto not_this_keyring;
 
-		ptr = ACCESS_ONCE(shortcut->next_node);
+		ptr = READ_ONCE(shortcut->next_node);
 		node = assoc_array_ptr_to_node(ptr);
 		goto begin_node;
 	}
@@ -740,7 +740,7 @@ static bool search_nested_keyrings(struct key *keyring,
 	if (assoc_array_ptr_is_shortcut(ptr)) {
 		shortcut = assoc_array_ptr_to_shortcut(ptr);
 		smp_read_barrier_depends();
-		ptr = ACCESS_ONCE(shortcut->next_node);
+		ptr = READ_ONCE(shortcut->next_node);
 		BUG_ON(!assoc_array_ptr_is_node(ptr));
 	}
 	node = assoc_array_ptr_to_node(ptr);
@@ -752,7 +752,7 @@ static bool search_nested_keyrings(struct key *keyring,
 ascend_to_node:
 	/* Go through the slots in a node */
 	for (; slot < ASSOC_ARRAY_FAN_OUT; slot++) {
-		ptr = ACCESS_ONCE(node->slots[slot]);
+		ptr = READ_ONCE(node->slots[slot]);
 
 		if (assoc_array_ptr_is_meta(ptr) && node->back_pointer)
 			goto descend_to_node;
@@ -790,13 +790,13 @@ static bool search_nested_keyrings(struct key *keyring,
 	/* We've dealt with all the slots in the current node, so now we need
 	 * to ascend to the parent and continue processing there.
 	 */
-	ptr = ACCESS_ONCE(node->back_pointer);
+	ptr = READ_ONCE(node->back_pointer);
 	slot = node->parent_slot;
 
 	if (ptr && assoc_array_ptr_is_shortcut(ptr)) {
 		shortcut = assoc_array_ptr_to_shortcut(ptr);
 		smp_read_barrier_depends();
-		ptr = ACCESS_ONCE(shortcut->back_pointer);
+		ptr = READ_ONCE(shortcut->back_pointer);
 		slot = shortcut->parent_slot;
 	}
 	if (!ptr)

