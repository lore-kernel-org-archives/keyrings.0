Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290039;
	b=JQ2+sTWANqeEhkjVFqNJc6/NHoZLp+vT7WX6/fUi7cmN1UODHMSodpfeEvtHg+9I/rig
	 WTUs5U/Nhhb2wwsD/C4EQ5VAsr/00xakPXmO/alhJEXHMexEyqDkRFykVSGFO20QxWrsM
	 pGREB0hVI3mdPRfYU/8TmOEkeHnXf9eKQG/Dx6mNPUzSGjC0YuVXdm3qyplfPi4COCae2
	 0f1stO1GbJaW/HLRBJfJfeSY8g1/NC3FDaNzU+FWPPAObYESY3OxucNJxw4g3/w/a3f66
	 6pCE+kRzGW/NtW9SlqPI7wmujkw3Jzh294UQbTYAel62LPiVUJ1x0XyMTuwubgTPIhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=6phBB/LhTBBlHeyPPTy42KiMPUWx2B/+SfXHzMCVM8g=;
	b=RBLJ9bsmv1JGNRSaf5j0xLSXY6ukxFW0RMx17oPTZ7zYLT/G2L8/SqKUdXbctCe16jTz
	 qx8LCsPyF69kfnhSW/QV+l/Il2ee/7VTIaTfdvEIye4nuDDrD7Kv3o5NaG83TsGHbRg9d
	 5mILOpUVKpv/5NPADBeXN6vx/ktomOaxEl9lNtKwwqi14ibdcRe8z9lbK0D/cYLtvLpOr
	 TrcpXTR+mhbp59zOL6UlQ4RiCrVsMZYv/kvZW76zJE/5/DRD5ib6VUCZj9M3XlbGeiFCf
	 dqYojG98dZn0+QPRkZ3k01PIpJseJAd4df/4MTyiHjeQgOYMYNJT0uEmAy2Bry83v2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qz0J8qL1;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDB6606A31E
	for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 16:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DDB6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Qz0J8qL1
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3adf5f6833cso1459238a91.0
        for <keyrings@vger.kernel.org>; Thu, 29 Oct 2026 09:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793290038; x=1793894838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6phBB/LhTBBlHeyPPTy42KiMPUWx2B/+SfXHzMCVM8g=;
        b=Qz0J8qL1HNBLnCibb7ZytadKUpGO+CWFl2dTuBChRwrAbhnR8/axv/QGQFyFk14YiS
         xq0ed0Ksbn6jt1KiUQQKJyUI3+hx2ukiEwkjFvjifU2d9HITWiBIrHrkG5ATB0Ci8gDJ
         q1MKz/qygmbP34AxWKSyLMngopUWjiJN7aNkWserV+t2XfZaJW1hCJ4GD3OyKJQTEPVG
         fN4LBtAVfmbi18qM4/kE4ODRCZzU86jsu3SFt1wTl9Oe/cpJWGEW7k9ouPxxrNltheJj
         hYzGhiUhPqkS11aM2CLLLUXZg+J7u1kmPYTk7fqnUzTrbmjmWKtGgRfHx7qAbYLwI2Hi
         cPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793290038; x=1793894838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6phBB/LhTBBlHeyPPTy42KiMPUWx2B/+SfXHzMCVM8g=;
        b=Cw13JususlywtjQs1ZJ5cg8SWCtINnkmz/5D4JjnlBziL+J8bAFZNgP3Qpr8w4l/xP
         Ot3AoEaYj/0MZi/cqWEW/E+lgWzXK78qbkh/GABSdQEmRsuUjHUHKpja1hMvj0lMW21q
         qoOea7Kh4o/ZMaBeTMbnGM/U3BXaD1YQ0upUME5zoOr8bIluC7LZBLulWphFCeiL9H0j
         PK4nAN8m0SQIdsMmAJIJOV8VEfWE0oH8ukiZqZmtGn1c97LeS1WsMWEFejXChx2Vy63m
         JSPxrc0SyzK/voLyDSgwyQKFoTSHjKNy3kMwVsrOJJ1IhaPBpCPGgN/WVjN6GlQWuHyS
         slaQ==
X-Gm-Message-State: AFq9FYJ9bYRz5GoCjq5uHZjAn9PhW58XvagEQTv/LsSojFOO9s8oE+cJ
	6RnrDP0uJOhOB6Hkeb6aN14eZkiXVP/Vy1GFi08G3UwQa/Gj7xZ6zE0T
X-Gm-Gg: AYBFou13Sa0H/HJG31L4LuKtzCmXgHG4fxuUBIFzpnzz/DzmD1lkbxoqcEqvc9R03EA
	NyrXPVgDicLzwvfJHvjrAR7kpR8wlBUZABLL2k6iBySRpDgU/ZekH7F+fD7kjj+EDOq+6Vn7IZR
	sI4wOE3sjlfOhLk7nzHfMk7zI+Ymnx+BWntYJm9wlHXrjUOBH375u5AjwB7g1jpOh/kgQjJasKG
	9qGZLI31l32kWHSYg8A0B+jxgOgUucX7s2iiyLdiiIiqgxCYLDDIAie6upFIDekWsM7Ek7TT/Xq
	f1ggxucUBeyuEtgFoOOLF8koVGks2r4ihAWlwTWRSbtMotRNSU1ltJYRzmz9oHOlS+v2wndSkPZ
	Ipj7JWHT3ZNJg/yXvL23EdDoKL+lJmVrrxtf7r+kRauIO2Kt47zJzgWFvovmUHT/QyH9++Oy1/q
	wlc3EAIL/TzdyWBynN0K08TduMtwyYCqiAf4fODjQw6X7xsMIi34gqso0NVbPfejAld5+SJTz+a
	RmXSZBoTR0KqZ9TYj26rm2D+5TbMSdOI8ZcUiU2jg3zWKhFOFz0gKqibP7i+pJVbAFUslKxFm6R
	8yw2AKSFRBNgbjiJGVRb0Kr1
X-Received: by 2002:a17:90b:57e3:b0:3ab:413:49bc with SMTP id 98e67ed59e1d1-3ae58123796mr4489353a91.37.1793290035781;
        Thu, 29 Oct 2026 09:07:15 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845432e4sm279427a91.3.2026.10.29.09.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:07:15 -0700 (PDT)
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
Subject: [PATCH v2] keys: Protect the update method check against type removal
Date: Fri, 30 Oct 2026 00:07:08 +0800
Message-Id: <pm-keys-update-type-removal-20261029-v7-e79d113bcff91e140d04@gmail.com>
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

For dns_resolver, which has no update method, key_update() returns at
the check, so doing the check with key->sem held would be enough. A
key type that is built as a module and has an update method, like
encrypted or trusted, gets past the check. If its module is unloaded
after the check and before key_update() takes key->sem, the GC has
already moved the key to key_type_dead, and key_update() calls the
update method of key_type_dead, which is NULL. So key->sem has to stay
held from the check until the update is done.

Take key->sem before the first access to key->type and hold it until
the preparsed payload has been freed. Once a key exists, only the GC
changes key->type, and it does so with key->sem held for writing.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
Changes in v2:
- Refine the commit message.
- Remove the code comment in key_update().
- Drop the Assisted-by tag.

Link to v1: https://lore.kernel.org/r/pm-keys-update-type-removal-20261029-v6-3d92b2f9693854230a02@gmail.com

 security/keys/key.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index e88548f1a704..994a34a80c29 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -1101,9 +1101,12 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
 	if (ret < 0)
 		return ret;
 
+	down_write(&key->sem);
+
 	/* attempt to update it if supported */
+	ret = -EOPNOTSUPP;
 	if (!key->type->update)
-		return -EOPNOTSUPP;
+		goto out;
 
 	memset(&prep, 0, sizeof(prep));
 	prep.data = payload;
@@ -1116,8 +1119,6 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
 			goto error;
 	}
 
-	down_write(&key->sem);
-
 	ret = key->type->update(key, &prep);
 	if (ret == 0) {
 		/* Updating a negative key positively instantiates it */
@@ -1125,11 +1126,11 @@ int key_update(key_ref_t key_ref, const void *payload, size_t plen)
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

