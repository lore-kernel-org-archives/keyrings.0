From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Jun 2017 13:48:03 +0000
Subject: [PATCH 06/23] KEYS: put keyring if install_session_keyring_to_cred() fails
Message-Id: <149692968329.11452.1023488254368799056.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
In-Reply-To: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In join_session_keyring(), if install_session_keyring_to_cred() were to
fail, we would leak the keyring reference, just like in the bug fixed by
commit 23567fd052a9 ("KEYS: Fix keyring ref leak in
join_session_keyring()").  Fortunately this cannot happen currently, but
we really should be more careful.  Do this by adding and using a new
error label at which the keyring reference is dropped.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/process_keys.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index 2217dfec7996..86bced9fdbdf 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -809,15 +809,14 @@ long join_session_keyring(const char *name)
 		ret = PTR_ERR(keyring);
 		goto error2;
 	} else if (keyring = new->session_keyring) {
-		key_put(keyring);
 		ret = 0;
-		goto error2;
+		goto error3;
 	}
 
 	/* we've got a keyring - now to install it */
 	ret = install_session_keyring_to_cred(new, keyring);
 	if (ret < 0)
-		goto error2;
+		goto error3;
 
 	commit_creds(new);
 	mutex_unlock(&key_session_mutex);
@@ -827,6 +826,8 @@ long join_session_keyring(const char *name)
 okay:
 	return ret;
 
+error3:
+	key_put(keyring);
 error2:
 	mutex_unlock(&key_session_mutex);
 error:

