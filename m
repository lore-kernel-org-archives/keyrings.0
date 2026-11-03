Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793675002;
	b=JH23PyH1SQGr74Tm5lWwdrHQWhdnj7yOLWw0laB711iTMziFUsgantkUVREq99sF6XMn
	 EQM4IU5CkKeHnyERLIevLXF5YUpujoZYWeimbEpuDfbcFOA5kgsFXrmvo+Ic3ChXMqFUH
	 uKYXLyIhYdHUT+UrjgIKJM6oVX9yurY5JrY9vNL4iSb2612x0y37QtQm2X1/YBWN6GkCo
	 nGQaXdUyAEjBw7WynwAZo3tpsBlvh5RmX27dm+A+hrp/Dh6d7B5TUhK3fXH61RZmt4dcg
	 nIzHmuiIT+W2gUmdT5eh89Ra5UaquQtiYvciy/N7/sTQ8YYdUT6hyEyOV8e3rXkRpEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793675002;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Sb2XMtjKsz+jI29azHxtIIZugzSbewTBfgbly0UTNlM=;
	b=RsvukDG6X25F4W2HRntmYUjAbPtzYthkG+x5oRrvEBEQAMoR9Jt78CxUhlIJJzuT1x26
	 BAPrYG+4bTNab4X7Agtlx/ld6yWFLULNn7ALztUrAgd8Yydhjd+PLY0l+64F3lcQWpVqd
	 Xepmr/sVG5Jds/IY3Gz8HqBIGqNkOXlg4cxqU7abeoq3qrRrOtnFzwVvJYHbx5WoJY6uW
	 fPTmKuu5E2JwxWUuXW34YcliNaNrRzd4zQMGO5w4kVUI2t/8T7iKAQgcNt8Vzx6M67sz9
	 1XPvDXey7JqvO6thQJcvJoB/uyffQdd1TlvY8Egf3y1fTPWwwzsjnZtg/ML65T1XHjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B8ukt+bh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 4B265606A32D;
	Tue,  3 Nov 2026 03:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B8ukt+bh
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5CB4E1F00A15;
	Tue,  3 Nov 2026 03:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793675001;
	bh=Sb2XMtjKsz+jI29azHxtIIZugzSbewTBfgbly0UTNlM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B8ukt+bhl8JyK9XykNxTse88EYFzR6NjbR4YSc7f1QJUPo4SzvzQdTkdXUrct8958
	 AE4RgEzzZMqAZesur7+M4PbSkcbHqpDap8BAYTYpYCD+Lg5+EMe3HpE5HmPTvkswRv
	 JxHT6Q3tfKZO09Jhnx/3KuhoU8UFcHzpfF3J41JeWuBg784tMC389l2e47B33Mtw4t
	 whMjeb9XSKayXCs5bEbgFZU5Je3/zEo6tvJsvzjLISBFP1+xpg8L678VbKqtOS6xFo
	 JaY5E6tPzkgWjsym0P0/cpibY7KceHlELo7X4ZP2iPsUKwfojMQZqqlf9U6zl/MlcV
	 p2tMBsieJK6bA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Sumit Garg <sumit.garg@kernel.org>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH v2 08/11] KEYS: trusted: TEE: Synchronize session lifetime
Date: Tue,  3 Nov 2026 05:02:13 +0200
Message-ID: <20261103030226.2685251-9-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261103030226.2685251-1-jarkko@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Even with sysfs bind attributes suppressed on trusted_key_driver, the
parent TEE device can still remove trusted_key_device while live trusted
keys keep trusted.ko loaded, and init_trusted() updated static calls
only after backend init() had already registered key_type_trusted.

Update the static calls before invoking backend init() and reset them on
failure. In the TEE backend, guard session context state with a mutex,
publish pvt_data.dev before registering key_type_trusted, sanitize
pvt_data on probe failure and remove, and reject seal/unseal/get_random
with -ENODEV when no active TEE session is bound.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/trusted-keys/trusted_core.c | 15 ++--
 security/keys/trusted-keys/trusted_tee.c  | 86 +++++++++++++++++------
 2 files changed, 75 insertions(+), 26 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
index 0509d9955f2a..11d7d296d063 100644
--- a/security/keys/trusted-keys/trusted_core.c
+++ b/security/keys/trusted-keys/trusted_core.c
@@ -373,14 +373,19 @@ static int __init init_trusted(void)
 		if (!get_random)
 			get_random = kernel_get_random;
 
+		static_call_update(trusted_key_seal, trusted_key_sources[i].ops->seal);
+		static_call_update(trusted_key_unseal, trusted_key_sources[i].ops->unseal);
+		static_call_update(trusted_key_get_random, get_random);
+		migratable = trusted_key_sources[i].ops->migratable;
+
 		ret = trusted_key_sources[i].ops->init();
 		if (!ret) {
-			static_call_update(trusted_key_seal, trusted_key_sources[i].ops->seal);
-			static_call_update(trusted_key_unseal, trusted_key_sources[i].ops->unseal);
-			static_call_update(trusted_key_get_random, get_random);
-
 			trusted_key_exit = trusted_key_sources[i].ops->exit;
-			migratable = trusted_key_sources[i].ops->migratable;
+		} else {
+			static_call_update(trusted_key_seal, NULL);
+			static_call_update(trusted_key_unseal, NULL);
+			static_call_update(trusted_key_get_random, NULL);
+			migratable = 0;
 		}
 
 		if (!ret || ret != -ENODEV)
diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
index 5d1288189e5c..a2ed16e0db3f 100644
--- a/security/keys/trusted-keys/trusted_tee.c
+++ b/security/keys/trusted-keys/trusted_tee.c
@@ -9,6 +9,7 @@
 #include <linux/err.h>
 #include <linux/key-type.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/tee_drv.h>
@@ -56,6 +57,8 @@ struct trusted_key_tee_private {
 };
 
 static struct trusted_key_tee_private pvt_data;
+/* Do not hold this mutex across key type registration or unregistration. */
+static DEFINE_MUTEX(trusted_key_tee_mutex);
 
 /*
  * Have the TEE seal(encrypt) the symmetric key
@@ -67,6 +70,12 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
 	struct tee_param param[4];
 	struct tee_shm *reg_shm = NULL;
 
+	mutex_lock(&trusted_key_tee_mutex);
+	if (!pvt_data.ctx) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
 	memset(&inv_arg, 0, sizeof(inv_arg));
 	memset(&param, 0, sizeof(param));
 
@@ -74,7 +83,8 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
 					      sizeof(p->key) + sizeof(p->blob));
 	if (IS_ERR(reg_shm)) {
 		dev_err(pvt_data.dev, "shm register failed\n");
-		return PTR_ERR(reg_shm);
+		ret = PTR_ERR(reg_shm);
+		goto out_unlock;
 	}
 
 	inv_arg.func = TA_CMD_SEAL;
@@ -100,7 +110,8 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
 	}
 
 	tee_shm_free(reg_shm);
-
+out_unlock:
+	mutex_unlock(&trusted_key_tee_mutex);
 	return ret;
 }
 
@@ -114,6 +125,12 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
 	struct tee_param param[4];
 	struct tee_shm *reg_shm = NULL;
 
+	mutex_lock(&trusted_key_tee_mutex);
+	if (!pvt_data.ctx) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
 	memset(&inv_arg, 0, sizeof(inv_arg));
 	memset(&param, 0, sizeof(param));
 
@@ -121,7 +138,8 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
 					      sizeof(p->key) + sizeof(p->blob));
 	if (IS_ERR(reg_shm)) {
 		dev_err(pvt_data.dev, "shm register failed\n");
-		return PTR_ERR(reg_shm);
+		ret = PTR_ERR(reg_shm);
+		goto out_unlock;
 	}
 
 	inv_arg.func = TA_CMD_UNSEAL;
@@ -147,7 +165,8 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
 	}
 
 	tee_shm_free(reg_shm);
-
+out_unlock:
+	mutex_unlock(&trusted_key_tee_mutex);
 	return ret;
 }
 
@@ -161,13 +180,20 @@ static int trusted_tee_get_random(unsigned char *key, size_t key_len)
 	struct tee_param param[4];
 	struct tee_shm *reg_shm = NULL;
 
+	mutex_lock(&trusted_key_tee_mutex);
+	if (!pvt_data.ctx) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
+
 	memset(&inv_arg, 0, sizeof(inv_arg));
 	memset(&param, 0, sizeof(param));
 
 	reg_shm = tee_shm_register_kernel_buf(pvt_data.ctx, key, key_len);
 	if (IS_ERR(reg_shm)) {
 		dev_err(pvt_data.dev, "key shm register failed\n");
-		return PTR_ERR(reg_shm);
+		ret = PTR_ERR(reg_shm);
+		goto out_unlock;
 	}
 
 	inv_arg.func = TA_CMD_GET_RANDOM;
@@ -189,7 +215,8 @@ static int trusted_tee_get_random(unsigned char *key, size_t key_len)
 	}
 
 	tee_shm_free(reg_shm);
-
+out_unlock:
+	mutex_unlock(&trusted_key_tee_mutex);
 	return ret;
 }
 
@@ -205,50 +232,67 @@ static int optee_ctx_match(struct tee_ioctl_version_data *ver, const void *data)
 static int trusted_key_probe(struct tee_client_device *rng_device)
 {
 	struct device *dev = &rng_device->dev;
+	struct tee_context *ctx;
 	int ret;
 	struct tee_ioctl_open_session_arg sess_arg;
 
+	mutex_lock(&trusted_key_tee_mutex);
+	if (pvt_data.ctx) {
+		ret = -EBUSY;
+		goto out_unlock;
+	}
+
 	memset(&sess_arg, 0, sizeof(sess_arg));
 
-	pvt_data.ctx = tee_client_open_context(NULL, optee_ctx_match, NULL,
-					       NULL);
-	if (IS_ERR(pvt_data.ctx))
-		return -ENODEV;
+	ctx = tee_client_open_context(NULL, optee_ctx_match, NULL, NULL);
+	if (IS_ERR(ctx)) {
+		ret = -ENODEV;
+		goto out_unlock;
+	}
 
 	memcpy(sess_arg.uuid, rng_device->id.uuid.b, TEE_IOCTL_UUID_LEN);
 	sess_arg.clnt_login = TEE_IOCTL_LOGIN_REE_KERNEL;
 	sess_arg.num_params = 0;
 
-	ret = tee_client_open_session(pvt_data.ctx, &sess_arg, NULL);
+	ret = tee_client_open_session(ctx, &sess_arg, NULL);
 	if ((ret < 0) || (sess_arg.ret != 0)) {
 		dev_err(dev, "tee_client_open_session failed, err: %x\n",
 			sess_arg.ret);
 		ret = -EINVAL;
 		goto out_ctx;
 	}
+	pvt_data.ctx = ctx;
 	pvt_data.session_id = sess_arg.session;
-
-	ret = register_key_type(&key_type_trusted);
-	if (ret < 0)
-		goto out_sess;
-
 	pvt_data.dev = dev;
+	mutex_unlock(&trusted_key_tee_mutex);
 
-	return 0;
+	ret = register_key_type(&key_type_trusted);
+	if (!ret)
+		return 0;
 
-out_sess:
-	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
+	mutex_lock(&trusted_key_tee_mutex);
+	tee_client_close_session(ctx, pvt_data.session_id);
 out_ctx:
-	tee_client_close_context(pvt_data.ctx);
-
+	tee_client_close_context(ctx);
+	pvt_data.ctx = NULL;
+	pvt_data.dev = NULL;
+	pvt_data.session_id = 0;
+out_unlock:
+	mutex_unlock(&trusted_key_tee_mutex);
 	return ret;
 }
 
 static void trusted_key_remove(struct tee_client_device *dev)
 {
 	unregister_key_type(&key_type_trusted);
+
+	mutex_lock(&trusted_key_tee_mutex);
 	tee_client_close_session(pvt_data.ctx, pvt_data.session_id);
 	tee_client_close_context(pvt_data.ctx);
+	pvt_data.ctx = NULL;
+	pvt_data.dev = NULL;
+	pvt_data.session_id = 0;
+	mutex_unlock(&trusted_key_tee_mutex);
 }
 
 static const struct tee_client_device_id trusted_key_id_table[] = {
-- 
2.47.3

