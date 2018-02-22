From: David Howells <dhowells@redhat.com>
Date: Thu, 22 Feb 2018 16:21:02 +0000
Subject: [PATCH 5/6] X.509: fix NULL dereference when restricting key with unsupported_sig
Message-Id: <151931646253.27713.5857757999911191687.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <151931642737.27713.5082532296556836948.stgit@warthog.procyon.org.uk>
In-Reply-To: <151931642737.27713.5082532296556836948.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

The asymmetric key type allows an X.509 certificate to be added even if
its signature's hash algorithm is not available in the crypto API.  In
that case 'payload.data[asym_auth]' will be NULL.  But the key
restriction code failed to check for this case before trying to use the
signature, resulting in a NULL pointer dereference in
key_or_keyring_common() or in restrict_link_by_signature().

Fix this by returning -ENOPKG when the signature is unsupported.

Reproducer when all the CONFIG_CRYPTO_SHA512* options are disabled and
keyctl has support for the 'restrict_keyring' command:

    keyctl new_session
    keyctl restrict_keyring @s asymmetric builtin_trusted
    openssl req -new -sha512 -x509 -batch -nodes -outform der \
        | keyctl padd asymmetric desc @s

Fixes: a511e1af8b12 ("KEYS: Move the point of trust determination to __key_link()")
Cc: <stable@vger.kernel.org> # v4.7+
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 crypto/asymmetric_keys/restrict.c |   21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 86fb68508952..7c93c7728454 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -67,8 +67,9 @@ __setup("ca_keys=", ca_keys_setup);
  *
  * Returns 0 if the new certificate was accepted, -ENOKEY if we couldn't find a
  * matching parent certificate in the trusted list, -EKEYREJECTED if the
- * signature check fails or the key is blacklisted and some other error if
- * there is a matching certificate but the signature check cannot be performed.
+ * signature check fails or the key is blacklisted, -ENOPKG if the signature
+ * uses unsupported crypto, or some other error if there is a matching
+ * certificate but the signature check cannot be performed.
  */
 int restrict_link_by_signature(struct key *dest_keyring,
 			       const struct key_type *type,
@@ -88,6 +89,8 @@ int restrict_link_by_signature(struct key *dest_keyring,
 		return -EOPNOTSUPP;
 
 	sig = payload->data[asym_auth];
+	if (!sig)
+		return -ENOPKG;
 	if (!sig->auth_ids[0] && !sig->auth_ids[1])
 		return -ENOKEY;
 
@@ -139,6 +142,8 @@ static int key_or_keyring_common(struct key *dest_keyring,
 		return -EOPNOTSUPP;
 
 	sig = payload->data[asym_auth];
+	if (!sig)
+		return -ENOPKG;
 	if (!sig->auth_ids[0] && !sig->auth_ids[1])
 		return -ENOKEY;
 
@@ -222,9 +227,9 @@ static int key_or_keyring_common(struct key *dest_keyring,
  *
  * Returns 0 if the new certificate was accepted, -ENOKEY if we
  * couldn't find a matching parent certificate in the trusted list,
- * -EKEYREJECTED if the signature check fails, and some other error if
- * there is a matching certificate but the signature check cannot be
- * performed.
+ * -EKEYREJECTED if the signature check fails, -ENOPKG if the signature uses
+ * unsupported crypto, or some other error if there is a matching certificate
+ * but the signature check cannot be performed.
  */
 int restrict_link_by_key_or_keyring(struct key *dest_keyring,
 				    const struct key_type *type,
@@ -249,9 +254,9 @@ int restrict_link_by_key_or_keyring(struct key *dest_keyring,
  *
  * Returns 0 if the new certificate was accepted, -ENOKEY if we
  * couldn't find a matching parent certificate in the trusted list,
- * -EKEYREJECTED if the signature check fails, and some other error if
- * there is a matching certificate but the signature check cannot be
- * performed.
+ * -EKEYREJECTED if the signature check fails, -ENOPKG if the signature uses
+ * unsupported crypto, or some other error if there is a matching certificate
+ * but the signature check cannot be performed.
  */
 int restrict_link_by_key_or_keyring_chain(struct key *dest_keyring,
 					  const struct key_type *type,

