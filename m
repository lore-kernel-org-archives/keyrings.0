From: Sasha Levin <sashal@kernel.org>
Date: Thu, 16 Jan 2020 17:19:32 +0000
Subject: [PATCH AUTOSEL 4.14 100/371] keys: Timestamp new keys
Message-Id: <20200116172403.18149-43-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200116172403.18149-1-sashal@kernel.org>
In-Reply-To: <20200116172403.18149-1-sashal@kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, James Morris <james.morris@microsoft.com>, Sasha Levin <sashal@kernel.org>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org

From: David Howells <dhowells@redhat.com>

[ Upstream commit 7c1857bdbdf1e4c541e45eab477ee23ed4333ea4 ]

Set the timestamp on new keys rather than leaving it unset.

Fixes: 31d5a79d7f3d ("KEYS: Do LRU discard in full keyrings")
Signed-off-by: David Howells <dhowells@redhat.com>
Signed-off-by: James Morris <james.morris@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/keys/key.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/keys/key.c b/security/keys/key.c
index 87172f99f73e..17244f5f54c6 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -297,6 +297,7 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	key->gid = gid;
 	key->perm = perm;
 	key->restrict_link = restrict_link;
+	key->last_used_at = ktime_get_real_seconds();
 
 	if (!(flags & KEY_ALLOC_NOT_IN_QUOTA))
 		key->flags |= 1 << KEY_FLAG_IN_QUOTA;
-- 
2.20.1
