From: David Howells <dhowells@redhat.com>
Date: Wed, 20 Feb 2019 13:32:11 +0000
Subject: [PATCH] KEYS: user: Align the payload buffer
Message-Id: <155066953188.21038.12015964986007814182.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190115033716.18380-1-ebiggers@kernel.org>
In-Reply-To: <20190115033716.18380-1-ebiggers@kernel.org>
To: jmorris@namei.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, stable@vger.kernel.org, Eric Biggers <ebiggers@google.com>Aaro Koskinen <aaro.koskinen@iki.fi>, keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Align the payload of "user" and "logon" keys so that users of the
keyrings service can access it as a struct that requires more than
2-byte alignment.  fscrypt currently does this which results in the read
of fscrypt_key::size being misaligned as it needs 4-byte alignment.

Align to __alignof__(u64) rather than __alignof__(long) since in the
future it's conceivable that people would use structs beginning with
u64, which on some platforms would require more than 'long' alignment.

Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Fixes: 2aa349f6e37c ("[PATCH] Keys: Export user-defined keyring operations")
Fixes: 88bd6ccdcdd6 ("ext4 crypto: add encryption key management facilities")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/keys/user-type.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/keys/user-type.h b/include/keys/user-type.h
index e098cbe27db5..12babe991594 100644
--- a/include/keys/user-type.h
+++ b/include/keys/user-type.h
@@ -31,7 +31,7 @@
 struct user_key_payload {
 	struct rcu_head	rcu;		/* RCU destructor */
 	unsigned short	datalen;	/* length of this data */
-	char		data[0];	/* actual data */
+	char		data[0] __aligned(__alignof__(u64)); /* actual data */
 };
 
 extern struct key_type key_type_user;
