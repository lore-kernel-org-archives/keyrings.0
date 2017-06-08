From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Jun 2017 13:49:42 +0000
Subject: [PATCH 19/23] KEYS: DH: don't feed uninitialized "otherinfo" into KDF
Message-Id: <149692978205.11452.9161641214967386572.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
In-Reply-To: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

If userspace called KEYCTL_DH_COMPUTE with kdf_params containing NULL
otherinfo but nonzero otherinfolen, the kernel would allocate a buffer
for the otherinfo, then feed it into the KDF without initializing it.
Fix this by always doing the copy from userspace (which will fail with
EFAULT in this scenario).

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Stephan Mueller <smueller@chronox.de>
---

 security/keys/dh.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/dh.c b/security/keys/dh.c
index 8abc70ebe22d..1c1cac677041 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -317,7 +317,7 @@ long __keyctl_dh_compute(struct keyctl_dh_params __user *params,
 	 * Concatenate SP800-56A otherinfo past DH shared secret -- the
 	 * input to the KDF is (DH shared secret || otherinfo)
 	 */
-	if (kdfcopy && kdfcopy->otherinfo &&
+	if (kdfcopy &&
 	    copy_from_user(kbuf + resultlen, kdfcopy->otherinfo,
 			   kdfcopy->otherinfolen) != 0) {
 		ret = -EFAULT;

