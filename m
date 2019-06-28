From: Thiago Jung Bauermann <bauerman@linux.ibm.com>
Date: Fri, 28 Jun 2019 02:19:31 +0000
Subject: [PATCH v12 08/11] ima: Collect modsig
Message-Id: <20190628021934.4260-9-bauerman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
References: <20190628021934.4260-1-bauerman@linux.ibm.com>
In-Reply-To: <20190628021934.4260-1-bauerman@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, David Howells <dhowells@redhat.com>, David Woodhouse <dwmw2@infradead.org>, Jessica Yu <jeyu@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Jonathan Corbet <corbet@lwn.net>, "AKASHI, Takahiro" <takahiro.akashi@linaro.org>, Thiago Jung Bauermann <bauerman@linux.ibm.com>

Obtain the modsig and calculate its corresponding hash in
ima_collect_measurement().

Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 security/integrity/ima/ima.h          |  8 ++++-
 security/integrity/ima/ima_api.c      |  5 ++-
 security/integrity/ima/ima_appraise.c |  2 +-
 security/integrity/ima/ima_main.c     |  2 +-
 security/integrity/ima/ima_modsig.c   | 50 ++++++++++++++++++++++++++-
 5 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
index fa188de1cef6..baf2ffd52a41 100644
--- a/security/integrity/ima/ima.h
+++ b/security/integrity/ima/ima.h
@@ -211,7 +211,7 @@ int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
 int ima_must_measure(struct inode *inode, int mask, enum ima_hooks func);
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
-			    enum hash_algo algo);
+			    enum hash_algo algo, struct modsig *modsig);
 void ima_store_measurement(struct integrity_iint_cache *iint, struct file *file,
 			   const unsigned char *filename,
 			   struct evm_ima_xattr_data *xattr_value,
@@ -315,6 +315,7 @@ static inline int ima_read_xattr(struct dentry *dentry,
 bool ima_hook_supports_modsig(enum ima_hooks func);
 int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 		    struct modsig **modsig);
+void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size);
 void ima_free_modsig(struct modsig *modsig);
 #else
 static inline bool ima_hook_supports_modsig(enum ima_hooks func)
@@ -328,6 +329,11 @@ static inline int ima_read_modsig(enum ima_hooks func, const void *buf,
 	return -EOPNOTSUPP;
 }
 
+static inline void ima_collect_modsig(struct modsig *modsig, const void *buf,
+				      loff_t size)
+{
+}
+
 static inline void ima_free_modsig(struct modsig *modsig)
 {
 }
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index d426d4d1fe04..ac35bc3d6e35 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -209,7 +209,7 @@ int ima_get_action(struct inode *inode, const struct cred *cred, u32 secid,
  */
 int ima_collect_measurement(struct integrity_iint_cache *iint,
 			    struct file *file, void *buf, loff_t size,
-			    enum hash_algo algo)
+			    enum hash_algo algo, struct modsig *modsig)
 {
 	const char *audit_cause = "failed";
 	struct inode *inode = file_inode(file);
@@ -256,6 +256,9 @@ int ima_collect_measurement(struct integrity_iint_cache *iint,
 	memcpy(iint->ima_hash, &hash, length);
 	iint->version = i_version;
 
+	if (modsig)
+		ima_collect_modsig(modsig, buf, size);
+
 	/* Possibly temporary failure due to type of read (eg. O_DIRECT) */
 	if (!result)
 		iint->flags |= IMA_COLLECTED;
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 70252ac3321d..aa14e3fe25d5 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -438,7 +438,7 @@ void ima_update_xattr(struct integrity_iint_cache *iint, struct file *file)
 	    !(iint->flags & IMA_HASH))
 		return;
 
-	rc = ima_collect_measurement(iint, file, NULL, 0, ima_hash_algo);
+	rc = ima_collect_measurement(iint, file, NULL, 0, ima_hash_algo, NULL);
 	if (rc < 0)
 		return;
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 309058c1d50e..cc4500f93408 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -318,7 +318,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 
 	hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
 
-	rc = ima_collect_measurement(iint, file, buf, size, hash_algo);
+	rc = ima_collect_measurement(iint, file, buf, size, hash_algo, modsig);
 	if (rc != 0 && rc != -EBADF && rc != -EINVAL)
 		goto out_locked;
 
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index f41ebe370fa0..d438b87dba89 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -17,6 +17,19 @@
 
 struct modsig {
 	struct pkcs7_message *pkcs7_msg;
+
+	enum hash_algo hash_algo;
+
+	/* This digest will go in the 'd-modsig' field of the IMA template. */
+	const u8 *digest;
+	u32 digest_size;
+
+	/*
+	 * This is what will go to the measurement list if the template requires
+	 * storing the signature.
+	 */
+	int raw_pkcs7_len;
+	u8 raw_pkcs7[];
 };
 
 /**
@@ -71,7 +84,8 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 	sig_len = be32_to_cpu(sig->sig_len);
 	buf_len -= sig_len + sizeof(*sig);
 
-	hdr = kmalloc(sizeof(*hdr), GFP_KERNEL);
+	/* Allocate sig_len additional bytes to hold the raw PKCS#7 data. */
+	hdr = kzalloc(sizeof(*hdr) + sig_len, GFP_KERNEL);
 	if (!hdr)
 		return -ENOMEM;
 
@@ -81,11 +95,45 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 		return PTR_ERR(hdr->pkcs7_msg);
 	}
 
+	memcpy(hdr->raw_pkcs7, buf + buf_len, sig_len);
+	hdr->raw_pkcs7_len = sig_len;
+
+	/* We don't know the hash algorithm yet. */
+	hdr->hash_algo = HASH_ALGO__LAST;
+
 	*modsig = hdr;
 
 	return 0;
 }
 
+/**
+ * ima_collect_modsig - Calculate the file hash without the appended signature.
+ *
+ * Since the modsig is part of the file contents, the hash used in its signature
+ * isn't the same one ordinarily calculated by IMA. Therefore PKCS7 code
+ * calculates a separate one for signature verification.
+ */
+void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size)
+{
+	int rc;
+
+	/*
+	 * Provide the file contents (minus the appended sig) so that the PKCS7
+	 * code can calculate the file hash.
+	 */
+	size -= modsig->raw_pkcs7_len + strlen(MODULE_SIG_STRING) +
+		sizeof(struct module_signature);
+	rc = pkcs7_supply_detached_data(modsig->pkcs7_msg, buf, size);
+	if (rc)
+		return;
+
+	/* Ask the PKCS7 code to calculate the file hash. */
+	rc = pkcs7_get_digest(modsig->pkcs7_msg, &modsig->digest,
+			      &modsig->digest_size, &modsig->hash_algo);
+	if (rc)
+		return;
+}
+
 int ima_modsig_verify(struct key *keyring, const struct modsig *modsig)
 {
 	return verify_pkcs7_message_sig(NULL, 0, modsig->pkcs7_msg, keyring,
