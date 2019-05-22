From: David Howells <dhowells@redhat.com>
Date: Wed, 22 May 2019 22:28:17 +0000
Subject: [PATCH 2/7] keys: sparse: Fix incorrect RCU accesses
Message-Id: <155856409697.10428.15024260088836364169.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155856408314.10428.17035328117829912815.stgit@warthog.procyon.org.uk>
In-Reply-To: <155856408314.10428.17035328117829912815.stgit@warthog.procyon.org.uk>
To: keyrings@vger.kernel.org
Cc: dhowells@redhat.com, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

Fix a pair of accesses that should be using RCU protection.

rcu_dereference_protected() is needed to access task_struct::real_parent.

current_cred() should be used to access current->cred.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/keyctl.c           |    3 ++-
 security/keys/request_key_auth.c |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 3e4053a217c3..0f947bcbad46 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -1524,7 +1524,8 @@ long keyctl_session_to_parent(void)
 
 	ret = -EPERM;
 	oldwork = NULL;
-	parent = me->real_parent;
+	parent = rcu_dereference_protected(me->real_parent,
+					   lockdep_is_held(&tasklist_lock));
 
 	/* the parent mustn't be init and mustn't be a kernel thread */
 	if (parent->pid <= 1 || !parent->mm)
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index bda6201c6c45..572c7a60473a 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -152,7 +152,7 @@ struct key *request_key_auth_new(struct key *target, const char *op,
 				 struct key *dest_keyring)
 {
 	struct request_key_auth *rka, *irka;
-	const struct cred *cred = current->cred;
+	const struct cred *cred = current_cred();
 	struct key *authkey = NULL;
 	char desc[20];
 	int ret = -ENOMEM;
