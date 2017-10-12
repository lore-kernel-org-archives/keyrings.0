From: David Howells <dhowells@redhat.com>
Date: Thu, 12 Oct 2017 20:16:03 +0000
Subject: [PATCH 01/15] KEYS: encrypted: fix dereference of NULL user_key_payload
Message-Id: <150783936328.10956.1529578849513896883.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
In-Reply-To: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

A key of type "encrypted" references a "master key" which is used to
encrypt and decrypt the encrypted key's payload.  However, when we
accessed the master key's payload, we failed to handle the case where
the master key has been revoked, which sets the payload pointer to NULL.
Note that request_key() *does* skip revoked keys, but there is still a
window where the key can be revoked before we acquire its semaphore.

Fix it by checking for a NULL payload, treating it like a key which was
already revoked at the time it was requested.

This was an issue for master keys of type "user" only.  Master keys can
also be of type "trusted", but those cannot be revoked.

Fixes: 7e70cb497850 ("keys: add new key-type encrypted")
Reviewed-by: James Morris <james.l.morris@oracle.com>
Cc: <stable@vger.kernel.org>    [v2.6.38+]
Cc: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: David Safford <safford@us.ibm.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/encrypted-keys/encrypted.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 69855ba0d3b3..535db141f4da 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -309,6 +309,13 @@ static struct key *request_user_key(const char *master_desc, const u8 **master_k
 
 	down_read(&ukey->sem);
 	upayload = user_key_payload_locked(ukey);
+	if (!upayload) {
+		/* key was revoked before we acquired its semaphore */
+		up_read(&ukey->sem);
+		key_put(ukey);
+		ukey = ERR_PTR(-EKEYREVOKED);
+		goto error;
+	}
 	*master_key = upayload->data;
 	*master_keylen = upayload->datalen;
 error:

