From: David Howells <dhowells@redhat.com>
Date: Wed, 19 Jun 2019 13:19:16 +0000
Subject: [PATCH 04/10] keys: Change keyring_serialise_link_sem to a mutex [ver #3]
Message-Id: <156095035684.9363.3671722354273186694.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <156095032052.9363.8954337545422131435.stgit@warthog.procyon.org.uk>
In-Reply-To: <156095032052.9363.8954337545422131435.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org, ebiggers@kernel.org
Cc: dhowells@redhat.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Change keyring_serialise_link_sem to a mutex as it's only ever
write-locked.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/keyring.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 5b218b270598..ca6694ba1773 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -100,7 +100,7 @@ EXPORT_SYMBOL(key_type_keyring);
  * Semaphore to serialise link/link calls to prevent two link calls in parallel
  * introducing a cycle.
  */
-static DECLARE_RWSEM(keyring_serialise_link_sem);
+static DEFINE_MUTEX(keyring_serialise_link_lock);
 
 /*
  * Publish the name of a keyring so that it can be found by name (if it has
@@ -1206,7 +1206,7 @@ int __key_link_begin(struct key *keyring,
 		     const struct keyring_index_key *index_key,
 		     struct assoc_array_edit **_edit)
 	__acquires(&keyring->sem)
-	__acquires(&keyring_serialise_link_sem)
+	__acquires(&keyring_serialise_link_lock)
 {
 	struct assoc_array_edit *edit;
 	int ret;
@@ -1228,7 +1228,7 @@ int __key_link_begin(struct key *keyring,
 	/* serialise link/link calls to prevent parallel calls causing a cycle
 	 * when linking two keyring in opposite orders */
 	if (index_key->type = &key_type_keyring)
-		down_write(&keyring_serialise_link_sem);
+		mutex_lock(&keyring_serialise_link_lock);
 
 	/* Create an edit script that will insert/replace the key in the
 	 * keyring tree.
@@ -1260,7 +1260,7 @@ int __key_link_begin(struct key *keyring,
 	assoc_array_cancel_edit(edit);
 error_sem:
 	if (index_key->type = &key_type_keyring)
-		up_write(&keyring_serialise_link_sem);
+		mutex_unlock(&keyring_serialise_link_lock);
 error_krsem:
 	up_write(&keyring->sem);
 	kleave(" = %d", ret);
@@ -1307,13 +1307,13 @@ void __key_link_end(struct key *keyring,
 		    const struct keyring_index_key *index_key,
 		    struct assoc_array_edit *edit)
 	__releases(&keyring->sem)
-	__releases(&keyring_serialise_link_sem)
+	__releases(&keyring_serialise_link_lock)
 {
 	BUG_ON(index_key->type = NULL);
 	kenter("%d,%s,", keyring->serial, index_key->type->name);
 
 	if (index_key->type = &key_type_keyring)
-		up_write(&keyring_serialise_link_sem);
+		mutex_unlock(&keyring_serialise_link_lock);
 
 	if (edit) {
 		if (!edit->dead_leaf) {
