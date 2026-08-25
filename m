Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926504446E4;
	Tue, 25 Aug 2026 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787667942; cv=none; b=SdpAIVygThcM8TpqNWt23tnFQTyoC4/F16vN1Un91/fygKch4qudcYEFGliOMImS730k722l+MtCWGVeCY2F5bneJr5M+J9xu2VuoblnFx2jm596pGRrRW5hy3X7XOBnCE3tU8UmIV+73TLQRuf+21Q00vpFSXoFMVfQLhqxp5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787667942; c=relaxed/simple;
	bh=f2rzlOPYRUutKGmCLoNH4Gx5Mds3UP0Mdb3angsdXvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+gOAK5M5jyj239MorUdW/LH6J6oc5ceqLdxm6NCcDWLX3zFBQffevZTprRKJHvzDoiz/2LILHb2mLoLBeTKAfM7Z+y0aZ7xwI3IyuYq3pF4j/PjAEb3HUgl3rZK1pG9lyWdkdZEozyV1UcXY7bnSv5efgNPMlYNdN1OrpAQ6EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=TK3QR55j; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="TK3QR55j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=4Y34iWw8FoIRxvP8jtdTMjV1KuMa03GqlNTHulPNua0=; b=TK3QR55j71tmbmKFAzyD10pB2Y
	1ORqlZRxlWWsG43guCoacaLCqOrt4e6OPdPsBz3yy4utW4mLFvZNQWZdfHASa8CQjQCbMV3Cp6qEu
	F+hDJwWTJYvGlP/6qwuK7A3/zGv7avfxspaoNVby6Rm6L0BnLShyF6/ZVRCXfGDG6xhtVsdme0HoF
	ul0RNy5rcQ9Knr/PDOQqAUk16Zygk2W0AEbLjDLPxDKueOtzRzPeKgmHtIvi8LZw1r4dNpvWaFrBR
	QjQDGqSGPo89wZ14vJ4HrvhjSddCM7wNQ5JuToFAUPSV6u+/3tNGCaiPeiU3rmus83U007Z5nLslS
	cNA07t9A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wys5k-000N7q-0R;
	Tue, 25 Aug 2026 16:25:32 +0200
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
Subject: [PATCH bpf-next v2 01/11] bpf: Add a bpf keyring for program signature validation
Date: Tue, 25 Aug 2026 16:25:20 +0200
Message-ID: <20260825142530.1329706-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825142530.1329706-1-daniel@iogearbox.net>
References: <20260825142530.1329706-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28103/Tue Aug 25 08:27:08 2026)

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
is selected with the new well-known keyring_id VERIFY_USE_BPF_KEYRING
and gives an operator a place to enroll a BPF-only signing key at boot,
specifically scoped to BPF program loading and nothing else in the
kernel's trust hierarchy.

By default the keyring is sealed empty at init. Systems that want to
provision keys pass bpf.keyring_unsealed=1, which leaves the keyring
open for the initrd to add keys to. The keyring is only ever consulted
once it is both non-empty and restricted. An unrestricted keyring is
ignored.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../admin-guide/kernel-parameters.txt         |  8 +++
 include/linux/bpf.h                           |  7 ++
 include/linux/verification.h                  | 10 +++
 kernel/bpf/Makefile                           |  3 +
 kernel/bpf/keys.c                             | 67 +++++++++++++++++++
 kernel/bpf/verifier.c                         | 13 +++-
 6 files changed, 106 insertions(+), 2 deletions(-)
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
diff --git a/include/linux/verification.h b/include/linux/verification.h
index dec7f2beabfd..1cb59ddda250 100644
--- a/include/linux/verification.h
+++ b/include/linux/verification.h
@@ -18,6 +18,16 @@
 #define VERIFY_USE_SECONDARY_KEYRING ((struct key *)1UL)
 #define VERIFY_USE_PLATFORM_KEYRING  ((struct key *)2UL)
 
+/*
+ * The id of BPF's ".bpf" keyring, reserved from the same space. It is
+ * explicitly not a sentinel like the two above as BPF resolves it to
+ * the keyring itself and passes that, so verify_pkcs7_signature() never
+ * sees this value, and system_keyring_id_check() must keep rejecting it.
+ * Left as a plain integer so that handing it over as @trusted_keys does
+ * not compile.
+ */
+#define VERIFY_USE_BPF_KEYRING	3
+
 static inline int system_keyring_id_check(u64 id)
 {
 	if (id > (unsigned long)VERIFY_USE_PLATFORM_KEYRING)
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
index 000000000000..dc4d3a33158a
--- /dev/null
+++ b/kernel/bpf/keys.c
@@ -0,0 +1,67 @@
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
+	return 0;
+}
+late_initcall(bpf_keyring_init);
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e036ae20bf6b..3be8d51d35ac 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20981,6 +20981,8 @@ static enum bpf_sig_keyring bpf_classify_keyring(s32 keyring_id)
 		return BPF_SIG_KEYRING_SECONDARY;
 	case (s32)(unsigned long)VERIFY_USE_PLATFORM_KEYRING:
 		return BPF_SIG_KEYRING_PLATFORM;
+	case VERIFY_USE_BPF_KEYRING:
+		return BPF_SIG_KEYRING_BPF;
 	default:
 		return BPF_SIG_KEYRING_USER;
 	}
@@ -21016,10 +21018,17 @@ static int bpf_prog_verify_signature(struct bpf_verifier_env *env,
 	if (!attr->signature_size ||
 	    attr->signature_size > KMALLOC_MAX_CACHE_SIZE)
 		return -EINVAL;
-	if (system_keyring_id_check(attr->keyring_id) == 0)
+	if (attr->keyring_id == VERIFY_USE_BPF_KEYRING) {
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
-- 
2.43.0

