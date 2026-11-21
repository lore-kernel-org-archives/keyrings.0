Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795265451;
	b=C1jtvQ0fV7M1ojlRf/uoOUPp05ivtZ4MADRs4ydzc3Tz3XgkzsP3WTrbmvn+jl0juiLt
	 /TGUF1pAjy8MFh+CJyJN4Q9QU2Z/wWBB7l8FtggnLZiqcgQj6xKg9KlQtmI9j+VsQh/J1
	 JT76qGlJy0IXItG7zUyDBWsZYlcA4I9JdG5G80dxKofm0d46ud0WPiR8o7NKRsy1SMvJW
	 xxpOL3TjnSma0nYZE+VJFYBFZaE1QFjOJh+tcZ9AKPZNnhXBlwkY07ww/wzih+/JVwZ7v
	 iIG5a3gOlsrWn74RBLXpvRikj3vWLVwkRSmvxgZlpPfrodgKYv0xAVHjUmRxE3i/aDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795265451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=a+JvEByhjl3Q0eRtUPeklA/fZjCl5bKRc9fdhPzK8Ac=;
	b=h0AndXqfRiwyOMw7EhJmvTHYTFeRGpFigZ/DDGoaRa5nq8JRBlautys8E9bMmP4eUk/q
	 SJ7F2/l5Jb+YSQjAOhez117iwoT33v8EqIZ6RJ2gb7l8Gty6ZQsQgprxDuT8NwTce8ZiE
	 UI9C3mHZfbGUIMQd0pHEA1cjkg4dvJkOpET7C07WZFElmwFlRlq7U18KGeED8R2bU+qEQ
	 RWS51PfrXmVMLRd613ZSs3Y8YGE857OPdGZ2D4XSAfgt006zWCfSbrixClsgbE67bO107
	 8vQ6lyvJqh0OzWo18BSC5sOOtJLH4HQvD33VdyP3hta87fq9T5gmAPqmwgFz6txTwjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Imsir6fH;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B97606A32A
	for <keyrings@vger.kernel.org>; Sat, 21 Nov 2026 12:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8B97606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Imsir6fH
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so16288935e9.3
        for <keyrings@vger.kernel.org>; Sat, 21 Nov 2026 04:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795265449; x=1795870249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a+JvEByhjl3Q0eRtUPeklA/fZjCl5bKRc9fdhPzK8Ac=;
        b=Imsir6fH8V7hOExu52NV554HH3pwtbhoLh70BMUw8H1FaFiWt7W9gMtzLxzyAWqEK7
         PDd4FwlbIR16ulmMWV/RrrEnkjme74mNISBwO15zVGJctYBCbuEexnAVhvDw7EChJweE
         CNJLlHu9Ia5dmdb8RBOiBLwhc4OjapiV+Cd5c2mU4ujK3opQq7DLiS0fxDOUOEmQUNcn
         Oc/JxNmuUt/GSKQYXe7LuWKLqWlVmLBpBDpHOHXdMcuoVtBhj0Cs7C48GQHHVRpGJLnx
         57FfYipZk9L0sk23f1CityQxeUziuI/F0K8U0AB14i0DdHS5Ft9RaNWxa8xeiGMaq5aa
         bU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795265449; x=1795870249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a+JvEByhjl3Q0eRtUPeklA/fZjCl5bKRc9fdhPzK8Ac=;
        b=mg00SwIC/2HhTe4gKIONBFJrEEkVUpY453HJjQbqsy8wA8GYFwvNry3lUKXNy0EOgF
         FLady0j3lDp0b6Mg660SPUiwrzu3R3nifBoIvnxE9wwDCuFq1iCyYAgy9aQ1Y/jOSnbX
         xoyGVwXEkKQIo5DmmWjjt1OLAZTX4f/ss1xSyWIo2o4CYkwMrIPQ9dcFtAWjSlD/TETq
         a+4A8sAU79MzxVW5/eE+FNQCm/BvfW7ux5yk4epgrw9mEZAoNdv0R+XsLPqZrwd9fxYh
         MZ1OjGSKn4UeAn+KhWslgTGBflXeSrVSP5Bi/5Dkc7CEWWaQEi0jZznuVdoqW+VgzUTM
         QzFA==
X-Forwarded-Encrypted: i=1; AL+hErHVbwdD0iV+vfjguKrYvcUoV+ah3TiTNGvpLjQaCDox/Xp9jibG+hxnzeuDJLzTNCHfIV8DwtuRaw==@vger.kernel.org
X-Gm-Message-State: APuU4Z9kWPjl/YX5GWo3aJcDwXitjxBh6iZxHYLO6nk8ST1ZAhkk9zak
	9bh35oSEpisSk8aU6wKf/P095005sEebDK+cURpHj+m2dQSgihnJxrY=
X-Gm-Gg: AZFdTZclDxDIsXOxKVtBEGkvCIYb1P5qgahPK3VQmIhq+mG5wpz1zBIE9ql4Yt7ufOu
	GYDQmxrDe65mIcWsfN5CoNe/MGMGKefgDm6LGx1cMC7ILuqpzkkkvOK/luk3ceRXKKxgh/IpmK5
	yCyOxzkA2Atd1lV3nFbaHWEQf+rhRKR+kfll4igEKG25FsI+kL+p0BeLIkIWN2k0VUcRXoV2uMZ
	pJINU4aWfzbTywYUp29lLIsoPLmJGd0671B1H4CyChQArn5WJ/SSx0l4VX+7FwP2e2YogJGsGaP
	Pw9mjr5clePAgu3TUBn1bH3FiEeX4LsXV8InJqWkMQFb/4h1w3HikZAnqziPH0JTMrFQYxNlz1I
	uHXtA/94z9A64Ojm44NUKuZAgTriqP51G/ZCS5ZS2eOoMWQsyBCtAzaa6rAD9i20kGwpNrVMdj8
	hdGUpIpuHXigdfxCX+6t1S1uoNAqgxrq4UZLTWS3UPl23ZYNoyd7+RD60gZOZLIeAf0khh+RQHC
	1u8aR14NTUE5jQ9hCyD9v+qEFzgIW4y25OEUfJ4/hg3peX/JQOms3W+XvMl9RrWsRAKXNXq16FT
	wyFhL/zrwfj7HIsHlvUyfpMkoWf75JmjANpR
X-Received: by 2002:a05:600c:820d:b0:4bb:6cef:d14b with SMTP id 5b1f17b1804b1-4bb887c34f1mr145440935e9.2.1795265448967;
        Sat, 21 Nov 2026 04:50:48 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf685asm10803003f8f.20.2026.11.21.04.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:50:48 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] KEYS: protect construct_key type dereference with key semaphore
Date: Sat, 21 Nov 2026 12:50:39 +0000
Message-ID: <20261121125039.2532663-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

construct_key() reads key->type->request_key without holding key->sem,
then calls the resulting actor function pointer.  While the
sys_request_key() syscall path holds key_types_sem for reading (via
key_type_lookup()), which prevents concurrent type removal, in-kernel
request_key() callers pass struct key_type directly without holding
key_types_sem.  If unregister_key_type() races with such a caller,
key_garbage_collector() can retype the key to key_type_dead and the
module text backing the original request_key method can be freed before
the actor call executes.

Take key->sem for reading around both the key->type->request_key lookup
and the actor() call, consistent with the approach used by 925c84e3cc21
("KEYS: Protect the read method check against type removal"),
51bcd09b9ffc ("KEYS: Protect the update method check against type
removal") and bab48a104447 ("KEYS: Protect the pkey method checks
against type removal") which protect analogous method dereferences in
the keyctl paths.

Fixes: b5f545c880a2 ("[PATCH] keys: Permit running process to instantiate keys")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v2:
- Hold key->sem across the actor() call, not just the type pointer read,
  matching the established pattern from the three prior fixes (Sashiko)
- Clarify that in-kernel request_key() callers do not hold key_types_sem
  so the race is reachable outside the syscall path (Sashiko)

 security/keys/request_key.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 22cd66a44da56..60a8cb5924e11 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -241,10 +241,12 @@ static int construct_key(struct key *key, const void *callout_info,
 
 	/* Make the call */
 	actor = call_sbin_request_key;
+	down_read(&key->sem);
 	if (key->type->request_key)
 		actor = key->type->request_key;
 
 	ret = actor(authkey, aux);
+	up_read(&key->sem);
 
 	/* check that the actor called complete_request_key() prior to
 	 * returning an error */
-- 
2.47.3

