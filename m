From: David Howells <dhowells@redhat.com>
Date: Fri, 15 Feb 2019 16:11:22 +0000
Subject: [RFC PATCH 21/27] keys: Fix request_key() lack of Link perm check on found key
Message-Id: <155024708261.21651.15380024848711404052.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
In-Reply-To: <155024683432.21651.14153938339749694146.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org, trond.myklebust@hammerspace.com, sfrench@samba.org
Cc: linux-security-module@vger.kernel.org, linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, rgb@redhat.com, dhowells@redhat.com, linux-kernel@vger.kernel.org

The request_key() syscall allows a process to gain access to the 'possessor'
permits of any key that grants it Search permission by virtue of request_key()
not checking whether a key it finds grants Link permission to the caller.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/request_key.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index ab1f6de9e623..10244b6fbf5d 100644
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
