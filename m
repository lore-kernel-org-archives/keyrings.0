Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793233878;
	b=WR5DUHt1zDDgALHZrF+BFXA1Yyc/5hEKwAySTLtAaaAIaH1/KcXQg4HHC54xAZu9Mc3p
	 nY0sS64N14o3OU2q9SXyIqAgAw4nOnlqigbWzlPvvC1lYawCWVp8kn6yX0boP4NOYBtLf
	 IYZcRy++FLLJ4Ud89p085uv24Ois1UhjZu2PxyjSDtC9MGXrdS8hYBCadWgAzG0gqAMA/
	 bj6QRRRck/rQQb2jWjMj/dBjuPckumW6qWSzbBIt/wFAsWYqQRhqlt1h4s3qj83l78fRW
	 +dPvieF607ICd1aAfKTM+WtnXe+zS6k9hT1pe6Iuq7upOM6GE7w4Fwze+nvmA5YTRug==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233878;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wHgrig9qjFP2gPZLGaq7vPBylHZ9kF92oCc7Wi052Sw=;
	b=h9q1NWiaYkcLDuB4jkraCSjWkfRxJ9kCDo/715CebqFonptTEG0xx42+rL+RCMMRVvsw
	 KZuXxWxahcj5Z/2sQW4ZiHHr6a3w9eEiwxeiq2KmosBOgHr6xmdfWX7FfUREMkUFX+Cju
	 bpFBbE4N8F8pryTeTGzimqo4ljFvFmHfR932SCt5LWQx+msHSPRFj846vKRXzkAuOOkRA
	 SJZov4xIlW4q7oXwrfhKJZYgOqCJsM4uyd4dPbVGet5ABdbKwIEnjMqTjKPlx3BjRvgIR
	 qssSukEUUQBamJInOF51naNsRhuQ0r7bIrXIBLl2M9nxLu5C07vIp8T8UGMhlfGoQ7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="DEF4MGo/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0566606A31D;
	Thu, 29 Oct 2026 00:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DEF4MGo/
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793233877;
	b=cQ036rESxVHkrk4ST7+vnZKcAYa4B59U76MJX1g9VI6Z9RXJ7Qwj6avzPu4Gux+TOGKR
	 tZ3fvDtxgMDhigAf/c6g2yTUB7tUjo4EMsXfzqwFziqUabNnunEQiWh9L5U7jruwEIweo
	 NfOKfjRC478mMK/Y4Tv3N2BpTsPCrlinr9ciSUu2RaiARoM3dEmeJadmzhzTxfr1xVlky
	 SKFKQSCGCo3S+NsGy8G5mXBuTDnLJ+8QvzQQCiP4P549bVtbbbI7xf7yfp9H7pWEI8hNU
	 z9/doSgoB/EuVLcKTvTP9P+AT6qmd4yYlO554ka6H3E5ABoioogfzxifxrwAmfUr99A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793233877;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=wHgrig9qjFP2gPZLGaq7vPBylHZ9kF92oCc7Wi052Sw=;
	b=a9uxWMdGKhN5fVbvtS31duEnvbj9fNjFwnVx3a7gJoGGBRbHAabHy6zLPDJX2R5IFjmF
	 QbOagnqOY7M3NvERLvS4Ht8ZUn42t522iAs+g5NvsiL5f2k20K+FBh0ujK222cgoViXT6
	 N/6cAIZlEUVRAbHpcsqfSqLpvW+2RDBmp0iDsIRB8fpmJ/9+Gnse1TyuiM8fH3G6bYj3p
	 ohs6ql6P3BW2zgzdNF+z/MZLzMmUZ8W9OXFgJd8Zb0M4gpK1doJS8hMurR21qxphwhxem
	 KTWWkKD9mf4B9xSDHbsGsCCYL3Nc/qN4Z87QRuu1LlZnsEOf/bOEHlZZhxmmZFavfPQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 13F4B1F031E0;
	Thu, 29 Oct 2026 00:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793233877;
	bh=wHgrig9qjFP2gPZLGaq7vPBylHZ9kF92oCc7Wi052Sw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=DEF4MGo/SXzQnYAvszVzL8Gt+FB5/8tW3Aur1B8+yIkCUrLlgyiaM1+HTfwdj2yhP
	 bEHAYVKQr3yw6ZpolEz6EfAW6mzT8vpJBroN1Awu5Md6c0sL50Cb4xwvDteGASXZWH
	 WlF/mkFCZkk4XX0JV0NUQrsqY9NChyaUrmTofyMhn8LqTuK0x8pBEEIUpxKg/COALl
	 k66rtfG5uBL5etdm8EFpBotzUuEoFFbGub0HBLeOdQUkJUvBDgw0+9D+WeMLOo9c94
	 iTW8TzAfgkvF9Oft+jLbkxKaiJrm6EiRZacmR3S2+vjGPW9S/q3Gjy7uiOdZ1+iFWZ
	 tamkjSzaT5EiQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 738864563B;
	Thu, 29 Oct 2026 00:31:15 +0000 (UTC)
From: Manuel Huber via B4 Relay <devnull+manuelh.nvidia.com@kernel.org>
Date: Thu, 29 Oct 2026 00:30:38 +0000
Subject: [PATCH v2 1/3] ipe: add the .ipe policy keyring
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
Message-Id: <20261029-b4-ipe-keyring-rfc-v2-1-77727b205844@nvidia.com>
References: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com>
In-Reply-To: <20261029-b4-ipe-keyring-rfc-v2-0-77727b205844@nvidia.com>
To: Fan Wu <wufan@kernel.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
 Andrew Halaney <andrew@amutable.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Luca Boccassi <luca.boccassi@gmail.com>, 
 James Bottomley <James.Bottomley@HansenPartnership.com>, 
 linux-security-module@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kexec@lists.infradead.org, Manuel Huber <manuelh@nvidia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793233875; l=8137;
 i=manuelh@nvidia.com; s=20261019; h=from:subject:message-id;
 bh=qUKO8xyX+/8KnwHErrUte/NPW7CoaYPDwwyvYL+BdNU=;
 b=MXkQBF9XIPmW3lQQqP3IeEwfmaFpTfmzIFwNsZAfrIlG+uYj7UlcRHC7eY3gmY9NLyjJSOSXl
 UChshGXrzhTCTBe+wgtGrLi/y93tQwVlFJqhvvfgB0ri92DtgmGQM/r
X-Developer-Key: i=manuelh@nvidia.com; a=ed25519;
 pk=uKggxpZ/mM0qtFnudxvh5Dfz8I6VoehwoM3eYCe3tyU=
X-Endpoint-Received: by B4 Relay for manuelh@nvidia.com/20261019 with
 auth_id=1244
X-Original-From: Manuel Huber <manuelh@nvidia.com>
Reply-To: manuelh@nvidia.com
Content-Transfer-Encoding: 7bit

From: Manuel Huber <manuelh@nvidia.com>

Add a dedicated .ipe keyring for IPE policy signature verification.
With this, userspace can provision its own keys into the keyring,
then restrict it and activate it for IPE policy signature verification.

Gate creation of the keyring behind a new by-default disabled
CONFIG_SECURITY_IPE_KEYRING Kconfig option. When created, the keyring
is empty and writable. The keyring is used as a fallback after the
existing policy trust sources only when it is created, non-empty, and
restricted with restrict_link_reject.

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
using dm-verity. While in that usage scenario, signing a per-guest
policy with a pre-provisioned policy-signing certificate in the
builtin, secondary, or platform keyrings would be technically possible,
it would require including its corresponding private key in the guest
build artifacts. Making it possible to use an ephemeral,
userspace-provided key avoids shipping a static policy-signing private
key with the guest rootfs.

Signed-off-by: Manuel Huber <manuelh@nvidia.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  1 +
 security/ipe/Kconfig                            | 16 +++++++++++++
 security/ipe/Makefile                           |  2 ++
 security/ipe/ipe.c                              |  4 ++++
 security/ipe/keyring.c                          | 30 +++++++++++++++++++++++++
 security/ipe/keyring.h                          | 17 ++++++++++++++
 security/ipe/policy.c                           | 17 ++++++++++++++
 7 files changed, 87 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e75344f4e0cd..9fabbc1c95b6 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -23,6 +23,7 @@
 	HW	Appropriate hardware is enabled.
 	HYPER_V HYPERV support is enabled.
 	IMA     Integrity measurement architecture is enabled.
+	IPE	Integrity Policy Enforcement is enabled.
 	IP_PNP	IP DHCP, BOOTP, or RARP is enabled.
 	IPV6	IPv6 support is enabled.
 	ISAPNP	ISA PnP code is enabled.
diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
index a110a6cd848b..5c51da074264 100644
--- a/security/ipe/Kconfig
+++ b/security/ipe/Kconfig
@@ -51,6 +51,22 @@ config IPE_POLICY_SIG_PLATFORM_KEYRING
 
 	  If unsure, answer Y.
 
+config SECURITY_IPE_KEYRING
+	bool "IPE policy keyring"
+	default n
+	help
+	  This option creates the .ipe keyring, which allows trusted
+	  userspace to provision certificates for IPE policy signature
+	  verification. IPE uses the keyring only after userspace has added
+	  at least one certificate and applied a reject-all restriction.
+
+	  Enable this only when the userspace component that provisions and
+	  restricts the keyring is part of the system's trusted computing
+	  base. Such systems must also prevent unauthorized kexec, which
+	  would start a new kernel without preserving the keyring state.
+
+	  If unsure, answer N.
+
 menu "IPE Trust Providers"
 
 config IPE_PROP_DM_VERITY
diff --git a/security/ipe/Makefile b/security/ipe/Makefile
index 2ffabfa63fe9..78161dfb48ea 100644
--- a/security/ipe/Makefile
+++ b/security/ipe/Makefile
@@ -25,6 +25,8 @@ obj-$(CONFIG_SECURITY_IPE) += \
 	policy_parser.o \
 	audit.o \
 
+obj-$(CONFIG_SECURITY_IPE_KEYRING) += keyring.o
+
 clean-files := boot_policy.c \
 
 obj-$(CONFIG_SECURITY_IPE_KUNIT_TEST) += \
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 495bb765de1b..ee8731eb4070 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -7,6 +7,7 @@
 #include "ipe.h"
 #include "eval.h"
 #include "hooks.h"
+#include "keyring.h"
 
 extern const char *const ipe_boot_policy;
 bool ipe_enabled;
@@ -97,4 +98,7 @@ DEFINE_LSM(ipe) = {
 	.init = ipe_init,
 	.blobs = &ipe_blobs,
 	.initcall_fs = ipe_init_securityfs,
+#ifdef CONFIG_SECURITY_IPE_KEYRING
+	.initcall_late = ipe_keyring_init,
+#endif
 };
diff --git a/security/ipe/keyring.c b/security/ipe/keyring.c
new file mode 100644
index 000000000000..8502f825945d
--- /dev/null
+++ b/security/ipe/keyring.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 NVIDIA CORPORATION & AFFILIATES. All rights reserved.
+ */
+
+#include <linux/cred.h>
+#include <linux/err.h>
+#include <linux/key.h>
+
+#include "keyring.h"
+
+struct key *ipe_keyring __ro_after_init;
+
+/**
+ * ipe_keyring_init() - Allocate and configure the IPE keyring.
+ *
+ * Return: Always %0.
+ */
+int __init ipe_keyring_init(void)
+{
+	ipe_keyring =
+		keyring_alloc(".ipe", GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+			      current_cred(), KEY_POS_SEARCH |
+				KEY_USR_VIEW | KEY_USR_READ | KEY_USR_WRITE |
+				KEY_USR_SEARCH | KEY_USR_SETATTR,
+			      KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
+	if (IS_ERR(ipe_keyring))
+		panic("failed to allocate \".ipe\" keyring");
+	return 0;
+}
diff --git a/security/ipe/keyring.h b/security/ipe/keyring.h
new file mode 100644
index 000000000000..d9a057a14978
--- /dev/null
+++ b/security/ipe/keyring.h
@@ -0,0 +1,17 @@
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
+extern struct key *ipe_keyring;
+
+int __init ipe_keyring_init(void);
+
+#endif /* _IPE_KEYRING_H */
diff --git a/security/ipe/policy.c b/security/ipe/policy.c
index e542329726bc..514a1985b5e1 100644
--- a/security/ipe/policy.c
+++ b/security/ipe/policy.c
@@ -4,11 +4,13 @@
  */
 
 #include <linux/errno.h>
+#include <linux/key.h>
 #include <linux/verification.h>
 
 #include "ipe.h"
 #include "eval.h"
 #include "fs.h"
+#include "keyring.h"
 #include "policy.h"
 #include "policy_parser.h"
 #include "audit.h"
@@ -160,6 +162,9 @@ struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
 				  const char *pkcs7, size_t pkcs7len)
 {
 	struct ipe_policy *new = NULL;
+#ifdef CONFIG_SECURITY_IPE_KEYRING
+	struct key_restriction *restriction;
+#endif
 	int rc = 0;
 
 	new = kzalloc_obj(*new);
@@ -188,6 +193,18 @@ struct ipe_policy *ipe_new_policy(const char *text, size_t textlen,
 						    VERIFY_USE_PLATFORM_KEYRING,
 						    VERIFYING_UNSPECIFIED_SIGNATURE,
 						    set_pkcs7_data, new);
+#endif
+#ifdef CONFIG_SECURITY_IPE_KEYRING
+		if (rc == -ENOKEY || rc == -EKEYREJECTED) {
+			restriction = READ_ONCE(ipe_keyring->restrict_link);
+			if (READ_ONCE(ipe_keyring->keys.nr_leaves_on_tree) &&
+			    restriction &&
+			    READ_ONCE(restriction->check) == restrict_link_reject)
+				rc = verify_pkcs7_signature(NULL, 0, new->pkcs7,
+							    pkcs7len, ipe_keyring,
+							    VERIFYING_UNSPECIFIED_SIGNATURE,
+							    set_pkcs7_data, new);
+		}
 #endif
 		if (rc)
 			goto err;

-- 
2.53.0


