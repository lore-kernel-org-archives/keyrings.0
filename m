Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795660541;
	b=yaNPhMsEp605tp9ylP7erM/ymZEF5/dV8apmJMwuzlXj5E6FVqUBa1DTnkxbooJY+aqp
	 o9qf6CzdWfx6xSm8IuTI84u8au1hQoTCYMWQrXqQaDHykRrYQ382HNrPkUPn82UshXh+7
	 UR2XTmLSBuI/opr2DFU75Gmufc1cx4mzpLm3UundrMQNUI67o/0L0QAJ8c6xEAmMAwJ3W
	 oSgu5wZs4ewkRL5kLD6rtuRtFt8BT6KI17ULRUhKAhjfx8nw1KS9JP+W8qLOtpOrwQQ1H
	 hr4QxpV7BzAMRs9FXUwVoCpwD9oQpO7LxKlrhg6tvk4pIqceuqPApYT8/xvZo+/2ArA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795660541;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=g3rQYEqeb9KItcfmF0Y01uIIXY4X06TFOeBbAGovoNY=;
	b=04oPPsm0IYnwo/OiJwhNa/K1zlRoJrpknV04nsnLLQxmmksjLfGUBnAixNUobufu2VF9
	 VdYai9nAZoVo+0C4KInGSNks2aRta0/BFj8Lp63C888Mf5rl/hpPv512eJeVyO58nrppl
	 sk8NkO5dQFctAr6TuKXX8BP4VHSH2X9Ad9OfDE1AKUBv1uP5R/nlGLUpxqVpRP9WQTqaT
	 yMIgh1KYedOWgNLslmqTDPHD6252K7QUcvnWn0v2KwV6P+4P+CF8t/oRQJ3AOs0eFbuCg
	 u6/cqgOLacm31kqvkEDRCTdfpW00fzR7CnbYTQWb6ufQAhzjI6cjzPB0cNfGNJuYP7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="X0uaxh/Y";
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE18606A321
	for <keyrings@vger.kernel.org>; Thu, 26 Nov 2026 02:35:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CE18606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=X0uaxh/Y
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-5384e381fbbso5710766b6e.2
        for <keyrings@vger.kernel.org>; Wed, 25 Nov 2026 18:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795660540; x=1796265340; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=g3rQYEqeb9KItcfmF0Y01uIIXY4X06TFOeBbAGovoNY=;
        b=X0uaxh/Y6FfGkSOerIan92Tqs5wCFuIdc1o5XtL4Lp9SJebTXEDKfoYaT0d1mgLGfJ
         uoAVeT8sSBexKcX+QGe9G42pp0CRDiIJhSP3qZA2f/FOsb082jGJIvvEV3P7BXZs8ZeB
         Ress+qPpeZPkiXc03IVbd3m5MIzK0IHO7sS+usV1OTXA6oqQ2Ej/nERYkA7FBbeJdmJJ
         GkzFKj6LmZxnkM7Ihigc758BKD76oTQ3eoHpo54UdpLrp4Bia8DJcl2pH1ff1HLjzcqW
         0ymVp0eXrXOb07GAQsN5oJws8pLnn8QStbpGHlQTZ18RhJzXyqUORM5q5q8E3lVOrr3u
         O39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795660540; x=1796265340;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=g3rQYEqeb9KItcfmF0Y01uIIXY4X06TFOeBbAGovoNY=;
        b=G4ar99rZOFPHgqgAHJZXcfRgEbMzARs5kI+U76FZ5cpXrKkW/VHsl1eR26kndy5FmV
         owhbgsFUrbosm3BLGhtNh3g/++XBhJfkw4DkUJiFTbt6TsqNi9lY+v73Of+l1oNtYyWH
         UaK4nPTfcWbkJYptis8lUsP56HseFOrUMEDDmUEzL0n3uNbh8+iCT20nih1OpSx4wLbY
         SFRQx/RdcAa06ZHTikLIzM0rv2tFghB3o6kVFSP92L0XmOkRfHLA2KbO7CUEups5JvCn
         aRCDOvWag5Np4Q4N10XY4JdMOj41fnaZzqJt/x0XYhPJDt+fyiLTl6hkx6con58qSTaU
         OqcA==
X-Forwarded-Encrypted: i=1; AL+hErET8/yqB1OpSZm9BojMfKbw2ZzCJmZm+nN0H2Z9kMck55dQgavVXqEkKR/PMcW9b3fketRk0KsLvQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+TKuAhJpu9Rc4JVpmxEgZn1Jg2kwpbOVQjjEa8fvHj+NvuNkUB
	eCZsue0gI1VEg/deziR2VVUrIsLjlwwLU7t8cvBGqin5Y+SfyEBVc1V5yVebuF4JIyB4lBCoZ7l
	p2lGAdS21RHKffWxT1xqmQABWchEkXw==
X-Received: from jaac8-n2.prod.google.com ([2002:a05:6638:c748:20b0:620:5ab5:d384])
 (user=zhenwenliang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4f49:b0:4c3:db9b:3ead with SMTP id 5614622812f47-57a06b1eaddmr21898545b6e.3.1795660540254;
 Wed, 25 Nov 2026 18:35:40 -0800 (PST)
Date: Thu, 26 Nov 2026 02:35:38 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126023538.4160950-1-zhenwenliang@google.com>
Subject: KEYS: encrypted: encrypted_rcu_free() callbacks can outlive the module
From: Zhenwen Liang <zhenwenliang@google.com>
To: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

encrypted_update() replaces the payload and frees the old one with

    rcu_assign_keypointer(key, new_epayload);
    call_rcu(&epayload->rcu, encrypted_rcu_free);

(security/keys/encrypted-keys/encrypted.c:898-899 on mainline
ebb7a8dc1e74), but the module exit path does not wait for those
callbacks:

    static void __exit cleanup_encrypted(void)
    {
            unregister_key_type(&key_type_encrypted);
    }

When ENCRYPTED_KEYS=m, an encrypted_rcu_free() callback queued by a
recent KEYCTL_UPDATE can therefore still be pending when
encrypted-keys.ko is unloaded. The RCU core later calls a function in
freed module text. unregister_key_type() garbage-collects the keys of
the type but, as far as I can see, nothing on that path waits for
already-queued call_rcu() callbacks (synchronize_rcu() is not enough for
that).

Sequence:
  1. a user who owns an encrypted key runs KEYCTL_UPDATE
     ("update <new master>"), which queues encrypted_rcu_free();
  2. before a grace period ends and the callback runs, root removes the
     module (no dependent module loaded);
  3. the callback runs from freed module memory.

The usual fix for this pattern is an rcu_barrier() in
cleanup_encrypted() after unregister_key_type(). trusted_core.c uses the
same call_rcu() pattern in trusted_update(); I have not checked its exit
path in detail.

Affected: the call_rcu() in encrypted_update() has been there since the
encrypted-keys code was moved to its own directory (61cf45d01990, 2011);
the code is unchanged in mainline ebb7a8dc1e74 and next-20261125.
Trigger: needs root to unload the module; queueing the callback needs
only a key owner. Impact: use-after-free of module text, i.e. a crash or
execution of reused memory, in a narrow window after the unload.

Found by a formal analysis tool we are developing that uses AI
assistance; I have reviewed the analysis and this report. The tool runs
verbatim copies of the kernel functions with stubs for the rest of the
kernel; it found the interleaving above, and the interleaving was
replayed natively on that harness under the tool's schedule. Functions
involved: encrypted_update(), encrypted_rcu_free(), cleanup_encrypted()
(RCU core and module unloading stubbed). It has not been reproduced on a
booted kernel.

Thanks,
Zhenwen Liang
