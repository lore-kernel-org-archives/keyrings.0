From: Eric Biggers <ebiggers3@gmail.com>
Date: Thu, 26 Oct 2017 20:57:44 +0000
Subject: [PATCH] KEYS: trusted: fix writing past end of buffer in trusted_read()
Message-Id: <20171026205744.105566-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

When calling keyctl_read() on a key of type "trusted", if the
user-supplied buffer was too small, the kernel ignored the buffer length
and just wrote past the end of the buffer, potentially corrupting
userspace memory.  Fix it by instead returning the size required, as per
the documentation for keyctl_read().

We also don't even fill the buffer at all in this case, as this is
slightly easier to implement than doing a short read, and either
behavior appears to be permitted.  It also makes it match the behavior
of the "encrypted" key type.

Fixes: d00a1c72f7f4 ("keys: add new trusted key-type")
Reported-by: Ben Hutchings <ben@decadent.org.uk>
Cc: <stable@vger.kernel.org> # v2.6.38+
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/trusted.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index bd85315cbfeb..98aa89ff7bfd 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -1147,20 +1147,21 @@ static long trusted_read(const struct key *key, char __user *buffer,
 	p = dereference_key_locked(key);
 	if (!p)
 		return -EINVAL;
-	if (!buffer || buflen <= 0)
-		return 2 * p->blob_len;
-	ascii_buf = kmalloc(2 * p->blob_len, GFP_KERNEL);
-	if (!ascii_buf)
-		return -ENOMEM;
 
-	bufp = ascii_buf;
-	for (i = 0; i < p->blob_len; i++)
-		bufp = hex_byte_pack(bufp, p->blob[i]);
-	if ((copy_to_user(buffer, ascii_buf, 2 * p->blob_len)) != 0) {
+	if (buffer && buflen >= 2 * p->blob_len) {
+		ascii_buf = kmalloc(2 * p->blob_len, GFP_KERNEL);
+		if (!ascii_buf)
+			return -ENOMEM;
+
+		bufp = ascii_buf;
+		for (i = 0; i < p->blob_len; i++)
+			bufp = hex_byte_pack(bufp, p->blob[i]);
+		if (copy_to_user(buffer, ascii_buf, 2 * p->blob_len) != 0) {
+			kzfree(ascii_buf);
+			return -EFAULT;
+		}
 		kzfree(ascii_buf);
-		return -EFAULT;
 	}
-	kzfree(ascii_buf);
 	return 2 * p->blob_len;
 }
 
-- 
2.15.0.rc2.357.g7e34df9404-goog

