From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 18 Sep 2017 18:36:12 +0000
Subject: [PATCH] KEYS: fix key refcount leak in keyctl_assume_authority()
Message-Id: <20170918183612.113941-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In keyctl_assume_authority(), if keyctl_change_reqkey_auth() were to
fail, we would leak the reference to the 'authkey'.  Currently this can
only happen if prepare_creds() fails to allocate memory.  But it still
should be fixed, as it is a more severe bug waiting to happen.

This patch also moves the read of 'authkey->serial' to before the
reference to the authkey is dropped.  Doing the read after dropping the
reference is very fragile because it assumes we still hold another
reference to the key.  (Which we do, in current->cred->request_key_auth,
but there's no reason not to write it in the "obviously correct" way.)

Fixes: d84f4f992cbd ("CRED: Inaugurate COW credentials")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/keyctl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 6a82090c7fc1..552e4460683b 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1411,11 +1411,9 @@ long keyctl_assume_authority(key_serial_t id)
 	}
 
 	ret = keyctl_change_reqkey_auth(authkey);
-	if (ret < 0)
-		goto error;
+	if (ret = 0)
+		ret = authkey->serial;
 	key_put(authkey);
-
-	ret = authkey->serial;
 error:
 	return ret;
 }
-- 
2.14.1.690.gbb1197296e-goog

