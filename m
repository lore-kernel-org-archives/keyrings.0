From: Eric Biggers <ebiggers3@gmail.com>
Date: Thu, 21 Sep 2017 20:57:40 +0000
Subject: [PATCH v2 1/3] KEYS: fix cred refcount leak in request_key_auth_new()
Message-Id: <20170921205742.144596-2-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170921205742.144596-1-ebiggers3@gmail.com>
In-Reply-To: <20170921205742.144596-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In request_key_auth_new(), if key_alloc() or key_instantiate_and_link()
were to fail, we would leak a reference to the 'struct cred'.  Currently
this can only happen if key_alloc() fails to allocate memory.  But it
still should be fixed, as it is a more severe bug waiting to happen.

Fix it by cleaning things up to use a helper function which frees a
'struct request_key_auth' correctly.

Fixes: d84f4f992cbd ("CRED: Inaugurate COW credentials")
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/request_key_auth.c | 67 ++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 37 deletions(-)

diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index afe9d22ab361..8f12645945ca 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -120,6 +120,18 @@ static void request_key_auth_revoke(struct key *key)
 	}
 }
 
+static void free_request_key_auth(struct request_key_auth *rka)
+{
+	if (!rka)
+		return;
+	key_put(rka->target_key);
+	key_put(rka->dest_keyring);
+	if (rka->cred)
+		put_cred(rka->cred);
+	kfree(rka->callout_info);
+	kfree(rka);
+}
+
 /*
  * Destroy an instantiation authorisation token key.
  */
@@ -129,15 +141,7 @@ static void request_key_auth_destroy(struct key *key)
 
 	kenter("{%d}", key->serial);
 
-	if (rka->cred) {
-		put_cred(rka->cred);
-		rka->cred = NULL;
-	}
-
-	key_put(rka->target_key);
-	key_put(rka->dest_keyring);
-	kfree(rka->callout_info);
-	kfree(rka);
+	free_request_key_auth(rka);
 }
 
 /*
@@ -151,22 +155,17 @@ struct key *request_key_auth_new(struct key *target, const void *callout_info,
 	const struct cred *cred = current->cred;
 	struct key *authkey = NULL;
 	char desc[20];
-	int ret;
+	int ret = -ENOMEM;
 
 	kenter("%d,", target->serial);
 
 	/* allocate a auth record */
-	rka = kmalloc(sizeof(*rka), GFP_KERNEL);
-	if (!rka) {
-		kleave(" = -ENOMEM");
-		return ERR_PTR(-ENOMEM);
-	}
+	rka = kzalloc(sizeof(*rka), GFP_KERNEL);
+	if (!rka)
+		goto error_free_rka;
 	rka->callout_info = kmalloc(callout_len, GFP_KERNEL);
-	if (!rka->callout_info) {
-		kleave(" = -ENOMEM");
-		kfree(rka);
-		return ERR_PTR(-ENOMEM);
-	}
+	if (!rka->callout_info)
+		goto error_free_rka;
 
 	/* see if the calling process is already servicing the key request of
 	 * another process */
@@ -176,8 +175,12 @@ struct key *request_key_auth_new(struct key *target, const void *callout_info,
 
 		/* if the auth key has been revoked, then the key we're
 		 * servicing is already instantiated */
-		if (test_bit(KEY_FLAG_REVOKED, &cred->request_key_auth->flags))
-			goto auth_key_revoked;
+		if (test_bit(KEY_FLAG_REVOKED,
+			     &cred->request_key_auth->flags)) {
+			up_read(&cred->request_key_auth->sem);
+			ret = -EKEYREVOKED;
+			goto error_free_rka;
+		}
 
 		irka = cred->request_key_auth->payload.data[0];
 		rka->cred = get_cred(irka->cred);
@@ -205,32 +208,22 @@ struct key *request_key_auth_new(struct key *target, const void *callout_info,
 			    KEY_USR_VIEW, KEY_ALLOC_NOT_IN_QUOTA, NULL);
 	if (IS_ERR(authkey)) {
 		ret = PTR_ERR(authkey);
-		goto error_alloc;
+		goto error_free_rka;
 	}
 
 	/* construct the auth key */
 	ret = key_instantiate_and_link(authkey, rka, 0, NULL, NULL);
 	if (ret < 0)
-		goto error_inst;
+		goto error_put_authkey;
 
 	kleave(" = {%d,%d}", authkey->serial, refcount_read(&authkey->usage));
 	return authkey;
 
-auth_key_revoked:
-	up_read(&cred->request_key_auth->sem);
-	kfree(rka->callout_info);
-	kfree(rka);
-	kleave("= -EKEYREVOKED");
-	return ERR_PTR(-EKEYREVOKED);
-
-error_inst:
+error_put_authkey:
 	key_revoke(authkey);
 	key_put(authkey);
-error_alloc:
-	key_put(rka->target_key);
-	key_put(rka->dest_keyring);
-	kfree(rka->callout_info);
-	kfree(rka);
+error_free_rka:
+	free_request_key_auth(rka);
 	kleave("= %d", ret);
 	return ERR_PTR(ret);
 }
-- 
2.14.1.821.g8fa685d3b7-goog

