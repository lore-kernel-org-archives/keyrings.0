From: Paul Moore <paul@paul-moore.com>
Date: Fri, 17 Apr 2020 15:48:47 +0000
Subject: Problem with 9ba09998baa9 ("selinux: Implement the watch_key security hook") in linux-next
Message-Id: <CAHC9VhT95GJKNTMvTtmZL35UOoVwbGH-eDWZyELb5oZ5rQU+Tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-security-module@vger.kernel.org

I just notice that the "selinux: Implement the watch_key security
hook" patch made it's way into linux-next via 9ba09998baa9:

  commit 9ba09998baa995518d94c9a32e6329b28ccb9045
  Author: David Howells <dhowells@redhat.com>
  Date:   Tue Jan 14 17:07:13 2020 +0000

   selinux: Implement the watch_key security hook

   Implement the watch_key security hook to make sure that a key grants the
   caller View permission in order to set a watch on a key.

   For the moment, the watch_devices security hook is left unimplemented as
   it's not obvious what the object should be since the queue is global and
   didn't previously exist.

   Signed-off-by: David Howells <dhowells@redhat.com>
   Acked-by: Stephen Smalley <sds@tycho.nsa.gov>

I'm reasonably confident that this code hasn't been tested as I expect
it would fail, or at the very least behave in unintended ways.  The
problem is the selinux_watch_key(...) function, shown below:

+static int selinux_watch_key(struct key *key)
+{
+       struct key_security_struct *ksec = key->security;
+       u32 sid = current_sid();
+
+       return avc_has_perm(&selinux_state,
+                           sid, ksec->sid, SECCLASS_KEY, KEY_NEED_VIEW, NULL);
+}

... in particular it is the fifth argument to avc_has_perm(),
"KEY_NEED_VIEW" which is a problem.  KEY_NEED_VIEW is not a SELinux
permission and would likely result in odd behavior when passed to
avc_has_perm().  Given that the keyring permission to SELinux object
class permission is variable depending on the key_perms policy
capability, it probably makes the most sense to pull the permission
mapping in selinux_key_permission() out into a separate function, e.g.
key_perm_to_av(...) (see the other XXX_to_av() functions in
security/selinux/hooks.c), and then use this newly created mapping
function in both selinux_key_permission() and selinux_watch_key().  Or
you could just duplicate the KEY_NEED_VIEW mapping code in both
functions, but I would advise against that.

-- 
paul moore
www.paul-moore.com
