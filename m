Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40218277C96
	for <keyrings@vger.kernel.org>; Sun, 19 Jul 2026 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784477720; cv=none; b=BOERLFFeUohJFoAO5h03V2bqJ8d63KvAm2t2b4rQmpsCv8gSEwdb8jsbeXWcpF85YeIedcrlmb7687tvDSdHICLee3TCCfQ0eJBbPzcDAkbzp0laPt8Pmo1V3vfYMVnjc5q7oqRIXXqaNyiK29K6+ia/faaKJCSdvaNYQQwMQJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784477720; c=relaxed/simple;
	bh=z7iFnYhuNkpMKfpkGAHIAltacElFBDKQMCZumHmuODE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9TJpxslpWdrWf4EB9/5Sz1IitIpdSllvLPdmXANBqHBVTrgRdBE0C7HXRM4pUfrVQaLF97CTBaLzqxGmrK58e7+5RCsZIv1ZrynQh0yYBkpZJXpfz1uyVmuvCTeCq57o4qNPfqX0oCdyuaYbqCMlpj3v66g4HxuODp0quKpfnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KK10IMqq; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KK10IMqq"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-92ea24a2dbfso791744485a.0
        for <keyrings@vger.kernel.org>; Sun, 19 Jul 2026 09:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784477718; x=1785082518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sv09Y2zV5fntrZQk40NqD/qbsVElT2FYKTtooq7g6h8=;
        b=KK10IMqq0Ej7p10MaQR4YYnt3Iv8anpcpvUcl5gj692/UEiKDpQS1VFq9657BayI47
         +hXQZDKACY9YreHeZVU/JKZndADrs17BOxd9SZCyGKIkFhdRsmUZaEgX65aK4Myf7mn6
         rqax2ajIFwrAttED0TN616MOl3N71WYt8lyU3JKmNHjYX5CDObZiiBHZfC11Qc25Djlu
         Ar4+oP5duGpP1XTqpLmgWMTHILbCWzpmUvVqsNjGs7Z/sLIQDgnDvotMkBFQjsvGwaWI
         ujeG+btvkJI09WANODVjSg/n7+LaDeq02T4spElnhnMRHlh4UDTHICn8FW1R6I3U++DQ
         SRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784477718; x=1785082518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sv09Y2zV5fntrZQk40NqD/qbsVElT2FYKTtooq7g6h8=;
        b=TLCkLFsUCcemutQhk/r9NB8vA6/AoT1aP0q1lslof3sm7X15qBEI3akJAJFgDe74pR
         IqyYsjU9ozk/ApbaIVPjfeyF8WSCH9YZfOjm9gblBCOB0FAqT6Tb6IejSJm/FtIuOGxi
         oOiEiy/XuLL4Lxg3Qmv4uG9l/yXV1hEgxVMA8CWFnuSEMs1md8Ub69AmOVHsQdR36bS7
         zo6XZuPi1sB8v8xdL/UDp7+se+XkprxqcD644v+VLbQ5XtoDdcoOAIQUnu/kJzCjUJsz
         hPOATR/Ky/TZVLX0IOkaPIr4ZTVvPJvQmrWuUAi0SHdPMjaQAa9wNLvTJy9/oGIUTJ9m
         AIzw==
X-Forwarded-Encrypted: i=1; AHgh+Ro5y+yrm9A1C2Ics8ZD7QmUeNWSzBj82KYHVFPRtJBfzlD0b4CqJARvjxEnBFm+vXI46WnSosM79g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEQcjV4URuTcSM/E82gbe5puKeYA4DXcqA/UGqhNlxynAvjfvH
	MRPUWXU1ESbeh+ROcCRryj2bN4bEgrKiqllxP43iZ17C+0xWmNdks9A2
X-Gm-Gg: AfdE7cm0WsANXO5dDurBkpsf1xIwASa183es6E31e28O5IV5sk2cEu0iR27OPttEV1b
	yEiAkwr7EhyeIzChEE0F0dVxtIA7VkJqY8dXA3C5hrBdSdGgZIYw6XilKFvSIaZWax1NlcCFt2f
	5XLlIAUi58dIZpOYi8komdY1jjYYkn4riCT9WYTMEw57Qzlg8CbrVpoP2p60TejQXSizenWVpZ8
	I8a9E5cnFanVJlQZV2W5kn3O4VpASsntSlqu0Yl1ccB12bLwVPOCuCXkD9Lzg0Q6hUegJtdiVDF
	T3qjErwIDPLe69PCggiTGdVepggh2LvH6DD1fk7ae1Inhld3Ut8X+NS9cNmmbNILN8+Dhjv91H8
	mTzUPyq/7A+0r35RzhNjfrjDL7bTZnW4afIVLf93fMIi3uZCMvF+XGOq7EKt8FUMLubDXouotFy
	i/3NbTLYHOx2318FcF1NDnj57FwuLqDUOlfG04UrcCfUiIX6rqXkiHuSvWdQ5ekQS6xByUTgVYM
	CoDwx6mL2tCA1O3UokMcDCv6iN2m8bl
X-Received: by 2002:a05:620a:29c4:b0:92e:bc32:8ca7 with SMTP id af79cd13be357-930b3ef7168mr1108379385a.33.1784477717968;
        Sun, 19 Jul 2026 09:15:17 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52fe271sm672374185a.16.2026.07.19.09.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 09:15:17 -0700 (PDT)
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
Subject: [PATCH v3 1/3] keys: fix out-of-bounds read in keyring_get_key_chunk()
Date: Sun, 19 Jul 2026 12:15:03 -0400
Message-ID: <20260719161505.2423935-2-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719161505.2423935-1-michael.bommarito@gmail.com>
References: <20260719161505.2423935-1-michael.bommarito@gmail.com>
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
 security/keys/keyring.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 7a2ee0ded7c93..085f7a743354c 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -271,6 +271,7 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 	unsigned long chunk = 0;
 	const u8 *d;
 	int desc_len = index_key->desc_len, n = sizeof(chunk);
+	unsigned int offset;
 
 	level /= ASSOC_ARRAY_KEY_CHUNK_SIZE;
 	switch (level) {
@@ -284,12 +285,12 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
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

