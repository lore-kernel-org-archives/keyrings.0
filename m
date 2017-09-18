From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 18 Sep 2017 18:37:39 +0000
Subject: [PATCH] KEYS: reset parent each time before searching key_user_tree
Message-Id: <20170918183739.114308-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In key_user_lookup(), if there is no key_user for the given uid, we drop
key_user_lock, allocate a new key_user, and search the tree again.  But
we failed to set 'parent' to NULL at the beginning of the second search.
If the tree were to be empty for the second search, the insertion would
be done with an invalid 'parent', scribbling over freed memory.

Fortunately this can't actually happen currently because the tree always
contains at least the root_key_user.  But it still should be fixed to
make the code more robust.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/key.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index e5c0896c3a8f..eb914a838840 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -54,10 +54,10 @@ void __key_check(const struct key *key)
 struct key_user *key_user_lookup(kuid_t uid)
 {
 	struct key_user *candidate = NULL, *user;
-	struct rb_node *parent = NULL;
-	struct rb_node **p;
+	struct rb_node *parent, **p;
 
 try_again:
+	parent = NULL;
 	p = &key_user_tree.rb_node;
 	spin_lock(&key_user_lock);
 
-- 
2.14.1.690.gbb1197296e-goog

