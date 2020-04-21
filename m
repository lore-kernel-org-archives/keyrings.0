From: David Howells <dhowells@redhat.com>
Date: Tue, 21 Apr 2020 12:29:46 +0000
Subject: Re: Problem with 9ba09998baa9 ("selinux: Implement the watch_key security hook") in linux-next
Message-Id: <2136640.1587472186@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com>
In-Reply-To: <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: dhowells@redhat.com, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-security-module@vger.kernel.org

Paul Moore <paul@paul-moore.com> wrote:

> ... in particular it is the fifth argument to avc_has_perm(),
> "KEY_NEED_VIEW" which is a problem.  KEY_NEED_VIEW is not a SELinux
> permission and would likely result in odd behavior when passed to
> avc_has_perm().

I think it works because KEY_NEED_VIEW happens to coincide with KEY__VIEW.  It
should just use KEY__VIEW instead.

> it probably makes the most sense to pull the permission mapping in
> selinux_key_permission() out into a separate function, e.g.
> key_perm_to_av(...)

Agreed.  How about the attached patch?  I wonder if I should do bit-by-bit
translation rather than using a switch?  But then it's difficult to decide
what it means if someone passes in two KEY_NEED_* flags OR'd together - is it
either or both?

> and then use this newly created mapping function in [...]
> selinux_watch_key()

No, I think I should just hard-code KEY__VIEW there.

David
---
commit 70d1d82aa014ae4511976b4d80c17138006dddec
Author: David Howells <dhowells@redhat.com>
Date:   Tue Apr 21 13:15:16 2020 +0100

    selinux: Fix use of KEY_NEED_* instead of KEY__* perms
    
    selinux_key_getsecurity() is passing the KEY_NEED_* permissions to
    security_sid_to_context() instead of the KEY__* values.  It happens to work
    because the values are all coincident.
    
    Fixes: d720024e94de ("[PATCH] selinux: add hooks for key subsystem")
    Reported-by: Paul Moore <paul@paul-moore.com>
    Signed-off-by: David Howells <dhowells@redhat.com>

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0b4e32161b77..32f7fa538c5f 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6539,12 +6539,27 @@ static void selinux_key_free(struct key *k)
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
@@ -6553,6 +6568,7 @@ static int selinux_key_permission(key_ref_t key_ref,
 	if (perm == 0)
 		return 0;
 
+	perm = selinux_keyperm_to_av(need_perm);
 	sid = cred_sid(cred);
 
 	key = key_ref_to_ptr(key_ref);
