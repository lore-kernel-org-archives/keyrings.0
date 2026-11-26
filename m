Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702402;
	b=eQVSIURcxd/6CzenIowYQwx/2oEMHfwP08Xj31nCP/9z3f8/ZpIat40Xg0dpzJHp27z0
	 HEM/aBe2WDlCg1tEwf7DD0H+x5iqCVn1V8Ofsebs+3FXBda1x3lqd+7t4aQa9Xs6SKIxU
	 UhJklBvkxsl3UtLbXkmb6iv48ThXNpulIaWFipU0mLhrmcYTYOLrNwHnV6HXdyCOY3pLS
	 tIPIvzzW7IbrmFxC+bPn5BFeA+dHEXqRh1RbWLJiiqEmAAqv5mhQ+7ckbO8iSyrZAZ8Va
	 lBSlfECRtuwgXuTJYKyb3VfK1HCboP9irZcZ46sOW2cfLNtFyWc2sKPl9eVeuAYGr5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702402;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=d5YDxJgG9JK1JSRTRJjyKxiPRcaLyJnCOnFuKhIe6Uk=;
	b=XhQemJsJRCbKs3oa4H4q6gWiRFZoKGS+DEtglEy5tyJtySl37z4oU8wq8miDg3H/TG7k
	 msDKdXNhPcmRxuIEsBj9SBjx2u0HiTxp1u4253uuRDr2stUaD4Zz4zlNlDG/nhSY7rHhq
	 HMC3UZGawxmnjmx4VZJW0E817WAWHstXywsG9bemcWojLditNupLvjhKxMOO6TA18EBCw
	 OR3p0hwt8CdErIYjY6xm96JTs7OSCcoQtBzajKhNkBiR8kP3ajYOJb//EqQRbsCabvzSZ
	 5YC+j1dRjy+ZTVFCDkjZ5lzTgdf+fz4VMRrI9gjw5jXeNvVrAu5y5o2IL5jATjQx/gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X980siII;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E14B606A321;
	Thu, 26 Nov 2026 14:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X980siII
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE771F000F2;
	Thu, 26 Nov 2026 14:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702402;
	bh=d5YDxJgG9JK1JSRTRJjyKxiPRcaLyJnCOnFuKhIe6Uk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=X980siIIaXZQ1JaNNjrNWWg/8vsbOVA3BVb1+ptQexuwzVOrOFyQpCU5QPEK/muNc
	 nnrzIxTILIEZWPtG3x18nbzugeKPbwXcko6e23h6HlOK3mtpE7baKMQqpL5K5oMu5t
	 WCU9iZKwME+0lbmFSxnqXw+gKxFX/DcnoeEPhLwZMwkWuvyqwg9C6+Y9FJFGWZfBpb
	 ndaRiQTyzUB1k/vPe5QtYBjynDxCGxxurTH7vDF9bR+lMS866YzgvN0MPPUlM6q18x
	 Wrk4wS4LLbNa4Q6leUq4s/D+rzVgk5Ksq176V6WMLiWgL4tp85aI1QPHnXOYJnxeEZ
	 m+HacA/gH5h7Q==
From: Hannes Reinecke <hare@kernel.org>
Date: Thu, 26 Nov 2026 15:12:27 +0100
Subject: [PATCH v7 09/14] nvme: allow to pass in key description as dhchap
 secret
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
Message-Id: <20261126-dhchap-keyring-v4-v7-9-ee438ffea527@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702352; l=18752;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=ouJr8PFV8MCzXnDoMBmOshUppzVgb/qgGCqNeq5hKPE=;
 b=PnKB2hFSnA5AyKc+QWsGxyDnfNHuLowj5YvynwHaKNm8F81mEVCmF9iyrlGZrQiLZ6GMT7jl9
 ipTlsOYMg/HCFAiMuKlLJJ9Ud/h6KD9TWiXtdnuHWoil39CKWXnnYkt
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

In order to use pre-populated keys update 'nvme_auth_extract_key()'
to accept a key description argument in addition to the currently
implemented raw key data. To mark this change rename the 'secret'
parameter of that function to 'input', and add a function description
to document the usage. Also add a 'generated' flag to distinguish
whether the keys have been auto-generated (which should be revoked
after use) or pre-populated (which should not be revoked).

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/auth.c     | 23 ++++++++++++++++-----
 drivers/nvme/host/auth.c       | 15 ++++++++++++++
 drivers/nvme/host/fabrics.c    | 30 +++++++++++++++++++++++++--
 drivers/nvme/host/fabrics.h    |  4 ++++
 drivers/nvme/host/nvme.h       |  2 ++
 drivers/nvme/host/sysfs.c      | 47 ++++++++++++++++++++++++++++++------------
 drivers/nvme/target/auth.c     | 32 ++++++++++++++++++----------
 drivers/nvme/target/configfs.c | 12 +++++++----
 drivers/nvme/target/nvmet.h    |  2 ++
 include/linux/nvme-auth.h      |  3 ++-
 10 files changed, 134 insertions(+), 36 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index ce16e7bf0c0edb892386dda97aacca0e758d3324..15e72fe8868af5698809cd6634a1f1f1da11ca2d 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -143,19 +143,32 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
 /**
  * nvme_auth_extract_key - extract the DH-HMAC-CHAP key
  *
- * @secret: key data
- * @secret_len: length of @secret
+ * @input: key description or key data
+ * @input_len: length of @input
+ * @generated: indicate whether a key has been generated
  *
- * Extracts a dhchap key from @secret.
+ * Extracts or generates a key from @input.
+ * @input can either be a key description or raw key data; in
+ * the latter case a key is generated from @input and
+ * @generated is set to 'true'.
  *
  * Returns the dhchap key or an error pointer on failure.
  */
-struct key *nvme_auth_extract_key(const char *secret, size_t secret_len)
+struct key *nvme_auth_extract_key(const char *input, size_t input_len,
+				  bool *generated)
 {
 	struct key *key;
 
-	key = nvme_dhchap_psk_create(secret, secret_len);
+	/* Check if @input is a key description */
+	key = nvme_dhchap_psk_lookup(input);
 	if (!IS_ERR(key)) {
+		*generated = false;
+		return key;
+	}
+	/* Generate a key from @input data */
+	key = nvme_dhchap_psk_create(input, input_len);
+	if (!IS_ERR(key)) {
+		*generated = true;
 		pr_debug("generated dhchap key %s\n",
 			 key->description);
 	}
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 285aa1c71f1026d17408f64500c7b41007c9d493..37307e64a4925c085f5393afbb1359780404ad71 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -1031,11 +1031,21 @@ static void nvme_auth_clear_key(struct nvme_ctrl *ctrl, bool is_ctrl)
 	if (is_ctrl) {
 		key = ctrl->ctrl_key;
 		ctrl->ctrl_key = NULL;
+		generated = ctrl->ctrl_key_generated;
+		ctrl->ctrl_key_generated = false;
 	} else {
 		key = ctrl->host_key;
 		ctrl->host_key = NULL;
+		generated = ctrl->host_key_generated;
+		ctrl->host_key_generated = false;
 	}
 	if (key) {
+		if (generated) {
+			dev_dbg(ctrl->device, "%s: revoke dhchap%s key %08x\n",
+				__func__, is_ctrl ? " ctrl" : " host",
+				key_serial(key));
+			key_revoke(key);
+		}
 		dev_dbg(ctrl->device, "%s: drop dhchap%s key %08x\n",
 			__func__, is_ctrl ? " ctrl" : " host",
 			key_serial(key));
@@ -1050,6 +1060,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dhchap_queue_context *chap;
 	struct key *host_key, *ctrl_key = NULL;
+	bool host_key_generated, ctrl_key_generated;
 	int i, ret;
 
 	mutex_init(&ctrl->dhchap_auth_mutex);
@@ -1077,6 +1088,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 		key_put(host_key);
 		return -ENOKEY;
 	}
+	host_key_generated = ctrl->opts->dhchap_key_generated;
 
 	if (ctrl->opts->dhchap_ctrl_key) {
 		ctrl_key = key_lookup(ctrl->opts->dhchap_ctrl_key);
@@ -1096,6 +1108,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 			key_put(host_key);
 			return -EKEYREVOKED;
 		}
+		ctrl_key_generated = ctrl->opts->dhchap_ctrl_key_generated;
 	}
 
 	pr_debug("%s: using dhchap host key %08x\n",
@@ -1103,6 +1116,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 	if (ctrl->host_key)
 		nvme_auth_clear_host_key(ctrl);
 	ctrl->host_key = host_key;
+	ctrl->host_key_generated = host_key_generated;
 
 	if (ctrl->ctrl_key)
 		nvme_auth_clear_ctrl_key(ctrl);
@@ -1110,6 +1124,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 		pr_debug("%s: using dhchap ctrl key %08x\n",
 			 __func__, key_serial(ctrl_key));
 		ctrl->ctrl_key = ctrl_key;
+		ctrl->ctrl_key_generated = ctrl_key_generated;
 	}
 
 	ctrl->dhchap_ctxs = kvzalloc_objs(*chap, ctrl_max_dhchaps(ctrl));
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 6c453b4f5cab1546fb036236bbfa8682a8611adb..bba6a4848f2271beee5a4b051419fcb1e703211f 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -742,7 +742,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->keyring = NULL;
 	opts->concat = false;
 	opts->dhchap_key = 0;
+	opts->dhchap_key_generated = false;
 	opts->dhchap_ctrl_key = 0;
+	opts->dhchap_ctrl_key_generated = false;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -1094,7 +1096,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	if (host_secret) {
 #ifdef CONFIG_NVME_HOST_AUTH
 		pr_debug("lookup dhchap host secret '%s'\n", host_secret);
-		key = nvme_auth_extract_key(host_secret, strlen(host_secret));
+		key = nvme_auth_extract_key(host_secret, strlen(host_secret),
+					    &opts->dhchap_key_generated);
 		if (IS_ERR(key)) {
 			ret = PTR_ERR(key);
 			goto out;
@@ -1111,7 +1114,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			goto out;
 		}
 		pr_debug("lookup dhchap ctrl secret '%s'\n", ctrl_secret);
-		key = nvme_auth_extract_key(ctrl_secret, strlen(ctrl_secret));
+		key = nvme_auth_extract_key(ctrl_secret, strlen(ctrl_secret),
+					    &opts->dhchap_ctrl_key_generated);
 		if (IS_ERR(key)) {
 			ret = PTR_ERR(key);
 			goto out;
@@ -1326,7 +1330,29 @@ static int nvmf_check_allowed_opts(struct nvmf_ctrl_options *opts,
 
 void nvmf_free_options(struct nvmf_ctrl_options *opts)
 {
+	struct key *key;
+
 	nvmf_host_put(opts->host);
+	if (opts->dhchap_key &&
+	    opts->dhchap_key_generated) {
+		key = key_lookup(opts->dhchap_key);
+		if (!IS_ERR(key)) {
+			pr_debug("revoke dhchap host key %08x\n",
+				 opts->dhchap_key);
+			key_revoke(key);
+			key_put(key);
+		}
+	}
+	if (opts->dhchap_ctrl_key &&
+	    opts->dhchap_ctrl_key_generated) {
+		key = key_lookup(opts->dhchap_ctrl_key);
+		if (!IS_ERR(key)) {
+			pr_debug("revoke dhchap ctrl key %08x\n",
+				 opts->dhchap_ctrl_key);
+			key_revoke(key);
+			key_put(key);
+		}
+	}
 	if (opts->keyring) {
 		int ret = nvme_keyring_unlink(opts->keyring);
 
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 49a6f6b6833a852a55e3bd3a3fbf3f1ca3e8c5d0..f2cce812362e2e9ec2f35837f16fbdf11ee87c35 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -99,6 +99,8 @@ enum {
  * @dhchap_key: DH-HMAC-CHAP pre-shared key
  * @dhchap_ctrl_key: DH-HMAC-CHAP controller pre-shared key for bi-directional
  *              authentication
+ * @dhchap_key_generated: True if the @dhchap_key has been auto-generated
+ * @dhchap_ctrl_key_generated: True if @dhchap_ctrl_key has been auto-generated
  * @keyring:    Keyring to use for key lookups
  * @tls_key:    TLS key for encrypted connections (TCP)
  * @tls:        Start TLS encrypted connections (TCP)
@@ -129,6 +131,8 @@ struct nvmf_ctrl_options {
 	struct nvmf_host	*host;
 	key_serial_t		dhchap_key;
 	key_serial_t		dhchap_ctrl_key;
+	bool			dhchap_key_generated;
+	bool			dhchap_ctrl_key_generated;
 	struct key		*keyring;
 	struct key		*tls_key;
 	bool			tls;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 434e3612c996a969075aa5844c51906c605e6f56..1161f94cca19b1e223ebc4e2894c6e3ae7d6779a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -464,6 +464,8 @@ struct nvme_ctrl {
 	struct key *host_key;
 	struct key *ctrl_key;
 	u16 transaction;
+	bool host_key_generated;
+	bool ctrl_key_generated;
 #endif
 	key_serial_t tls_pskid;
 
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 27f06394af83601ae4ad4a06f3f235d48c5a73d9..ab912a4b281c717ca569062c19850d305f20500d 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -833,13 +833,14 @@ static ssize_t dhchap_secret_show(struct device *dev,
 	down_read(&key->sem);
 	if (key_validate(key))
 		count = sysfs_emit(buf, "<invalidated>\n");
-	else {
+	else if (ctrl->host_key_generated) {
 		count = key->type->read(key, buf, PAGE_SIZE);
 		if (count > 0) {
 			buf[count] = '\n';
 			count++;
 		}
-	}
+	} else
+		count = sysfs_emit(buf, "%s\n", key->description);
 	up_read(&key->sem);
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	return count;
@@ -851,6 +852,7 @@ static ssize_t dhchap_secret_store(struct device *dev,
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 	struct key *key, *old_key;
 	char *dhchap_secret;
+	bool generated = false;
 	size_t len;
 	int ret;
 
@@ -864,7 +866,8 @@ static ssize_t dhchap_secret_store(struct device *dev,
 	memcpy(dhchap_secret, buf, len);
 	nvme_auth_stop(ctrl);
 
-	key = nvme_auth_extract_key(dhchap_secret, len);
+	key = nvme_auth_extract_key(dhchap_secret, len,
+				    &generated);
 	if (IS_ERR(key)) {
 		kfree_sensitive(dhchap_secret);
 		return PTR_ERR(key);
@@ -875,7 +878,11 @@ static ssize_t dhchap_secret_store(struct device *dev,
 	if (ret) {
 		dev_warn(ctrl->device, "key %08x invalidated\n",
 			 key_serial(key));
-		key_revoke(key);
+		if (generated) {
+			dev_dbg(ctrl->device, "revoke host key %08x\n",
+				key_serial(key));
+			key_revoke(key);
+		}
 		key_put(key);
 		kfree_sensitive(dhchap_secret);
 		return ret;
@@ -885,10 +892,15 @@ static ssize_t dhchap_secret_store(struct device *dev,
 	if (old_key && key_serial(old_key) == key_serial(key)) {
 		dev_warn(ctrl->device, "using existing key %08x\n",
 			 key_serial(old_key));
-		key_revoke(key);
 		old_key = key;
 	} else {
+		if (ctrl->host_key_generated) {
+			dev_dbg(ctrl->device, "revoke host key %08x\n",
+				key_serial(old_key));
+			key_revoke(old_key);
+		}
 		ctrl->host_key = key;
+		ctrl->host_key_generated = generated;
 	}
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	key_put(old_key);
@@ -915,16 +927,18 @@ static ssize_t dhchap_ctrl_secret_show(struct device *dev,
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		return sysfs_emit(buf, "none\n");
 	}
+
 	down_read(&key->sem);
 	if (key_validate(key))
 		count = sysfs_emit(buf, "<invalidated>\n");
-	else {
+	else if (ctrl->ctrl_key_generated) {
 		count = key->type->read(key, buf, PAGE_SIZE);
 		if (count > 0) {
 			buf[count] = '\n';
 			count++;
 		}
-	}
+	} else
+		count = sysfs_emit(buf, "%s\n", key->description);
 	up_read(&key->sem);
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	return count;
@@ -936,6 +950,7 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 	struct key *key, *old_key;
 	char *dhchap_secret;
+	bool generated = false;
 	size_t len;
 	int ret;
 
@@ -948,7 +963,8 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 		return -ENOMEM;
 	memcpy(dhchap_secret, buf, len);
 	nvme_auth_stop(ctrl);
-	key = nvme_auth_extract_key(dhchap_secret, len);
+	key = nvme_auth_extract_key(dhchap_secret, len,
+				    &generated);
 	if (IS_ERR(key)) {
 		kfree_sensitive(dhchap_secret);
 		return PTR_ERR(key);
@@ -959,9 +975,11 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 	if (ret) {
 		dev_warn(ctrl->device, "key %08x invalidated\n",
 			 key_serial(key));
-		dev_dbg(ctrl->device, "revoke ctrl key %08x\n",
-			key_serial(key));
-		key_revoke(key);
+		if (generated) {
+			dev_dbg(ctrl->device, "revoke ctrl key %08x\n",
+				key_serial(key));
+			key_revoke(key);
+		}
 		key_put(key);
 		kfree_sensitive(dhchap_secret);
 		return ret;
@@ -973,10 +991,13 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 			 key_serial(old_key));
 		old_key = key;
 	} else {
-		dev_dbg(ctrl->device, "revoke ctrl key %08x\n",
+		if (ctrl->ctrl_key_generated) {
+			dev_dbg(ctrl->device, "revoke ctrl key %08x\n",
 				key_serial(old_key));
-		key_revoke(old_key);
+			key_revoke(old_key);
+		}
 		ctrl->ctrl_key = key;
+		ctrl->ctrl_key_generated = generated;
 	}
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	key_put(old_key);
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index ff0e8569d70675e80c1a8f18733a83317184026a..54e79c8a7cae67a509a9f6b993b7886e706af8e0 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -20,31 +20,38 @@
 #include "nvmet.h"
 
 static void nvmet_auth_update_key(struct nvmet_host *host, bool set_ctrl,
-				  struct key *new_key)
+				  struct key *new_key, bool new_generated)
 {
 	key_serial_t old_key_id = 0, new_key_id = key_serial(new_key);
 	struct key *key = NULL;
+	bool generated = false;
 
 	if (set_ctrl) {
 		if (host->dhchap_ctrl_key) {
 			if (host->dhchap_ctrl_key == new_key_id) {
-				if (new_key)
+				if (new_key && new_generated)
 					key_revoke(new_key);
 				return;
 			}
 			old_key_id = host->dhchap_ctrl_key;
+			generated = host->dhchap_ctrl_key_generated;
+			host->dhchap_ctrl_key_generated = false;
 		}
 		host->dhchap_ctrl_key = new_key_id;
+		host->dhchap_key_generated = new_generated;
 	} else {
 		if (host->dhchap_key) {
 			if (host->dhchap_key == new_key_id) {
-				if (new_key)
+				if (new_key && new_generated)
 					key_revoke(new_key);
 				return;
 			}
 			old_key_id = host->dhchap_key;
+			generated = host->dhchap_key_generated;
+			host->dhchap_key_generated = false;
 		}
 		host->dhchap_key = new_key_id;
+		host->dhchap_key_generated = new_generated;
 	}
 	if (!old_key_id)
 		return;
@@ -52,32 +59,35 @@ static void nvmet_auth_update_key(struct nvmet_host *host, bool set_ctrl,
 	key = key_lookup(old_key_id);
 	if (IS_ERR(key))
 		return;
-	pr_debug("%s: revoke %s key %08x\n", __func__,
-		 set_ctrl ? "ctrl" : "host", key_serial(key));
-	key_revoke(key);
+	if (generated) {
+		pr_debug("%s: revoke %s key %08x\n", __func__,
+			 set_ctrl ? "ctrl" : "host", key_serial(key));
+		key_revoke(key);
+	}
 	key_put(key);
 }
 
 void nvmet_auth_clear_key(struct nvmet_host *host)
 {
-	nvmet_auth_update_key(host, false, NULL);
-	nvmet_auth_update_key(host, true, NULL);
+	nvmet_auth_update_key(host, false, NULL, false);
+	nvmet_auth_update_key(host, true, NULL, false);
 }
 
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl)
 {
+	bool generated = false;
 	struct key *key;
 	size_t len;
 
 	if (!secret || !strlen(secret)) {
 		down_write(&nvmet_config_sem);
-		nvmet_auth_update_key(host, set_ctrl, NULL);
+		nvmet_auth_update_key(host, set_ctrl, NULL, false);
 		up_write(&nvmet_config_sem);
 		return 0;
 	}
 	len = strcspn(secret, "\n");
-	key = nvme_auth_extract_key(secret, len);
+	key = nvme_auth_extract_key(secret, len, &generated);
 	if (IS_ERR(key)) {
 		pr_debug("%s: invalid key specification\n", __func__);
 		return PTR_ERR(key);
@@ -92,7 +102,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 	}
 	up_read(&key->sem);
 	down_write(&nvmet_config_sem);
-	nvmet_auth_update_key(host, set_ctrl, key);
+	nvmet_auth_update_key(host, set_ctrl, key, generated);
 	up_write(&nvmet_config_sem);
 	key_put(key);
 	return 0;
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index f6bfda757f076293e6e3a2db4d4245ea3a754b40..3defa3f9484972265a5351ed08055735c859be74 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -2248,13 +2248,15 @@ static ssize_t nvmet_host_dhchap_key_show(struct config_item *item,
 		down_read(&key->sem);
 		if (key_validate(key))
 			ret = sprintf(page, "<invalidated>\n");
-		else {
+		else if (host->dhchap_key_generated) {
 			ret = key->type->read(key, page, PAGE_SIZE);
 			if (ret > 0) {
 				page[ret] = '\n';
 				ret++;
 			}
-		}
+		} else
+			ret = scnprintf(page, PAGE_SIZE,
+					"%s\n", key->description);
 		up_read(&key->sem);
 		key_put(key);
 	}
@@ -2305,13 +2307,15 @@ static ssize_t nvmet_host_dhchap_ctrl_key_show(struct config_item *item,
 		down_read(&key->sem);
 		if (key_validate(key))
 			ret = sprintf(page, "<invalidated>\n");
-		else {
+		else if (host->dhchap_ctrl_key_generated) {
 			ret = key->type->read(key, page, PAGE_SIZE);
 			if (ret > 0) {
 				page[ret] = '\n';
 				ret++;
 			}
-		}
+		} else
+			ret = scnprintf(page, PAGE_SIZE,
+					"%s\n", key->description);
 		up_read(&key->sem);
 		key_put(key);
 	}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index df84776b90f3e198f19f158e82ddddc473ee7296..f6848a2f4e4c7857dcd710522db80a24a13f3e3e 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -400,7 +400,9 @@ static inline struct nvmet_subsys *namespaces_to_subsys(
 struct nvmet_host {
 	struct config_group	group;
 	key_serial_t		dhchap_key;
+	bool			dhchap_key_generated;
 	key_serial_t		dhchap_ctrl_key;
+	bool			dhchap_ctrl_key_generated;
 	u8			dhchap_hash_id;
 	u8			dhchap_dhgroup_id;
 };
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index ac618b82585ec8d81f1aa92823821488eba32a32..1f912a40aca3fab85498f85ba43059a427bb956f 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -31,7 +31,8 @@ void nvme_auth_hmac_update(struct nvme_auth_hmac_ctx *hmac, const u8 *data,
 			   size_t data_len);
 void nvme_auth_hmac_final(struct nvme_auth_hmac_ctx *hmac, u8 *out);
 
-struct key *nvme_auth_extract_key(const char *secret, size_t secret_len);
+struct key *nvme_auth_extract_key(const char *input, size_t input_len,
+				  bool *generated);
 int nvme_auth_transform_key(struct key *key, const char *nqn,
 			    u8 **transformed_secret);
 int nvme_auth_augmented_challenge(u8 hmac_id, const u8 *skey, size_t skey_len,

-- 
2.51.0

