From: David Howells <dhowells@redhat.com>
Date: Wed, 19 Jun 2019 13:19:23 +0000
Subject: [PATCH 05/10] keys: Break bits out of key_unlink() [ver #3]
Message-Id: <156095036385.9363.921620306060848348.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <156095032052.9363.8954337545422131435.stgit@warthog.procyon.org.uk>
In-Reply-To: <156095032052.9363.8954337545422131435.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org, ebiggers@kernel.org
Cc: dhowells@redhat.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Break bits out of key_unlink() into helper functions so that they can be
used in implementing key_move().

Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/keyring.c |   88 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 67 insertions(+), 21 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index ca6694ba1773..6990c7761eaa 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1382,6 +1382,65 @@ int key_link(struct key *keyring, struct key *key)
 }
 EXPORT_SYMBOL(key_link);
 
+/*
+ * Lock a keyring for unlink.
+ */
+static int __key_unlink_lock(struct key *keyring)
+	__acquires(&keyring->sem)
+{
+	if (keyring->type != &key_type_keyring)
+		return -ENOTDIR;
+
+	down_write(&keyring->sem);
+	return 0;
+}
+
+/*
+ * Begin the process of unlinking a key from a keyring.
+ */
+static int __key_unlink_begin(struct key *keyring, struct key *key,
+			      struct assoc_array_edit **_edit)
+{
+	struct assoc_array_edit *edit;
+
+	BUG_ON(*_edit != NULL);
+	
+	edit = assoc_array_delete(&keyring->keys, &keyring_assoc_array_ops,
+				  &key->index_key);
+	if (IS_ERR(edit))
+		return PTR_ERR(edit);
+
+	if (!edit)
+		return -ENOENT;
+
+	*_edit = edit;
+	return 0;
+}
+
+/*
+ * Apply an unlink change.
+ */
+static void __key_unlink(struct key *keyring, struct key *key,
+			 struct assoc_array_edit **_edit)
+{
+	assoc_array_apply_edit(*_edit);
+	*_edit = NULL;
+	key_payload_reserve(keyring, keyring->datalen - KEYQUOTA_LINK_BYTES);
+}
+
+/*
+ * Finish unlinking a key from to a keyring.
+ */
+static void __key_unlink_end(struct key *keyring,
+			     struct key *key,
+			     struct assoc_array_edit *edit)
+	__releases(&keyring->sem)
+{
+	if (edit)
+		assoc_array_cancel_edit(edit);
+	up_write(&keyring->sem);
+}
+
 /**
  * key_unlink - Unlink the first link to a key from a keyring.
  * @keyring: The keyring to remove the link from.
@@ -1401,33 +1460,20 @@ EXPORT_SYMBOL(key_link);
  */
 int key_unlink(struct key *keyring, struct key *key)
 {
-	struct assoc_array_edit *edit;
+	struct assoc_array_edit *edit = NULL;
 	int ret;
 
 	key_check(keyring);
 	key_check(key);
 
-	if (keyring->type != &key_type_keyring)
-		return -ENOTDIR;
-
-	down_write(&keyring->sem);
-
-	edit = assoc_array_delete(&keyring->keys, &keyring_assoc_array_ops,
-				  &key->index_key);
-	if (IS_ERR(edit)) {
-		ret = PTR_ERR(edit);
-		goto error;
-	}
-	ret = -ENOENT;
-	if (edit = NULL)
-		goto error;
-
-	assoc_array_apply_edit(edit);
-	key_payload_reserve(keyring, keyring->datalen - KEYQUOTA_LINK_BYTES);
-	ret = 0;
+	ret = __key_unlink_lock(keyring);
+	if (ret < 0)
+		return ret;
 
-error:
-	up_write(&keyring->sem);
+	ret = __key_unlink_begin(keyring, key, &edit);
+	if (ret = 0)
+		__key_unlink(keyring, key, &edit);
+	__key_unlink_end(keyring, key, edit);
 	return ret;
 }
 EXPORT_SYMBOL(key_unlink);
