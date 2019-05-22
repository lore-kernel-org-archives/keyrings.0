From: David Howells <dhowells@redhat.com>
Date: Wed, 22 May 2019 22:28:31 +0000
Subject: [PATCH 4/7] keys: Break bits out of key_unlink()
Message-Id: <155856411142.10428.16280282329908085391.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155856408314.10428.17035328117829912815.stgit@warthog.procyon.org.uk>
In-Reply-To: <155856408314.10428.17035328117829912815.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org
Cc: dhowells@redhat.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Break bits out of key_unlink() into helper functions so that they can be
used in implementing key_move().

Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/keyring.c |   86 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 21 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 5b218b270598..2cfeeeaa1ffa 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1382,6 +1382,65 @@ int key_link(struct key *keyring, struct key *key)
 }
 EXPORT_SYMBOL(key_link);
 
+/*
+ * Begin the process of unlinking a key from a keyring.
+ */
+static int __key_unlink_begin(struct key *keyring, unsigned int lock_nesting,
+			      struct key *key, struct assoc_array_edit **_edit)
+	__acquires(&keyring->sem)
+{
+	struct assoc_array_edit *edit;
+	int ret;
+
+	if (keyring->type != &key_type_keyring)
+		return -ENOTDIR;
+
+	down_write_nested(&keyring->sem, lock_nesting);
+
+	edit = assoc_array_delete(&keyring->keys, &keyring_assoc_array_ops,
+				  &key->index_key);
+	if (IS_ERR(edit)) {
+		ret = PTR_ERR(edit);
+		goto error;
+	}
+
+	if (!edit) {
+		ret = -ENOENT;
+		goto error;
+	}
+
+	*_edit = edit;
+	return 0;
+
+error:
+	up_write(&keyring->sem);
+	return ret;
+}
+
+/*
+ * Apply an unlink change.
+ */
+static void __key_unlink(struct key *keyring, struct key *key,
+			      struct assoc_array_edit **_edit)
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
@@ -1407,28 +1466,13 @@ int key_unlink(struct key *keyring, struct key *key)
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
+	ret = __key_unlink_begin(keyring, 0, key, &edit);
+	if (ret < 0)
+		return ret;
 
-error:
-	up_write(&keyring->sem);
-	return ret;
+	__key_unlink(keyring, key, &edit);
+	__key_unlink_end(keyring, key, edit);
+	return 0;
 }
 EXPORT_SYMBOL(key_unlink);
 
