From: David Howells <dhowells@redhat.com>
Date: Wed, 19 Jun 2019 15:36:03 +0000
Subject: [PATCH 1/6] keys: Fix request_key() lack of Link perm check on found key [ver #2]
Message-Id: <156095856342.25264.11029423243013014147.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <156095855610.25264.16666970456822465537.stgit@warthog.procyon.org.uk>
In-Reply-To: <156095855610.25264.16666970456822465537.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

The request_key() syscall allows a process to gain access to the 'possessor'
permits of any key that grants it Search permission by virtue of request_key()
not checking whether a key it finds grants Link permission to the caller.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/security/keys/core.rst |    4 ++++
 security/keys/request_key.c          |   10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 823d29bf44f7..82dd457ff78d 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -433,6 +433,10 @@ The main syscalls are:
      /sbin/request-key will be invoked in an attempt to obtain a key. The
      callout_info string will be passed as an argument to the program.
 
+     To link a key into the destination keyring the key must grant link
+     permission on the key to the caller and the keyring must grant write
+     permission.
+
      See also Documentation/security/keys/request-key.rst.
 
 
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 857da65e1940..a6543ed98b1f 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -564,6 +564,16 @@ struct key *request_key_and_link(struct key_type *type,
 	key_ref = search_process_keyrings(&ctx);
 
 	if (!IS_ERR(key_ref)) {
+		if (dest_keyring) {
+			ret = key_task_permission(key_ref, current_cred(),
+						  KEY_NEED_LINK);
+			if (ret < 0) {
+				key_ref_put(key_ref);
+				key = ERR_PTR(ret);
+				goto error_free;
+			}
+		}
+
 		key = key_ref_to_ptr(key_ref);
 		if (dest_keyring) {
 			ret = key_link(dest_keyring, key);
