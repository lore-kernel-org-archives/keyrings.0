Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702392;
	b=L0Rw4J6PQXfB8wlYIANjpF1MFcjdqx5aB0lji51auuZWB+bz3J0Q+m2pZfLxJk8xZm6/
	 b1n7hgK0Biz2yBmKCIx5hhPSJb29bggBQqQTNnTv6KIfHkGU5q1Nq8lYh0K16BXIiRxkA
	 LxjdfjwZ5YjRQZgjIVvxtK0MTYoqH7WjmSbMzuRhQB2dQKA0wzL4o6BuU4syPHfFrIcjq
	 +6ghXuKyM93ExgwwGZ1eDEE35FkF8RCg8MG44/QaBK0/CJdGBaDsVRkEtUM9YuHhL34HZ
	 UA8k+iWYF1TYn0mCo1B+zTPhYnlpbtlAKAJ3rCpc7nkrSK0Ce6f6YvEmIvb0v8PhApg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702392;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=8xZveT6SrxHucTHAKZXA+BGtTzyVHhiH3Vbl+1uxlJ4=;
	b=M/Kxsuzm6I7S6LkFOZ8fDXyvV022tGyNTLfzGl2H8DpycHbFISgUGa8IAMi4gJ8caGpS
	 A7ysIl/m2r5ppZcGPcH2h5rJ1xeEq5PeZFN/b5h9K2Wba5OpKo5M0fz1DBHc67ZyVXma2
	 RuAOTxItB1zSmqNQ0bnr+J/uE6tENOU745DoHdLhjNaVzQ57kyLfHxA83zZqN/77bWXvv
	 HdyhcT+g+etoHae6IHzO5jbaInbAx1iO86IL71RqgTJj0PqlATD/PcbS/XrzasiHi7WB7
	 HZ4HDeqHNaDWfC1snkpGaiJeKYBkR+tWtkNveKH+1HlY6uSBaoeyQvXK4m1fEw+SCog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxLbOr8b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651D8606A31C;
	Thu, 26 Nov 2026 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jxLbOr8b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BD41F000C0;
	Thu, 26 Nov 2026 14:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702391;
	bh=8xZveT6SrxHucTHAKZXA+BGtTzyVHhiH3Vbl+1uxlJ4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jxLbOr8bXtlKwNsR4o3+5Exm+DQbj6MVjJXDeSKy9sifTZUiRorGJoNvLZnZCwJ6H
	 g4OK4B5UBAukJxdrs/AaZsYRo6qpPBcH8iqsbNdQWg8OR9hZOEVehroZBcfDcA9+ir
	 UXYrq2iFHPj+/PRT7VXXg3ID+NwDIhrMdVjjh6mWa8aYLxQyaMPFXkucvz8DSMeNWw
	 7G0KK3x1ck0KPS6XilhaYgOGjREKbhGAmMbNNBk1pOiOoeJwMsQ5Sbt4WEqHqlsVhD
	 +Dv/mlCBscuEM0eHSE1DcUcW7TxmjWuEnxewKnM+vspN4/Hqv42DzN3vMr5b38AVXm
	 uQMFGIrRbCnTA==
From: Hannes Reinecke <hare@kernel.org>
Date: Thu, 26 Nov 2026 15:12:25 +0100
Subject: [PATCH v7 07/14] nvme: parse dhchap keys during option parsing
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
Message-Id: <20261126-dhchap-keyring-v4-v7-7-ee438ffea527@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702352; l=22595;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=FNXkL9swIbj/twSqmc/Ko+2cEp8bMWr0Fqq9RiK9OLU=;
 b=ExoDCnXs8CNK/w9x3Iw2dPBZ3oQSu8YC/yTHP2vtWXPu8kjDV272iL5PFZY/xVEAmOi3WxaJ3
 rCiVQigRg1WBIJYHUDe+5bEXJPK6JuoTzgjnrLSsn9wJGizIc6xMLQ1
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

We really should parse the dhchap keys during option parsing to avoid
having to pass around the plain dhchap secret. During options parsing
we will create a 'dhchap' key with a random UUID as description, and
store the key serial in the 'opts' structure.
This simplifies key handling as we don't need to pass around the key
itself, but rather lookup and validate the key by serial number before
accessing the key data.
This patch also creates two new sysfs attributes 'dhchap_key' and
'dhchap_ctrl_key' which will contain the key serial of the respective
keys.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 Documentation/ABI/stable/sysfs-nvme |  10 ++
 drivers/nvme/common/keyring.c       |   8 +-
 drivers/nvme/host/auth.c            | 116 +++++++++++++------
 drivers/nvme/host/fabrics.c         |  77 ++++++++-----
 drivers/nvme/host/fabrics.h         |   8 +-
 drivers/nvme/host/sysfs.c           | 223 +++++++++++++++++++++++++++---------
 6 files changed, 323 insertions(+), 119 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-nvme b/Documentation/ABI/stable/sysfs-nvme
index 1826df9161d24db41287811df30c65ee6ed550ce..725499309ab4dfbdb4b0b50813b901f1a1b184dc 100644
--- a/Documentation/ABI/stable/sysfs-nvme
+++ b/Documentation/ABI/stable/sysfs-nvme
@@ -166,7 +166,9 @@ Description:
 		sqsize: Shows the submission queue size for this controller.
 
 What:		/sys/class/nvme/nvmeX/dhchap_secret
+What:		/sys/class/nvme/nvmeX/dhchap_key
 What:		/sys/class/nvme/nvmeX/dhchap_ctrl_secret
+What:		/sys/class/nvme/nvmeX/dhchap_ctrl_key
 Date:		June 2022
 KernelVersion:	6.0
 Contact:	Hannes Reinecke <hare@suse.de>
@@ -176,10 +178,18 @@ Description:
 		Writing must use the "DHHC-1:" key format and triggers
 		re-authentication.
 
+		dhchap_key: Shows the key serial of the key containing
+		the DH-HMAC-CHAP secret for this controller.
+		Reading returns "none" if not set.
+
 		dhchap_ctrl_secret: Shows or sets the controller
 		DH-HMAC-CHAP secret for bidirectional authentication.
 		Same format as dhchap_secret.
 
+		dhchap_ctrl_key: Shows the key serial of the key containing
+		the DH-HMAC-CHAP controller secret for bidirectional authentication.
+		Reading returns "none" if not set.
+
 		Only available when CONFIG_NVME_HOST_AUTH is enabled and
 		for fabrics controllers.
 
diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index dc0a4fb9296f1d937992028f0520f7a184eec6ae..bee64c592752a7179e1e6575f96749a7ae26a6d6 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -469,7 +469,8 @@ static struct key_type nvme_dhchap_psk_key_type = {
  * @data: Key data
  * @data_len: Length of @data
  *
- * Creates a new DH-HMAC-CHAP key with a random UUID as the key identity.
+ * Creates a new DH-HMAC-CHAP key in the default .nvme keyring
+ * with a random UUID as the key identity.
  * Returns the new key or an error pointer on failure.
  */
 struct key *nvme_dhchap_psk_create(const char *data, size_t data_len)
@@ -514,7 +515,10 @@ EXPORT_SYMBOL_GPL(nvme_dhchap_psk_create);
  * nvme_dhchap_psk_lookup - Lookup DH-HMAC-CHAP key
  * @identity: key identity to search
  *
- * Looks up a key with identity @identity from keyring @keyring.
+ * Looks up a key with identity @identity from the .nvme.
+ * Other keyrings might be linked into the .nvme keyring
+ * to facilitate lookup from there keyring in addition
+ * to the default .nvme keyring.
  * Returns the key or an error pointer if not found.
  */
 struct key *nvme_dhchap_psk_lookup(const char *identity)
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index d6abdb4f1e21c77761f4eb00723fc9d853428295..285aa1c71f1026d17408f64500c7b41007c9d493 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -939,11 +939,6 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 		return -ENOKEY;
 	}
 
-	if (ctrl->opts->dhchap_ctrl_secret && !ctrl->ctrl_key) {
-		dev_warn(ctrl->device, "qid %d: invalid ctrl key\n", qid);
-		return -ENOKEY;
-	}
-
 	chap = &ctrl->dhchap_ctxs[qid];
 	cancel_work_sync(&chap->auth_work);
 	queue_work(nvme_auth_wq, &chap->auth_work);
@@ -1028,38 +1023,100 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
 	}
 }
 
+static void nvme_auth_clear_key(struct nvme_ctrl *ctrl, bool is_ctrl)
+{
+	struct key *key;
+	bool generated;
+
+	if (is_ctrl) {
+		key = ctrl->ctrl_key;
+		ctrl->ctrl_key = NULL;
+	} else {
+		key = ctrl->host_key;
+		ctrl->host_key = NULL;
+	}
+	if (key) {
+		dev_dbg(ctrl->device, "%s: drop dhchap%s key %08x\n",
+			__func__, is_ctrl ? " ctrl" : " host",
+			key_serial(key));
+		key_put(key);
+	}
+}
+
+#define nvme_auth_clear_host_key(c) nvme_auth_clear_key(c, false)
+#define nvme_auth_clear_ctrl_key(c) nvme_auth_clear_key(c, true)
+
 int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dhchap_queue_context *chap;
+	struct key *host_key, *ctrl_key = NULL;
 	int i, ret;
 
 	mutex_init(&ctrl->dhchap_auth_mutex);
 	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
 	if (!ctrl->opts)
 		return 0;
-	ctrl->host_key = nvme_auth_extract_key(ctrl->opts->dhchap_secret,
-				strlen(ctrl->opts->dhchap_secret));
-	if (IS_ERR(ctrl->host_key)) {
-		ret = PTR_ERR(ctrl->host_key);
-		ctrl->host_key = NULL;
-		return ret;
+	if (!ctrl->opts->dhchap_key) {
+		nvme_auth_clear_host_key(ctrl);
+		nvme_auth_clear_ctrl_key(ctrl);
+		return 0;
 	}
 
-	ctrl->ctrl_key = nvme_auth_extract_key(ctrl->opts->dhchap_ctrl_secret,
-				strlen(ctrl->opts->dhchap_ctrl_secret));
-	if (IS_ERR(ctrl->ctrl_key)) {
-		ret = PTR_ERR(ctrl->ctrl_key);
-		ctrl->ctrl_key = NULL;
-		goto err_free_dhchap_secret;
+	host_key = key_lookup(ctrl->opts->dhchap_key);
+	if (!host_key) {
+		pr_warn("dhchap host key %08x not present\n",
+			ctrl->opts->dhchap_key);
+		return -ENOKEY;
+	}
+	down_read(&host_key->sem);
+	ret = key_validate(host_key);
+	up_read(&host_key->sem);
+	if (ret) {
+		pr_warn("dhchap host key %08x invalidated\n",
+			key_serial(host_key));
+		key_put(host_key);
+		return -ENOKEY;
 	}
 
-	if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
-		return 0;
+	if (ctrl->opts->dhchap_ctrl_key) {
+		ctrl_key = key_lookup(ctrl->opts->dhchap_ctrl_key);
+		if (!ctrl_key) {
+			pr_warn("dhchap ctrl key %08x not present\n",
+				ctrl->opts->dhchap_ctrl_key);
+			key_put(host_key);
+			return -ENOKEY;
+		}
+		down_read(&ctrl_key->sem);
+		ret = key_validate(ctrl_key);
+		up_read(&ctrl_key->sem);
+		if (ret) {
+			pr_warn("dhchap ctrl key %08x invalidated\n",
+				key_serial(ctrl_key));
+			key_put(ctrl_key);
+			key_put(host_key);
+			return -EKEYREVOKED;
+		}
+	}
+
+	pr_debug("%s: using dhchap host key %08x\n",
+	       __func__, key_serial(host_key));
+	if (ctrl->host_key)
+		nvme_auth_clear_host_key(ctrl);
+	ctrl->host_key = host_key;
+
+	if (ctrl->ctrl_key)
+		nvme_auth_clear_ctrl_key(ctrl);
+	if (ctrl_key) {
+		pr_debug("%s: using dhchap ctrl key %08x\n",
+			 __func__, key_serial(ctrl_key));
+		ctrl->ctrl_key = ctrl_key;
+	}
 
 	ctrl->dhchap_ctxs = kvzalloc_objs(*chap, ctrl_max_dhchaps(ctrl));
 	if (!ctrl->dhchap_ctxs) {
-		ret = -ENOMEM;
-		goto err_free_dhchap_ctrl_secret;
+		nvme_auth_clear_ctrl_key(ctrl);
+		nvme_auth_clear_host_key(ctrl);
+		return -ENOMEM;
 	}
 
 	for (i = 0; i < ctrl_max_dhchaps(ctrl); i++) {
@@ -1071,13 +1128,6 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 	}
 
 	return 0;
-err_free_dhchap_ctrl_secret:
-	key_put(ctrl->ctrl_key);
-	ctrl->ctrl_key = NULL;
-err_free_dhchap_secret:
-	key_put(ctrl->host_key);
-	ctrl->host_key = NULL;
-	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_init_ctrl);
 
@@ -1096,14 +1146,8 @@ void nvme_auth_free(struct nvme_ctrl *ctrl)
 			nvme_auth_free_dhchap(&ctrl->dhchap_ctxs[i]);
 		kvfree(ctrl->dhchap_ctxs);
 	}
-	if (ctrl->host_key) {
-		key_put(ctrl->host_key);
-		ctrl->host_key = NULL;
-	}
-	if (ctrl->ctrl_key) {
-		key_put(ctrl->ctrl_key);
-		ctrl->ctrl_key = NULL;
-	}
+	nvme_auth_clear_host_key(ctrl);
+	nvme_auth_clear_ctrl_key(ctrl);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_free);
 
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 6a918d72d14c5dd92d00191c184e72b0e5614b7a..6c453b4f5cab1546fb036236bbfa8682a8611adb 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -12,7 +12,9 @@
 #include <linux/seq_file.h>
 #include "nvme.h"
 #include "fabrics.h"
+#include <linux/nvme-auth.h>
 #include <linux/nvme-keyring.h>
+#include <linux/key-type.h>
 
 static DECLARE_RWSEM(nvmf_transports_rwsem);
 static LIST_HEAD_GUARDED(nvmf_transports, nvmf_transports_rwsem);
@@ -717,6 +719,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 {
 	substring_t args[MAX_OPT_ARGS];
 	char *options, *o, *p;
+	char *host_secret = NULL, *ctrl_secret = NULL;
 	int token, ret = 0;
 	size_t nqnlen  = 0;
 	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO, key_id;
@@ -738,6 +741,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->tls_key = NULL;
 	opts->keyring = NULL;
 	opts->concat = false;
+	opts->dhchap_key = 0;
+	opts->dhchap_ctrl_key = 0;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -1024,14 +1029,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -ENOMEM;
 				goto out;
 			}
-			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
-				pr_err("Invalid DH-CHAP secret %s\n", p);
-				kfree_sensitive(p);
-				ret = -EINVAL;
-				goto out;
-			}
-			kfree_sensitive(opts->dhchap_secret);
-			opts->dhchap_secret = p;
+			kfree_sensitive(host_secret);
+			host_secret = p;
 			break;
 		case NVMF_OPT_DHCHAP_CTRL_SECRET:
 			p = match_strdup(args);
@@ -1039,14 +1038,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -ENOMEM;
 				goto out;
 			}
-			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
-				pr_err("Invalid DH-CHAP secret %s\n", p);
-				kfree_sensitive(p);
-				ret = -EINVAL;
-				goto out;
-			}
-			kfree_sensitive(opts->dhchap_ctrl_secret);
-			opts->dhchap_ctrl_secret = p;
+			kfree_sensitive(ctrl_secret);
+			ctrl_secret = p;
 			break;
 		case NVMF_OPT_TLS:
 			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
@@ -1090,6 +1083,45 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			pr_warn("failfast tmo (%d) larger than controller loss tmo (%d)\n",
 				opts->fast_io_fail_tmo, ctrl_loss_tmo);
 	}
+
+	opts->host = nvmf_host_add(hostnqn, &hostid);
+	if (IS_ERR(opts->host)) {
+		ret = PTR_ERR(opts->host);
+		opts->host = NULL;
+		goto out;
+	}
+
+	if (host_secret) {
+#ifdef CONFIG_NVME_HOST_AUTH
+		pr_debug("lookup dhchap host secret '%s'\n", host_secret);
+		key = nvme_auth_extract_key(host_secret, strlen(host_secret));
+		if (IS_ERR(key)) {
+			ret = PTR_ERR(key);
+			goto out;
+		}
+		pr_debug("using dhchap host key %08x\n", key_serial(key));
+		opts->dhchap_key = key_serial(key);
+		key_put(key);
+#endif
+	}
+	if (ctrl_secret) {
+#ifdef CONFIG_NVME_HOST_AUTH
+		if (!opts->dhchap_key) {
+			ret = -EINVAL;
+			goto out;
+		}
+		pr_debug("lookup dhchap ctrl secret '%s'\n", ctrl_secret);
+		key = nvme_auth_extract_key(ctrl_secret, strlen(ctrl_secret));
+		if (IS_ERR(key)) {
+			ret = PTR_ERR(key);
+			goto out;
+		}
+		pr_debug("using dhchap ctrl key %08x\n", key_serial(key));
+		opts->dhchap_ctrl_key = key_serial(key);
+		key_put(key);
+#endif
+	}
+
 	if (opts->concat) {
 		if (opts->tls) {
 			pr_err("Secure concatenation over TLS is not supported\n");
@@ -1101,21 +1133,16 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			ret = -EINVAL;
 			goto out;
 		}
-		if (!opts->dhchap_secret) {
+		if (!opts->dhchap_key) {
 			pr_err("Need to enable DH-CHAP for secure concatenation\n");
 			ret = -EINVAL;
 			goto out;
 		}
 	}
 
-	opts->host = nvmf_host_add(hostnqn, &hostid);
-	if (IS_ERR(opts->host)) {
-		ret = PTR_ERR(opts->host);
-		opts->host = NULL;
-		goto out;
-	}
-
 out:
+	kfree_sensitive(ctrl_secret);
+	kfree_sensitive(host_secret);
 	kfree(options);
 	return ret;
 }
@@ -1313,8 +1340,6 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 	kfree(opts->subsysnqn);
 	kfree(opts->host_traddr);
 	kfree(opts->host_iface);
-	kfree_sensitive(opts->dhchap_secret);
-	kfree_sensitive(opts->dhchap_ctrl_secret);
 	kfree(opts);
 }
 EXPORT_SYMBOL_GPL(nvmf_free_options);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index caf5503d0833296aa03c028c0199cf92cc409edc..49a6f6b6833a852a55e3bd3a3fbf3f1ca3e8c5d0 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -96,8 +96,8 @@ enum {
  * @discovery_nqn: indicates if the subsysnqn is the well-known discovery NQN.
  * @kato:	Keep-alive timeout.
  * @host:	Virtual NVMe host, contains the NQN and Host ID.
- * @dhchap_secret: DH-HMAC-CHAP secret
- * @dhchap_ctrl_secret: DH-HMAC-CHAP controller secret for bi-directional
+ * @dhchap_key: DH-HMAC-CHAP pre-shared key
+ * @dhchap_ctrl_key: DH-HMAC-CHAP controller pre-shared key for bi-directional
  *              authentication
  * @keyring:    Keyring to use for key lookups
  * @tls_key:    TLS key for encrypted connections (TCP)
@@ -127,8 +127,8 @@ struct nvmf_ctrl_options {
 	bool			duplicate_connect;
 	unsigned int		kato;
 	struct nvmf_host	*host;
-	char			*dhchap_secret;
-	char			*dhchap_ctrl_secret;
+	key_serial_t		dhchap_key;
+	key_serial_t		dhchap_ctrl_key;
 	struct key		*keyring;
 	struct key		*tls_key;
 	bool			tls;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index e7e4fe2ad506ac30ba88a964c52d0dd3a995d75b..27f06394af83601ae4ad4a06f3f235d48c5a73d9 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -7,6 +7,7 @@
 
 #include <linux/nvme-auth.h>
 #include <linux/nvme-keyring.h>
+#include <linux/key-type.h>
 #include <linux/blkdev.h>
 
 #include "nvme.h"
@@ -819,47 +820,79 @@ static ssize_t dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
+	struct key *key;
+	ssize_t count;
 
-	if (!opts->dhchap_secret)
+	mutex_lock(&ctrl->dhchap_auth_mutex);
+	key = ctrl->host_key;
+	if (!key) {
+		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		return sysfs_emit(buf, "none\n");
-	return sysfs_emit(buf, "%s\n", opts->dhchap_secret);
+	}
+
+	down_read(&key->sem);
+	if (key_validate(key))
+		count = sysfs_emit(buf, "<invalidated>\n");
+	else {
+		count = key->type->read(key, buf, PAGE_SIZE);
+		if (count > 0) {
+			buf[count] = '\n';
+			count++;
+		}
+	}
+	up_read(&key->sem);
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
+	return count;
 }
 
 static ssize_t dhchap_secret_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
+	struct key *key, *old_key;
 	char *dhchap_secret;
+	size_t len;
+	int ret;
 
-	if (!ctrl->opts->dhchap_secret)
-		return -EINVAL;
-	if (count < 7)
+	if (!ctrl->host_key || !count)
 		return -EINVAL;
 
-	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
+	len = strcspn(buf, "\n");
+	dhchap_secret = kzalloc(len + 1, GFP_KERNEL);
 	if (!dhchap_secret)
 		return -ENOMEM;
-	memcpy(dhchap_secret, buf, count);
+	memcpy(dhchap_secret, buf, len);
 	nvme_auth_stop(ctrl);
-	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
-		struct key *key, *host_key;
 
-		key = nvme_auth_extract_key(dhchap_secret, count);
-		if (IS_ERR(key)) {
-			kfree_sensitive(dhchap_secret);
-			return PTR_ERR(key);
-		}
-		kfree_sensitive(opts->dhchap_secret);
-		opts->dhchap_secret = dhchap_secret;
-		host_key = ctrl->host_key;
-		mutex_lock(&ctrl->dhchap_auth_mutex);
-		ctrl->host_key = key;
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		key_put(host_key);
-	} else
+	key = nvme_auth_extract_key(dhchap_secret, len);
+	if (IS_ERR(key)) {
+		kfree_sensitive(dhchap_secret);
+		return PTR_ERR(key);
+	}
+	down_read(&key->sem);
+	ret = key_validate(key);
+	up_read(&key->sem);
+	if (ret) {
+		dev_warn(ctrl->device, "key %08x invalidated\n",
+			 key_serial(key));
+		key_revoke(key);
+		key_put(key);
 		kfree_sensitive(dhchap_secret);
+		return ret;
+	}
+	mutex_lock(&ctrl->dhchap_auth_mutex);
+	old_key = ctrl->host_key;
+	if (old_key && key_serial(old_key) == key_serial(key)) {
+		dev_warn(ctrl->device, "using existing key %08x\n",
+			 key_serial(old_key));
+		key_revoke(key);
+		old_key = key;
+	} else {
+		ctrl->host_key = key;
+	}
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
+	key_put(old_key);
+	kfree_sensitive(dhchap_secret);
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
@@ -873,49 +906,81 @@ static ssize_t dhchap_ctrl_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
+	struct key *key;
+	ssize_t count;
 
-	if (!opts->dhchap_ctrl_secret)
+	mutex_lock(&ctrl->dhchap_auth_mutex);
+	key = ctrl->ctrl_key;
+	if (!key) {
+		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		return sysfs_emit(buf, "none\n");
-	return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
+	}
+	down_read(&key->sem);
+	if (key_validate(key))
+		count = sysfs_emit(buf, "<invalidated>\n");
+	else {
+		count = key->type->read(key, buf, PAGE_SIZE);
+		if (count > 0) {
+			buf[count] = '\n';
+			count++;
+		}
+	}
+	up_read(&key->sem);
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
+	return count;
 }
 
 static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
+	struct key *key, *old_key;
 	char *dhchap_secret;
+	size_t len;
+	int ret;
 
-	if (!ctrl->opts->dhchap_ctrl_secret)
-		return -EINVAL;
-	if (count < 7)
-		return -EINVAL;
-	if (memcmp(buf, "DHHC-1:", 7))
+	if (!ctrl->ctrl_key || !count)
 		return -EINVAL;
 
-	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
+	len = strcspn(buf, "\n");
+	dhchap_secret = kzalloc(len + 1, GFP_KERNEL);
 	if (!dhchap_secret)
 		return -ENOMEM;
-	memcpy(dhchap_secret, buf, count);
+	memcpy(dhchap_secret, buf, len);
 	nvme_auth_stop(ctrl);
-	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
-		struct key *key, *ctrl_key;
-
-		key = nvme_auth_extract_key(dhchap_secret, count);
-		if (IS_ERR(key)) {
-			kfree_sensitive(dhchap_secret);
-			return PTR_ERR(key);
-		}
-		kfree_sensitive(opts->dhchap_ctrl_secret);
-		opts->dhchap_ctrl_secret = dhchap_secret;
-		ctrl_key = ctrl->ctrl_key;
-		mutex_lock(&ctrl->dhchap_auth_mutex);
-		ctrl->ctrl_key = key;
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		key_put(ctrl_key);
-	} else
+	key = nvme_auth_extract_key(dhchap_secret, len);
+	if (IS_ERR(key)) {
+		kfree_sensitive(dhchap_secret);
+		return PTR_ERR(key);
+	}
+	down_read(&key->sem);
+	ret = key_validate(key);
+	up_read(&key->sem);
+	if (ret) {
+		dev_warn(ctrl->device, "key %08x invalidated\n",
+			 key_serial(key));
+		dev_dbg(ctrl->device, "revoke ctrl key %08x\n",
+			key_serial(key));
+		key_revoke(key);
+		key_put(key);
 		kfree_sensitive(dhchap_secret);
+		return ret;
+	}
+	mutex_lock(&ctrl->dhchap_auth_mutex);
+	old_key = ctrl->ctrl_key;
+	if (old_key && key_serial(old_key) == key_serial(key)) {
+		dev_warn(ctrl->device, "using existing ctrl key %08x\n",
+			 key_serial(old_key));
+		old_key = key;
+	} else {
+		dev_dbg(ctrl->device, "revoke ctrl key %08x\n",
+				key_serial(old_key));
+		key_revoke(old_key);
+		ctrl->ctrl_key = key;
+	}
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
+	key_put(old_key);
+	kfree_sensitive(dhchap_secret);
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
@@ -924,6 +989,56 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 }
 
 static DEVICE_ATTR_ADMIN_RW(dhchap_ctrl_secret);
+
+static ssize_t dhchap_key_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct key *key;
+	ssize_t count = 0;
+
+	mutex_lock(&ctrl->dhchap_auth_mutex);
+	key = ctrl->host_key;
+	if (!key) {
+		mutex_unlock(&ctrl->dhchap_auth_mutex);
+		return sysfs_emit(buf, "none\n");
+	}
+	down_read(&key->sem);
+	if (key_validate(key))
+		count = sysfs_emit(buf, "<invalidated>\n");
+	else
+		count = sysfs_emit(buf, "%08x\n",
+				   key_serial(key));
+	up_read(&key->sem);
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
+	return count;
+}
+static DEVICE_ATTR_ADMIN_RO(dhchap_key);
+
+static ssize_t dhchap_ctrl_key_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct key *key;
+	ssize_t count = 0;
+
+	mutex_lock(&ctrl->dhchap_auth_mutex);
+	key = ctrl->ctrl_key;
+	if (!key) {
+		mutex_unlock(&ctrl->dhchap_auth_mutex);
+		return sysfs_emit(buf, "none\n");
+	}
+	down_read(&key->sem);
+	if (key_validate(key))
+		count = sysfs_emit(buf, "<invalidated>\n");
+	else
+		count = sysfs_emit(buf, "%08x\n",
+				   key_serial(key));
+	up_read(&key->sem);
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
+	return count;
+}
+static DEVICE_ATTR_ADMIN_RO(dhchap_ctrl_key);
 #endif
 
 static struct attribute *nvme_dev_attrs[] = {
@@ -955,6 +1070,8 @@ static struct attribute *nvme_dev_attrs[] = {
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
+	&dev_attr_dhchap_key.attr,
+	&dev_attr_dhchap_ctrl_key.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
 	NULL
@@ -985,6 +1102,10 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		return 0;
 	if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
 		return 0;
+	if (a == &dev_attr_dhchap_key.attr && !ctrl->opts)
+		return 0;
+	if (a == &dev_attr_dhchap_ctrl_key.attr && !ctrl->opts)
+		return 0;
 #endif
 
 	return a->mode;

-- 
2.51.0

