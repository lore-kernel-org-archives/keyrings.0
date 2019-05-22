From: David Howells <dhowells@redhat.com>
Date: Wed, 22 May 2019 22:28:23 +0000
Subject: [PATCH 3/7] keys: sparse: Fix kdoc mismatches
Message-Id: <155856410370.10428.4854212353631906601.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155856408314.10428.17035328117829912815.stgit@warthog.procyon.org.uk>
In-Reply-To: <155856408314.10428.17035328117829912815.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org
Cc: dhowells@redhat.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Fix some kdoc argument description mismatches reported by sparse and give
keyring_restrict() a description.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Mat Martineau <mathew.j.martineau@linux.intel.com>
---

 security/keys/keyring.c     |   10 +++++++---
 security/keys/request_key.c |    2 +-
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index e14f09e3a4b0..5b218b270598 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -520,7 +520,7 @@ EXPORT_SYMBOL(keyring_alloc);
  * @keyring: The keyring being added to.
  * @type: The type of key being added.
  * @payload: The payload of the key intended to be added.
- * @data: Additional data for evaluating restriction.
+ * @restriction_key: Keys providing additional data for evaluating restriction.
  *
  * Reject the addition of any links to a keyring.  It can be overridden by
  * passing KEY_ALLOC_BYPASS_RESTRICTION to key_instantiate_and_link() when
@@ -976,9 +976,13 @@ static bool keyring_detect_restriction_cycle(const struct key *dest_keyring,
 
 /**
  * keyring_restrict - Look up and apply a restriction to a keyring
- *
- * @keyring: The keyring to be restricted
+ * @keyring_ref: The keyring to be restricted
+ * @type: The key type that will provide the restriction checker.
  * @restriction: The restriction options to apply to the keyring
+ *
+ * Look up a keyring and apply a restriction to it.  The restriction is managed
+ * by the specific key type, but can be configured by the options specified in
+ * the restriction string.
  */
 int keyring_restrict(key_ref_t keyring_ref, const char *type,
 		     const char *restriction)
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 75d87f9e0f49..1f234b019437 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -24,7 +24,7 @@
 
 /**
  * complete_request_key - Complete the construction of a key.
- * @auth_key: The authorisation key.
+ * @authkey: The authorisation key.
  * @error: The success or failute of the construction.
  *
  * Complete the attempt to construct a key.  The key will be negated
