Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDFA3914FD;
	Fri, 28 Aug 2026 17:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939558; cv=none; b=odB5eXCp5fC+Z15nARvLRGnZ+VuZyjEeF5qAuaUnzsfmvOAYSGQqxuz7XzoJk8C6S0VJoKfGD4vARxgPciMdLaM/R+DoyE3MWVN/IxyZY+igEgihJwUYT19/ngbw3JI/0o+peppSeu23XiLrOHbAbpFli1Ltc3A6yLWVcNA3GIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939558; c=relaxed/simple;
	bh=K4e3Bgnmza+1tOT3q4RCvmyMW7VH5CglEPFBipnHPLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EY8DkVehtB1bPZavZY4k6qxG743tPBxvgTLrNS0kCDJAUJ2V0XXw3J7g1mrUrXIFF3vN3uVKRj8+FC76RmqHGqoJl5Mwh6nVPsWkrG1U0U9HTalAhFB8XiV9kdKGSHExhzZk2X68sUWrL9PzLOAWUIr9y0qLaXL7G7EViV++EAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=K50b+L/S; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="K50b+L/S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=HEm/EIc6Tx0BbH6j8VluF5TRjnLRV/IY+TjGi9Bzblo=; b=K50b+L/S3KaLfb0AnbyVISxhOn
	d0fG4a96001if3+Ix8Ykl8WqhUwIQwvbcgjCHs9kVFezqhn1wUy3SQa1eGvM7aq5RpjoFkuzyHFSn
	laG8s+H7H0xVOHi2HCiGc4KPB7zNXE9uVbhU6+4iQS0x9r6PukNPGoQ81DY6lIp9LlLRIrE6abIbu
	l6AQlnfKwcMTolO6efWS/upiZht5EatuL4MwtvOCpiRzs4xSdXc8xg7koZQkMUhwwT8YuosrbXwBr
	br6lFVXYxAqiK0prumt/tW6c09Dz3jQQq8M1VobjFilM1LszVt6zKnDFYMWMqdD/ShaVMR6Zn88W4
	Peb4SsSA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1x00kg-0000aE-0k;
	Fri, 28 Aug 2026 19:52:30 +0200
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
Subject: [PATCH bpf-next v4 02/11] bpf: Refuse caller-supplied keyrings when the bpf one is active
Date: Fri, 28 Aug 2026 19:52:18 +0200
Message-ID: <20260828175227.1537793-3-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828175227.1537793-1-daniel@iogearbox.net>
References: <20260828175227.1537793-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28106/Fri Aug 28 08:27:08 2026)

Nothing changes for systems that do not use the bpf keyring. Without
bpf.keyring_unsealed=1 a caller-supplied keyring behaves exactly as
before, which also lets it serve as the staging step for software
installed onto a running system whose signing key is not enrolled
anywhere yet.

Passing bpf.keyring_unsealed=1 states that the bpf keyring is the trust
anchor for this boot, so from the first program load onwards a caller-
supplied keyring is refused with -EPERM. Deriving this from the boot
flag rather than from the keyring's runtime state keeps the decision
immutable from userspace.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 ++++++++
 include/linux/bpf.h                             |  6 ++++++
 kernel/bpf/keys.c                               |  5 +++++
 kernel/bpf/verifier.c                           | 10 +++++++---
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2beb61092bb3..e70fb15757d4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -673,6 +673,14 @@ Kernel parameters
 			keys. Once the keyring is restricted it becomes active
 			and can be used for BPF program signature verification.
 
+			Setting this also means that the bpf keyring is the
+			only non-system keyring a loader may select for the
+			rest of the boot: caller-supplied user/session
+			keyrings are refused with -EPERM, whether or not
+			provisioning actually completed. The system keyrings
+			stay selectable. Leaving it unset keeps the prior
+			behaviour, where a caller-supplied keyring is allowed.
+
 			See Documentation/bpf/signing.rst
 
 	bttv.card=	[HW,V4L] bttv (bt848 + bt878 based grabber cards)
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 039674b2f875..3a7eb2185c35 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3821,6 +3821,7 @@ struct bpf_key {
 struct bpf_key *bpf_lookup_user_key(s32 serial, u64 flags);
 struct bpf_key *bpf_lookup_system_key(u64 id);
 struct bpf_key *bpf_lookup_keyring(void);
+bool bpf_keyring_enforced(void);
 void bpf_key_put(struct bpf_key *bkey);
 int bpf_verify_pkcs7_signature(const struct bpf_dynptr *data_p,
 			       const struct bpf_dynptr *sig_p,
@@ -3846,6 +3847,11 @@ static inline struct bpf_key *bpf_lookup_keyring(void)
 	return NULL;
 }
 
+static inline bool bpf_keyring_enforced(void)
+{
+	return false;
+}
+
 static inline void bpf_key_put(struct bpf_key *bkey)
 {
 }
diff --git a/kernel/bpf/keys.c b/kernel/bpf/keys.c
index 08549b3220c1..bffc356839ac 100644
--- a/kernel/bpf/keys.c
+++ b/kernel/bpf/keys.c
@@ -18,6 +18,11 @@ static bool bpf_keyring_unsealed __ro_after_init;
 module_param_named(keyring_unsealed, bpf_keyring_unsealed, bool, 0444);
 MODULE_PARM_DESC(keyring_unsealed, "Leave the bpf keyring unsealed");
 
+bool bpf_keyring_enforced(void)
+{
+	return bpf_keyring_unsealed;
+}
+
 struct bpf_key *bpf_lookup_keyring(void)
 {
 	struct bpf_key *bkey;
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9c6624d2f5fb..2d50adf3800d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21019,12 +21019,16 @@ static int bpf_prog_verify_signature(struct bpf_verifier_env *env,
 	if (!attr->signature_size ||
 	    attr->signature_size > KMALLOC_MAX_CACHE_SIZE)
 		return -EINVAL;
-	if (system_keyring_id_check(attr->keyring_id) == 0)
+	if (system_keyring_id_check(attr->keyring_id) == 0) {
 		key = bpf_lookup_system_key(attr->keyring_id);
-	else if (attr->keyring_id == KEY_SPEC_BPF_KEYRING)
+	} else if (attr->keyring_id == KEY_SPEC_BPF_KEYRING) {
 		key = bpf_lookup_keyring();
-	else
+	} else if (bpf_keyring_enforced()) {
+		verbose(env, "caller-supplied keyring refused, use bpf keyring\n");
+		return -EPERM;
+	} else {
 		key = bpf_lookup_user_key(attr->keyring_id, 0);
+	}
 	if (!key) {
 		if (attr->keyring_id == KEY_SPEC_BPF_KEYRING) {
 			verbose(env, "the bpf keyring is empty or has not been restricted\n");
-- 
2.43.0

