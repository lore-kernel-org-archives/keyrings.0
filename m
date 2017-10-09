From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 09 Oct 2017 19:43:20 +0000
Subject: [PATCH v2] lib/digsig: fix dereference of NULL user_key_payload
Message-Id: <20171009194320.67221-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

digsig_verify() requests a user key, then accesses its payload.
However, a revoked key has a NULL payload, and we failed to check for
this.  request_key() *does* skip revoked keys, but there is still a
window where the key can be revoked before we acquire its semaphore.

Fix it by checking for a NULL payload, treating it like a key which was
already revoked at the time it was requested.

Fixes: 051dbb918c7f ("crypto: digital signature verification support")
Reviewed-by: James Morris <james.l.morris@oracle.com>
Cc: <stable@vger.kernel.org>    [v3.3+]
Cc: Dmitry Kasatkin <dmitry.kasatkin@intel.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---

Changed since v1: added Reviewed-by and resent as standalone patch.  Can
this please be taken through the security tree or the keyrings tree?

 lib/digsig.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/digsig.c b/lib/digsig.c
index 03d7c63837ae..6ba6fcd92dd1 100644
--- a/lib/digsig.c
+++ b/lib/digsig.c
@@ -87,6 +87,12 @@ static int digsig_verify_rsa(struct key *key,
 	down_read(&key->sem);
 	ukp = user_key_payload_locked(key);
 
+	if (!ukp) {
+		/* key was revoked before we acquired its semaphore */
+		err = -EKEYREVOKED;
+		goto err1;
+	}
+
 	if (ukp->datalen < sizeof(*pkh))
 		goto err1;
 
-- 
2.14.2.920.gcf0c67979c-goog

