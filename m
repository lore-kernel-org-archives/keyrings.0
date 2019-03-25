From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Date: Mon, 25 Mar 2019 14:47:35 +0000
Subject: [PATCH] KEYS: trusted: allow trusted.ko to initialize w/o a TPM
Message-Id: <20190325144735.30443-1-jarkko.sakkinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Id: <keyrings.vger.kernel.org>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, Dan Williams <dan.j.williams@intel.com>, stable@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>, Mimi Zohar <zohar@linuxibm.com>, David Howells <dhowells@redhat.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "open list:KEYS-TRUSTED" <keyrings@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>

Allow trusted.ko to initialize w/o a TPM. This commit adds checks to the
key type callbacks and exported functions to fail when a TPM is not
available.

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: stable@vger.kernel.org
Fixes: 240730437deb ("KEYS: trusted: explicitly use tpm_chip structure...")
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 security/keys/trusted.c | 46 +++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/security/keys/trusted.c b/security/keys/trusted.c
index ecec672d3a77..13fb1068e371 100644
--- a/security/keys/trusted.c
+++ b/security/keys/trusted.c
@@ -135,6 +135,9 @@ int TSS_authhmac(unsigned char *digest, const unsigned char *key,
 	int ret;
 	va_list argp;
 
+	if (!chip)
+		return -ENODEV;
+
 	sdesc = init_sdesc(hashalg);
 	if (IS_ERR(sdesc)) {
 		pr_info("trusted_key: can't alloc %s\n", hash_alg);
@@ -196,6 +199,9 @@ int TSS_checkhmac1(unsigned char *buffer,
 	va_list argp;
 	int ret;
 
+	if (!chip)
+		return -ENODEV;
+
 	bufsize = LOAD32(buffer, TPM_SIZE_OFFSET);
 	tag = LOAD16(buffer, 0);
 	ordinal = command;
@@ -363,6 +369,9 @@ int trusted_tpm_send(unsigned char *cmd, size_t buflen)
 {
 	int rc;
 
+	if (!chip)
+		return -ENODEV;
+
 	dump_tpm_buf(cmd);
 	rc = tpm_send(chip, cmd, buflen);
 	dump_tpm_buf(cmd);
@@ -429,6 +438,9 @@ int oiap(struct tpm_buf *tb, uint32_t *handle, unsigned char *nonce)
 {
 	int ret;
 
+	if (!chip)
+		return -ENODEV;
+
 	INIT_BUF(tb);
 	store16(tb, TPM_TAG_RQU_COMMAND);
 	store32(tb, TPM_OIAP_SIZE);
@@ -967,6 +979,9 @@ static int trusted_instantiate(struct key *key,
 	size_t key_len;
 	int tpm2;
 
+	if (!chip)
+		return -ENODEV;
+
 	tpm2 = tpm_is_tpm2(chip);
 	if (tpm2 < 0)
 		return tpm2;
@@ -1050,6 +1065,9 @@ static void trusted_rcu_free(struct rcu_head *rcu)
 {
 	struct trusted_key_payload *p;
 
+	if (!chip)
+		return;
+
 	p = container_of(rcu, struct trusted_key_payload, rcu);
 	kzfree(p);
 }
@@ -1066,6 +1084,9 @@ static int trusted_update(struct key *key, struct key_preparsed_payload *prep)
 	char *datablob;
 	int ret = 0;
 
+	if (!chip)
+		return -ENODEV;
+
 	if (key_is_negative(key))
 		return -ENOKEY;
 	p = key->payload.data[0];
@@ -1144,6 +1165,9 @@ static long trusted_read(const struct key *key, char __user *buffer,
 	char *bufp;
 	int i;
 
+	if (!chip)
+		return -ENODEV;
+
 	p = dereference_key_locked(key);
 	if (!p)
 		return -EINVAL;
@@ -1170,6 +1194,9 @@ static long trusted_read(const struct key *key, char __user *buffer,
  */
 static void trusted_destroy(struct key *key)
 {
+	if (!chip)
+		return;
+
 	kzfree(key->payload.data[0]);
 }
 
@@ -1245,9 +1272,13 @@ static int __init init_trusted(void)
 {
 	int ret;
 
+	/* encrypted_keys.ko depends on successful load of this module even if
+	 * TPM is not used.
+	 */
 	chip = tpm_default_chip();
 	if (!chip)
-		return -ENOENT;
+		return 0;
+
 	ret = init_digests();
 	if (ret < 0)
 		goto err_put;
@@ -1263,16 +1294,19 @@ static int __init init_trusted(void)
 err_free:
 	kfree(digests);
 err_put:
-	put_device(&chip->dev);
+	if (chip)
+		put_device(&chip->dev);
 	return ret;
 }
 
 static void __exit cleanup_trusted(void)
 {
-	put_device(&chip->dev);
-	kfree(digests);
-	trusted_shash_release();
-	unregister_key_type(&key_type_trusted);
+	if (chip) {
+		put_device(&chip->dev);
+		kfree(digests);
+		trusted_shash_release();
+		unregister_key_type(&key_type_trusted);
+	}
 }
 
 late_initcall(init_trusted);
-- 
2.19.1
