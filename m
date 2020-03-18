From: Waiman Long <longman@redhat.com>
Date: Wed, 18 Mar 2020 22:14:57 +0000
Subject: [PATCH v5 2/2] KEYS: Avoid false positive ENOMEM error on key read
Message-Id: <20200318221457.1330-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200318221457.1330-1-longman@redhat.com>
In-Reply-To: <20200318221457.1330-1-longman@redhat.com>
To: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, linux-afs@lists.infradead.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>, Waiman Long <longman@redhat.com>

By allocating a kernel buffer with a user-supplied buffer length, it
is possible that a false positive ENOMEM error may be returned because
the user-supplied length is just too large even if the system do have
enough memory to hold the actual key data.

Moreover, if the buffer length is larger than the maximum amount of
memory that can be returned by kmalloc() (2^(MAX_ORDER-1) number of
pages), a warning message will also be printed.

To reduce this possibility, we set a threshold (page size) over which we
do check the actual key length first before allocating a buffer of the
right size to hold it. The threshold is arbitrary, it is just used to
trigger a buffer length check. It does not limit the actual key length
as long as there is enough memory to satisfy the memory request.

To further avoid large buffer allocation failure due to page
fragmentation, kvmalloc() is used to allocate the buffer so that vmapped
pages can be used when there is not a large enough contiguous set of
pages available for allocation.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 security/keys/internal.h | 12 ++++++++++++
 security/keys/keyctl.c   | 41 ++++++++++++++++++++++++++++++++--------
 2 files changed, 45 insertions(+), 8 deletions(-)

diff --git a/security/keys/internal.h b/security/keys/internal.h
index ba3e2da14cef..6d0ca48ae9a5 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -16,6 +16,8 @@
 #include <linux/keyctl.h>
 #include <linux/refcount.h>
 #include <linux/compat.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
 
 struct iovec;
 
@@ -349,4 +351,14 @@ static inline void key_check(const struct key *key)
 
 #endif
 
+/*
+ * Helper function to clear and free a kvmalloc'ed memory object.
+ */
+static inline void __kvzfree(const void *addr, size_t len)
+{
+	if (addr) {
+		memset((void *)addr, 0, len);
+		kvfree(addr);
+	}
+}
 #endif /* _INTERNAL_H */
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 81f68e434b9f..07eaa46d344c 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -339,7 +339,7 @@ long keyctl_update_key(key_serial_t id,
 	payload = NULL;
 	if (plen) {
 		ret = -ENOMEM;
-		payload = kmalloc(plen, GFP_KERNEL);
+		payload = kvmalloc(plen, GFP_KERNEL);
 		if (!payload)
 			goto error;
 
@@ -360,7 +360,7 @@ long keyctl_update_key(key_serial_t id,
 
 	key_ref_put(key_ref);
 error2:
-	kzfree(payload);
+	__kvzfree(payload, plen);
 error:
 	return ret;
 }
@@ -877,13 +877,24 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 		 * transferring them to user buffer to avoid potential
 		 * deadlock involving page fault and mmap_sem.
 		 */
-		char *tmpbuf = kmalloc(buflen, GFP_KERNEL);
+		char *tmpbuf = NULL;
+		size_t tmpbuflen = buflen;
 
-		if (!tmpbuf) {
-			ret = -ENOMEM;
-			goto error2;
+		/*
+		 * To prevent memory allocation failure with an arbitrary
+		 * large user-supplied buflen, we do a key length check
+		 * before allocating a buffer of the right size to hold
+		 * key data if it exceeds a threshold (PAGE_SIZE).
+		 */
+		if (buflen <= PAGE_SIZE) {
+allocbuf:
+			tmpbuf = kvmalloc(tmpbuflen, GFP_KERNEL);
+			if (!tmpbuf) {
+				ret = -ENOMEM;
+				goto error2;
+			}
 		}
-		ret = __keyctl_read_key(key, tmpbuf, buflen);
+		ret = __keyctl_read_key(key, tmpbuf, tmpbuflen);
 
 		/*
 		 * Read methods will just return the required length
@@ -891,10 +902,24 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 		 * enough.
 		 */
 		if ((ret > 0) && (ret <= buflen)) {
+			/*
+			 * It is possible, though unlikely, that the key
+			 * changes in between the up_read->down_read period.
+			 * If the key becomes longer, we will have to
+			 * allocate a larger buffer and redo the key read
+			 * again.
+			 */
+			if (!tmpbuf || unlikely(ret > tmpbuflen)) {
+				if (unlikely(tmpbuf))
+					__kvzfree(tmpbuf, tmpbuflen);
+				tmpbuflen = ret;
+				goto allocbuf;
+			}
+
 			if (copy_to_user(buffer, tmpbuf, ret))
 				ret = -EFAULT;
 		}
-		kzfree(tmpbuf);
+		__kvzfree(tmpbuf, tmpbuflen);
 	}
 
 error2:
-- 
2.18.1
