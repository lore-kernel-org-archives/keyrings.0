Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793275096;
	b=jIvLWm90047yboZ2CNO6Y1DeeE/c0HNZ7gaVJMDSEBpRfhQCWk3FAnEltpF3qM1RePHS
	 GdX6H6D9eE37Qxi/pJZN+dohEl4b4o4F7H5muLXr+huD2OLsxJV+RG98wPLbaZBDym/4b
	 qB1C4A6lCiB6UQTCp9CBszJH0GBEZnRCG+77oPt05vqJ5VEkspZK4ErNchCJiJS4AT/OL
	 H7dRNvEDn8pmKsgghabdT9Q1/fi4e0s+PFp9DcHqw0fglzUq+4E3TFcZOtmwmVCwckZSP
	 lIMH5D6i6NVeNvcGaUS46T8laEPayh90qv2x4BU2uR6Nybh6hzUl5/g/on9q/ibRwUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VEJxuw7v5WS1JXklJNxWI3IzTNd4l+O1vemEGC9NlII=;
	b=0cglB9ivsAhB5XGtrzkyCT2Fa0fLIWQbgkN0wA3+HnXObJHgwGKfBbX2nMgJJJYFzOiB
	 Rc9AZAs0akDTTbSpP8w/KFuTt+OaAVytGTh3Rtdbthhy1picLpCyNwEn86jJnNGFM9i2b
	 /By5QjJV5tW1dPACeLsraRLHyg5fMgktJM5uKlfJ7toqTNPVKF76WlsHeisi6O+yBKvt4
	 xpajeuQKAa8FCud8/QR6obKSgBnQZW0mE/D3bZRNUQtWhPtjRPdTzRlvkhNyV6Y/TCiOY
	 UffTaMOzeIb6NAiBCyXY95y6X1qnWJO2QNYeoz2hAPlHSMAjvnyex8EKIpf8oSNeMzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZxOySYw6;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B82606A31D
	for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 11:58:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5B82606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZxOySYw6
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e5378b281aso11014015ad.2
        for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 04:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793275095; x=1793879895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VEJxuw7v5WS1JXklJNxWI3IzTNd4l+O1vemEGC9NlII=;
        b=ZxOySYw6NYmINxrUznhCRkoVM326b1kMuU0Pzv421sKfplb9XFqTFdPUjFvnQHH07z
         dU1dUS6CghARvfNo0xujIQxq0UtnRQXho6lVU2aBzH1dV6rzrbMl9qn+62l9uSeWGR/Q
         /n3DmY+eG/tVIP6NWe7zrqjdPr7Pd76YXeNf5eXZbEqjOJ2PUDQfZEl+Ikp76A9KNXfP
         QsrWwasvhfhgUFBKNVv9G9xmiIoEyYpocrWbBPlkb8K//1xwGGxZzz9aLI8m4SKuQcNK
         uF3tVlKFnZbXjuKX6XWmBEdXdDVFdsdYtBZHRWKe4Eb+43avQTJXnvK01TvDRJgQjdgA
         ES/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793275095; x=1793879895;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VEJxuw7v5WS1JXklJNxWI3IzTNd4l+O1vemEGC9NlII=;
        b=wigTIkautEN9oCNu5E6VO2cOdnARyaOUoNi5IVsLwdEi9SA2X74l5lApERguylmnlG
         kdtMigayw1ICs2TAnEC/NUxFHisooBtyLEhbqfKL8FcOJRV1I8yAaImUccQMXHXDqZq2
         WGZiriZ7YBqZtub74Ejp0/P8sq0pPMqcCdZry4uA9ON8QkaGM3PT10YKUaDzfUagJGLb
         e8htdijuShHtb9VZlyiGqCxIOXyKoz6YcGHHXqTzIBLtacCJgwnTXOG+lGayE1oC7Rlx
         sB+4rZFWC6+up+N0zQgCe63063xh5SBqYIQg2Kh182gCSy53iPQ6DvTFmooyc1XzM6hf
         cL+A==
X-Gm-Message-State: AFq9FYJDITxSPR+Rf88y/5ibWpTG+E5r71ge1QCiQ0UwMndxg0Tl441y
	M4o7+BrVaIgv8Kh+NFy3p8saSCHqqE4+c/w136yZ+WF7hdyKQAH1PJbB
X-Gm-Gg: AYBFou3urELPy3TU/hFflrtvFU9UAy7oOjB4xpTSyxBRWCa3QlPUsgpmAovYQnpidHd
	2X+QgBAj6eSdgnPoTnmQBYC3E7zhtAnE7x3eQPKdy40z3wtD/JtOo+mA4mB+oRe/k/LHA9XasH0
	nfGfuFHL2WFFTo22hKnmEejMx89BSJAF/VnRPKySzZehC5oOkY5aZQN0RXS0SU3cdmpctuOkKhA
	cLaPoTa/5xeL7sqIa7VThBySoDRQ9898kG5pMyb5STtpU9pvvoo/d099S21hNNMdNQ/Z/YI6KVd
	DlqqQVWz2xSnodIg6W49tyD9jQ+u1JqhtM4Noj26kdE1+WYL8s0npLlBp79Z/ANRV1GHZHaa2gY
	d6EHHyCU6iX2IJz1ZW3IE/czrzP8Jm2Y0ndH7GZUmVrvEZJFfmvStEw7q25T90drnblFHwe0bTQ
	81VWftvsRqgFCQbv+ZrpKSSU/UrAyBmGGTxbgIUhNnKF1eVCa7MP8jttP1w7awUU53QJ1sym4sC
	QuieF/65aVvrXlVeLnlPcRl6+eHIrkvoYZ+DYSVYgFTZePjLuvs74UpkxGblzn1iVztU0mjXwIq
	955Pf/B4Fe2BNCSMwBp5LkR+
X-Received: by 2002:a17:90b:2710:b0:3ab:ab5a:ef06 with SMTP id 98e67ed59e1d1-3ae57f637cemr3901099a91.12.1793275094915;
        Thu, 29 Oct 2026 04:58:14 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e8401casm4137834a91.11.2026.10.29.04.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 04:58:14 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] keys: Protect the update method check against type removal
Date: Thu, 29 Oct 2026 19:58:06 +0800
Message-Id: <pm-keys-update-type-removal-20261029-v6-3d92b2f9693854230a02@gmail.com>
X-Mailer: git-send-email 2.34.1
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

key_update() reads key->type->update, ->def_datalen and ->preparse
before it takes key->sem. A reference on the key does not pin the
module that provides its type, so KEYCTL_UPDATE can race with the
unloading of that module, for example dns_resolver:

  KEYCTL_UPDATE task                  Module unload and key GC
  ------------------                  ------------------------
  keyctl_update_key()
    key_update()
      key_permission()
      load key->type
                                      exit_dns_resolver()
                                        unregister_key_type()
                                          GC: down_write(&key->sem)
                                          GC: retype to key_type_dead
                                          GC: up_write(&key->sem)
                                        unregister_key_type() returns
                                      free_module()
      read saved type's update member

The final access reads freed module memory. With the updating task
held after the key->type load, it faults:

  BUG: unable to handle page fault for address: fffffbfff804107f
  #PF: supervisor read access in kernel mode
  RIP: 0010:key_update+0x12d/0x550
  Call Trace:
   keyctl_update_key+0x6b/0x110
   __do_sys_keyctl+0x21d/0x4f0

This is the same problem that commit 925c84e3cc21 ("keys: Protect the
read method check against type removal") fixed for KEYCTL_READ.

The encrypted and trusted types can be built as modules and have an
update method. For them there is a second window: the GC can move the
key to key_type_dead after the method check and before key_update()
takes key->sem. key_update() then calls the NULL update method of
key_type_dead.

Take key->sem before the first access to key->type and hold it until
the preparsed payload has been freed. Once a key exists, only the GC
changes key->type, and it does so with key->sem held for writing.
unregister_key_type() does not return before the GC has done that for
every key of the type that is still in use, so the type stays valid
for the whole update. If the GC has already moved the key to
key_type_dead when key_update() gets key->sem, there is no update
method and key_update() returns -EOPNOTSUPP.

Assisted-by: LLM
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
 security/keys/key.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index e88548f1a704..bac2333089fc 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -1101,9 +1101,13 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
 	if (ret < 0)
 		return ret;
 
+	/* the GC cannot change the key's type while we hold the semaphore */
+	down_write(&key->sem);
+
 	/* attempt to update it if supported */
+	ret = -EOPNOTSUPP;
 	if (!key->type->update)
-		return -EOPNOTSUPP;
+		goto out;
 
 	memset(&prep, 0, sizeof(prep));
 	prep.data = payload;
@@ -1116,8 +1120,6 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
 			goto error;
 	}
 
-	down_write(&key->sem);
-
 	ret = key->type->update(key, &prep);
 	if (ret == 0) {
 		/* Updating a negative key positively instantiates it */
@@ -1125,11 +1127,11 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
 		notify_key(key, NOTIFY_KEY_UPDATED, 0);
 	}
 
-	up_write(&key->sem);
-
 error:
 	if (key->type->preparse)
 		key->type->free_preparse(&prep);
+out:
+	up_write(&key->sem);
 	return ret;
 }
 EXPORT_SYMBOL(key_update);

base-commit: 9a2a4c51dccc3168c3dc949fcbaa360a478fa228
-- 
2.43.0

