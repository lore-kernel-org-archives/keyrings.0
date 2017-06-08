From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Jun 2017 13:48:18 +0000
Subject: [PATCH 08/23] KEYS: encrypted: fix buffer overread in valid_master_desc()
Message-Id: <149692969796.11452.2915277493345705577.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
In-Reply-To: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

With the 'encrypted' key type it was possible for userspace to provide a
data blob ending with a master key description shorter than expected,
e.g. 'keyctl add encrypted desc "new x" @s'.  When validating such a
master key description, validate_master_desc() could read beyond the end
of the buffer.  Fix this by using strncmp() instead of memcmp().  [Also
clean up the code to deduplicate some logic.]

Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/encrypted-keys/encrypted.c |   31 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index d14f1a47a130..0f7b95de3b5f 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -141,23 +141,22 @@ static int valid_ecryptfs_desc(const char *ecryptfs_desc)
  */
 static int valid_master_desc(const char *new_desc, const char *orig_desc)
 {
-	if (!memcmp(new_desc, KEY_TRUSTED_PREFIX, KEY_TRUSTED_PREFIX_LEN)) {
-		if (strlen(new_desc) = KEY_TRUSTED_PREFIX_LEN)
-			goto out;
-		if (orig_desc)
-			if (memcmp(new_desc, orig_desc, KEY_TRUSTED_PREFIX_LEN))
-				goto out;
-	} else if (!memcmp(new_desc, KEY_USER_PREFIX, KEY_USER_PREFIX_LEN)) {
-		if (strlen(new_desc) = KEY_USER_PREFIX_LEN)
-			goto out;
-		if (orig_desc)
-			if (memcmp(new_desc, orig_desc, KEY_USER_PREFIX_LEN))
-				goto out;
-	} else
-		goto out;
+	int prefix_len;
+
+	if (!strncmp(new_desc, KEY_TRUSTED_PREFIX, KEY_TRUSTED_PREFIX_LEN))
+		prefix_len = KEY_TRUSTED_PREFIX_LEN;
+	else if (!strncmp(new_desc, KEY_USER_PREFIX, KEY_USER_PREFIX_LEN))
+		prefix_len = KEY_USER_PREFIX_LEN;
+	else
+		return -EINVAL;
+
+	if (!new_desc[prefix_len])
+		return -EINVAL;
+
+	if (orig_desc && strncmp(new_desc, orig_desc, prefix_len))
+		return -EINVAL;
+
 	return 0;
-out:
-	return -EINVAL;
 }
 
 /*

