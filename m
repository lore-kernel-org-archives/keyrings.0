From: David Howells <dhowells@redhat.com>
Date: Thu, 08 Jun 2017 13:49:34 +0000
Subject: [PATCH 18/23] KEYS: DH: forbid using digest_null as the KDF hash
Message-Id: <149692977475.11452.14202503501716155138.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
In-Reply-To: <149692963884.11452.7673998701432248814.stgit@warthog.procyon.org.uk>
To: linux-security-module@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Requesting "digest_null" in the keyctl_kdf_params caused an infinite
loop in kdf_ctr() because the "null" hash has a digest size of 0.  Fix
it by rejecting hash algorithms with a digest size of 0.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Acked-by: Stephan Mueller <smueller@chronox.de>
---

 security/keys/dh.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/security/keys/dh.c b/security/keys/dh.c
index e603bd912e4c..8abc70ebe22d 100644
--- a/security/keys/dh.c
+++ b/security/keys/dh.c
@@ -89,6 +89,7 @@ static int kdf_alloc(struct kdf_sdesc **sdesc_ret, char *hashname)
 	struct crypto_shash *tfm;
 	struct kdf_sdesc *sdesc;
 	int size;
+	int err;
 
 	/* allocate synchronous hash */
 	tfm = crypto_alloc_shash(hashname, 0, 0);
@@ -97,16 +98,25 @@ static int kdf_alloc(struct kdf_sdesc **sdesc_ret, char *hashname)
 		return PTR_ERR(tfm);
 	}
 
+	err = -EINVAL;
+	if (crypto_shash_digestsize(tfm) = 0)
+		goto out_free_tfm;
+
+	err = -ENOMEM;
 	size = sizeof(struct shash_desc) + crypto_shash_descsize(tfm);
 	sdesc = kmalloc(size, GFP_KERNEL);
 	if (!sdesc)
-		return -ENOMEM;
+		goto out_free_tfm;
 	sdesc->shash.tfm = tfm;
 	sdesc->shash.flags = 0x0;
 
 	*sdesc_ret = sdesc;
 
 	return 0;
+
+out_free_tfm:
+	crypto_free_shash(tfm);
+	return err;
 }
 
 static void kdf_dealloc(struct kdf_sdesc *sdesc)

