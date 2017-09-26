From: Eric Biggers <ebiggers3@gmail.com>
Date: Tue, 26 Sep 2017 20:11:04 +0000
Subject: [PATCH v2 5/6] KEYS: load key flags and expiry time atomically in proc_keys_show()
Message-Id: <20170926201105.126166-6-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20170926201105.126166-1-ebiggers3@gmail.com>
In-Reply-To: <20170926201105.126166-1-ebiggers3@gmail.com>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

In proc_keys_show(), the key semaphore is not held, so the key ->flags
and ->expiry can be changed concurrently.  We therefore should read them
atomically just once.  Otherwise /proc/keys may show an inconsistent
state, such a key that is negative ('N') but not instantiated ('I').

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/proc.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/security/keys/proc.c b/security/keys/proc.c
index de834309d100..a038069ac46a 100644
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
 	int rc;
@@ -217,12 +219,13 @@ static int proc_keys_show(struct seq_file *m, void *v)
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
@@ -236,18 +239,19 @@ static int proc_keys_show(struct seq_file *m, void *v)
 			sprintf(xbuf, "%luw", timo / (60*60*24*7));
 	}
 
-#define showflag(KEY, LETTER, FLAG) \
-	(test_bit(FLAG,	&(KEY)->flags) ? LETTER : '-')
+#define showflag(FLAGS, LETTER, FLAG) \
+	((FLAGS & (1 << FLAG)) ? LETTER : '-')
 
+	flags = READ_ONCE(key->flags);
 	seq_printf(m, "%08x %c%c%c%c%c%c%c %5d %4s %08x %5d %5d %-9.9s ",
 		   key->serial,
-		   showflag(key, 'I', KEY_FLAG_INSTANTIATED),
-		   showflag(key, 'R', KEY_FLAG_REVOKED),
-		   showflag(key, 'D', KEY_FLAG_DEAD),
-		   showflag(key, 'Q', KEY_FLAG_IN_QUOTA),
-		   showflag(key, 'U', KEY_FLAG_USER_CONSTRUCT),
-		   showflag(key, 'N', KEY_FLAG_NEGATIVE),
-		   showflag(key, 'i', KEY_FLAG_INVALIDATED),
+		   showflag(flags, 'I', KEY_FLAG_INSTANTIATED),
+		   showflag(flags, 'R', KEY_FLAG_REVOKED),
+		   showflag(flags, 'D', KEY_FLAG_DEAD),
+		   showflag(flags, 'Q', KEY_FLAG_IN_QUOTA),
+		   showflag(flags, 'U', KEY_FLAG_USER_CONSTRUCT),
+		   showflag(flags, 'N', KEY_FLAG_NEGATIVE),
+		   showflag(flags, 'i', KEY_FLAG_INVALIDATED),
 		   refcount_read(&key->usage),
 		   xbuf,
 		   key->perm,
-- 
2.14.1.992.g2c7b836f3a-goog

