From: Eric Biggers <ebiggers3@gmail.com>
Date: Mon, 18 Sep 2017 18:36:45 +0000
Subject: [PATCH] KEYS: fix writing past end of user-supplied buffer in keyring_read()
Message-Id: <20170918183645.114070-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Userspace can call keyctl_read() on a keyring to get the list of IDs of
keys in the keyring.  But if the user-supplied buffer is too small, the
kernel would write the full list anyway --- which will corrupt whatever
userspace memory happened to be past the end of the buffer.  Fix it by
only filling the space that is available.

Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
Cc: <stable@vger.kernel.org>	[v3.13+]
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 security/keys/keyring.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index d8d08bd9c159..4fa82a8a9c0e 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -423,7 +423,7 @@ static void keyring_describe(const struct key *keyring, struct seq_file *m)
 }
 
 struct keyring_read_iterator_context {
-	size_t			qty;
+	size_t			buflen;
 	size_t			count;
 	key_serial_t __user	*buffer;
 };
@@ -435,9 +435,9 @@ static int keyring_read_iterator(const void *object, void *data)
 	int ret;
 
 	kenter("{%s,%d},,{%zu/%zu}",
-	       key->type->name, key->serial, ctx->count, ctx->qty);
+	       key->type->name, key->serial, ctx->count, ctx->buflen);
 
-	if (ctx->count >= ctx->qty)
+	if (ctx->count >= ctx->buflen)
 		return 1;
 
 	ret = put_user(key->serial, ctx->buffer);
@@ -472,16 +472,12 @@ static long keyring_read(const struct key *keyring,
 		return 0;
 
 	/* Calculate how much data we could return */
-	ctx.qty = nr_keys * sizeof(key_serial_t);
-
 	if (!buffer || !buflen)
-		return ctx.qty;
-
-	if (buflen > ctx.qty)
-		ctx.qty = buflen;
+		return nr_keys * sizeof(key_serial_t);
 
 	/* Copy the IDs of the subscribed keys into the buffer */
 	ctx.buffer = (key_serial_t __user *)buffer;
+	ctx.buflen = buflen;
 	ctx.count = 0;
 	ret = assoc_array_iterate(&keyring->keys, keyring_read_iterator, &ctx);
 	if (ret < 0) {
-- 
2.14.1.690.gbb1197296e-goog

