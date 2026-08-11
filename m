Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C35745C6FA
	for <keyrings@vger.kernel.org>; Tue, 11 Aug 2026 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786469884; cv=none; b=IXymFkBMyytYI1Xn9Xo8Qd1ZDuBo9MftxQAxyOiUS3yDTg9YfYdzpHmGPpxxuxHCrGtKjVx7fvPZqDQzMJBq++ZIVYr5e82MnXnJ1WkP3EH+QSVx4CdDASG+v/D3Rg47jc3qvWjXMZAXdl715DmRiQiLfsI5LcA2vCgXMqEe+Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786469884; c=relaxed/simple;
	bh=Wx+Lw1mWnP0vMT3xO2mP96AGSIGJljennZAA0N/aXaM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gs+/ekJ2IbJtsmwML4/1ZkMmVGLr/MRx9lEqZ8ZG6X6q2N7IfzPBrXcYBN4klbweANHhqJeKAXiVGYFi2kqSvgrLrzq8VsngFDCU/7p/MwYaguW8hylh1ZKd8n89u/0QKomqmnhNyBVHrynq/6UPRRJ2H1J9+rl8g9JE7IEJT7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEFd0FjT; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEFd0FjT"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47f7854678cso26455f8f.1
        for <keyrings@vger.kernel.org>; Tue, 11 Aug 2026 10:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786469880; x=1787074680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J040IJ4YuazKH3F6B7O8n/Q7U453GJeDkkhgsQhCUds=;
        b=EEFd0FjTDluKEVPlVwGBFbxvzM+/hOlL6RKB62cwdvVjumPkV5SSbyVdYdmTHBSJpw
         BJb8NTxYHPe9pgQqMk9MCX9kuLC8wAamHab2deFpx/CSRKpNRlIEDQtOnl4+Uee+VM6t
         oUip7vPp+ZNI9aAyD05oBOkwfnqVUnylwsTgMTeFwoU+kTUzmHpOSB7MLOQs84bVYzwm
         LMN1JrcDNoRMBQ3Kp8j143zfFy8bKQBPn7zK/ChUCZQnq6HevzFX/fk/P4vF/Xg60rAD
         PbcjbkE8TzvyUiJc1o0BAlMy08KFKxEKe01MIoAuhEP/6F/bRoRO0WgB0WIFNdYKIMIc
         M8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786469880; x=1787074680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J040IJ4YuazKH3F6B7O8n/Q7U453GJeDkkhgsQhCUds=;
        b=W5iQ8EjLn4LH5tKYAim6lxHX/dbPTAt7dy5hUArbZkDWQoavdfMGa1Bz5WOY6/j5vp
         E2liQ6yjy6aizvV6aHFMT/bpTgtjZ1Sf/V7OAM7SfkUyCtLzuVF5XcNUDY3pty9B5KsH
         1HE5MIWuQojNlxYGtEgrwadarDSaf1r5MEnfngPfSE2iKE0VNiELLngKqk22PQ8e1DyQ
         aa1MUbeGNREQDo3ckWVCHi8Kq7gnnuiszAYVlVE4A+2Zx5i8hgrLj+9QCADVHSAM2TA1
         OoejgvD6GtnddMoEP14myoIAjBK2v6hO6D5y5LOILZZ6MTPKt2OC1cgeHGnWQULr9qZy
         mMfw==
X-Forwarded-Encrypted: i=1; AHgh+RotyjvmQtXIiYmXNjfW+Cs4lLnwl1EfFlJ4xH06eJ2giVml8p/t2CWgG1lHeJ2LjiqKqMh4U4PWNA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw58534ji13+5yC56bsmUqHRraNHCaquGPSk9HVkxwULhag0qfe
	yJzV1gSSjKhgDgFRAxAsyz9EWRIHzRZtMWiSJyRsMXlgbTq254WATt+Q
X-Gm-Gg: AR+sD13eOGo3Mfgq2J1QyTGLXC5/VAK/sC4yqy9zejpUGWjs2C5MFT0/zGVFv2N3U9e
	wg8Wo/vPV70Htc0r2St2Gf/BZdICtXubHtb3MgwxYLu1Pnz+Nkz9bhc4M0VaRj+tmOUxt9sft4L
	WIbKInVJsyg7Qy0sWIX5n3YyaJUdPM2bFc7OmqlK/KSY3G7pv1tWIwCuxNN6JjNWCg5gJKGrdYM
	pz4Lrc2697E667VgnKyq2XsqUfkZPffv3m3VyDqTRDZ84sVQGGnZ86I12+5uJ4r/KqhcK/W2F8y
	vXSh9Ovmj4aq3TgKSgIegWO6heVmzfYJu/y/JDrPEOz2Slicbo7daWcw8O4QArHSBCG2sEqIVsz
	WuV2W98Y7z5mMlFYSvOb4M82usDpchy+koIkTeZkOboO9h9djTozTfJtVDmG5uD8HQ9OsDxd8Tu
	imt2/i6GYe9fmSa0x6TrDoTAFpkfikQMHyIDgQbekpCRcmSJ/29cGusw5pQXw2P7YyMP49EYMyM
	bDuFywkP2yykMpOeiHfgvk1cAltkm0klWQLiMGRnxDQusfUart8gwoSvAvyOZApUZwZXKmrvSV9
	NKpOCgmqFPk7zXXWA6B/6Vpq+fMFxrjJ662F9Gnge03ghkEbYlPgxoiatcBRbiVRgaep
X-Received: by 2002:a05:600c:4ecc:b0:493:cefc:d113 with SMTP id 5b1f17b1804b1-499784297e8mr70560745e9.5.1786469880221;
        Tue, 11 Aug 2026 10:38:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a133-e401-bc8e-d36c-2d08-c5e0.310.pool.telefonica.de. [2a02:3100:a133:e401:bc8e:d36c:2d08:c5e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4997aabf134sm7815485e9.12.2026.08.11.10.37.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 11 Aug 2026 10:37:59 -0700 (PDT)
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
Subject: [PATCH] keys: fix lost wakeup when reaping a dead key type
Date: Tue, 11 Aug 2026 19:37:53 +0200
Message-Id: <20260811173753.67616-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

key_garbage_collector() clears KEY_GC_REAPING_KEYTYPE and calls
wake_up_bit() after reaping a dead key type. wake_up_bit() uses a
lockless waitqueue check and requires a full barrier after the clear.

The existing smp_mb() is before clear_bit(), so the GC can see an empty
waitqueue while unregister_key_type() still sees the bit set. The final
wakeup can then be lost, leaving module unload stuck in wait_on_bit().

Use clear_and_wake_up_bit(). Its clear_bit_unlock() preserves the
ordering of the completed GC work, and its smp_mb__after_atomic()
orders the clear before the waitqueue check.

Fixes: 0c061b5707ab ("KEYS: Correctly destroy key payloads when their keytype is removed")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
LKMM (herdtools7 7.58). LKMM has no clear_bit*() primitives, so these
tests abstract the bit clear as a store while preserving the ordering
relevant to this race. The fixed test models clear_bit_unlock() with
smp_store_release() and smp_mb__after_atomic() with smp_mb().

  C keys-gc-buggy
  { flag=1; }
  P0(int *flag, int *wq)
  {
  	int r0;
  	smp_mb();
  	WRITE_ONCE(*flag, 0);
  	r0 = READ_ONCE(*wq);
  }
  P1(int *flag, int *wq)
  {
  	int r1;
  	WRITE_ONCE(*wq, 1);
  	smp_mb();
  	r1 = READ_ONCE(*flag);
  }
  exists (0:r0=0 /\ 1:r1=1)

  C keys-gc-fixed
  { flag=1; }
  P0(int *flag, int *wq)
  {
  	int r0;
  	smp_store_release(flag, 0);
  	smp_mb();
  	r0 = READ_ONCE(*wq);
  }
  P1(int *flag, int *wq)
  {
  	int r1;
  	WRITE_ONCE(*wq, 1);
  	smp_mb();
  	r1 = READ_ONCE(*flag);
  }
  exists (0:r0=0 /\ 1:r1=1)

  herd7 -conf linux-kernel.cfg keys-gc-buggy.litmus
  herd7 -conf linux-kernel.cfg keys-gc-fixed.litmus

  pre-fix: Sometimes
  fixed:   Never

 security/keys/gc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/security/keys/gc.c b/security/keys/gc.c
index 748e83818a760..eda445f815d47 100644
--- a/security/keys/gc.c
+++ b/security/keys/gc.c
@@ -318,9 +318,7 @@ static void key_garbage_collector(struct work_struct *work)

 	if (unlikely(gc_state & KEY_GC_REAPING_DEAD_3)) {
 		kdebug("dead wake");
-		smp_mb();
-		clear_bit(KEY_GC_REAPING_KEYTYPE, &key_gc_flags);
-		wake_up_bit(&key_gc_flags, KEY_GC_REAPING_KEYTYPE);
+		clear_and_wake_up_bit(KEY_GC_REAPING_KEYTYPE, &key_gc_flags);
 	}

 	if (gc_state & KEY_GC_REAP_AGAIN)
--
2.53.0
