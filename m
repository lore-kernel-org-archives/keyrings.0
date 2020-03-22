From: Waiman Long <longman@redhat.com>
Date: Sun, 22 Mar 2020 01:11:23 +0000
Subject: [PATCH v8 0/2] KEYS: Read keys to internal buffer & then copy to userspace
Message-Id: <20200322011125.24327-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, linux-afs@lists.infradead.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>, Waiman Long <longman@redhat.com>

v8:
 - Change the do-while loop in patch 2 to a for loop to make "continue"
   work.

v7:
 - Restructure code in keyctl_read_key() to reduce nesting.
 - Restructure patch 2 to use loop instead of backward jump as suggested
   by Jarkko.

v6:
 - Make some variable name changes and revise comments as suggested by
   Jarkko. No functional change from v5.

v5:
 - Merge v4 patches 2 and 3 into 1 to avoid sparse warning. Merge some of 
   commit logs into patch 1 as well. There is no further change.

v4:
 - Remove the __user annotation from big_key_read() and user_read() in
   patch 1.
 - Add a new patch 2 to remove __user annotation from rxrpc_read().
 - Add a new patch 3 to remove __user annotation from dns_resolver_read().
 - Merge the original patches 2 and 3 into a single patch 4 and refactor
   it as suggested by Jarkko and Eric.

The current security key read methods are called with the key semaphore
held.  The methods then copy out the key data to userspace which is
subjected to page fault and may acquire the mmap semaphore. That can
result in circular lock dependency and hence a chance to get into
deadlock.

To avoid such a deadlock, an internal buffer is now allocated for getting
out the necessary data first. After releasing the key semaphore, the
key data are then copied out to userspace sidestepping the circular
lock dependency.

The keyutils test suite was run and the test passed with these patchset
applied without any falure.

Waiman Long (2):
  KEYS: Don't write out to userspace while holding key semaphore
  KEYS: Avoid false positive ENOMEM error on key read

 include/keys/big_key-type.h               |   2 +-
 include/keys/user-type.h                  |   3 +-
 include/linux/key-type.h                  |   2 +-
 net/dns_resolver/dns_key.c                |   2 +-
 net/rxrpc/key.c                           |  27 ++----
 security/keys/big_key.c                   |  11 +--
 security/keys/encrypted-keys/encrypted.c  |   7 +-
 security/keys/internal.h                  |  12 +++
 security/keys/keyctl.c                    | 103 ++++++++++++++++++----
 security/keys/keyring.c                   |   6 +-
 security/keys/request_key_auth.c          |   7 +-
 security/keys/trusted-keys/trusted_tpm1.c |  14 +--
 security/keys/user_defined.c              |   5 +-
 13 files changed, 126 insertions(+), 75 deletions(-)

Code diff from v6:

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index ded69108db0d..0062e422e0fd 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -827,26 +827,28 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 	struct key *key;
 	key_ref_t key_ref;
 	long ret;
+	char *key_data = NULL;
+	size_t key_data_len;
 
 	/* find the key first */
 	key_ref = lookup_user_key(keyid, 0, 0);
 	if (IS_ERR(key_ref)) {
 		ret = -ENOKEY;
-		goto error;
+		goto out;
 	}
 
 	key = key_ref_to_ptr(key_ref);
 
 	ret = key_read_state(key);
 	if (ret < 0)
-		goto error2; /* Negatively instantiated */
+		goto key_put_out; /* Negatively instantiated */
 
 	/* see if we can read it directly */
 	ret = key_permission(key_ref, KEY_NEED_READ);
 	if (ret = 0)
 		goto can_read_key;
 	if (ret != -EACCES)
-		goto error2;
+		goto key_put_out;
 
 	/* we can't; see if it's searchable from this process's keyrings
 	 * - we automatically take account of the fact that it may be
@@ -854,75 +856,78 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 	 */
 	if (!is_key_possessed(key_ref)) {
 		ret = -EACCES;
-		goto error2;
+		goto key_put_out;
 	}
 
 	/* the key is probably readable - now try to read it */
 can_read_key:
 	if (!key->type->read) {
 		ret = -EOPNOTSUPP;
-		goto error2;
+		goto key_put_out;
 	}
 
 	if (!buffer || !buflen) {
 		/* Get the key length from the read method */
 		ret = __keyctl_read_key(key, NULL, 0);
-	} else {
-
-		/*
-		 * Read the data with the semaphore held (since we might sleep)
-		 * to protect against the key being updated or revoked.
-		 *
-		 * Allocating a temporary buffer to hold the keys before
-		 * transferring them to user buffer to avoid potential
-		 * deadlock involving page fault and mmap_sem.
-		 */
-		char *key_data = NULL;
-		size_t key_data_len = buflen;
+		goto key_put_out;
+	}
 
-		/*
-		 * When the user-supplied key length is larger than
-		 * PAGE_SIZE, we get the actual key length first before
-		 * allocating a right-sized key data buffer.
-		 */
-		if (buflen <= PAGE_SIZE) {
-allocbuf:
+	/*
+	 * Read the data with the semaphore held (since we might sleep)
+	 * to protect against the key being updated or revoked.
+	 *
+	 * Allocating a temporary buffer to hold the keys before
+	 * transferring them to user buffer to avoid potential
+	 * deadlock involving page fault and mmap_sem.
+	 *
+	 * key_data_len = (buflen <= PAGE_SIZE)
+	 *		? buflen : actual length of key data
+	 *
+	 * This prevents allocating arbitrary large buffer which can
+	 * be much larger than the actual key length. In the latter case,
+	 * at least 2 passes of this loop is required.
+	 */
+	key_data_len = (buflen <= PAGE_SIZE) ? buflen : 0;
+	for (;;) {
+		if (key_data_len) {
 			key_data = kvmalloc(key_data_len, GFP_KERNEL);
 			if (!key_data) {
 				ret = -ENOMEM;
-				goto error2;
+				goto key_put_out;
 			}
 		}
+
 		ret = __keyctl_read_key(key, key_data, key_data_len);
 
 		/*
-		 * Read methods will just return the required length
-		 * without any copying if the provided length isn't big
-		 * enough.
+		 * Read methods will just return the required length without
+		 * any copying if the provided length isn't large enough.
 		 */
-		if (ret > 0 && ret <= buflen) {
-			/*
-			 * The key may change (unlikely) in between 2
-			 * consecutive __keyctl_read_key() calls. We will
-			 * need to allocate a larger buffer and redo the key
-			 * read when key_data_len < ret <= buflen.
-			 */
-			if (!key_data || unlikely(ret > key_data_len)) {
-				if (unlikely(key_data))
-					__kvzfree(key_data, key_data_len);
-				key_data_len = ret;
-				goto allocbuf;
-			}
+		if (ret <= 0 || ret > buflen)
+			break;
 
-			if (copy_to_user(buffer, key_data, ret))
-				ret = -EFAULT;
+		/*
+		 * The key may change (unlikely) in between 2 consecutive
+		 * __keyctl_read_key() calls. In this case, we reallocate
+		 * a larger buffer and redo the key read when
+		 * key_data_len < ret <= buflen.
+		 */
+		if (ret > key_data_len) {
+			if (unlikely(key_data))
+				__kvzfree(key_data, key_data_len);
+			key_data_len = ret;
+			continue;	/* Allocate buffer */
 		}
-		__kvzfree(key_data, key_data_len);
+
+		if (copy_to_user(buffer, key_data, ret))
+			ret = -EFAULT;
+		break;
 	}
+	__kvzfree(key_data, key_data_len);
 
-error2:
+key_put_out:
 	key_put(key);
-error:
+out:
 	return ret;
 }

-- 
2.18.1
