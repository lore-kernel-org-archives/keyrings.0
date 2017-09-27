From: Eric Biggers <ebiggers3@gmail.com>
Date: Wed, 27 Sep 2017 19:50:43 +0000
Subject: [PATCH v3 3/7] KEYS: load key flags atomically in key_is_instantiated()
Message-Id: <20170927195047.122358-4-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170927195047.122358-1-ebiggers3@gmail.com>
In-Reply-To: <20170927195047.122358-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In key_is_instantiated(), we check for KEY_FLAG_INSTANTIATED set and
KEY_FLAG_NEGATIVE unset.  But this was done as two separate bit tests
which were not atomic with respect to each other, and had no memory
barrier providing ordering.  Therefore, it was theoretically possible
for the function to incorrectly return true if called while the key was
being negatively instantiated.

There also needs to be a memory barrier before anything which is only
meaningful for positively instantiated keys, e.g. ->payload and
->datalen, can be read --- which some of the ->describe() methods do.

Fix both these problems by loading the flags using smp_load_acquire().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/key.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index b7b590d7c480..551f099f2f6a 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -372,8 +372,11 @@ extern void key_set_timeout(struct key *, unsigned);
  */
 static inline bool key_is_instantiated(const struct key *key)
 {
-	return test_bit(KEY_FLAG_INSTANTIATED, &key->flags) &&
-		!test_bit(KEY_FLAG_NEGATIVE, &key->flags);
+	/* Pairs with RELEASE in mark_key_instantiated() */
+	unsigned long flags = smp_load_acquire(&key->flags);
+
+	return (flags & (1 << KEY_FLAG_INSTANTIATED)) &&
+		!(flags & (1 << KEY_FLAG_NEGATIVE));
 }
 
 #define dereference_key_rcu(KEY)					\
-- 
2.14.2.822.g60be5d43e6-goog

