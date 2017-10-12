From: David Howells <dhowells@redhat.com>
Date: Thu, 12 Oct 2017 20:16:25 +0000
Subject: [PATCH 04/15] fscrypt: fix dereference of NULL user_key_payload
Message-Id: <150783938584.10956.13443945741849277533.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
In-Reply-To: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

When an fscrypt-encrypted file is opened, we request the file's master
key from the keyrings service as a logon key, then access its payload.
However, a revoked key has a NULL payload, and we failed to check for
this.  request_key() *does* skip revoked keys, but there is still a
window where the key can be revoked before we acquire its semaphore.

Fix it by checking for a NULL payload, treating it like a key which was
already revoked at the time it was requested.

Fixes: 88bd6ccdcdd6 ("ext4 crypto: add encryption key management facilities")
Reviewed-by: James Morris <james.l.morris@oracle.com>
Cc: <stable@vger.kernel.org>    [v4.1+]
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/crypto/keyinfo.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/crypto/keyinfo.c b/fs/crypto/keyinfo.c
index 018c588c7ac3..8e704d12a1cf 100644
--- a/fs/crypto/keyinfo.c
+++ b/fs/crypto/keyinfo.c
@@ -109,6 +109,11 @@ static int validate_user_key(struct fscrypt_info *crypt_info,
 		goto out;
 	}
 	ukp = user_key_payload_locked(keyring_key);
+	if (!ukp) {
+		/* key was revoked before we acquired its semaphore */
+		res = -EKEYREVOKED;
+		goto out;
+	}
 	if (ukp->datalen != sizeof(struct fscrypt_key)) {
 		res = -EINVAL;
 		goto out;

