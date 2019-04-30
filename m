From: David Howells <dhowells@redhat.com>
Date: Tue, 30 Apr 2019 15:07:55 +0000
Subject: [PATCH 09/11] keys: Garbage collect keys for which the domain has been removed [ver #2]
Message-Id: <155663687510.31331.10679763975666107254.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <155663679069.31331.3777091898004242996.stgit@warthog.procyon.org.uk>
In-Reply-To: <155663679069.31331.3777091898004242996.stgit@warthog.procyon.org.uk>
To: ebiederm@xmission.com
Cc: keyrings@vger.kernel.org, dhowells@redhat.com, linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, dwalsh@redhat.com, vgoyal@redhat.com

If a key operation domain (such as a network namespace) has been removed
then attempt to garbage collect all the keys that use it.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/key.h      |    1 +
 security/keys/internal.h |    3 ++-
 security/keys/keyring.c  |   15 +++++++++++++++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/linux/key.h b/include/linux/key.h
index c02f6e171b8c..c22e64b9bd91 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -278,6 +278,7 @@ extern void key_revoke(struct key *key);
 extern void key_invalidate(struct key *key);
 extern void key_put(struct key *key);
 extern bool key_put_tag(struct key_tag *tag);
+extern void key_remove_domain(struct key_tag *domain_tag);
 
 static inline struct key *__key_get(struct key *key)
 {
diff --git a/security/keys/internal.h b/security/keys/internal.h
index ea48d8b30794..c07fcc756fdd 100644
--- a/security/keys/internal.h
+++ b/security/keys/internal.h
@@ -205,7 +205,8 @@ static inline bool key_is_dead(const struct key *key, time64_t limit)
 	return
 		key->flags & ((1 << KEY_FLAG_DEAD) |
 			      (1 << KEY_FLAG_INVALIDATED)) ||
-		(key->expiry > 0 && key->expiry <= limit);
+		(key->expiry > 0 && key->expiry <= limit) ||
+		key->domain_tag->removed;
 }
 
 /*
diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 0898d6d91d41..d2ad27535624 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -241,6 +241,21 @@ bool key_put_tag(struct key_tag *tag)
 	return false;
 }
 
+/**
+ * key_remove_domain - Kill off a key domain and gc its keys
+ * @domain_tag: The domain tag to release.
+ *
+ * This marks a domain tag as being dead and releases a ref on it.  If that
+ * wasn't the last reference, the garbage collector is poked to try and delete
+ * all keys that were in the domain.
+ */
+void key_remove_domain(struct key_tag *domain_tag)
+{
+	domain_tag->removed = true;
+	if (!key_put_tag(domain_tag))
+		key_schedule_gc_links();
+}
+
 /*
  * Build the next index key chunk.
  *
