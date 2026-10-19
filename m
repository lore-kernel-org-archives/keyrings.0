Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792446046;
	b=gngYgEkwwUS9o4+bG5O315oQm4DzkUt9uua+zES3TfSYTPzTwnNisdyyu5vaB4kCTPGU
	 vu61MahpBz8Fx/bTCjahzNC8FI7XA+W7VC8ZDezKiY0AEBpgQUfSkG5uo/OOGYeSm3aBY
	 b4kIoaILjfas7myuGEQ+udsbooCShXvxQw1PplUiCzjy80eEd+hAJDTWDOb5U6UWHPTeR
	 ipJ0QYU8xLfO8wSvJhGsZFFHgbOlS3mU8mYOrCaXlFL8hNl/YtDg4DucHsWqKZM9bi+G6
	 bHex0Z+rUCBUlb8XSKd2LnzF/k3ipES6d/1KxFBJNrGGtvCFVc8uTQnUPGGcbVG+LHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792446046;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=r5lantx5T1q6bN4wiI36oD3VJ/9gICPU472zEAG06qk=;
	b=IXF3EfqYCoKGXRzqmxrlAHlMn98/tRmWmNlkZ0kEIkW1riG5Gi9LqC8WEkdhn5U0Bh6c
	 53VGExxXsPebV4OmgKW7vTREcfQHQIq8Q9jcEkxPvBZZYHn38+32gG3fohlr/uHA+15nM
	 uM5rmoZo5ridAAxeSczeOp04TNwA7BuY59vN7Q7GUOS2CDyDJOsf8EYIm4jJAWPGtcwNu
	 qMS1kXGRagaTlLvlFWtIVoNw3pn1oA7+RvrJ+jtT19oVCyh8Y4tr1GN1zgZW/QolBsUu/
	 00/+84Dt6jfpdYfCsPQicvK1pOEAHAH5BJ6QatztFz57LMw6ibmHKvd6f/w0zZBulFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=grmjwNzc;
	arc=fail smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C02606A339;
	Mon, 19 Oct 2026 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=grmjwNzc
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792446045;
	b=eGGeAbMjuvThgHW4jO3ThLv+PfV6w1sBZ3U4aB3htHMORPaodIZTaUZgg/5hjtTN8GHS
	 wXd9SPAPorqnG0LeT3EOIe7M6aXENHaiw9abEU9VYPwYZo2ONhG2ni8wXstxezd0WL1mh
	 THEoZFfbb1hdS6ePPBOeO/XaHkAiaA9PtHSTyy/DOO33tuN+Jh0PcZOmgKkRcvN5ooxLj
	 w5oRt0lGp55k05ElyL9tGJG7ChomQrW9rAT7fhy8HAMiTtT4x8QMguWwBNcGza35yTVYT
	 mToDIMevzEPPqnonLcjbGmUoA9bhHuRszLd5w2Dnh+4C9ojMZUXz2KqEykIwojZxiAg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792446045;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=r5lantx5T1q6bN4wiI36oD3VJ/9gICPU472zEAG06qk=;
	b=EsDZU8mrXSUVLhqAORAoKy+pJtedIWE2PxCUdDz3zJ5ikpHeYwKosz8ZDY+anzrv1CxV
	 qAW7s6WOUQd4NTjIdgHskdtYiVd0co8YOpKoBUBtIFQ7Kp3oMyKHhZLHaA8gjiu7rGkfl
	 Rvf4kpt6TG+2kTnk2awHmZxzz0uFXOIiWD4NQwGwuKhLB3Xz0W5FxeySqt8jZm/GQGneT
	 5Sul/WAM23gisfZV3y/q/FvYOAEnlaQIPJX8HieHFlxQgg6cqgc1r0y3FJ4SjGLYN5z+3
	 fxMb7mbgNu0CB403P0nsnjZmA9rTrtsuQJ7N18V6z8L1IxMHVmRBAX67BNbTsE2PuGw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B2AAE1F000C6;
	Mon, 19 Oct 2026 21:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792446045;
	bh=r5lantx5T1q6bN4wiI36oD3VJ/9gICPU472zEAG06qk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=grmjwNzcQ5BRj//giAsTZ3a4i41shrVcHWCOgpfCOKxwgZlcrFqvRKJ+SpVpCLoNv
	 8iwrqOm//IZwaKdYjCjoeqHQdB7ns8+cxthdUQLXV/62WT4B/kYvsVwu0Z/HQxJJ52
	 F/q84fuRZz7nVR+WbwLXBlHjfTZ+C2n1D16daEsnDo7NlezMO66SqR4TDi8FwZg38H
	 4LjJoUhZ6G9clTljLjgZ9TdG5bx71+e05deo9xqqPJvSgYuB30Y4KTt8KI+GM4yK4e
	 RUPZiWHdPCZhyUqyZ7VB5gbxesh0b3jSvePi6Ncrao9CbAsYGL5cXpT9/nP4+aasWz
	 gCgbD7IeP+GRQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 083D140631;
	Mon, 19 Oct 2026 21:40:43 +0000 (UTC)
From: Manuel Huber via B4 Relay <devnull+manuelh.nvidia.com@kernel.org>
Date: Mon, 19 Oct 2026 21:40:25 +0000
Subject: [PATCH RFC 1/4] ipe: add the .ipe policy keyring
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
Message-Id: <20261019-b4-ipe-keyring-rfc-v1-1-156f0b93e843@nvidia.com>
References: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
In-Reply-To: <20261019-b4-ipe-keyring-rfc-v1-0-156f0b93e843@nvidia.com>
To: Fan Wu <wufan@kernel.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Shuah Khan <shuah@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Manuel Huber <manuelh@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792446042; l=7425;
 i=manuelh@nvidia.com; s=20261019; h=from:subject:message-id;
 bh=pzmdNrjH0K9jBZOsygXh8Yb7f2fOt7gvUDgHY5ObJnM=;
 b=224d2yttNRkgR9OFGtyo3Av3E6VfoYQzjQs75w2w9gzlveaL4NqBDAD/bPpkGmLk8nKssW5tw
 bnMFsrT4dQqDt7AuC0tNnj5u5wi9HMLbltX0uZGNIerHOwUPuFqmWxJ
X-Developer-Key: i=manuelh@nvidia.com; a=ed25519;
 pk=uKggxpZ/mM0qtFnudxvh5Dfz8I6VoehwoM3eYCe3tyU=
X-Endpoint-Received: by B4 Relay for manuelh@nvidia.com/20261019 with
 auth_id=1244
X-Original-From: Manuel Huber <manuelh@nvidia.com>
Reply-To: manuelh@nvidia.com
Content-Transfer-Encoding: 7bit

From: Manuel Huber <manuelh@nvidia.com>

Add a dedicated .ipe keyring for IPE policy signature verification,
modeled after the .dm-verity and .bpf keyring implementations.

With this, userspace can provision its own keys into the keyring,
then restrict it and activate it for IPE policy signature verification.

This enables scenarios in which a trusted userspace component generates
an IPE policy, and creates an ephemeral policy-signing key pair,
provisions its public certificate, and restricts the IPE keyring during
the early lifetime of a system. The trusted component can then sign the
IPE policy, destroy the private key, and load and activate the policy.
During that phase, the system is considered in a trusted state whereas
the system transitions into a possibly untrusted state afterwards,
running arbitrary user-provided applications. In such a scenario, the
trusted userspace component could reside on a dm-verity protected
rootfs disk, and applications would reside on additional dm-verity
protected disks. The latter disks would be dynamically attached and
their dm-verity root hashes and/or signatures not known a priori to
launching the system.

A concrete usage scenario could be Kata Containers, which enables
running Kubernetes pods in ephemeral, headless utility VMs, possibly
without systemd. The rootfs disk is static and known beforehand, but
containerd's image layers might be acquired and transported into the
VM using the erofs snapshotter and dynamic block device attachment
using dm-verity.

Signed-off-by: Manuel Huber <manuelh@nvidia.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  9 +++
 security/ipe/Makefile                           |  1 +
 security/ipe/ipe.c                              |  2 +
 security/ipe/keyring.c                          | 79 +++++++++++++++++++++++++
 security/ipe/keyring.h                          | 16 +++++
 security/ipe/policy.c                           | 10 ++++
 6 files changed, 117 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e75344f4e0cd..fd508dd779ed 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2733,6 +2733,15 @@ Kernel parameters
 			Determine whether IPE starts in permissive (0) or
 			enforce (1) mode. The default is enforce.
 
+	ipe.keyring_unsealed=
+			[IPE]
+			Format: <bool>
+			When set to 1, leave the IPE policy keyring
+			unsealed after initialization so userspace can provision
+			keys. Once the keyring is nonempty and restricted, it is
+			searched during policy-signature verification. The default
+			is 0, which creates the keyring restricted and empty.
+
 	ipe.success_audit=
 			[IPE]
 			Format: <bool>
diff --git a/security/ipe/Makefile b/security/ipe/Makefile
index 2ffabfa63fe9..109e736696a5 100644
--- a/security/ipe/Makefile
+++ b/security/ipe/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_SECURITY_IPE) += \
 	hooks.o \
 	fs.o \
 	ipe.o \
+	keyring.o \
 	policy.o \
 	policy_fs.o \
 	policy_parser.o \
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 495bb765de1b..f5232f850dc2 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -7,6 +7,7 @@
 #include "ipe.h"
 #include "eval.h"
 #include "hooks.h"
+#include "keyring.h"
 
 extern const char *const ipe_boot_policy;
 bool ipe_enabled;
@@ -97,4 +98,5 @@ DEFINE_LSM(ipe) = {
 	.init = ipe_init,
 	.blobs = &ipe_blobs,
 	.initcall_fs = ipe_init_securityfs,
+	.initcall_late = ipe_keyring_init,
 };
diff --git a/security/ipe/keyring.c b/security/ipe/keyring.c
new file mode 100644
index 000000000000..ea8d164b62a6
--- /dev/null
+++ b/security/ipe/keyring.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#include <linux/cred.h>
+#include <linux/err.h>
+#include <linux/key.h>
+#include <linux/moduleparam.h>
+
+#include "ipe.h"
+#include "keyring.h"
+
+static struct key *ipe_keyring __ro_after_init;
+
+static bool ipe_keyring_unsealed __ro_after_init;
+
+/* Set the right module name for built-in parameters. */
+#ifdef KBUILD_MODNAME
+#undef KBUILD_MODNAME
+#define KBUILD_MODNAME "ipe"
+#endif
+
+module_param_named(keyring_unsealed, ipe_keyring_unsealed, bool, 0444);
+MODULE_PARM_DESC(keyring_unsealed, "Leave the IPE keyring unsealed");
+
+/**
+ * ipe_keyring_lookup() - Get the IPE keyring if it is ready for use.
+ *
+ * Return: A borrowed pointer to the IPE keyring if it is nonempty and
+ * restricted, or %NULL otherwise. The keyring has system lifetime.
+ */
+struct key *ipe_keyring_lookup(void)
+{
+	if (!ipe_keyring)
+		return NULL;
+
+	if (!READ_ONCE(ipe_keyring->keys.nr_leaves_on_tree) ||
+	    !READ_ONCE(ipe_keyring->restrict_link))
+		return NULL;
+
+	return ipe_keyring;
+}
+
+/**
+ * ipe_keyring_init() - Allocate and configure the IPE keyring.
+ *
+ * Return: Always %0. A failure leaves IPE without its dedicated keyring.
+ */
+int __init ipe_keyring_init(void)
+{
+	struct key *keyring;
+	int rc;
+
+	keyring = keyring_alloc(".ipe", GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+				current_cred(),
+				KEY_POS_SEARCH |
+				KEY_USR_VIEW | KEY_USR_READ | KEY_USR_WRITE |
+				KEY_USR_SEARCH | KEY_USR_SETATTR,
+				KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
+	if (IS_ERR(keyring)) {
+		pr_err("failed to allocate keyring: %ld\n", PTR_ERR(keyring));
+		return 0;
+	}
+
+	if (!ipe_keyring_unsealed) {
+		rc = keyring_restrict(make_key_ref(keyring, true), NULL, NULL);
+		if (rc) {
+			pr_err("failed to restrict keyring: %d\n", rc);
+			key_revoke(keyring);
+			key_put(keyring);
+			return 0;
+		}
+	}
+
+	ipe_keyring = keyring;
+
+	return 0;
+}
diff --git a/security/ipe/keyring.h b/security/ipe/keyring.h
new file mode 100644
index 000000000000..3d450a465511
--- /dev/null
+++ b/security/ipe/keyring.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#ifndef _IPE_KEYRING_H
+#define _IPE_KEYRING_H
+
+#include <linux/init.h>
+
+struct key;
+
+int __init ipe_keyring_init(void);
+struct key *ipe_keyring_lookup(void);
+
+#endif /* _IPE_KEYRING_H */
diff --git a/security/ipe/policy.c b/security/ipe/policy.c
index e542329726bc..abc1ff9ac230 100644
--- a/security/ipe/policy.c
+++ b/security/ipe/policy.c
@@ -9,6 +9,7 @@
 #include "ipe.h"
 #include "eval.h"
 #include "fs.h"
+#include "keyring.h"
 #include "policy.h"
 #include "policy_parser.h"
 #include "audit.h"
@@ -160,6 +161,7 @@ struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
 				  const char *pkcs7, size_t pkcs7len)
 {
 	struct ipe_policy *new = NULL;
+	struct key *keyring;
 	int rc = 0;
 
 	new = kzalloc_obj(*new);
@@ -189,6 +191,14 @@ struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
 						    VERIFYING_UNSPECIFIED_SIGNATURE,
 						    set_pkcs7_data, new);
 #endif
+		if (rc == -ENOKEY || rc == -EKEYREJECTED) {
+			keyring = ipe_keyring_lookup();
+			if (keyring)
+				rc = verify_pkcs7_signature(NULL, 0, new->pkcs7,
+							    pkcs7len, keyring,
+							    VERIFYING_UNSPECIFIED_SIGNATURE,
+							    set_pkcs7_data, new);
+		}
 		if (rc)
 			goto err;
 	} else {

-- 
2.53.0


