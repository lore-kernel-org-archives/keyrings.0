From: Waiman Long <longman@redhat.com>
Date: Tue, 17 Mar 2020 19:41:38 +0000
Subject: [PATCH v4 2/4] KEYS: Remove __user annotation from rxrpc_read()
Message-Id: <20200317194140.6031-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20200317194140.6031-1-longman@redhat.com>
In-Reply-To: <20200317194140.6031-1-longman@redhat.com>
To: David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, linux-afs@lists.infradead.org, Sumit Garg <sumit.garg@linaro.org>, Jerry Snitselaar <jsnitsel@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>, Eric Biggers <ebiggers@google.com>, Chris von Recklinghausen <crecklin@redhat.com>, Waiman Long <longman@redhat.com>

As the keyctl_read_key() has been modified to use a temporary kernel
buffer to read out the key data instead of passing in the user-supplied
buffer directly, there is no need to use the __user annotation for
rxrpc_read(). In addition,

 1) The put_user() call is replaced by a direct copy.
 2) The copy_to_user() call is replaced by memcpy().
 3) All the fault handling code is removed.

Compiling on a x86-64 system, the size of the rxrpc_read() function is
reduced from 3795 bytes to 2384 bytes with this patch.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 net/rxrpc/key.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index 6c3f35fac42d..0c98313dd7a8 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -31,7 +31,7 @@ static void rxrpc_free_preparse_s(struct key_preparsed_payload *);
 static void rxrpc_destroy(struct key *);
 static void rxrpc_destroy_s(struct key *);
 static void rxrpc_describe(const struct key *, struct seq_file *);
-static long rxrpc_read(const struct key *, char __user *, size_t);
+static long rxrpc_read(const struct key *, char *, size_t);
 
 /*
  * rxrpc defined keys take an arbitrary string as the description and an
@@ -1042,12 +1042,12 @@ EXPORT_SYMBOL(rxrpc_get_null_key);
  * - this returns the result in XDR form
  */
 static long rxrpc_read(const struct key *key,
-		       char __user *buffer, size_t buflen)
+		       char *buffer, size_t buflen)
 {
 	const struct rxrpc_key_token *token;
 	const struct krb5_principal *princ;
 	size_t size;
-	__be32 __user *xdr, *oldxdr;
+	__be32 *xdr, *oldxdr;
 	u32 cnlen, toksize, ntoks, tok, zero;
 	u16 toksizes[AFSTOKEN_MAX];
 	int loop;
@@ -1124,30 +1124,25 @@ static long rxrpc_read(const struct key *key,
 	if (!buffer || buflen < size)
 		return size;
 
-	xdr = (__be32 __user *) buffer;
+	xdr = (__be32 *)buffer;
 	zero = 0;
 #define ENCODE(x)				\
 	do {					\
-		__be32 y = htonl(x);		\
-		if (put_user(y, xdr++) < 0)	\
-			goto fault;		\
+		*xdr++ = htonl(x);		\
 	} while(0)
 #define ENCODE_DATA(l, s)						\
 	do {								\
 		u32 _l = (l);						\
 		ENCODE(l);						\
-		if (copy_to_user(xdr, (s), _l) != 0)			\
-			goto fault;					\
-		if (_l & 3 &&						\
-		    copy_to_user((u8 __user *)xdr + _l, &zero, 4 - (_l & 3)) != 0) \
-			goto fault;					\
+		memcpy(xdr, (s), _l);					\
+		if (_l & 3)						\
+			memcpy((u8 *)xdr + _l, &zero, 4 - (_l & 3));	\
 		xdr += (_l + 3) >> 2;					\
 	} while(0)
 #define ENCODE64(x)					\
 	do {						\
 		__be64 y = cpu_to_be64(x);		\
-		if (copy_to_user(xdr, &y, 8) != 0)	\
-			goto fault;			\
+		memcpy(xdr, &y, 8);			\
 		xdr += 8 >> 2;				\
 	} while(0)
 #define ENCODE_STR(s)				\
@@ -1238,8 +1233,4 @@ static long rxrpc_read(const struct key *key,
 	ASSERTCMP((char __user *) xdr - buffer, =, size);
 	_leave(" = %zu", size);
 	return size;
-
-fault:
-	_leave(" = -EFAULT");
-	return -EFAULT;
 }
-- 
2.18.1
