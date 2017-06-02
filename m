From: Eric Biggers <ebiggers3@gmail.com>
Date: Fri, 02 Jun 2017 17:25:01 +0000
Subject: [PATCH v2] KEYS: sanitize add_key() and keyctl() key payloads
Message-Id: <20170602172501.4853-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Before returning from add_key() or one of the keyctl() commands that
takes in a key payload, zero the temporary buffer that was allocated to
hold the key payload copied from userspace.  This may contain sensitive
key material that should not be kept around in the slab caches.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/keyctl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 94c2790f8283..ab0b337c84b4 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -132,7 +132,10 @@ SYSCALL_DEFINE5(add_key, const char __user *, _type,
 
 	key_ref_put(keyring_ref);
  error3:
-	kvfree(payload);
+	if (payload) {
+		memzero_explicit(payload, plen);
+		kvfree(payload);
+	}
  error2:
 	kfree(description);
  error:
@@ -347,7 +350,7 @@ long keyctl_update_key(key_serial_t id,
 
 	key_ref_put(key_ref);
 error2:
-	kfree(payload);
+	kzfree(payload);
 error:
 	return ret;
 }
@@ -1093,7 +1096,10 @@ long keyctl_instantiate_key_common(key_serial_t id,
 		keyctl_change_reqkey_auth(NULL);
 
 error2:
-	kvfree(payload);
+	if (payload) {
+		memzero_explicit(payload, plen);
+		kvfree(payload);
+	}
 error:
 	return ret;
 }
-- 
2.13.0

