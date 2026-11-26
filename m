Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702362;
	b=xi7xQkDiw8ewrjM4d9PP9ByFR+HZqED/d23vCWfjHScYdqy8GHCK+pcQ/u83bIiSmBTE
	 LYx3ATE6uei0f3rmDSp7ORp6zXR0s1iW+RJdP7Kpp1zWfrF8H0zDttx/9HDgyU+9bP9OH
	 7+cp3zV5MDS6GyGuTn2yxBWLKdMr10FxqBpeHNjlF5BXQdR+ZBidupgxATGDJqIAZgTWN
	 rItGj/K5iLuyumkGEc7T7Gx2IWgIpFe0uFf4B5/i1QOu9+4Ggnq3FQgEhxFPSXtj+2bOB
	 h/y15nCvXrGQZKbki0ugpsrCQdq3RsywlFM3yDmgfP/YvTgotwIZ3BQh2/VlZZ0ik4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702362;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=kRbunCWh64X8sjPCCbsN6qVv/uy3p7pcuqx0kyRvjVY=;
	b=MWI9rIFIalO1HWzu4oao9vhabdv89v1zdC+lLsp7og3BTQd0fKfAFZ5EKNXH28HdKnLg
	 Nu00YSRP/lrhxjdSjaH3mhHdxb2e2UvBQ7ieSaB/use59IeC70P4nMITQyvtqFbZ7c7Tg
	 dAkQZjf+Fh5vSeher6X2S3XyYzxQcsSZMWm426f+17p9APV/FdUP7SPdvgxjFLq6hHmFH
	 oBGkN7bZIRmWYnNIKtiSSEwA3Ea/yIk4E70dXPV58NPqDpDWsnM2IklnxzFi56HEFUN3U
	 lIeJUiSBmUcAiguhL/S3otpEq+Srfwmxjfo+TffcurJAJAE/v+fC3T5zLCpWZgHsECg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGtXt8Hw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C4B606A31C;
	Thu, 26 Nov 2026 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fGtXt8Hw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724611F000CA;
	Thu, 26 Nov 2026 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702362;
	bh=kRbunCWh64X8sjPCCbsN6qVv/uy3p7pcuqx0kyRvjVY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fGtXt8HwYSxQrt/SbFJeWcCgjNL0wU+80x9lEN+8KtBKEc1vnndjaMUIKDTsf8j6k
	 qML4yWkReqZBgJxhlFvgi+i17nvRVcIFxBBNFub5WQIU/ytbR7UhLTlh0eMa+TB/h2
	 CCTWlErM0I+vy0qFIJ7tESdIlhN0kUgCV+VbCU/X71CvtxOSCa1A23ikcT05cPrl8g
	 flpIdOqKwJFdmojJbZ5G0N4tM8mnxWQ7nT3G/AkGufeuwRUZKhmUgXAnPDa+T/weq+
	 LHO0E0BFR92xpK/3q7XPo9ozEZRXSYt8a4kAkgxWfDU3A/9ktDYiEF6O0XotDXoQXy
	 6093CWSQhOFxA==
From: Hannes Reinecke <hare@kernel.org>
Date: Thu, 26 Nov 2026 15:12:19 +0100
Subject: [PATCH v7 01/14] nvme-auth: modify nvme_auth_transform_key() to
 return status
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
Message-Id: <20261126-dhchap-keyring-v4-v7-1-ee438ffea527@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702352; l=9494;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=Ld7A5CpfR4qv5lsoGPUMMTLqr6yQkEMwmB6MKXTXMzQ=;
 b=qNcUxIlpRBXN9DDUz9RRBHGxwmhrdGBgYc45r5nTDXWmg4dK9Hu+PZKNBSZFAz04woL9cIdkq
 4rzuSZCsdn5Deh7KG703fesJjpF8KKp32YXUAf0CNuDY/tYHSwphHtZ
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

In preparation for converting the DH-HMAC-CHAP code to use the
kernel keyring modify nvme_auth_transform_key() to return a status
and provide the transformed data as argument on the command line as
raw data.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/auth.c | 37 ++++++++++++++++++++-----------------
 drivers/nvme/host/auth.c   | 44 +++++++++++++++++++++++---------------------
 drivers/nvme/target/auth.c | 37 +++++++++++++++++++++----------------
 include/linux/nvme-auth.h  |  4 ++--
 4 files changed, 66 insertions(+), 56 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 1fdc4e4ed0b94d8a36aade033f19e17463f15632..308af3d7c7383acbfb327921c8a650898f0e15ea 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -317,37 +317,40 @@ static int nvme_auth_hash(u8 hmac_id, const u8 *data, size_t data_len, u8 *out)
 	return -EINVAL;
 }
 
-struct nvme_dhchap_key *nvme_auth_transform_key(
-		const struct nvme_dhchap_key *key, const char *nqn)
+int nvme_auth_transform_key(const struct nvme_dhchap_key *key, const char *nqn,
+			    u8 **transformed_secret)
 {
 	struct nvme_auth_hmac_ctx hmac;
-	struct nvme_dhchap_key *transformed_key;
-	int ret, key_len;
+	u8 *key_data;
+	size_t transformed_len;
+	int ret;
 
 	if (!key) {
 		pr_warn("No key specified\n");
-		return ERR_PTR(-ENOKEY);
+		return -ENOKEY;
 	}
 	if (key->hash == 0) {
-		key_len = nvme_auth_key_struct_size(key->len);
-		transformed_key = kmemdup(key, key_len, GFP_KERNEL);
-		if (!transformed_key)
-			return ERR_PTR(-ENOMEM);
-		return transformed_key;
+		key_data = kzalloc(key->len, GFP_KERNEL);
+		if (!key_data)
+			return -ENOMEM;
+		memcpy(key_data, key->key, key->len);
+		*transformed_secret = key_data;
+		return key->len;
 	}
 	ret = nvme_auth_hmac_init(&hmac, key->hash, key->key, key->len);
 	if (ret)
-		return ERR_PTR(ret);
-	key_len = nvme_auth_hmac_hash_len(key->hash);
-	transformed_key = nvme_auth_alloc_key(key_len, key->hash);
-	if (!transformed_key) {
+		return ret;
+	transformed_len = nvme_auth_hmac_hash_len(key->hash);
+	key_data = kzalloc(transformed_len, GFP_KERNEL);
+	if (!key_data) {
 		memzero_explicit(&hmac, sizeof(hmac));
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	}
 	nvme_auth_hmac_update(&hmac, nqn, strlen(nqn));
 	nvme_auth_hmac_update(&hmac, "NVMe-over-Fabrics", 17);
-	nvme_auth_hmac_final(&hmac, transformed_key->key);
-	return transformed_key;
+	nvme_auth_hmac_final(&hmac, key_data);
+	*transformed_secret = key_data;
+	return transformed_len;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_transform_key);
 
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 9a3da74dec5aa818538dfbc36fd27f7f756cc059..295e0a9533c8995c32781324650d73b6bfedbf13 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -22,7 +22,8 @@ struct nvme_dhchap_queue_context {
 	struct work_struct auth_work;
 	struct nvme_ctrl *ctrl;
 	struct crypto_kpp *dh_tfm;
-	struct nvme_dhchap_key *transformed_key;
+	u8 *transformed_secret;
+	size_t transformed_len;
 	void *buf;
 	int qid;
 	int error;
@@ -436,22 +437,21 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 	dev_dbg(ctrl->device, "%s: qid %d host response seq %u transaction %d\n",
 		__func__, chap->qid, chap->s1, chap->transaction);
 
-	if (!chap->transformed_key) {
-		chap->transformed_key = nvme_auth_transform_key(ctrl->host_key,
-						ctrl->opts->host->nqn);
-		if (IS_ERR(chap->transformed_key)) {
-			ret = PTR_ERR(chap->transformed_key);
-			chap->transformed_key = NULL;
+	if (!chap->transformed_secret) {
+		ret = nvme_auth_transform_key(ctrl->host_key,
+					      ctrl->opts->host->nqn,
+					      &chap->transformed_secret);
+		if (ret < 0)
 			return ret;
-		}
+		chap->transformed_len = ret;
 	} else {
 		dev_dbg(ctrl->device, "%s: qid %d re-using host response\n",
 			__func__, chap->qid);
 	}
 
 	ret = nvme_auth_hmac_init(&hmac, chap->hash_id,
-				  chap->transformed_key->key,
-				  chap->transformed_key->len);
+				  chap->transformed_secret,
+				  chap->transformed_len);
 	if (ret)
 		goto out;
 
@@ -500,19 +500,20 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 		struct nvme_dhchap_queue_context *chap)
 {
 	struct nvme_auth_hmac_ctx hmac;
-	struct nvme_dhchap_key *transformed_key;
+	u8 *transformed_secret;
+	size_t transformed_len;
 	u8 buf[4], *challenge = chap->c2;
 	int ret;
 
-	transformed_key = nvme_auth_transform_key(ctrl->ctrl_key,
-				ctrl->opts->subsysnqn);
-	if (IS_ERR(transformed_key)) {
-		ret = PTR_ERR(transformed_key);
+	ret = nvme_auth_transform_key(ctrl->ctrl_key,
+				      ctrl->opts->subsysnqn,
+				      &transformed_secret);
+	if (ret < 0)
 		return ret;
-	}
+	transformed_len = ret;
 
-	ret = nvme_auth_hmac_init(&hmac, chap->hash_id, transformed_key->key,
-				  transformed_key->len);
+	ret = nvme_auth_hmac_init(&hmac, chap->hash_id, transformed_secret,
+				  transformed_len);
 	if (ret) {
 		dev_warn(ctrl->device, "qid %d: failed to init hmac, error %d\n",
 			 chap->qid, ret);
@@ -565,7 +566,7 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 	if (challenge != chap->c2)
 		kfree(challenge);
 	memzero_explicit(&hmac, sizeof(hmac));
-	nvme_auth_free_key(transformed_key);
+	kfree_sensitive(transformed_secret);
 	return ret;
 }
 
@@ -628,8 +629,9 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
 
 static void nvme_auth_reset_dhchap(struct nvme_dhchap_queue_context *chap)
 {
-	nvme_auth_free_key(chap->transformed_key);
-	chap->transformed_key = NULL;
+	kfree_sensitive(chap->transformed_secret);
+	chap->transformed_secret = NULL;
+	chap->transformed_len = 0;
 	kfree_sensitive(chap->host_key);
 	chap->host_key = NULL;
 	chap->host_key_len = 0;
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index a4a2a5cfd823f921a9e9503f41de51b846c43296..150818d7009d8c2fca96e12fd54fdc1cb6b68882 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -295,17 +295,19 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	struct nvme_auth_hmac_ctx hmac;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	u8 *challenge = req->sq->dhchap_c1;
-	struct nvme_dhchap_key *transformed_key;
+	u8 *transformed_secret;
+	size_t transformed_len;
 	u8 buf[4];
 	int ret;
 
-	transformed_key = nvme_auth_transform_key(ctrl->host_key,
-						  ctrl->hostnqn);
-	if (IS_ERR(transformed_key))
-		return PTR_ERR(transformed_key);
+	ret = nvme_auth_transform_key(ctrl->host_key, ctrl->hostnqn,
+				      &transformed_secret);
+	if (ret < 0)
+		return ret;
+	transformed_len = ret;
 
-	ret = nvme_auth_hmac_init(&hmac, ctrl->shash_id, transformed_key->key,
-				  transformed_key->len);
+	ret = nvme_auth_hmac_init(&hmac, ctrl->shash_id, transformed_secret,
+				  transformed_len);
 	if (ret)
 		goto out_free_response;
 
@@ -357,7 +359,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 		kfree(challenge);
 out_free_response:
 	memzero_explicit(&hmac, sizeof(hmac));
-	nvme_auth_free_key(transformed_key);
+	kfree_sensitive(transformed_secret);
 	return ret;
 }
 
@@ -367,17 +369,20 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 	struct nvme_auth_hmac_ctx hmac;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	u8 *challenge = req->sq->dhchap_c2;
-	struct nvme_dhchap_key *transformed_key;
+	u8 *transformed_secret;
+	size_t transformed_len;
 	u8 buf[4];
 	int ret;
 
-	transformed_key = nvme_auth_transform_key(ctrl->ctrl_key,
-						ctrl->subsys->subsysnqn);
-	if (IS_ERR(transformed_key))
-		return PTR_ERR(transformed_key);
+	ret = nvme_auth_transform_key(ctrl->ctrl_key,
+				      ctrl->subsys->subsysnqn,
+				      &transformed_secret);
+	if (ret < 0)
+		return ret;
+	transformed_len = ret;
 
-	ret = nvme_auth_hmac_init(&hmac, ctrl->shash_id, transformed_key->key,
-				  transformed_key->len);
+	ret = nvme_auth_hmac_init(&hmac, ctrl->shash_id, transformed_secret,
+				  transformed_len);
 	if (ret)
 		goto out_free_response;
 
@@ -426,7 +431,7 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 		kfree(challenge);
 out_free_response:
 	memzero_explicit(&hmac, sizeof(hmac));
-	nvme_auth_free_key(transformed_key);
+	kfree_sensitive(transformed_secret);
 	return ret;
 }
 
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index d674d8ab26e6b3b4b297ebaefa3f33b8ec97bc0a..1c5ce635b169dd0747c1344e9adcc14839776cd1 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -41,8 +41,8 @@ u32 nvme_auth_key_struct_size(u32 key_len);
 struct nvme_dhchap_key *nvme_auth_extract_key(const char *secret, u8 key_hash);
 void nvme_auth_free_key(struct nvme_dhchap_key *key);
 struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash);
-struct nvme_dhchap_key *nvme_auth_transform_key(
-		const struct nvme_dhchap_key *key, const char *nqn);
+int nvme_auth_transform_key(const struct nvme_dhchap_key *key,
+			    const char *nqn, u8 **transformed_secret);
 int nvme_auth_parse_key(const char *secret, struct nvme_dhchap_key **ret_key);
 int nvme_auth_augmented_challenge(u8 hmac_id, const u8 *skey, size_t skey_len,
 				  const u8 *challenge, u8 *aug, size_t hlen);

-- 
2.51.0

