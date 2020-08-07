From: Randy Dunlap <rdunlap@infradead.org>
Date: Fri, 07 Aug 2020 16:51:23 +0000
Subject: [PATCH] security: keys: delete repeated words in comments
Message-Id: <20200807165123.3863-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, keyrings@vger.kernel.org, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org

Drop repeated words in comments.
{to, will, the}

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: keyrings@vger.kernel.org
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org
---
 security/keys/keyctl.c  |    2 +-
 security/keys/keyring.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20200731.orig/security/keys/keyctl.c
+++ linux-next-20200731/security/keys/keyctl.c
@@ -506,7 +506,7 @@ error:
  * keyring, otherwise replace the link to the matching key with a link to the
  * new key.
  *
- * The key must grant the caller Link permission and the the keyring must grant
+ * The key must grant the caller Link permission and the keyring must grant
  * the caller Write permission.  Furthermore, if an additional link is created,
  * the keyring's quota will be extended.
  *
--- linux-next-20200731.orig/security/keys/keyring.c
+++ linux-next-20200731/security/keys/keyring.c
@@ -881,7 +881,7 @@ found:
  *
  * Keys are matched to the type provided and are then filtered by the match
  * function, which is given the description to use in any way it sees fit.  The
- * match function may use any attributes of a key that it wishes to to
+ * match function may use any attributes of a key that it wishes to
  * determine the match.  Normally the match function from the key type would be
  * used.
  *
@@ -1204,7 +1204,7 @@ static int keyring_detect_cycle_iterator
 }
 
 /*
- * See if a cycle will will be created by inserting acyclic tree B in acyclic
+ * See if a cycle will be created by inserting acyclic tree B in acyclic
  * tree A at the topmost level (ie: as a direct child of A).
  *
  * Since we are adding B to A at the top level, checking for cycles should just
