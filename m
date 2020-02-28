From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Fri, 28 Feb 2020 04:41:51 +0000
Subject: [PATCH v3] KEYS: reaching the keys quotas correctly
Message-Id: <1582864911-30823-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200228033009.GA932@sol.localdomain>
In-Reply-To: <20200228033009.GA932@sol.localdomain>
To: jarkko.sakkinen@linux.intel.com

Currently, when we add a new user key, the calltrace as below:

add_key()
  key_create_or_update()
    key_alloc()
    __key_instantiate_and_link
      generic_key_instantiate
        key_payload_reserve
          ......

Since commit a08bf91ce28e ("KEYS: allow reaching the keys quotas exactly"),
we can reach max bytes/keys in key_alloc, but we forget to remove this
limit when we reserver space for payload in key_payload_reserve. So we
can only reach max keys but not max bytes when having delta between plen
and type->def_datalen. Remove this limit when instantiating the key, so we
can keep consistent with key_alloc.

Also, fix the similar problem in keyctl_chown_key().

Fixes: 0b77f5bfb45c ("keys: make the keyring quotas controllable through /proc/sys")
Fixes: a08bf91ce28e ("KEYS: allow reaching the keys quotas exactly")
Cc: Eric Biggers <ebiggers@google.com>
Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 security/keys/key.c    | 2 +-
 security/keys/keyctl.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index 718bf7217420..e959b3c96b48 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -382,7 +382,7 @@ int key_payload_reserve(struct key *key, size_t datalen)
 		spin_lock(&key->user->lock);
 
 		if (delta > 0 &&
-		    (key->user->qnbytes + delta >= maxbytes ||
+		    (key->user->qnbytes + delta > maxbytes ||
 		     key->user->qnbytes + delta < key->user->qnbytes)) {
 			ret = -EDQUOT;
 		}
diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
index 9b898c969558..d1a3dea58dee 100644
--- a/security/keys/keyctl.c
+++ b/security/keys/keyctl.c
@@ -937,8 +937,8 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
 				key_quota_root_maxbytes : key_quota_maxbytes;
 
 			spin_lock(&newowner->lock);
-			if (newowner->qnkeys + 1 >= maxkeys ||
-			    newowner->qnbytes + key->quotalen >= maxbytes ||
+			if (newowner->qnkeys + 1 > maxkeys ||
+			    newowner->qnbytes + key->quotalen > maxbytes ||
 			    newowner->qnbytes + key->quotalen <
 			    newowner->qnbytes)
 				goto quota_overrun;
-- 
2.18.0
