From: David Howells <dhowells@redhat.com>
Date: Thu, 14 Feb 2019 16:20:37 +0000
Subject: [PATCH 4/4] keys: Timestamp new keys
Message-Id: <155016123488.8115.7213459410629624800.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155016118572.8115.3243711127043478822.stgit@warthog.procyon.org.uk>
In-Reply-To: <155016118572.8115.3243711127043478822.stgit@warthog.procyon.org.uk>
To: jmorris@namei.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, dhowells@redhat.com, ebiggers@kernel.org, linux-kernel@vger.kernel.org

Set the timestamp on new keys rather than leaving it unset.

Fixes: 31d5a79d7f3d ("KEYS: Do LRU discard in full keyrings")
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/key.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/key.c b/security/keys/key.c
index 0ec9322af4f9..696f1c092c50 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -297,6 +297,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	key->gid = gid;
 	key->perm = perm;
 	key->restrict_link = restrict_link;
+	key->last_used_at = ktime_get_real_seconds();
 
 	if (!(flags & KEY_ALLOC_NOT_IN_QUOTA))
 		key->flags |= 1 << KEY_FLAG_IN_QUOTA;
