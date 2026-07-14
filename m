Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DDF381EA8
	for <keyrings@vger.kernel.org>; Tue, 14 Jul 2026 11:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030099; cv=none; b=VLLzobQsHK9drtdfD4xPtn8IjLQAcIYx+Bzgl4pgGccWDlFoOW56nB090DtmC+kBiQau2RO0jPTj/QvsU8qr3zqDOE/VScyoFU8qK9MAEyTbufo73NOaKeX2z8O9tD9tK888OsUBKiHd5fTwW4r76Nx/A+VzsTjER4ecmM4MsVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030099; c=relaxed/simple;
	bh=8zs0bohkqz5AHgWLOAdTFJ4eY64BQy7weh3GYB3lFvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcoyiZw0LJoUiuPhLyb17BVEADM5SsoOGDNso4yW4nkDO9Tzp1Y0oNYHJY9A/TnWsJUl7FudFEM/9UtHmCW1YZHs0Ez1XIkv97wzKMrA5CEjzumRMB64OpB1xVF+aJX8Nx4R2kXRFuwLHUCjWv4kvvzvK1TBR4fEIqT0ltDYiQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rAXfcIR2; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rAXfcIR2"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-902f92b8504so34099976d6.2
        for <keyrings@vger.kernel.org>; Tue, 14 Jul 2026 04:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030096; x=1784634896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=suF5ptZtpi7RCzW0/i+xzlbJ6znA4LVm3BIxn07HFo4=;
        b=rAXfcIR2zHh3aG5qw7wuYEVjK+UcuYnVTWmpBsZyQWU8+yhhkrSrXIJbpnTdJt2SXd
         44kvuSitJ3hFdCyqc2eGnh40hdYIXQ5k2nFpTZQPQxnfiPGw0QlfLSfHZ3WTf8WpgU+m
         cv2aHpMRg0/1ql96evQPZYPntLmQ8YQuvNWSyWPunGX5Fu5nUdPfxzT/Hv5WJon73QpI
         qoXuyHdoXmn7AxYaz6buXJC61lBdMn0qD+da4sPgQQo+J/xMQB/308BFNo5H0FJoR9NZ
         8zjnMwLCK0znYJzrUI7Dr4rnr8lti463QPtH6ERAi+rPc0jvCFUv3F6o+NKpd5mgNJar
         gkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030096; x=1784634896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=suF5ptZtpi7RCzW0/i+xzlbJ6znA4LVm3BIxn07HFo4=;
        b=eog97KTBHOAldqlkO7L5SNqMq04Lu5hMoHo6b1waJx7MSv2RflujUnfzpFH4yX5y2Y
         ciazbiw1kc9L2hNADRVQ1QNI2qHlffvBIbmyDrru3GEOyi9dDIeyg/tDvRusU7bsfF6R
         KlVVMPOIbUkMgbyMEKUDRRINrGnnX/US68mWC/Vg9hiwGETkNVBCANn0txb1dGOmVtp4
         PDbob2VZPDVcrP/rpQ/sb/bfx3IMeXd7rm36i8eTjXw0AtAWTZJ4zPLCZlVdFzqMWGC2
         tSmUP9xbIVsjCNenh1jvDrFK/+eC0exOD8fFuMTHhpFD1K+JllNTPhKQYZQMuRwQy/H2
         oVRg==
X-Forwarded-Encrypted: i=1; AHgh+RrEQmu9TQvHTYBlr+4shidN6R5bN/ZRH6Cd9L315bCnmizNZQLbteG3TnJD8VQKW1tUKft2W9JbEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEZFpnx5+27pwDm3Drh6tq2l4Nn9SHMxC99l/oLBWNfcOGiqek
	AhslHTAEUhA+IRZkBJGGDyAP2RjojLfUUKRAdqnYz6LCmTTCm0s9tAR6
X-Gm-Gg: AfdE7cl07JrZ0YQJFKIwSYrKaeDelNRJUKMDgwoI8mwogK9NNjUSpcKE49sEv8VN3va
	2pReh2b8e2RAEsonu6HVij2c3k+TDi4zZnUdKlAsBxR/kYFekTjBma3oBGyAtBKhsx+9nU/zCBA
	OO+qA2VFFrT6WxhUQLKRCwx5SoaWj68DMmQeVqznJOBsixrHeQKXSUBbrvNQEhVRCWYk9uEDIcr
	ltE2ssz2bilI+6sQcNX6+iMCzY9GF7jhySSXHDVRJQq5LPzuYGLsH267s9rQJAieEbci7t+ktLk
	QH8iSPUiBm8onC5M8C8B0qBxGmc0LXRTGvE05hDyp5qVRQi2CCWMCHFvsCZxncOLx48SdCKd9Oe
	SLH3kUgzRBDA4nJRr13ilh1aqPJLl/uM/6QoRLPEy68H+D5oAUis4UgfAz+/6Had5T9DhxLnIUy
	rADTUvGDj+/WAddtl7IZbNaU3NTi6CaA1bgrAsX6bPaPhap5/kVALRVcQeD0bAPzILND7nEJgOg
	09SQQrRFw==
X-Received: by 2002:a05:6214:2b8c:b0:8ed:a980:6b29 with SMTP id 6a1803df08f44-90403a6103amr144551036d6.32.1784030096456;
        Tue, 14 Jul 2026 04:54:56 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fd492sm185100576d6.34.2026.07.14.04.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:54:56 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] keys: fix out-of-bounds read in keyring_get_key_chunk()
Date: Tue, 14 Jul 2026 07:54:49 -0400
Message-ID: <20260714115451.3773164-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714115451.3773164-1-michael.bommarito@gmail.com>
References: <20260714115451.3773164-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

For description-level chunks keyring_get_key_chunk() advances the read
pointer by level * sizeof(long) past the inline prefix but only
bounds-checks the prefix, so a long enough key description is read past
its kmemdup(desc, desc_len + 1) allocation.  Compute the full byte
offset and bounds-check the description against it before reading.

The walk only reaches a description-level chunk when two keys collide
through the hash, x, type and domain_tag chunks, so this is reached from
an unprivileged add_key(2) with a crafted pair of same-type keys whose
index hashes collide; KASAN reports a slab-out-of-bounds read.

Fixes: f771fde82051 ("keys: Simplify key description management")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 security/keys/keyring.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

KASAN, x86_64: add_key(2) of a crafted hash-colliding "user"-key pair
(~63-byte descriptions) reports

  BUG: KASAN: slab-out-of-bounds in keyring_get_key_chunk
  keyring_get_key_chunk <- assoc_array_insert <- __key_link_begin
    <- __do_sys_add_key

reading one byte past the description allocation; the same trigger is
KASAN-clean with this patch.  On a kernel built without init-on-alloc,
reading the colliding keyring back with KEYCTL_READ returns
uninitialized slab until patches 2 and 3 are applied too.  Trigger
available off-list.

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 7a2ee0ded7c93..1739373172ad5 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -270,7 +270,7 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 	const struct keyring_index_key *index_key = data;
 	unsigned long chunk = 0;
 	const u8 *d;
-	int desc_len = index_key->desc_len, n = sizeof(chunk);
+	int desc_len = index_key->desc_len, n = sizeof(chunk), offset;
 
 	level /= ASSOC_ARRAY_KEY_CHUNK_SIZE;
 	switch (level) {
@@ -284,12 +284,12 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 		return (unsigned long)index_key->domain_tag;
 	default:
 		level -= 4;
-		if (desc_len <= sizeof(index_key->desc))
+		offset = sizeof(index_key->desc) + level * sizeof(long);
+		if (desc_len <= offset)
 			return 0;
 
-		d = index_key->description + sizeof(index_key->desc);
-		d += level * sizeof(long);
-		desc_len -= sizeof(index_key->desc);
+		d = index_key->description + offset;
+		desc_len -= offset;
 		if (desc_len > n)
 			desc_len = n;
 		do {
-- 
2.53.0

