Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150213148B4
	for <keyrings@vger.kernel.org>; Fri, 21 Aug 2026 02:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787280816; cv=none; b=fYnMXHg46X14GQZJivYXBKdx6RXTmHdNSWD7xexNFUJrqeuA8fZSsBxtSiosG3jTG235dNPmvupjEiYgDGsoy9vafntNRsTt6FA5OyCJ8n+dIZMburpcqrfaxBeeaOSA402dFoMXPcHJJMC4z99jTLmKIuNRbKCkwIUUjaq4KqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787280816; c=relaxed/simple;
	bh=fc/UOG1joBYpH+1V5oaIRdcVOyoy8B87yG2u2Og7z68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TGTvfZ3Hsw942s8gW8r++e1u6nPSr8X9R8fur5aPhyCbBLT33WGGdD4OUJDHSsIR8jPpIzLVHTdCEop3vFhGDQCvQKnsixWxEkNFgwUkkesQvZZfylgkXt1GJ5g7OCrDJfI4JKOUtm5PAEh6BTSyom5XNc9hWCbF2psZ+IFFssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=slrLyGZX; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slrLyGZX"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a1542cdb53so744425a12.2
        for <keyrings@vger.kernel.org>; Thu, 20 Aug 2026 19:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787280813; x=1787885613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8KBiC8cel7Bm6yYFzHAwDueQ4V69k5ZlAn269AvVB4E=;
        b=slrLyGZXRlBjjaAkd0MahHzdCpzet13R3GA5iat/xDHog3lkMRPbZGCTjSGYpjYHtb
         2aUbAEkWsl3mgIMdL8CAxlLZyEPgwmA78s3Zgo4HrMAHw5xIqZuQ8l/sprkv2n/hBGuQ
         k8zT9b/dPgM/zjdodzyNZVFTiHEB+6swEZoDSRrFyJtUuvHCxPsr6USy3+JmEprVe0sY
         nGlcR03kJBSq4uEBOEg5knhLJgulNbeKNajAWBu/46i6xfxG+uhAwcMMT1cyTOly53VX
         4c+QF7Y/TO1xAflw8VXaw7ahC8U+892OibYDWcSBXxR9d3rvUCojZ2xQ61Xu4geFr5/X
         t3BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787280813; x=1787885613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8KBiC8cel7Bm6yYFzHAwDueQ4V69k5ZlAn269AvVB4E=;
        b=BPJA8hbnCfelXVuIBgU7mFq4oIJTWDm1qPljPdxjWDGUuzLIRk/QHNJVDF5KInaP55
         pmWJ2XTQFzyBkbXgTxpfVoiuLCiEC5clYRNtSathWo9HZ3/ps+AFMdECs9X+PnMSAzp2
         dPtVZmOvCf8Or2SooBnDxi56qezAJYTgR0EmN1cfE4yQU6MX97cE1B/OsT6l4rrR+nfi
         Y6rIzvvlHimPGJqPYVZ0DSbdBITxBqC3tjogIgiG6rsGDKOh4xQHJaCWw0EVDdE/Hp5O
         tCxRUkiGFZPb7ZP5v3iWZJNJZgZWysMqjvd++DYkjZJqSGUJnyLeSUjPjO0cMIy004nd
         sQdw==
X-Forwarded-Encrypted: i=1; AHgh+RrJkIG14WVB760JDZlE4IH0XEOy10A8Rgd48/ZcjztTECfEBwxuNlgo3ml+CC7XRe+FaAhgLzo5UA==@vger.kernel.org
X-Gm-Message-State: AFuF++nKNgMs2WOIfcbC/LbJYNhAg/f9WU2tLgTeZrtL+uPXsH+g8yM1
	h45frm6OhUbQ1usk8wI1ZHBlO0Lfsq7+uBrscTm0n1NGpG6DX4QvJ34g
X-Gm-Gg: AR+sD11d1Vnzxg+AjKJQAVI4A5X75HDvDomBW34/BfpfI96VZ8MNqqVkx3QY28dZOFU
	LAw1XyG+l6tRghoQHWRGWLgdbD5Bk/533T9+GjCfPkOCEYf8wEfhciJJa9RlQn06+Mg+vYny5g0
	oDRG+05VKX91iEi792EBcFt+SQ8kzKS9YI6FjEztsy51OFVaK8NBfDEFgqy9PsTfVbZm6juMBN4
	6Zz9S3lg+vrDD4kWE5Aw2GWHdcmnNfOEu/JYGLpnhSztB3CwZB8ZfjVcfYa6d4Nyo6IglM/vgXQ
	6ddPS4efKdJ5BXMfyC3ev1qfiB+34pqFh5UMSZO+uHSeRosZmK77McUEmCQOMrs2xGMbmVlGRFD
	A9zBLpmy5nuzRQWfJwO8yo0g0Av0qa3NKl+l9Atvz3iKmo34ru6xbxg2H0lGXgm5v33EmYHdqVs
	bF2aRKty1INe3k3GoRsNcTWk/woUiGLxPpN1MLJsdWSfhulnhWN4aIjhj7kquoIHeqnbROcbTwD
	LedahxOCybrkKqOUFuZlmERgbNrZIQvG4C4bmJX2+yDUDj6KEUjbGdLX/1TWtPUg1lXMQaY1t3a
	6C1KIqASj0Yosf82+k+4rqTH22lQ+u46KlZhM33RM/XuW3SU797ZvlxAfq4w4s6E0IUfiN5jXd2
	xSmt8GIFkNRur
X-Received: by 2002:a05:6402:a0d9:b0:6a1:fd14:8832 with SMTP id 4fb4d7f45d1cf-6a42f25843bmr3113530a12.12.1787280813127;
        Thu, 20 Aug 2026 19:53:33 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a103-bf01-4ca5-89c5-9aa3-9754.310.pool.telefonica.de. [2a02:3100:a103:bf01:4ca5:89c5:9aa3:9754])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feeca188sm4214314a12.6.2026.08.20.19.53.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Aug 2026 19:53:31 -0700 (PDT)
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
Subject: [PATCH v2] keys: fix lost wakeup when reaping a dead key type
Date: Fri, 21 Aug 2026 04:53:27 +0200
Message-Id: <20260821025327.61488-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

clear_bit() is atomic with respect to the word it modifies, but it is
an unordered operation: it implies no memory barrier on either side
(Documentation/atomic_bitops.txt).

key_garbage_collector() clears KEY_GC_REAPING_KEYTYPE with clear_bit()
and calls wake_up_bit() after reaping a dead key type. wake_up_bit()
uses a lockless waitqueue check and requires a full barrier after the
clear.

The existing smp_mb() is before clear_bit(), so nothing orders the clear
against that check. The GC can see an empty waitqueue while
unregister_key_type() still sees the bit set. The final wakeup is then
lost, leaving module unload stuck in wait_on_bit().

Use clear_and_wake_up_bit(). Its clear_bit_unlock() has RELEASE
semantics, so the completed GC work stays ordered before the clear, and
its smp_mb__after_atomic() orders the clear before the waitqueue check.

Fixes: 0c061b5707ab ("KEYS: Correctly destroy key payloads when their keytype is removed")
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
v2: open with the ordering semantics of clear_bit(), as suggested by
    Jarkko. No code change.
v1: https://lore.kernel.org/r/20260811173753.67616-1-kmehltretter@gmail.com/

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
