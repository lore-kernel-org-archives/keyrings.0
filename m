From: Waiman Long <longman@redhat.com>
Date: Fri, 13 Mar 2020 15:21:01 +0000
Subject: [PATCH v3 2/3] KEYS: Avoid false positive ENOMEM error on key read
Message-Id: <20200313152102.1707-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200313152102.1707-1-longman@redhat.com>
In-Reply-To: <20200313152102.1707-1-longman@redhat.com>
To: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>, Waiman Long <longman@redhat.com>

By allocating a kernel buffer with an user-supplied buffer length, it
is possible that a false positive ENOMEM error may be returned because
the user-supplied length is just too large even if the system do have
enough memory to hold the actual key data.

To reduce this possibility, we set a threshold (1024) over which we
do check the actual key length first before allocating a buffer of the
right size to hold it.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 security/keys/keyctl.c | 48 ++++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 11 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 81f68e434b9f..a05a4dd2f9ce 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -877,24 +877,50 @@ long keyctl_read_key(key_serial_t keyid, char __user *buffer, size_t buflen)
 		 * transferring them to user buffer to avoid potential
 		 * deadlock involving page fault and mmap_sem.
 		 */
-		char *tmpbuf = kmalloc(buflen, GFP_KERNEL);
-
-		if (!tmpbuf) {
-			ret = -ENOMEM;
-			goto error2;
-		}
-		ret = __keyctl_read_key(key, tmpbuf, buflen);
+		char *tmpbuf = NULL;
+		size_t tmpbuflen = buflen;
 
 		/*
-		 * Read methods will just return the required length
-		 * without any copying if the provided length isn't big
-		 * enough.
+		 * We don't want an erronous -ENOMEM error due to an
+		 * arbitrary large user-supplied buflen. So if buflen
+		 * exceeds a threshold (1024 bytes in this case), we call
+		 * the read method twice. The first time to get the buffer
+		 * length and the second time to read out the key data.
+		 *
+		 * N.B. All the read methods will return the required
+		 *      buffer length with a NULL input buffer or when
+		 *      the input buffer length isn't large enough.
 		 */
+		if (buflen <= 0x400) {
+allocbuf:
+			tmpbuf = kmalloc(tmpbuflen, GFP_KERNEL);
+			if (!tmpbuf) {
+				ret = -ENOMEM;
+				goto error2;
+			}
+		}
+
+		ret = __keyctl_read_key(key, tmpbuf, tmpbuflen);
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
+					kzfree(tmpbuf);
+				tmpbuflen = ret;
+				goto allocbuf;
+			}
+
 			if (copy_to_user(buffer, tmpbuf, ret))
 				ret = -EFAULT;
 		}
-		kzfree(tmpbuf);
+		if (tmpbuf)
+			kzfree(tmpbuf);
 	}
 
 error2:
-- 
2.18.1
