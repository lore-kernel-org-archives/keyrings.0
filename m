Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792446046;
	b=jYauuBEWJZIvC4u1uD0Jons/z3b7E8tlZJFPa38Gvvf/OjZ3hiOZOrq8OMvBozfZ++tV
	 T1KntY2miRpgdEhDr+41ZX7eZ+IrpizB7Zln+PO/F5kZ9AJaTCWezl1VYSnJa0pjBclIO
	 qsALmBbFBQfS8q50S626jee4yZvi4hlCaBNbZ81vDMnubS6X16zyfqPk96vv1QjRJd5/4
	 isrKivG2oxYQyjkGDQFhodWGVwSBHUFo4HbHnau2EjbKS1VAYbUgRPz6uiCbdUrBBqYsT
	 afuthcF68i5SDpz0TIJb1QblMLoktIeaLugBn47zMav8eIGOECrPyLtGGbdd4ge1idw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792446046;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qmF0C7xRAK3ZpSq3uSOFx/vq9csLsn2rRQh0+bevgPU=;
	b=YX8HPZMWJ6TJvTybdKpx8y+0pWaVtHaZfOUZfDZwCdBeMm8IFsaxNVx6OE5f9qs0rzIk
	 F9BA3oEf+bALhG+JUH9gpANWdgyE0D2icVOLZ2NadFI9kMDFXHs7CAIVnD83xvZgrRi5P
	 H/QldWBX4VT+z1i390w6f9Wwgp8mQZ8QX0txKlk1Y6akamOjH/rZ0TeS1PqByvkknD7IL
	 mpvTqDOd6rLLy0mZp9Ua5pJYgle1gm0Z9Hgluhf+m7NyYBD1oBmZKt7bvtC7bCI8v/CDZ
	 3GIb8jUwdONOmV2E6B32pczAt7CeIhXIylotp9sXYh6iSrwQhiGYfuKpbtsM9Z0exQQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6W9MbtB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A31D606A329;
	Mon, 19 Oct 2026 21:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j6W9MbtB
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792446044;
	b=Z4SLXDlczRBzmeAUbbd1cSgMH38rKO/K4pXDRjdWAoQE82z/zgm1nvBkGGyHgOMzKLfE
	 8BE1Xk/tYv0GyX+OL52TZwYfYo6LjinfVc4DPaXs3G+jGcqRRvxfwlzaFkYlGSU1k4wqO
	 yP32rcnXlMPTNNrjSNHw8P2juE4fMZH5mnunqPR2+OwPNbEwt1oiE5hTPZD5cPpyB4Rfa
	 m+LrZex+WOvZ01SNoz32OqReHzftHbGFSLAZHCl/cZ2q01ldRWZlf2NnCAtZ4lRzx8DvD
	 U9+bv7JhJpYb68+Nmh85QbAjRDaYqUz5RmVQe7SYJfNoEdAM7PqCTi4TQL3fi3wRHaQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792446044;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qmF0C7xRAK3ZpSq3uSOFx/vq9csLsn2rRQh0+bevgPU=;
	b=AiyGkuesdOJesJq8E3KljWJygk08f7JncpN0bRO3wR5TXikuw+u7LRedskfBTcU0gSvn
	 RIxntKgNW45r7dk+scImq0/4W2IUveyxrcn1yv7fUNXT+b9gRkRrxWuwWKU/grzGqIEON
	 59KpOu/9k/VyMpcVfFCnJb/8ZMXBEOu85WlP6CVMHyrjInEGE1qYBeBGRHhRADBRKxKea
	 S+y31K0V/4TGG+9H8LWLKN2npa02pZbPSNMnysUMizX4RGScYr+dowMC/siYYJJnu+U2b
	 wJymP97vr8s5kAVK0xzzD47s6/ekMjRJRgLzeQkf45a+pGb48lzblYh4H4xVbNq/7ZA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B1BBC1F000C4;
	Mon, 19 Oct 2026 21:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792446044;
	bh=qmF0C7xRAK3ZpSq3uSOFx/vq9csLsn2rRQh0+bevgPU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=j6W9MbtBHx659jYDHencTM5xb1jIn32ra1WfbTZ94965dUhXysF8LjVjsk2rxe7db
	 lBWheL8wPWXvpiaO5mS+eSF8O2DX9+3TRNDFwPS3T7iOmAewQbby5ys/nglyRa+0fN
	 X5e3A47i2/1HDvNkxIJnVRsS91sMF2IbqTPTdIl2l+NDeT0EDKSU6yy/TVSkgBi5T6
	 XBbqthw/UhCUmtkhycIu2DCxLxWj91v8/PD1yml8qFeoTqkCtbrCt1G/TseDRCv7Q1
	 atirVk62iJzc1WRBDIcBCHwmxCCFHWZez/UPB8Odt5bIyP4oVxgeqkzYSmG/d+N5OZ
	 a6y5x4RBnU9dw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0EE5B40638;
	Mon, 19 Oct 2026 21:40:43 +0000 (UTC)
From: Manuel Huber via B4 Relay <devnull+manuelh.nvidia.com@kernel.org>
Date: Mon, 19 Oct 2026 21:40:26 +0000
Subject: [PATCH RFC 2/4] keys: add KEY_SPEC_IPE_KEYRING
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
Message-Id: <20261019-b4-ipe-keyring-rfc-v1-2-156f0b93e843@nvidia.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792446042; l=4139;
 i=manuelh@nvidia.com; s=20261019; h=from:subject:message-id;
 bh=qU5seb89kAZTaYK+uzyIJT50NtrM62WKZmZ+vUqdSqw=;
 b=NJd1deluGBJGvxMmMXOfHxq9TE+XBK4A2IXsdH4GeJcSmNg3QJBNkqq9r9ZbUVHoSowaLXGxB
 SSNA6aw5bVjDNkrjofshdkxNM6TGTie/nOlYBdg1/XzigYGkhIM1/TI
X-Developer-Key: i=manuelh@nvidia.com; a=ed25519;
 pk=uKggxpZ/mM0qtFnudxvh5Dfz8I6VoehwoM3eYCe3tyU=
X-Endpoint-Received: by B4 Relay for manuelh@nvidia.com/20261019 with
 auth_id=1244
X-Original-From: Manuel Huber <manuelh@nvidia.com>
Reply-To: manuelh@nvidia.com
Content-Transfer-Encoding: 7bit

From: Manuel Huber <manuelh@nvidia.com>

The IPE policy keyring is allocated unlinked, so userspace would
otherwise have to scrape /proc/keys to name it.

Signed-off-by: Manuel Huber <manuelh@nvidia.com>
---
 Documentation/security/keys/core.rst |  9 +++++++++
 include/linux/key.h                  |  2 ++
 include/uapi/linux/keyctl.h          |  1 +
 security/ipe/keyring.c               |  1 +
 security/keys/process_keys.c         | 23 +++++++++++++++++++++++
 5 files changed, 36 insertions(+)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 326b8a973828..e4ecda5c2525 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -373,6 +373,15 @@ process making the call::
 	KEY_SPEC_REQKEY_AUTH_KEY	-7	assumed request_key()
 						  authorisation key
 
+There are also values that refer to a specific kernel keyring rather than to
+anything belonging to the caller.  These keyrings are not linked into any
+keyring, so a search cannot reach them and the ID is the only way to name
+one::
+
+	CONSTANT			VALUE	KEY REFERENCED
+	==============================	======	===========================
+	KEY_SPEC_IPE_KEYRING		-12	the ".ipe" keyring
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
index ea8d164b62a6..5158dc7310a7 100644
--- a/security/ipe/keyring.c
+++ b/security/ipe/keyring.c
@@ -74,6 +74,7 @@ int __init ipe_keyring_init(void)
 	}
 
 	ipe_keyring = keyring;
+	key_register_ipe_keyring(ipe_keyring);
 
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


