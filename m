From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 20 Nov 2017 22:57:57 +0000
Subject: [PATCH] KEYS: remove unnecessary get/put of explicit dest_keyring
Message-Id: <20171120225757.96498-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In request_key_and_link(), in the case where the dest_keyring was
explicitly specified, there is no need to get another reference to
dest_keyring before calling key_link(), then drop it afterwards.  This
is because by definition, we already have a reference to dest_keyring.

This change is useful because we'll be making
construct_get_dest_keyring() able to return an error code, and we don't
want to have to handle that error here for no reason.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/request_key.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index e8036cd0ad54..c6880af8b411 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -546,9 +546,7 @@ struct key *request_key_and_link(struct key_type *type,
 	if (!IS_ERR(key_ref)) {
 		key = key_ref_to_ptr(key_ref);
 		if (dest_keyring) {
-			construct_get_dest_keyring(&dest_keyring);
 			ret = key_link(dest_keyring, key);
-			key_put(dest_keyring);
 			if (ret < 0) {
 				key_put(key);
 				key = ERR_PTR(ret);
-- 
2.15.0.448.gf294e3d99a-goog

