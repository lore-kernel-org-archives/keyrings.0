Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793233878;
	b=yCCqnAVL4OwUcjf7+Mf64W0mqscpVnbSz13lBl1GVxSP64KxayN+bcTOx0Yb5bEDO6/u
	 ogbMjTYU/AWm8qleaPNaCZrGz7pLepuG88ttkZnkuZDlXgXejRBvNcOkUqa9vkBRYGAq7
	 wPIwdlEOs+73fWBT2TBg9jwH2iowtOJ29t6tDykd2wC1E2uZH6vYimKQTGVNHWCQlPES+
	 shg5Xm5m2LHCH0dCcdxIJuWfTDlUj0PjugnQHN2TPN/LNxijbCGQtV8SK+9aHupqxbxWG
	 wqbPdI78dqD7kGs1D512AW+YXp1kTNBAS2DxGoeRtGRR85g83zD6DtCFH+Sa3VxLM/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793233878;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zJlwqunvja1+hbNO+ndF9qMacVMMl8ctft2u4mlfKb8=;
	b=uI9+eNs7mz17HhGAI3xxMUyqsI2wcWUHo1mnWweT9KvlFlRWbt69EGOPRc33T/IBnvuv
	 2i7TRCdaoLNrGrK+Q2xMLSydDXIyhhXdE8iKiPvImtoqK1SWYVSF76NxhXlcxizvSLzSN
	 7dRM/HTE2oR5oqdFadjwLDRq6ByVbodpFXpEHrS9fUm/h9nQjVunJ8hhSZoNgbdLbSGPj
	 vCEbVxSXBer5v8SjPsefqOI52ULSb/PPi1yxzzXUvCJDnuYb3F87PyzZP/1ihHhH0qcy6
	 JM4i/MYWnjxHN7aTQIYQ/rcMByMYkN6BNsQPqHx+yM6eaJcdx6xsvg+JUQ+WYD0PJOg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ILf/SieR";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A22A606A31C;
	Thu, 29 Oct 2026 00:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILf/SieR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793233877;
	b=1Y+co5982V5LVlLrtYhwCN+17kMvxQoHr2S1HSjwF48BB1FIVzbZtn4zUpXBvfvbrB8+
	 gBupZ0JwDc0Tw9nQJmqG0R5255df/KhCdX6mQNXdSPbTERsp4xEODnJrf7UTYexBUJ8VI
	 RbSC1zIj4KcQDiNiT5dDoMNWgGpSYXxWQ1bJFIVjeTw56Y91SZQVzguPKNY9XB9HS1l8v
	 Z5/oAiFHOtgZBGVEXHNt152juooHJNbPpCzS04h6Eo6Zc0s//+xCSWstB1AWvk31MNm2E
	 4zLBPxy5ph+5rDyUoJ806L0uF1zRuLBjhbMiEXv7+cY2JE8TSPO6BGUPFfB02x3Vs2A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793233877;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=zJlwqunvja1+hbNO+ndF9qMacVMMl8ctft2u4mlfKb8=;
	b=0WiNzgjmwLa2qd3tE8EJLtJ9DbAWt2igXD8a66Q+Gz/VvgWgW08wl+0N7RBMrA+ZG9kv
	 9Lb4Ma+SHfiHkbh1YVcajWVafxZD9iC5gaKwGCMPrbSzyR1/v+oDOW5BiPfIrAUXD5ZzN
	 KoL1fe7Phqk9yVOhOtehOM7W/EZue4O8fCzPc9idDHjNAZeM7CK3jh4eibKa6heKiP54K
	 nU2W3QR+fnKxnhnB4QIyucYfJn/c0uxHD5k/FNfPQ22Dis9j25mOONvaeW0YMilm9STXo
	 dooRl9uCIUobvxJsHsjWy1pP79kY8j0FzZWo5+qnkPoEXExbncjBdHIjiIRqPZ5nh2g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 139CB1F01828;
	Thu, 29 Oct 2026 00:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793233877;
	bh=zJlwqunvja1+hbNO+ndF9qMacVMMl8ctft2u4mlfKb8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ILf/SieRqerEMSonFvZJ+3GWYeC3ZPbSCe4Z/qxYMUZ3FLTnp+mCmGF5EnBZJUdtX
	 mFYg+Om5NqInzYBgul262w1JS8dJ1IiOs2Fe5EwTNa6Y6jTMuTi6XBbPKzb8XZlHug
	 WKqWTy6M8NivuW/2ErUgjh7edkLw3WzypBWdPZK8JyHmLB8a40D4lgxmKB+VzR7JEn
	 WMT79XSUaF0B2XV4M+4omXlzSKTTrFehn2/9JZLo2mdXzVwR3DQUrRMpeUVYyb3HkG
	 va6MwYNmXNyYlKfHWB63+3t7eoloxT6GO65Y0/Gph/+1dxJpIf3MJxReYf//bz7uPW
	 QpjrK7pccq8pg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 7FA664564C;
	Thu, 29 Oct 2026 00:31:15 +0000 (UTC)
From: Manuel Huber via B4 Relay <devnull+manuelh.nvidia.com@kernel.org>
Date: Thu, 29 Oct 2026 00:30:39 +0000
Subject: [PATCH v2 2/3] keys: add KEY_SPEC_IPE_KEYRING
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
Message-Id: <20261029-b4-ipe-keyring-rfc-v2-2-77727b205844@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793233875; l=4547;
 i=manuelh@nvidia.com; s=20261019; h=from:subject:message-id;
 bh=/BFpBbq1FQa32YOzNX0aI7W2U2EGLrFUn65BbO8gg8g=;
 b=a8U5f4fDz3jnb/NdfevMsgRLh/Bpxd/5HEOmei1beg5hrND+EV39Tf8E8oS855+nuFE+ElntV
 n91Ec7ANsvBAm1CF9zhXRGxQp3PZor/EBkp5EHuKnB0+Vk+S+UDqvu0
X-Developer-Key: i=manuelh@nvidia.com; a=ed25519;
 pk=uKggxpZ/mM0qtFnudxvh5Dfz8I6VoehwoM3eYCe3tyU=
X-Endpoint-Received: by B4 Relay for manuelh@nvidia.com/20261019 with
 auth_id=1244
X-Original-From: Manuel Huber <manuelh@nvidia.com>
Reply-To: manuelh@nvidia.com
Content-Transfer-Encoding: 7bit

From: Manuel Huber <manuelh@nvidia.com>

The BPF, dm-verity, and fs-verity keyrings have well-known IDs which
allow userspace to directly address them. This commit follows the same
pattern for the .ipe keyring.

This provides a direct interface independent of resolving %:.ipe through
process keyrings and /proc/keys.

Signed-off-by: Manuel Huber <manuelh@nvidia.com>
---
 Documentation/security/keys/core.rst | 12 ++++++++++++
 include/linux/key.h                  |  2 ++
 include/uapi/linux/keyctl.h          |  1 +
 security/ipe/keyring.c               |  2 ++
 security/keys/process_keys.c         | 23 +++++++++++++++++++++++
 5 files changed, 40 insertions(+)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 326b8a973828..64b37817a335 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -373,6 +373,18 @@ process making the call::
 	KEY_SPEC_REQKEY_AUTH_KEY	-7	assumed request_key()
 						  authorisation key
 
+There are also values that refer to a specific kernel keyring rather than to
+anything belonging to the caller.  These well-known IDs allow userspace to
+name kernel keyrings directly even when they are not linked into a process
+keyring::
+
+	CONSTANT			VALUE	KEY REFERENCED
+	==============================	======	===========================
+	KEY_SPEC_IPE_KEYRING		-12	the ".ipe" keyring
+
+The availability of a subsystem keyring depends on its kernel configuration.
+Looking up an unavailable keyring returns ``ENOKEY``.
+
 
 The main syscalls are:
 
diff --git a/include/linux/key.h b/include/linux/key.h
index 81b8f05c6898..9c2ac0c70d56 100644
--- a/include/linux/key.h
+++ b/include/linux/key.h
@@ -440,6 +440,8 @@ extern key_ref_t keyring_search(key_ref_t keyring,
 extern int keyring_restrict(key_ref_t keyring, const char *type,
 			    const char *restriction);
 
+extern void key_register_ipe_keyring(struct key *keyring);
+
 extern struct key *key_lookup(key_serial_t id);
 
 static inline key_serial_t key_serial(const struct key *key)
diff --git a/include/uapi/linux/keyctl.h b/include/uapi/linux/keyctl.h
index 4c8884eea808..e42fca286b15 100644
--- a/include/uapi/linux/keyctl.h
+++ b/include/uapi/linux/keyctl.h
@@ -24,6 +24,7 @@
 #define KEY_SPEC_GROUP_KEYRING		-6	/* - key ID for GID-specific keyring */
 #define KEY_SPEC_REQKEY_AUTH_KEY	-7	/* - key ID for assumed request_key auth key */
 #define KEY_SPEC_REQUESTOR_KEYRING	-8	/* - key ID for request_key() dest keyring */
+#define KEY_SPEC_IPE_KEYRING		-12	/* - key ID for the .ipe keyring */
 
 /* request-key default keyrings */
 #define KEY_REQKEY_DEFL_NO_CHANGE		-1
diff --git a/security/ipe/keyring.c b/security/ipe/keyring.c
index 8502f825945d..14626df46e71 100644
--- a/security/ipe/keyring.c
+++ b/security/ipe/keyring.c
@@ -26,5 +26,7 @@ int __init ipe_keyring_init(void)
 			      KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
 	if (IS_ERR(ipe_keyring))
 		panic("failed to allocate \".ipe\" keyring");
+	key_register_ipe_keyring(ipe_keyring);
+
 	return 0;
 }
diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index a63c46bb2d14..20d6faefb75e 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -22,6 +22,9 @@
 /* Session keyring create vs join semaphore */
 static DEFINE_MUTEX(key_session_mutex);
 
+/* IPE keyring reachable through KEY_SPEC_IPE_KEYRING */
+static struct key *ipe_keyring __ro_after_init;
+
 /* The root user's tracking struct */
 struct key_user root_key_user = {
 	.usage		= REFCOUNT_INIT(3),
@@ -590,6 +593,18 @@ bool lookup_user_key_possessed(const struct key *key,
 	return key == match_data->raw_data;
 }
 
+/**
+ * key_register_ipe_keyring - Publish the IPE keyring
+ * @keyring: The keyring to publish
+ *
+ * Make @keyring reachable by userspace through the KEY_SPEC_IPE_KEYRING
+ * special key ID. Called once, from an initcall, and never undone.
+ */
+void key_register_ipe_keyring(struct key *keyring)
+{
+	ipe_keyring = keyring;
+}
+
 /*
  * Look up a key ID given us by userspace with a given permissions mask to get
  * the key it refers to.
@@ -741,6 +756,14 @@ key_ref_t lookup_user_key(key_serial_t id, unsigned long lflags,
 		key_ref = make_key_ref(key, 1);
 		break;
 
+	case KEY_SPEC_IPE_KEYRING:
+		key = ipe_keyring;
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
2.53.0


