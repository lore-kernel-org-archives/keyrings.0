From: David Howells <dhowells@redhat.com>
Date: Thu, 14 Feb 2019 16:19:16 +0000
Subject: [PATCH 1/4] KEYS: allow reaching the keys quotas exactly
Message-Id: <155016114592.8024.108035728807781948.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: jmorris@namei.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com, ebiggers@kernel.org, linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

If the sysctl 'kernel.keys.maxkeys' is set to some number n, then
actually users can only add up to 'n - 1' keys.  Likewise for
'kernel.keys.maxbytes' and the root_* versions of these sysctls.  But
these sysctls are apparently supposed to be *maximums*, as per their
names and all documentation I could find -- the keyrings(7) man page,
Documentation/security/keys/core.rst, and all the mentions of EDQUOT
meaning that the key quota was *exceeded* (as opposed to reached).

Thus, fix the code to allow reaching the quotas exactly.

Fixes: 0b77f5bfb45c ("keys: make the keyring quotas controllable through /proc/sys")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/key.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 44a80d6741a1..0ec9322af4f9 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -265,8 +265,8 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 
 		spin_lock(&user->lock);
 		if (!(flags & KEY_ALLOC_QUOTA_OVERRUN)) {
-			if (user->qnkeys + 1 >= maxkeys ||
-			    user->qnbytes + quotalen >= maxbytes ||
+			if (user->qnkeys + 1 > maxkeys ||
+			    user->qnbytes + quotalen > maxbytes ||
 			    user->qnbytes + quotalen < user->qnbytes)
 				goto no_quota;
 		}
