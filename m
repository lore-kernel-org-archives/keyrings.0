From: Waiman Long <longman@redhat.com>
Date: Fri, 13 Mar 2020 15:21:02 +0000
Subject: [PATCH v3 3/3] KEYS: Use kvmalloc() to better handle large buffer allocation
Message-Id: <20200313152102.1707-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200313152102.1707-1-longman@redhat.com>
In-Reply-To: <20200313152102.1707-1-longman@redhat.com>
To: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>, Waiman Long <longman@redhat.com>

For large multi-page temporary buffer allocation, the security/keys
subsystem don't need contiguous physical pages. It will work perfectly
fine with virtually mapped pages.

Replace the kmalloc() call by kvmalloc() and provide a __kvzfree()
helper function to clear and free the kvmalloc'ed buffer. This will
reduce the chance of memory allocation failure just because of highly
fragmented pages.

Suggested-by: David Howells <dhowells@redhat.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 security/keys/internal.h | 14 ++++++++++++++
 security/keys/keyctl.c   | 10 +++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/security/keys/internal.h b/security/keys/internal.h
index ba3e2da14cef..855b11eb73ee 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -16,6 +16,8 @@
 #include <linux/keyctl.h>
 #include <linux/refcount.h>
 #include <linux/compat.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
 
 struct iovec;
 
@@ -349,4 +351,16 @@ static inline void key_check(const struct key *key)
 
 #endif
 
+/*
+ * Helper function to clear and free a kvmalloc'ed memory object.
+ */
+static inline void __kvzfree(const void *addr, size_t len)
+{
+	if (is_vmalloc_addr(addr)) {
+		memset((void *)addr, 0, len);
+		vfree(addr);
+	} else {
+		kzfree(addr);
+	}
+}
 #endif /* _INTERNAL_H */
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index a05a4dd2f9ce..878259cf35d5 100644
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
@@ -893,7 +893,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 		 */
 		if (buflen <= 0x400) {
 allocbuf:
-			tmpbuf = kmalloc(tmpbuflen, GFP_KERNEL);
+			tmpbuf = kvmalloc(tmpbuflen, GFP_KERNEL);
 			if (!tmpbuf) {
 				ret = -ENOMEM;
 				goto error2;
@@ -911,7 +911,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 			 */
 			if (!tmpbuf || unlikely(ret > tmpbuflen)) {
 				if (unlikely(tmpbuf))
-					kzfree(tmpbuf);
+					__kvzfree(tmpbuf, tmpbuflen);
 				tmpbuflen = ret;
 				goto allocbuf;
 			}
@@ -920,7 +920,7 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 				ret = -EFAULT;
 		}
 		if (tmpbuf)
-			kzfree(tmpbuf);
+			__kvzfree(tmpbuf, tmpbuflen);
 	}
 
 error2:
-- 
2.18.1
