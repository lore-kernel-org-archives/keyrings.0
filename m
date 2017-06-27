From: Mat Martineau <mathew.j.martineau@linux.intel.com>
Date: Tue, 27 Jun 2017 16:28:37 +0000
Subject: [PATCH v2] KEYS: Add documentation for asymmetric keyring restrictions
Message-Id: <20170627162837.12182-1-mathew.j.martineau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Provide more specific examples of keyring restrictions as applied to
X.509 signature chain verification.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---

v2: David's suggested edits, and use "X.509" instead of "x509". 

 Documentation/crypto/asymmetric-keys.txt | 65 ++++++++++++++++++++++++++++----
 Documentation/security/keys.txt          |  5 +++
 2 files changed, 62 insertions(+), 8 deletions(-)

diff --git a/Documentation/crypto/asymmetric-keys.txt b/Documentation/crypto/asymmetric-keys.txt
index 5ad6480e3fb9..cba2affc8f77 100644
--- a/Documentation/crypto/asymmetric-keys.txt
+++ b/Documentation/crypto/asymmetric-keys.txt
@@ -10,6 +10,7 @@ Contents:
     - Signature verification.
   - Asymmetric key subtypes.
   - Instantiation data parsers.
+  - Keyring link restrictions.
 
 
 ====
@@ -318,7 +319,8 @@ KEYRING LINK RESTRICTIONS
 ============ 
 Keyrings created from userspace using add_key can be configured to check the
-signature of the key being linked.
+signature of the key being linked.  Keys without a valid signature are not
+allowed to link.
 
 Several restriction methods are available:
 
@@ -327,9 +329,10 @@ Several restriction methods are available:
      - Option string used with KEYCTL_RESTRICT_KEYRING:
        - "builtin_trusted"
 
-     The kernel builtin trusted keyring will be searched for the signing
-     key. The ca_keys kernel parameter also affects which keys are used for
-     signature verification.
+     The kernel builtin trusted keyring will be searched for the signing key.
+     If the builtin trusted keyring is not configured, all links will be
+     rejected.  The ca_keys kernel parameter also affects which keys are used
+     for signature verification.
 
  (2) Restrict using the kernel builtin and secondary trusted keyrings
 
@@ -337,8 +340,10 @@ Several restriction methods are available:
        - "builtin_and_secondary_trusted"
 
      The kernel builtin and secondary trusted keyrings will be searched for the
-     signing key. The ca_keys kernel parameter also affects which keys are used
-     for signature verification.
+     signing key.  If the secondary trusted keyring is not configured, this
+     restriction will behave like the "builtin_trusted" option.  The ca_keys
+     kernel parameter also affects which keys are used for signature
+     verification.
 
  (3) Restrict using a separate key or keyring
 
@@ -346,7 +351,7 @@ Several restriction methods are available:
        - "key_or_keyring:<key or keyring serial number>[:chain]"
 
      Whenever a key link is requested, the link will only succeed if the key
-     being linked is signed by one of the designated keys. This key may be
+     being linked is signed by one of the designated keys.  This key may be
      specified directly by providing a serial number for one asymmetric key, or
      a group of keys may be searched for the signing key by providing the
      serial number for a keyring.
@@ -354,7 +359,51 @@ Several restriction methods are available:
      When the "chain" option is provided at the end of the string, the keys
      within the destination keyring will also be searched for signing keys.
      This allows for verification of certificate chains by adding each
-     cert in order (starting closest to the root) to one keyring.
+     certificate in order (starting closest to the root) to a keyring.  For
+     instance, one keyring can be populated with links to a set of root
+     certificates, with a separate, restricted keyring set up for each
+     certificate chain to be validated:
+
+	# Create and populate a keyring for root certificates
+	root-id=`keyctl add keyring root-certs "" @s`
+	keyctl padd asymmetric "" $root-id < root1.cert
+	keyctl padd asymmetric "" $root-id < root2.cert
+
+	# Create and restrict a keyring for the certificate chain
+	chain-id=`keyctl add keyring chain "" @s`
+	keyctl restrict_keyring $chain-id asymmetric key_or_keyring:$root-id:chain
+
+	# Attempt to add each certificate in the chain, starting with the
+	# certificate closest to the root.
+	keyctl padd asymmetric "" $chain-id < intermediateA.cert
+	keyctl padd asymmetric "" $chain-id < intermediateB.cert
+	keyctl padd asymmetric "" $chain-id < end-entity.cert
+
+     If the final end-entity certificate is successfully added to the "chain"
+     keyring, we can be certain that it has a valid signing chain going back to
+     one of the root certificates.
+
+     A single keyring can be used to verify a chain of signatures by
+     restricting the keyring after linking the root certificate:
+
+	# Create a keyring for the certificate chain and add the root
+	chain2-id=`keyctl add keyring chain2 "" @s`
+	keyctl padd asymmetric "" $chain2-id < root1.cert
+
+	# Restrict the keyring that already has root1.cert linked.  The cert
+	# will remain linked by the keyring.
+	keyctl restrict_keyring $chain2-id asymmetric key_or_keyring:0:chain
+
+	# Attempt to add each certificate in the chain, starting with the
+	# certificate closest to the root.
+	keyctl padd asymmetric "" $chain2-id < intermediateA.cert
+	keyctl padd asymmetric "" $chain2-id < intermediateB.cert
+	keyctl padd asymmetric "" $chain2-id < end-entity.cert
+
+     If the final end-entity certificate is successfully added to the "chain2"
+     keyring, we can be certain that there is a valid signing chain going back
+     to the root certificate that was added before the keyring was restricted.
+
 
 In all of these cases, if the signing key is found the signature of the key to
 be linked will be verified using the signing key.  The requested key is added
diff --git a/Documentation/security/keys.txt b/Documentation/security/keys.txt
index cd5019934d7f..5a8dd723b60a 100644
--- a/Documentation/security/keys.txt
+++ b/Documentation/security/keys.txt
@@ -900,6 +900,11 @@ The keyctl syscall functions are:
      To apply a keyring restriction the process must have Set Attribute
      permission and the keyring must not be previously restricted.
 
+     One application of restricted keyrings is to verify X.509 certificate
+     chains or individual certificate signatures using the asymmetric key type.
+     See Documentation/crypto/asymmetric-keys.txt for specific restrictions
+     applicable to the asymmetric key type.
+
 ======= KERNEL SERVICES
 =======-- 
2.13.2

