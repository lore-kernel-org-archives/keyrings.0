Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41B63BD64B
	for <keyrings@vger.kernel.org>; Sun, 30 Aug 2026 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788114033; cv=none; b=m6miSisB3xL1/NCp1d1d43U9i48G2TZ4fEGTPGvpNa8bbW1EpeHtVvTHVqpykJMwAS/JsXEsbpIYPbGoX9mHawlLL7w1Mn3fFZRYE51uuwejpuNdwqoWqbi6SfatjHQz59H/FVn+8VmG9PKGn0Zue41ASPiy5pGiljTOTJP7rzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788114033; c=relaxed/simple;
	bh=TVCyLwZDMmVp0hAurQYMH3T2j5DMGrsKI0ZW+vcU8T4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XCIObvKVCw+Yh76IDi1hYRwQs7PLUS2lsJAa8GVhMb1BlsaQDkHHvl+KC1/P1u/d0dUKypU0DL9dge1MlGmnS+uhOCixEF/Kmau/HkVZPyAPsJfNlJgd3ft9btWakVNoFmKI9rFD7WQvlBynQ4+Ogxu0WxdFsqlxbDgbdDqIfnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKmLibdZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKmLibdZ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-482e257a23aso1454414f8f.0
        for <keyrings@vger.kernel.org>; Sun, 30 Aug 2026 11:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788114030; x=1788718830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Rco2GCRhLFay115dRTUgmepuW15efqnKFUOomZek2ow=;
        b=VKmLibdZ2hzJjmcmtqZhbmpzR2rX3cJB7sKEUjaMQ4PflODCN0/VedqcwTI6bYGBji
         SyFEdoRBlylb0MbOZs/84j629JUiWxLkvdkC8LvueJXfPQQhDkEY80rt8oO/fOCsHcWo
         MLehDz7MTz2ijFlekXeRDAJ3coNK0gTw5o+NGC5OXFFn95QFfsyJvCHxEbsX10yWd3Gw
         I5Ebf8ZmhZUf/6nskQNviZS9ds+TVmY8eBwtdOJFNhdPRdl7UH0JC7I/5/HhWTStyfbD
         RzZQYNVdR5D2yqUo7IcVTYdF6YSja4tCCI1s16MlCJvm+VPWnPKqOk54+YZeTf+8CZoV
         Mxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788114030; x=1788718830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Rco2GCRhLFay115dRTUgmepuW15efqnKFUOomZek2ow=;
        b=KBchJVwC6zaOdmaSh2NQj4lcwg5oJEY2n6HtPC34NOm4xO4q9H7NoiFWBhA6cJalC+
         xHzViKZZ3ytBzlP2ztOxeMmwY0RKGtuRqQ/c0qP3i8WRs3q24BtkbOBA1q4M7U2oE/Fx
         CUf5Qy/pD/9Cf84zoONafqxcKGb5tMMJpYouK5Tepk3JH3fbtvfnB5peEqmIgUu3VLtT
         VgpCjRV6pDSd5QLHrFuWkUTc/QGYrXVtW1b3oJq1eGGWlDPUkqAY/GMUQ+61+AjZf5XF
         1k75BoktyGz9ahs6vbI9CVSp6Nb+POIYog1uwi7Zz4lnQnK60eR3nvaHEyIS5Wyx6Rxb
         yU7Q==
X-Forwarded-Encrypted: i=1; AHgh+RqxsUwr1SkTNnfipoI5JKCxGki5r46mtsn1s+EzTvmkceXm6aapgHebavNvv2/JrOFxCDWp0hPtRA==@vger.kernel.org
X-Gm-Message-State: AFuF++kVYARPqgAwpfwxEDsy6CY+vMQ7SraVjDh8oZxRYQz5tfWeoLF5
	cPGkhBu7Gjlgioyl8isoPg/dRyaOamOB1tVSwlZkMOWlOThdvVI7UuwCCHeBjyBn
X-Gm-Gg: AR+sD13FL0vby9MY1kjs45aSC0IXOoqBrvv9X+5Eb1oJNptWDR5eqI2jPclcVyo/HUm
	ylhIspG+XLzfk/jD7lBU9/4kmC8lOYjWef1jUJviyMvc3mKXLMhz+gI3HIY9BX5KGALCd1Qx5WK
	EuBJxHTdtZa/k/5wYjmn7GTRvv6i8StmNToZL+CcYd5YqLVF5g3pPETNH59HqFTjDEgeTBLZz2o
	FmIbcxcGFJPVl9W82tumv/w++6XuiiPdFnL8fC4tR7Gy2M/cTmGOBQfmVOVfwsHk3c4OsF9dBYc
	7sj1BmjBYjhmt4gnrYBJGm6mWyPZZ7bZ5RUPuAXbiXkUFe7sxPER4qPptMYqxQGwYWkqSXt8Wl8
	kiOsWDV2oJT6IZjLsu2czgEbuSPYGki+OnJwlydzoCcGa+mWgl8bCjdL4Okx0BFWxQSVZmb0/1g
	QO6AhoYjeNl28qNFEKb4557P+u4FDVo1N4ZVEsKKOzD6RRqdiS9rWQs1kVLl4Zrmj7dgpNVI+fL
	cseaHqn74XfBe1JekIoubw5NMLBltLVXb70dzFmkRsPB/wayagIMbpLV6bZa/cVADDQxAedukm4
	d/Hxe9QyskbGmSlQakloskeXzqLCJABK0dohxNINM/M4MtYOND89fkYa4KvAcx+1xyzyebLG6l0
	sMjrqjvet2sqbTvIfJomrdw==
X-Received: by 2002:a05:600c:8b86:b0:493:f5bf:4dc6 with SMTP id 5b1f17b1804b1-49b91c2777emr366315815e9.7.1788114029578;
        Sun, 30 Aug 2026 11:20:29 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-adda-dc01-edc7-8a6f-c6f3-73e0.310.pool.telefonica.de. [2a02:3100:adda:dc01:edc7:8a6f:c6f3:73e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b94dc0f57sm252584505e9.2.2026.08.30.11.20.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 30 Aug 2026 11:20:29 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] keys: set persistent keyring timeout before destination linking
Date: Sun, 30 Aug 2026 20:20:26 +0200
Message-Id: <bb0370340c671.1788111790.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

keyring_alloc() links a newly created persistent keyring into the
namespace's hidden register with TIME64_MAX expiry.
key_get_persistent() sets the configured timeout only after linking the
keyring into the caller's destination.

If the destination rejects the link, the registered keyring retains
infinite expiry. It is exempt from key quota and can remain until namespace
teardown or reboot even though the syscall returned an error. At most one
such keyring exists per UID per namespace. Repeated failures for the same
UID therefore strand only one small allocation.

This is reachable from unprivileged userspace: KEYCTL_RESTRICT_KEYRING on
the destination makes key_link() return -EPERM via restrict_link_reject(),
after key_create_persistent() has already registered the keyring.

Set the timeout immediately after creating and registering the keyring. A
later permission or destination-link failure then leaves a collectible
persistent keyring. The successful path may refresh the same timeout again
without changing its semantics.

Fixes: f36f8c75ae2e ("KEYS: Add per-user_namespace registers for persistent per-UID kerberos caches")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Tested with QEMU 10.2.1 TCG. The reproducer set
/proc/sys/kernel/keys/persistent_keyring_expiry to 60 seconds, restricted
the destination with KEYCTL_RESTRICT_KEYRING, and then called
KEYCTL_GET_PERSISTENT. No LSM policy was loaded.

                      syscall result  /proc/keys expiry
  i386 baseline       -EPERM          perm
  i386 patched        -EPERM          1m
  x86_64 patched      -EPERM          1m

Full kernel builds completed for i386 and ARM926, and for x86_64 with
CONFIG_PROVE_LOCKING=y. The x86_64 reproducer completed without lockdep
reports, warnings, or bugs.

 security/keys/persistent.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/keys/persistent.c b/security/keys/persistent.c
index 97af230aa4b22..0eca8c5758434 100644
--- a/security/keys/persistent.c
+++ b/security/keys/persistent.c
@@ -63,6 +63,12 @@ static key_ref_t key_create_persistent(struct user_namespace *ns, kuid_t uid,
 	if (IS_ERR(persistent))
 		return ERR_CAST(persistent);
 
+	/* Set the expiry now: if the caller then fails to link the keyring to
+	 * its destination, the register is left holding a collectible key
+	 * rather than a permanent, quota-exempt one.
+	 */
+	key_set_timeout(persistent, persistent_keyring_expiry);
+
 	return make_key_ref(persistent, true);
 }
 

base-commit: 08dbfad3f5040f5bdb6c529da20d6d4e81fefd72
-- 
2.53.0
