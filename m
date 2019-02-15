From: David Howells <dhowells@redhat.com>
Date: Fri, 15 Feb 2019 16:09:32 +0000
Subject: [RFC PATCH 14/27] keys: Break bits out of key_unlink()
Message-Id: <155024697274.21651.2339284853609462143.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
In-Reply-To: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org, trond.myklebust@hammerspace.com, sfrench@samba.org
Cc: linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, rgb@redhat.com, dhowells@redhat.com, linux-kernel@vger.kernel.org

Break bits out of key_unlink() into helper functions so that they can be
used in implementing key_move().

Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/keyring.c |   89 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 66 insertions(+), 23 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 062cad635edf..431094c6cd74 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1409,6 +1409,66 @@ int key_link(struct key *keyring, struct key *key)
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
+	notify_key(keyring, NOTIFY_KEY_UNLINKED, key_serial(key));
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
@@ -1429,35 +1489,18 @@ EXPORT_SYMBOL(key_link);
 int key_unlink(struct key *keyring, struct key *key)
 {
 	struct assoc_array_edit *edit;
-	key_serial_t target = key_serial(key);
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
-	notify_key(keyring, NOTIFY_KEY_UNLINKED, target);
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
 
