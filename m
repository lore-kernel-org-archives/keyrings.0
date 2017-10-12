From: David Howells <dhowells@redhat.com>
Date: Thu, 12 Oct 2017 20:17:48 +0000
Subject: [PATCH 15/15] KEYS: load key flags and expiry time atomically in proc_keys_show()
Message-Id: <150783946795.10956.9874718534834195991.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
In-Reply-To: <150783935268.10956.14343227057986655899.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In proc_keys_show(), the key semaphore is not held, so the key ->flags
and ->expiry can be changed concurrently.  We therefore should read them
atomically just once.  Otherwise /proc/keys may show an inconsistent
state, such a key that is negative ('N') but not instantiated ('I').

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 security/keys/proc.c |   24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/security/keys/proc.c b/security/keys/proc.c
index 46fa0f1bfcc3..589328ed736f 100644
--- a/security/keys/proc.c
+++ b/security/keys/proc.c
@@ -179,7 +179,9 @@ static int proc_keys_show(struct seq_file *m, void *v)
 	struct rb_node *_p = v;
 	struct key *key = rb_entry(_p, struct key, serial_node);
 	struct timespec now;
+	time_t expiry;
 	unsigned long timo;
+	unsigned long flags;
 	key_ref_t key_ref, skey_ref;
 	char xbuf[16];
 	short state;
@@ -218,12 +220,13 @@ static int proc_keys_show(struct seq_file *m, void *v)
 	rcu_read_lock();
 
 	/* come up with a suitable timeout value */
-	if (key->expiry = 0) {
+	expiry = READ_ONCE(key->expiry);
+	if (expiry = 0) {
 		memcpy(xbuf, "perm", 5);
-	} else if (now.tv_sec >= key->expiry) {
+	} else if (now.tv_sec >= expiry) {
 		memcpy(xbuf, "expd", 5);
 	} else {
-		timo = key->expiry - now.tv_sec;
+		timo = expiry - now.tv_sec;
 
 		if (timo < 60)
 			sprintf(xbuf, "%lus", timo);
@@ -239,18 +242,19 @@ static int proc_keys_show(struct seq_file *m, void *v)
 
 	state = READ_ONCE(key->state);
 
-#define showflag(KEY, LETTER, FLAG) \
-	(test_bit(FLAG,	&(KEY)->flags) ? LETTER : '-')
+#define showflag(FLAGS, LETTER, FLAG) \
+	((FLAGS & (1 << FLAG)) ? LETTER : '-')
 
+	flags = READ_ONCE(key->flags);
 	seq_printf(m, "%08x %c%c%c%c%c%c%c %5d %4s %08x %5d %5d %-9.9s ",
 		   key->serial,
 		   state = KEY_IS_INSTANTIATED ? 'I' : '-',
-		   showflag(key, 'R', KEY_FLAG_REVOKED),
-		   showflag(key, 'D', KEY_FLAG_DEAD),
-		   showflag(key, 'Q', KEY_FLAG_IN_QUOTA),
-		   showflag(key, 'U', KEY_FLAG_USER_CONSTRUCT),
+		   showflag(flags, 'R', KEY_FLAG_REVOKED),
+		   showflag(flags, 'D', KEY_FLAG_DEAD),
+		   showflag(flags, 'Q', KEY_FLAG_IN_QUOTA),
+		   showflag(flags, 'U', KEY_FLAG_USER_CONSTRUCT),
 		   state < 0 ? 'N' : '-',
-		   showflag(key, 'i', KEY_FLAG_INVALIDATED),
+		   showflag(flags, 'i', KEY_FLAG_INVALIDATED),
 		   refcount_read(&key->usage),
 		   xbuf,
 		   key->perm,

