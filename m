From: Mat Martineau <mathew.j.martineau@linux.intel.com>
Date: Mon, 26 Jun 2017 20:45:18 +0000
Subject: [PATCH] KEYS: Add documentation for asymmetric keyring restrictions
Message-Id: <20170626204518.13138-1-mathew.j.martineau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: keyrings@vger.kernel.org

Provide more specific examples of keyring restrictions as applied to
x509 signature chain verification.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---

If this looks good, I will adapt the restriction content to a man page and
submit a patch to the man-pages project.

 Documentation/crypto/asymmetric-keys.txt | 64 ++++++++++++++++++++++++++++----
 Documentation/security/keys.txt          |  5 +++
 2 files changed, 61 insertions(+), 8 deletions(-)

diff --git a/Documentation/crypto/asymmetric-keys.txt b/Documentation/crypto/asymmetric-keys.txt
index 5ad6480e3fb9..19cfad8a7ac8 100644
--- a/Documentation/crypto/asymmetric-keys.txt
+++ b/Documentation/crypto/asymmetric-keys.txt
@@ -318,7 +318,8 @@ KEYRING LINK RESTRICTIONS
 ============ 
 Keyrings created from userspace using add_key can be configured to check the
-signature of the key being linked.
+signature of the key being linked. Keys without a valid signature are not
+allowed to link.
 
 Several restriction methods are available:
 
@@ -328,8 +329,9 @@ Several restriction methods are available:
        - "builtin_trusted"
 
      The kernel builtin trusted keyring will be searched for the signing
-     key. The ca_keys kernel parameter also affects which keys are used for
-     signature verification.
+     key. If the builtin trusted keyring is not configured, all links will be
+     rejected. The ca_keys kernel parameter also affects which keys are used
+     for signature verification.
 
  (2) Restrict using the kernel builtin and secondary trusted keyrings
 
@@ -337,8 +339,10 @@ Several restriction methods are available:
        - "builtin_and_secondary_trusted"
 
      The kernel builtin and secondary trusted keyrings will be searched for the
-     signing key. The ca_keys kernel parameter also affects which keys are used
-     for signature verification.
+     signing key. If the secondary trusted keyring is not configured, this
+     restriction will behave like the "builtin_trusted" option. The ca_keys
+     kernel parameter also affects which keys are used for signature
+     verification.
 
  (3) Restrict using a separate key or keyring
 
@@ -352,9 +356,53 @@ Several restriction methods are available:
      serial number for a keyring.
 
      When the "chain" option is provided at the end of the string, the keys
-     within the destination keyring will also be searched for signing keys.
-     This allows for verification of certificate chains by adding each
-     cert in order (starting closest to the root) to one keyring.
+     within the destination keyring will also be searched for signing
+     keys. This allows for verification of certificate chains by adding each
+     certificate in order (starting closest to the root) to a keyring. For
+     instance, one keyring can be populated with links to a set of root
+     certificates, with a separate, restricted keyring set up for each
+     certificate chain to be validated:
+
+	# Create and populate a keyring for root certificates
+	keyctl add keyring root-certs "" @s > root-id
+	keyctl padd asymmetric "" `cat root-id` < root1.cert
+	keyctl padd asymmetric "" `cat root-id` < root2.cert
+
+	# Create and restrict a keyring for the certificate chain
+	keyctl add keyring chain "" @s > chain-id
+	keyctl restrict_keyring `cat chain-id` asymmetric key_or_keyring:`cat root-id`:chain
+
+	# Attempt to add each certificate in the chain, starting with the
+	# certificate closest to the root.
+	keyctl padd asymmetric "" `cat chain-id` < intermediateA.cert
+	keyctl padd asymmetric "" `cat chain-id` < intermediateB.cert
+	keyctl padd asymmetric "" `cat chain-id` < end-entity.cert
+
+     If the final end-entity certificate is successfully added to the "chain"
+     keyring, it has a valid signing chain going back to one of the root
+     certificates.
+
+     A single keyring can be used to verify a chain of signatures by
+     restricting the keyring after linking the root certificate:
+
+	# Create a keyring for the certificate chain and add the root
+	keyctl add keyring chain2 "" @s > chain2-id
+	keyctl padd asymmetric "" `cat chain2-id` < root1.cert
+
+	# Restrict the keyring that already has root1.cert linked. The cert
+	# will remain linked by the keyring.
+	keyctl restrict_keyring `cat chain2-id` asymmetric key_or_keyring:0:chain
+
+	# Attempt to add each certificate in the chain, starting with the
+	# certificate closest to the root.
+	keyctl padd asymmetric "" `cat chain2-id` < intermediateA.cert
+	keyctl padd asymmetric "" `cat chain2-id` < intermediateB.cert
+	keyctl padd asymmetric "" `cat chain2-id` < end-entity.cert
+
+     In this case, if the final end-entity certificate is successfully added to
+     the "chain2" keyring, there is a valid signing chain going back to the
+     root certificate that was added before the keyring was restricted.
+
 
 In all of these cases, if the signing key is found the signature of the key to
 be linked will be verified using the signing key.  The requested key is added
diff --git a/Documentation/security/keys.txt b/Documentation/security/keys.txt
index cd5019934d7f..bf6b1623a21b 100644
--- a/Documentation/security/keys.txt
+++ b/Documentation/security/keys.txt
@@ -900,6 +900,11 @@ The keyctl syscall functions are:
      To apply a keyring restriction the process must have Set Attribute
      permission and the keyring must not be previously restricted.
 
+     One application of restricted keyrings is to verify x509 certificate
+     chains or individual certificate signatures using the asymmetric key type.
+     See Documentation/crypto/asymmetric-keys.txt for specific restrictions
+     applicable to the asymmetric key type.
+
 ======= KERNEL SERVICES
 =======-- 
2.13.2

