Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792816211;
	b=ebbHiwViX3qGuU56nHSAlyE6wm1HqkzNYALtelETd088ZefZ/Uf0FG1fBwa4Hnn8ryP5
	 nOTBL+npAARRu6DENUC1TUfWc6v1P1r2dN+WUa+5EghPFSaYqpOv8PC3RRLjv85i7GgzE
	 rbqS4kUWBff128f3so+AmTI09wqa8f9bOChKkdDhHhb02DxBwldDX4e+oZ9mBR527i1D0
	 f9z5q8RfGJNT28SeaIQ6m0R6etEIQW275m7ziB8wx+vvtn13FEfuE3zaLJLphd7qZmTc5
	 gPuIbhdeGp4CUF/VCKo47Khd3PxK2r6/RUvSEE3LufVfBblSVMPZNzVynnnKBMzNpqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792816211;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=9fTxeCcNNzzF29W6dGmG1z9MBljc31aj3PxIdltLkYA=;
	b=4PHmFeoEnpnVnnJT5sFj8C5+08fsccxziGNiBJucfl9UjSMhEneonHKKZRWmOd1s5FhU
	 la4om0wb5G1Ugxx1ISJON1q6RY8ogpjnEUhCwvV82WzRQyoZvUtbcrBnefLO3xB9aUnRe
	 EM10WA3QewcPbHAUlgt3wMQnGUpN0D/IaNN/Uf8pthkGWW9PbigVrbILpE50VIPHeC4kZ
	 /tKnOilj09G7ZQfrTh2OTVpBraRLkSyHIMtzBIjKmtTd0W1k3AVivFzSMZzzVWnTeJTNe
	 eXptehdmBHHz10BXWxJ3uwNhNW1Vju4mdl5dc1UqnhtPvSJQGqEmqrqG/TFqii5+MuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hzi8tAPV;
	arc=none smtp.remote-ip=209.85.167.46
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A111E606A31E
	for <keyrings@vger.kernel.org>; Sat, 24 Oct 2026 04:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A111E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hzi8tAPV
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5be42ae8eadso953929e87.3
        for <keyrings@vger.kernel.org>; Fri, 23 Oct 2026 21:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792816209; x=1793421009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9fTxeCcNNzzF29W6dGmG1z9MBljc31aj3PxIdltLkYA=;
        b=hzi8tAPVKcYUDH8FGM7gnF7SbUQSl1BcNQF2Iwy9MGDSO+BWQ/wJtPW0mA6FPYD2Sx
         Gmy/R8K8ThDhFVVcyg+ltUDc4il8tUuEYs/c7q82vOiVBOE1IoSOjDeYnbRyoCe0c0GM
         GxXvjQKp9XCgpS0g4UD+P5LN/87szacBjzpxVqDfRQkeL/K6hsafKppFaqpZwDgk3to3
         5/iIpo7CTj5UYTxPxFIJHF2S+Tn/W7wPV5r2BnMOTPgozAYvIztDam5qWwC3hj8eca5i
         6Q7+7JktppSrKbdgdPBhswliQ24kuenTkzTu8Zqdv3wewJwd+SWNP/ienz9KVQu8AWth
         O5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792816209; x=1793421009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9fTxeCcNNzzF29W6dGmG1z9MBljc31aj3PxIdltLkYA=;
        b=gZnbjp3zD1SgeW6kpdXPcuwAQsH5M62OWhiEqWxid7OwgR0FkR8JotOzfnoMtRugOL
         thxNZ0G4RgyX8AufR0wWz20erHMjWAYleSFL/q4FyVVv3bEy3v55bo6KVFDyox+apUH0
         84KjCRyJSmA1Y3xe9/m4+Zsn4LkJ4loZSXEfPa5agAelaM/w12MsFlFQax2V1rPf4F7Z
         1ZyXIl4QHhjjcN8ky4+VmOM4ZA7+Rm6S0KdEv4Da3AanmgB7goiN00gURJevbgUuiBy1
         VnVmsOkDg90IMHDQ2f4NojfikzLUXKGxZn18ZOt058GH93jhdh4rguqwZI2uJrpkTbC5
         4Rag==
X-Gm-Message-State: AFq9FYIb6mBjjSvLTowNGEwZ9HYUQe9UGWInA4+iANrxdwI+rqfCgRTv
	IaEjINNiL9RgiCqEHefRBkJOtcH2Q/lP4hkY2DBLbW6Nysc7CnbmIu76
X-Gm-Gg: AYBFou05M8Dedqqh06ymo8JmcjVd/s1lxh2ajIu0M1t7+orK8EecnonH7dmguSM3q9g
	6wdtHvtkWeGe4sopRPp2kFOdzv8GnZxMcQA851xQTPO9Vqomg08COb9EEMxsXWxzAdd+phgEYIf
	4N+C31MM/TnTdIMaoM2xde1gbYTnG9FK5QplHRV2EUAdX56XGoz2enQgbhazRATGncEW/gn8nxr
	UdYwJOrI++pX/0+0OpuCvpOmL0u7aRxv944hZK5lMDemrTX9gAi6gJq16BPjgPPTJUHJG2sc0US
	PZv27EhV09nw7FkG3YCgPWpjYQpWpqOBuMnWPDmr8MzifoEfjqsLJSU0zwyn0m9pdkObTWbTVrn
	v1w/rzpQoE6Mrl4keN2UYK8ZJRdTknR7OfdtwlUkOVvg/TWMx4pPENe3o5+maCKlJy0ftG/aNq1
	T7aM95JbmZiZzJ/9nytGM/adSUJtFmZsze/NmlYdikXeDtwa+VE7+YVwha1pbFZfVavp5vGxMQ5
	ZYkiuOE45V2PBJ+rt1s7ZNwD1gb8cFoBZr2LvXFbQenYFpBIoP1nMxvNYxu
X-Received: by 2002:a05:6512:6694:20b0:5bf:b7d1:6488 with SMTP id 2adb3069b0e04-5bfb7d16896mr109075e87.52.1792816208523;
        Fri, 23 Oct 2026 21:30:08 -0700 (PDT)
Received: from localhost.net ([196.240.54.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfb7a6b051sm168295e87.14.2026.10.23.21.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 21:30:08 -0700 (PDT)
From: Eduard Zateev <hackerowskiy@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	Eduard Zateev <hackerowskiy@gmail.com>
Subject: [PATCH] keys: use long workqueue for garbage collection
Date: Sat, 24 Oct 2026 06:29:44 +0200
Message-ID: <20261024042944.52493-1-hackerowskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
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

The key garbage collector can wait for RCU grace periods. This can occupy a
normal events worker for a long time and contribute to workqueue lockups.

Queue key GC on system_long_wq because its work may wait for long periods.

Reported-by: syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=c15de43f1e7fffbb7b9b
Signed-off-by: Eduard Zateev <hackerowskiy@gmail.com>
---
 security/keys/gc.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/security/keys/gc.c b/security/keys/gc.c
index eda445f815d..b174b8c511b 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -19,6 +19,7 @@ unsigned key_gc_delay = 5 * 60;
  * Reaper for unused keys.
  */
 static void key_garbage_collector(struct work_struct *work);
+/* Key GC may wait for RCU grace periods, so queue it on system_long_wq. */
 DECLARE_WORK(key_gc_work, key_garbage_collector);
 
 /*
@@ -57,7 +58,7 @@ void key_schedule_gc(time64_t gc_at)
 
 	if (gc_at <= now || test_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags)) {
 		kdebug("IMMEDIATE");
-		schedule_work(&key_gc_work);
+		queue_work(system_long_wq, &key_gc_work);
 	} else if (gc_at < key_gc_next_run) {
 		kdebug("DEFERRED");
 		key_gc_next_run = gc_at;
@@ -85,7 +86,7 @@ void key_set_expiry(struct key *key, time64_t expiry)
 void key_schedule_gc_links(void)
 {
 	set_bit(KEY_GC_KEY_EXPIRED, &key_gc_flags);
-	schedule_work(&key_gc_work);
+	queue_work(system_long_wq, &key_gc_work);
 }
 
 /*
@@ -119,7 +120,7 @@ void key_gc_keytype(struct key_type *ktype)
 	set_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags);
 
 	kdebug("schedule");
-	schedule_work(&key_gc_work);
+	queue_work(system_long_wq, &key_gc_work);
 
 	kdebug("sleep");
 	wait_on_bit(&key_gc_flags, KEY_GC_REAPING_KEYTYPE,
@@ -322,7 +323,7 @@ static void key_garbage_collector(struct work_struct *work)
 	}
 
 	if (gc_state & KEY_GC_REAP_AGAIN)
-		schedule_work(&key_gc_work);
+		queue_work(system_long_wq, &key_gc_work);
 	kleave(" [end %x]", gc_state);
 	return;
 
-- 
2.55.0

