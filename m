Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702382;
	b=uqSp+ZLmlv9T6VGS87T/m9UdrT3Vo4ZKWfSs0544qHom7xXl6Y4rJgzrhWlzXJb+Sigu
	 qPFc28tq70d0kQRIpZr0DoV/hOOujeDevPkk/XM15mFtBaT4K804UVqLC2cUnr9f85bQD
	 Y7PUONT79G+02IO4I6nvSZ8tULyAVZqINpBKExJ2rhMF3789H5V4B2sv3L22PYtYxjrZ4
	 ogVJmFpkyrqlk5ykU7aTiGNagMdZm0n3B7n60D37Hkx6JpZuN+LuVq25sd+KUzRjSJeXa
	 pC+yim4SCsYVgSIWEe1QshOyt65mURR4YQYQNH16ndLuO9Sfo1ZFUw0sC8DX4grZ3bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702382;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=b8GKwzg8hnVB/dJMfW1eFFdPAzBoP31B1ZzsR+6efoE=;
	b=BHnWD3RMvtwlHhPecA0/GsjiPDi5HKuBRJShHoLB3QK+qlqDNly//no8oKoKz0ylRZAP
	 Ia8WUAHqPTPYQR8bnnacVw2zJN3E5UU919EJKEh3r5O5R2avRFkPOQTcpNL63gJ2hUsgb
	 N76budJXquF4FEJcwl+SBnexctz0OHyHrgwQ0neEArDoU+6lj/E4lNA+MCRoMoKbwdMDC
	 pzjJSfRBtm0XJr4Uewne6fNrhb3ellUx/0gMCv63lEF1pRPJhT1lK2eJMvsH8Hy8rmWZQ
	 gUJ2Y5k4vsmeYI+UPbBw3SZVYSSEZH7zIqz1NbDI8huRU/Lg43no5sfQV2PN+nX2mIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="EbDO/GBX";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAEC606A323;
	Thu, 26 Nov 2026 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EbDO/GBX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E191F000EC;
	Thu, 26 Nov 2026 14:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702381;
	bh=b8GKwzg8hnVB/dJMfW1eFFdPAzBoP31B1ZzsR+6efoE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EbDO/GBXEXsZRb9VDb9YYRcukjNoOvTPIcFFkCl88tB8xceArqrYu0gm0e/aQgO8x
	 kyj9vuC93G4y1NKlecIZ4x+NActajLPGww6M10aAdEH8po/z9P/ro+KP+G8uDuZI43
	 0dYZ0Blrsuu++nL9SvwD13Qh25/twer2hY0Cfg3vxu3Og1/bvw6aB6SOHi24DW+Ssb
	 ThAIwI8gPl31HqrYYFdtCH16NaIkryn/CMpjy0MPAR1nmDqKZAh0KxlIvZT/JrubZh
	 J6GmtKc0o9AJE1HslOViBLcNWzWAamepW+0WJjQB3RnuFccSL+0ZGoWxdoRKXypn2i
	 XYbRpqSPn6DFQ==
From: Hannes Reinecke <hare@kernel.org>
Date: Thu, 26 Nov 2026 15:12:23 +0100
Subject: [PATCH v7 05/14] nvme-keyring: link addtional keyring into .nvme
 keyring
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-dhchap-keyring-v4-v7-5-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
In-Reply-To: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Eric Biggers <ebiggers@kernel.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702352; l=11283;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=6Eto8R0qyjlO6R/vabgw1HE6a2csuDqokyNKglJbUdU=;
 b=YMnpIeqVg2LfASDtG9uZRJSFA0/6s5TVFOkjMP33nmVO8Wlw54KYiZPgZLNjS2Tzx267LR5Bb
 1nfaSMV4ec8BBEA3YNE4s7CMMzR93X2pxt0bqb4b6EjH00SGBNupajO
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

Rather than switching to a different keyring (and trying
to deal with possibly restricted access to that keyring)
we should link the additional keyring into the default .nvme
keyring to make the keys available for lookup for
the lifetime of the corresponding nvme structures.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/keyring.c | 63 ++++++++++++++++++++++++++-----------------
 drivers/nvme/host/auth.c      |  3 +--
 drivers/nvme/host/fabrics.c   | 13 +++++++--
 drivers/nvme/host/sysfs.c     |  3 +++
 drivers/nvme/host/tcp.c       |  3 +--
 drivers/nvme/target/auth.c    |  2 +-
 include/linux/nvme-keyring.h  | 30 +++++++++++++++------
 7 files changed, 77 insertions(+), 40 deletions(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 373f51e1032a4d29ef945a62fd9fb3720f8a9ea8..0fc6b4825c2dd9a23daaf4aae3d9f63f4f07c164 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -22,6 +22,24 @@ key_serial_t nvme_keyring_id(void)
 }
 EXPORT_SYMBOL_GPL(nvme_keyring_id);
 
+const char *nvme_keyring_name(void)
+{
+	return nvme_keyring->description;
+}
+EXPORT_SYMBOL_GPL(nvme_keyring_name);
+
+int nvme_keyring_link(struct key *keyring)
+{
+	return key_link(nvme_keyring, keyring);
+}
+EXPORT_SYMBOL_GPL(nvme_keyring_link);
+
+int nvme_keyring_unlink(struct key *keyring)
+{
+	return key_unlink(nvme_keyring, keyring);
+}
+EXPORT_SYMBOL_GPL(nvme_keyring_unlink);
+
 struct key *nvme_tls_key_lookup(key_serial_t key_id)
 {
 	struct key *key = key_lookup(key_id);
@@ -88,14 +106,12 @@ static struct key_type nvme_tls_psk_key_type = {
 	.read           = user_read,
 };
 
-static struct key *nvme_tls_psk_lookup(struct key *keyring,
-		const char *hostnqn, const char *subnqn,
+static struct key *nvme_tls_psk_lookup(const char *hostnqn, const char *subnqn,
 		u8 hmac, u8 psk_ver, bool generated)
 {
 	char *identity;
 	size_t identity_len = (NVMF_NQN_SIZE) * 2 + 11;
 	key_ref_t keyref;
-	key_serial_t keyring_id;
 
 	identity = kzalloc(identity_len, GFP_KERNEL);
 	if (!identity)
@@ -104,12 +120,8 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
 	snprintf(identity, identity_len, "NVMe%u%c%02u %s %s",
 		 psk_ver, generated ? 'G' : 'R', hmac, hostnqn, subnqn);
 
-	if (!keyring)
-		keyring = nvme_keyring;
-	keyring_id = key_serial(keyring);
-	pr_debug("keyring %x lookup tls psk '%s'\n",
-		 keyring_id, identity);
-	keyref = keyring_search(make_key_ref(keyring, true),
+	pr_debug("lookup tls psk '%s'\n", identity);
+	keyref = keyring_search(make_key_ref(nvme_keyring, true),
 				&nvme_tls_psk_key_type,
 				identity, false);
 	if (IS_ERR(keyref)) {
@@ -125,7 +137,6 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
 
 /**
  * nvme_tls_psk_refresh - Refresh TLS PSK
- * @keyring: Keyring holding the TLS PSK
  * @hostnqn: Host NQN to use
  * @subnqn: Subsystem NQN to use
  * @hmac_id: Hash function identifier
@@ -139,9 +150,8 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
  *
  * Returns the updated key success or an error pointer otherwise.
  */
-struct key *nvme_tls_psk_refresh(struct key *keyring,
-		const char *hostnqn, const char *subnqn, u8 hmac_id,
-		u8 *data, size_t data_len, const char *digest)
+struct key *nvme_tls_psk_refresh(const char *hostnqn, const char *subnqn,
+		u8 hmac_id, u8 *data, size_t data_len, const char *digest)
 {
 	key_perm_t keyperm =
 		KEY_POS_SEARCH | KEY_POS_VIEW | KEY_POS_READ |
@@ -149,7 +159,6 @@ struct key *nvme_tls_psk_refresh(struct key *keyring,
 		KEY_USR_SEARCH | KEY_USR_VIEW | KEY_USR_READ;
 	char *identity;
 	key_ref_t keyref;
-	key_serial_t keyring_id;
 	struct key *key;
 
 	if (!hostnqn || !subnqn || !data || !data_len)
@@ -160,12 +169,8 @@ struct key *nvme_tls_psk_refresh(struct key *keyring,
 	if (!identity)
 		return ERR_PTR(-ENOMEM);
 
-	if (!keyring)
-		keyring = nvme_keyring;
-	keyring_id = key_serial(keyring);
-	pr_debug("keyring %x refresh tls psk '%s'\n",
-		 keyring_id, identity);
-	keyref = key_create_or_update(make_key_ref(keyring, true),
+	pr_debug("refresh tls psk '%s'\n", identity);
+	keyref = key_create_or_update(make_key_ref(nvme_keyring, true),
 				"psk", identity, data, data_len,
 				keyperm, KEY_ALLOC_NOT_IN_QUOTA |
 				      KEY_ALLOC_BUILT_IN |
@@ -226,10 +231,18 @@ static struct nvme_tls_psk_priority_list {
 };
 
 /*
- * nvme_tls_psk_default - Return the preferred PSK to use for TLS ClientHello
+ * nvme_tls_psk_default - Select the preferred PSK to use for TLS ClientHello
+ * @hostnqn: Host NQN of the NVME TLS connection
+ * @subnqn: Subsystem NQN of the NVME TLS connection
+ *
+ * Looks up the preferred PSK to be used for the TLC ClientHello.
+ * The preferred PSK is the first matching PSK from the nvme_tls_psk_prio
+ * array.
+ *
+ * Returns: the key serial number of the preferred PSK or 0 if no matchine
+ * PSK was found.
  */
-key_serial_t nvme_tls_psk_default(struct key *keyring,
-		      const char *hostnqn, const char *subnqn)
+key_serial_t nvme_tls_psk_default(const char *hostnqn, const char *subnqn)
 {
 	struct key *tls_key;
 	key_serial_t tls_key_id;
@@ -240,8 +253,8 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 		u8 ver = nvme_tls_psk_prio[prio].psk_ver;
 		enum nvme_tcp_tls_cipher cipher = nvme_tls_psk_prio[prio].cipher;
 
-		tls_key = nvme_tls_psk_lookup(keyring, hostnqn, subnqn,
-					      cipher, ver, generated);
+		tls_key = nvme_tls_psk_lookup(hostnqn, subnqn, cipher,
+					      ver, generated);
 		if (!IS_ERR(tls_key)) {
 			tls_key_id = tls_key->serial;
 			key_put(tls_key);
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 295e0a9533c8995c32781324650d73b6bfedbf13..06399c075405353325b05c099811a54134fbeb53 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -726,8 +726,7 @@ static int nvme_auth_secure_concat(struct nvme_ctrl *ctrl,
 		goto out_free_digest;
 	}
 
-	tls_key = nvme_tls_psk_refresh(ctrl->opts->keyring,
-				       ctrl->opts->host->nqn,
+	tls_key = nvme_tls_psk_refresh(ctrl->opts->host->nqn,
 				       ctrl->opts->subsysnqn, chap->hash_id,
 				       tls_psk, psk_len, digest);
 	if (IS_ERR(tls_key)) {
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5ed91557f07065a284e664950a9c71d771614ec2..6a918d72d14c5dd92d00191c184e72b0e5614b7a 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -995,7 +995,11 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = PTR_ERR(key);
 				goto out;
 			}
-			key_put(opts->keyring);
+			ret = nvme_keyring_link(opts->keyring);
+			if (ret) {
+				key_put(key);
+				goto out;
+			}
 			opts->keyring = key;
 			break;
 		case NVMF_OPT_TLS_KEY:
@@ -1296,7 +1300,12 @@ static int nvmf_check_allowed_opts(struct nvmf_ctrl_options *opts,
 void nvmf_free_options(struct nvmf_ctrl_options *opts)
 {
 	nvmf_host_put(opts->host);
-	key_put(opts->keyring);
+	if (opts->keyring) {
+		int ret = nvme_keyring_unlink(opts->keyring);
+
+		WARN_ON(ret);
+		key_put(opts->keyring);
+	}
 	key_put(opts->tls_key);
 	kfree(opts->transport);
 	kfree(opts->traddr);
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 35f871e3e0c0ae49b390f0fb64c538796207a98f..c1375f23a97f6b5a47bb8aad6b12e7ff3ad12638 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/nvme-auth.h>
+#include <linux/nvme-keyring.h>
 #include <linux/blkdev.h>
 
 #include "nvme.h"
@@ -1069,6 +1070,8 @@ static ssize_t tls_keyring_show(struct device *dev,
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 	struct key *keyring = ctrl->opts->keyring;
 
+	if (!keyring)
+		return sysfs_emit(buf, "%s\n", nvme_keyring_name());
 	return sysfs_emit(buf, "%s\n", keyring->description);
 }
 static DEVICE_ATTR_RO(tls_keyring);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 62a594b8ab9bfa51a6f47b10ef2400839f9dd18e..585aba1d544518d6e712e23c7987741b130aee4d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2416,8 +2416,7 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 		if (ctrl->opts->tls_key)
 			pskid = key_serial(ctrl->opts->tls_key);
 		else if (ctrl->opts->tls) {
-			pskid = nvme_tls_psk_default(ctrl->opts->keyring,
-						      ctrl->opts->host->nqn,
+			pskid = nvme_tls_psk_default(ctrl->opts->host->nqn,
 						      ctrl->opts->subsysnqn);
 			if (!pskid) {
 				dev_err(ctrl->device, "no valid PSK found\n");
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 150818d7009d8c2fca96e12fd54fdc1cb6b68882..7ebd867c89468e94e31fd2739d3ee77018775f18 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -523,7 +523,7 @@ void nvmet_auth_insert_psk(struct nvmet_sq *sq)
 		goto out_free_digest;
 	}
 #ifdef CONFIG_NVME_TARGET_TCP_TLS
-	tls_key = nvme_tls_psk_refresh(NULL, sq->ctrl->hostnqn,
+	tls_key = nvme_tls_psk_refresh(sq->ctrl->hostnqn,
 				       sq->ctrl->subsys->subsysnqn,
 				       sq->ctrl->shash_id, tls_psk, psk_len,
 				       digest);
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index ab8971afa9734a276d9197076b780321460dddc2..680eb93088d485ca3368f615715d71fa570b1077 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -10,20 +10,22 @@
 
 #if IS_ENABLED(CONFIG_NVME_KEYRING)
 
-struct key *nvme_tls_psk_refresh(struct key *keyring,
-		const char *hostnqn, const char *subnqn, u8 hmac_id,
-		u8 *data, size_t data_len, const char *digest);
-key_serial_t nvme_tls_psk_default(struct key *keyring,
-		const char *hostnqn, const char *subnqn);
+struct key *nvme_tls_psk_refresh(const char *hostnqn, const char *subnqn,
+		u8 hmac_id, u8 *data, size_t data_len, const char *digest);
+key_serial_t nvme_tls_psk_default(const char *hostnqn, const char *subnqn);
 
 key_serial_t nvme_keyring_id(void);
+const char *nvme_keyring_name(void);
+int nvme_keyring_link(struct key *keyring);
+int nvme_keyring_unlink(struct key *keyring);
 struct key *nvme_tls_key_lookup(key_serial_t key_id);
+
 #else
 static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
-		const char *hostnqn, char *subnqn, u8 hmac_id,
+		const char *hostnqn, const char *subnqn, u8 hmac_id,
 		u8 *data, size_t data_len, const char *digest)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn)
@@ -34,9 +36,21 @@ static inline key_serial_t nvme_keyring_id(void)
 {
 	return 0;
 }
+static const char *nvme_keyring_name(void)
+{
+	return NULL;
+}
+static int nvme_keyring_link(struct key *keyring)
+{
+	return 0;
+}
+int nvme_keyring_unlink(struct key *keyring)
+{
+	return 0;
+}
 static inline struct key *nvme_tls_key_lookup(key_serial_t key_id)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 #endif /* !CONFIG_NVME_KEYRING */
 #endif /* _NVME_KEYRING_H */

-- 
2.51.0

