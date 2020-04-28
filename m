From: David Howells <dhowells@redhat.com>
Date: Tue, 28 Apr 2020 12:54:44 +0000
Subject: [PATCH] selinux: Fix use of KEY_NEED_* instead of KEY__* perms [v2]
Message-Id: <924658.1588078484@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com>
In-Reply-To: <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com>
To: Paul Moore <paul@paul-moore.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-security-module@vger.kernel.org

selinux: Fix use of KEY_NEED_* instead of KEY__* perms
    
selinux_key_permission() is passing the KEY_NEED_* permissions to
avc_has_perm() instead of the KEY__* values.  It happens to work because
the values are all coincident.

Fixes: d720024e94de ("[PATCH] selinux: add hooks for key subsystem")
Reported-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---
 security/selinux/hooks.c |   23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0b4e32161b77..4b6624e5dab4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6539,20 +6539,39 @@ static void selinux_key_free(struct key *k)
 	kfree(ksec);
 }
 
+static unsigned int selinux_keyperm_to_av(unsigned int need_perm)
+{
+	switch (need_perm) {
+	case KEY_NEED_VIEW:	return KEY__VIEW;
+	case KEY_NEED_READ:	return KEY__READ;
+	case KEY_NEED_WRITE:	return KEY__WRITE;
+	case KEY_NEED_SEARCH:	return KEY__SEARCH;
+	case KEY_NEED_LINK:	return KEY__LINK;
+	case KEY_NEED_SETATTR:	return KEY__SETATTR;
+	default:
+		WARN_ON(1);
+		return 0;
+	}
+}
+
 static int selinux_key_permission(key_ref_t key_ref,
 				  const struct cred *cred,
-				  unsigned perm)
+				  unsigned need_perm)
 {
 	struct key *key;
 	struct key_security_struct *ksec;
+	unsigned int perm;
 	u32 sid;
 
 	/* if no specific permissions are requested, we skip the
 	   permission check. No serious, additional covert channels
 	   appear to be created. */
-	if (perm = 0)
+	if (need_perm = 0)
 		return 0;
 
+	perm = selinux_keyperm_to_av(need_perm);
+	if (perm = 0)
+		return -EPERM;
 	sid = cred_sid(cred);
 
 	key = key_ref_to_ptr(key_ref);
