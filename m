From: David Howells <dhowells@redhat.com>
Date: Wed, 22 May 2019 22:46:10 +0000
Subject: [PATCH 1/6] keys: Fix request_key() lack of Link perm check on found key
Message-Id: <155856517025.11737.11943384989202404333.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155856516286.11737.11196637682919902718.stgit@warthog.procyon.org.uk>
In-Reply-To: <155856516286.11737.11196637682919902718.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org
Cc: dhowells@redhat.com, linux-afs@lists.infradead.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

The request_key() syscall allows a process to gain access to the 'possessor'
permits of any key that grants it Search permission by virtue of request_key()
not checking whether a key it finds grants Link permission to the caller.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/request_key.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index e3653c6f85c6..d204d7c0152e 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -559,6 +559,16 @@ struct key *request_key_and_link(struct key_type *type,
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
