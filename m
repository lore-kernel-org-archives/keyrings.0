Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261E64766BC;
	Wed, 26 Aug 2026 16:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787762541; cv=none; b=Df4sEH6TfFUGJaGtvLDIQP7dM2I0y5yYd4BZGjJhLtvnCRRDG0S9+GUDKL9w8X1TUV2HvvetdvFflNoa3APs6ny9RQXS8hY4bQTLQOEt67EQBAIl3wvF1k6YdJ1MHVasrecxznX9DbovAeDiGYu3qltpb7uUTLxXNt3hQSvB9ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787762541; c=relaxed/simple;
	bh=xHMKdcIzJKEWbW2/jUBUyyWXvn6DxzwImcsRNLqSJ6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psGhr7mVK9SHztb3u7n2uJsDZJASsS2dTnXPeDqmUU0X5QbG0DaOQPvgmuwdGoPj+bOfbAyz2wvtqLxlcHHhA2hYUDVJ+Dnx04r7D2f5g2WwlrM1ub714r8loQMxp87peqC5YwOeVi5S33MmkprD+sHPbiNjpXkulfAmNXCscH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=Q1SLbL71; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="Q1SLbL71"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=m+kFZoFWIAnD1BHv0Tlk8apirdS/rn7WPtfbgpd7TQU=; b=Q1SLbL71zqpaJfhOSfm1bliuDo
	0sTnHDsfd7oORr5gNNIaZ5HTI1lSg67Wv7HONDNKWHD8UPUVq5pS+uasw3LIGAH1vAnxTAJRwxIpP
	evBwspGZwGlvxl5qKlpMDbWg53scSKglW+Re/i2OY/JWMIq1U90S5UwkHq908N7ntCQkvhzKzRAd6
	SpAsaa2WaOXCr1IWKh5XLVC9ATuOdvmlXW9INpfVl0mtg0YGnvtUFAojP+x67NoWj4IUQuZ/riGMe
	6YuERFRmqAwBYRB6470nvrrr0MHkNPR3BPMeTzeyPk+UL07QDGF56IsrzxxyyZpiaj/L1BPHK0PCA
	SJVH8NhA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wzGh0-000IKY-11;
	Wed, 26 Aug 2026 18:41:38 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: brauner@kernel.org,
	kpsingh@kernel.org,
	ast@kernel.org,
	john.fastabend@gmail.com,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org,
	dhowells@redhat.com,
	jarkko@kernel.org,
	keyrings@vger.kernel.org
Subject: [PATCH bpf-next v3 01/11] bpf, keys: Add a bpf keyring for program signature validation
Date: Wed, 26 Aug 2026 18:41:26 +0200
Message-ID: <20260826164136.1400997-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826164136.1400997-1-daniel@iogearbox.net>
References: <20260826164136.1400997-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28104/Wed Aug 26 08:24:01 2026)

BPF program signatures can currently be verified against one of the
system keyrings (builtin, secondary, platform) or against an arbitrary
user/session caller-supplied keyring named through keyring_id. There
is nothing in between: the system keyrings need a kernel rebuild or a
vouched-for enrollment to rotate a key, while a caller-supplied keyring
is fully controlled by the loader and therefore carries no trust on
its own (unless explicitly combined with BPF LSM to protect against
key tampering).

Add a dedicated bpf keyring to fill that gap, modelled after the
dm-verity keyring which was added in commit 033724b1c627 ("dm-verity:
add dm-verity keyring") and which can eventually be used also via
systemd through the same enrollment method as in dm-verity's case. It
is selected with the new KEY_SPEC_BPF_KEYRING special key id and gives
an operator a place to enroll a BPF-only signing key at boot,
specifically scoped to BPF program loading and nothing else in the
kernel's trust hierarchy.

The id is reserved from the KEY_SPEC space so that the latter is not
linked into any process keyring, and lookup_user_key() resolves
KEY_SPEC_BPF_KEYRING constant instead of having to look it up via
/proc/keys first.

By default the keyring is sealed empty at init. Systems that want to
provision keys pass bpf.keyring_unsealed=1, which leaves the keyring
open for the initrd to add keys to. The keyring is only ever consulted
once it is both non-empty and restricted. An unrestricted keyring is
ignored.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../admin-guide/kernel-parameters.txt         |  8 +++
 include/linux/bpf.h                           |  7 ++
 include/linux/key.h                           |  2 +
 include/uapi/linux/keyctl.h                   |  1 +
 kernel/bpf/Makefile                           |  3 +
 kernel/bpf/keys.c                             | 68 +++++++++++++++++++
 kernel/bpf/verifier.c                         | 14 +++-
 security/keys/process_keys.c                  | 25 +++++++
 8 files changed, 126 insertions(+), 2 deletions(-)
 create mode 100644 kernel/bpf/keys.c

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e4643634a9b1..2beb61092bb3 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -667,6 +667,14 @@ Kernel parameters
 
 			See Documentation/admin-guide/bootconfig.rst
 
+	bpf.keyring_unsealed=
+			[BPF] When set to 1, leave the bpf keyring unsealed
+			after initialization so that userspace can provision
+			keys. Once the keyring is restricted it becomes active
+			and can be used for BPF program signature verification.
+
+			See Documentation/bpf/signing.rst
+
 	bttv.card=	[HW,V4L] bttv (bt848 + bt878 based grabber cards)
 	bttv.radio=	Most important insmod options are available as
 			kernel args too.
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b3cd28d9e3b5..62b095f7f524 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1735,6 +1735,7 @@ enum bpf_sig_keyring {
 	BPF_SIG_KEYRING_SECONDARY,
 	BPF_SIG_KEYRING_PLATFORM,
 	BPF_SIG_KEYRING_USER,
+	BPF_SIG_KEYRING_BPF,
 };
 
 struct bpf_prog_aux {
@@ -3819,6 +3820,7 @@ struct bpf_key {
 #if defined(CONFIG_KEYS) && defined(CONFIG_BPF_SYSCALL)
 struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags);
 struct bpf_key *bpf_lookup_system_key(u64 id);
+struct bpf_key *bpf_lookup_keyring(void);
 void bpf_key_put(struct bpf_key *bkey);
 int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_p,
 			       const struct bpf_dynptr *sig_p,
@@ -3839,6 +3841,11 @@ static inline struct bpf_key *bpf_lookup_system_key(u64 id)
 	return NULL;
 }
 
+static inline struct bpf_key *bpf_lookup_keyring(void)
+{
+	return NULL;
+}
+
 static inline void bpf_key_put(struct bpf_key *bkey)
 {
 }
diff --git a/include/linux/key.h b/include/linux/key.h
index 81b8f05c6898..bd10fe45819d 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -440,6 +440,8 @@ extern key_ref_t keyring_search(key_ref_t keyring,
 extern int keyring_restrict(key_ref_t keyring, const char *type,
 			    const char *restriction);
 
+extern void key_register_bpf_keyring(struct key *keyring);
+
 extern struct key *key_lookup(key_serial_t id);
 
 static inline key_serial_t key_serial(const struct key *key)
diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 4c8884eea808..fa85b9760391 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -24,6 +24,7 @@
 #define KEY_SPEC_GROUP_KEYRING		-6	/* - key ID for GID-specific keyring */
 #define KEY_SPEC_REQKEY_AUTH_KEY	-7	/* - key ID for assumed request_key auth key */
 #define KEY_SPEC_REQUESTOR_KEYRING	-8	/* - key ID for request_key() dest keyring */
+#define KEY_SPEC_BPF_KEYRING		-9	/* - key ID for the BPF-specific keyring */
 
 /* request-key default keyrings */
 #define KEY_REQKEY_DEFL_NO_CHANGE		-1
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index 90255d80e5be..9a92c348bbda 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -27,6 +27,9 @@ obj-$(CONFIG_BPF_SYSCALL) += offload.o
 obj-$(CONFIG_BPF_SYSCALL) += net_namespace.o
 obj-$(CONFIG_BPF_SYSCALL) += tcx.o
 endif
+ifeq ($(CONFIG_KEYS),y)
+obj-$(CONFIG_BPF_SYSCALL) += keys.o
+endif
 ifeq ($(CONFIG_PERF_EVENTS),y)
 obj-$(CONFIG_BPF_SYSCALL) += stackmap.o
 endif
diff --git a/kernel/bpf/keys.c b/kernel/bpf/keys.c
new file mode 100644
index 000000000000..08549b3220c1
--- /dev/null
+++ b/kernel/bpf/keys.c
@@ -0,0 +1,68 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2026 Isovalent */
+
+#include <linux/bpf.h>
+#include <linux/cred.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/key.h>
+#include <linux/moduleparam.h>
+#include <linux/slab.h>
+
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "bpf."
+
+static struct key *bpf_keyring;
+
+static bool bpf_keyring_unsealed __ro_after_init;
+module_param_named(keyring_unsealed, bpf_keyring_unsealed, bool, 0444);
+MODULE_PARM_DESC(keyring_unsealed, "Leave the bpf keyring unsealed");
+
+struct bpf_key *bpf_lookup_keyring(void)
+{
+	struct bpf_key *bkey;
+
+	if (!bpf_keyring)
+		return NULL;
+	if (!READ_ONCE(bpf_keyring->keys.nr_leaves_on_tree) ||
+	    !READ_ONCE(bpf_keyring->restrict_link))
+		return NULL;
+
+	bkey = kmalloc_obj(*bkey);
+	if (!bkey)
+		return NULL;
+
+	bkey->key = bpf_keyring;
+	bkey->has_ref = false;
+	return bkey;
+}
+
+static int __init bpf_keyring_init(void)
+{
+	struct key *keyring;
+
+	keyring = keyring_alloc(".bpf",
+				GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+				current_cred(), KEY_POS_SEARCH |
+				KEY_USR_VIEW | KEY_USR_READ |
+				KEY_USR_WRITE | KEY_USR_SEARCH |
+				KEY_USR_SETATTR, KEY_ALLOC_NOT_IN_QUOTA,
+				NULL, NULL);
+	if (IS_ERR(keyring)) {
+		pr_err("bpf: cannot allocate bpf keyring: %ld\n",
+		       PTR_ERR(keyring));
+		return 0;
+	}
+	if (!bpf_keyring_unsealed &&
+	    keyring_restrict(make_key_ref(keyring, true), NULL, NULL)) {
+		pr_err("bpf: cannot seal bpf keyring\n");
+		key_revoke(keyring);
+		key_put(keyring);
+		return 0;
+	}
+
+	bpf_keyring = keyring;
+	key_register_bpf_keyring(keyring);
+	return 0;
+}
+late_initcall(bpf_keyring_init);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e036ae20bf6b..b45d201c2535 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -24,6 +24,7 @@
 #include <linux/bpf_lsm.h>
 #include <linux/security.h>
 #include <linux/verification.h>
+#include <linux/keyctl.h>
 #include <linux/btf_ids.h>
 #include <linux/poison.h>
 #include <linux/module.h>
@@ -20981,6 +20982,8 @@ static enum bpf_sig_keyring bpf_classify_keyring(s32 keyring_id)
 		return BPF_SIG_KEYRING_SECONDARY;
 	case (s32)(unsigned long)VERIFY_USE_PLATFORM_KEYRING:
 		return BPF_SIG_KEYRING_PLATFORM;
+	case KEY_SPEC_BPF_KEYRING:
+		return BPF_SIG_KEYRING_BPF;
 	default:
 		return BPF_SIG_KEYRING_USER;
 	}
@@ -21016,10 +21019,17 @@ static int bpf_prog_verify_signature(struct bpf_verifier_env *env,
 	if (!attr->signature_size ||
 	    attr->signature_size > KMALLOC_MAX_CACHE_SIZE)
 		return -EINVAL;
-	if (system_keyring_id_check(attr->keyring_id) == 0)
+	if (attr->keyring_id == KEY_SPEC_BPF_KEYRING) {
+		key = bpf_lookup_keyring();
+		if (!key) {
+			verbose(env, "the bpf keyring is empty or has not been restricted\n");
+			return -ENOKEY;
+		}
+	} else if (system_keyring_id_check(attr->keyring_id) == 0) {
 		key = bpf_lookup_system_key(attr->keyring_id);
-	else
+	} else {
 		key = bpf_lookup_user_key(attr->keyring_id, 0);
+	}
 	if (!key) {
 		verbose(env, "cannot resolve signing keyring with keyring_id %d\n",
 			attr->keyring_id);
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index a63c46bb2d14..44358388e395 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -22,6 +22,9 @@
 /* Session keyring create vs join semaphore */
 static DEFINE_MUTEX(key_session_mutex);
 
+/* BPF keyring reachable through KEY_SPEC_BPF_KEYRING */
+static struct key *bpf_keyring __ro_after_init;
+
 /* The root user's tracking struct */
 struct key_user root_key_user = {
 	.usage		= REFCOUNT_INIT(3),
@@ -590,6 +593,20 @@ bool lookup_user_key_possessed(const struct key *key,
 	return key == match_data->raw_data;
 }
 
+/**
+ * key_register_bpf_keyring - Publish the BPF keyring for KEY_SPEC_BPF_KEYRING
+ * @keyring: The keyring to publish
+ *
+ * Make @keyring reachable by userspace through the KEY_SPEC_BPF_KEYRING
+ * special key ID, so that provisioning it does not require scraping its
+ * serial out of /proc/keys first. Called once, from an initcall, and never
+ * undone.
+ */
+void key_register_bpf_keyring(struct key *keyring)
+{
+	bpf_keyring = keyring;
+}
+
 /*
  * Look up a key ID given us by userspace with a given permissions mask to get
  * the key it refers to.
@@ -741,6 +758,14 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 		key_ref = make_key_ref(key, 1);
 		break;
 
+	case KEY_SPEC_BPF_KEYRING:
+		key = bpf_keyring;
+		if (!key)
+			goto error;
+		__key_get(key);
+		key_ref = make_key_ref(key, 0);
+		break;
+
 	default:
 		key_ref = ERR_PTR(-EINVAL);
 		if (id < 1)
-- 
2.43.0

