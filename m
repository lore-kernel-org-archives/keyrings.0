Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723262;
	b=bsMxYeKKIw3e8RD6K2DdDNTYsd5TK8QW4a2QdW4mQ9AYjqljrHYF5J02U0Xv9kdCb5jn
	 sUx6K+lhTSVkTX1hw+Kb7ozl/CxS+N2pXcPFuxVaumYQwLd5MHI6fPQumpz1g99I1sD/y
	 gd5VpBZaANaQ65igRggtq2X52/pQDYyfrf/ESc4FFSfaECzCFFM1e3Kav3UrXgb1Wpa8k
	 txpwVvmJgNV65IhFTFgS/61HioF/lGEmMIKb1IhsgwWa6JCd5CKBtnIOWhHZ0ghXQg3VC
	 2UO6t1011IMDegL/9JkzBML+EmEaIOzux+N9d1uXaoQNykaOTQgwlp8Be8QsGSnQhPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=6kyFcKzeGDxm7QHLL2jhZm3kVHS8REfuYCj505/rh+w=;
	b=af9rcIpSNEAAkAKfZhbFpzee0pzDqNwBLXND2oAbxrwtpr16ivPbat4wgUmzaLBhq3gT
	 O6UwBAj7bB4RJKfrTafxn69qjerXKzIE0F/Hyyj8oiSuQ24d/iBcnoIT2Uj1q01WbPX7v
	 kj6+afX2Kb61KhyOJqQ4vJ/TPD8zdlT2/spp9DbpHBknz0sMC4m0G0YtWBIK3lIpMbXcC
	 rrfdgWn50nJv0ny96Fc0CnulB2lTTEmCUM3Ds0vZo2w85rq1pLTGX6xEI36NNaY9NsPOC
	 TC5JNdHdvqFM9AjqXbeeDFVXapCHdpV2wIsdViIGA+P9Xf7Rht6Tgh80dJUqWYR/lYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DWn5Adbn;
	arc=none smtp.remote-ip=209.85.167.198
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18AF606A31C
	for <keyrings@vger.kernel.org>; Thu, 26 Nov 2026 20:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B18AF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhenwenliang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DWn5Adbn
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4c467e19391so10132085b6e.3
        for <keyrings@vger.kernel.org>; Thu, 26 Nov 2026 12:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795723260; x=1796328060; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6kyFcKzeGDxm7QHLL2jhZm3kVHS8REfuYCj505/rh+w=;
        b=DWn5Adbn/TnNY1xH6jgc26TeZjfcHBww+a2kKpHR/5eZOfNI4t4Z8aZ+omqwN2qsgm
         yCCY+enUXphkASUrR2TQTtRUsbfdpo/dOnwNQidEPIzUBdvoLll/U7bOMSQrkFBhmlgC
         LFdps5bXzAbXF8KyZGclTM8zxvQawERuH7hjUYr8k8TiLMccakam0RxJTH5Ras1LDvAU
         tqiDFp4hF8T13krvROhq/XaDdR0fXEqWiqmsuLW5RV0vKZWaPH9gnzcEwwXLg0rLFctj
         ZGkqJQtLYChkZZAgCZjAT1GFaA/XkgDu+1xVJ/ICK7iYXkodppDvgxd5LykFlB9tdHlW
         VOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795723260; x=1796328060;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6kyFcKzeGDxm7QHLL2jhZm3kVHS8REfuYCj505/rh+w=;
        b=eZ9+kwFzaUbOG9p3MnJ5kQIu/owZx3WfsxHTNtaOt28D9GmUvtJksVzkfdceTHDmC9
         ysTd+uZ6x7H0sDJkMbXE6sFTk1T0PhH1i7epTma5KWdOH91aqvz0wySZHk83M07AJP3A
         ALf3nTygmfyEZimwcoJGROaMWN4dJRUclDuubc74pF4UB1Fc+nbgDEltleAYaA3+wHKj
         Jfov8geEltHzAzAygktmp2HSqVO2TvSGZb0GXxpwg9q52AEpLbXVURDTF+VK1AEBFTQ3
         XmolCf1eCznvcNrfvadAA7Gc/25zdJvDl28rY+eSCW76Qxw1R/+KyRMlnGE8zujW28WY
         G/6w==
X-Forwarded-Encrypted: i=1; AL+hErEkL4ieTHHaQJ8GEGw5xyQV3rgeUn+SEHg5+9vro9B9TaNYjJ5+OJEpZ3IFoaiqMpCBAftrH9mkrA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8BA/5EFc6DhvHPxaeYAm0+YdiCpQk1usRwcS0symnyOsQT7da2
	7gM6VIHcMl27mZweizMEUdrU7YCOsphPn9eyN2EBnPkarrHLaha3wydyEYEBgJsYml0r+5WE3u+
	7W6pdWd8JCpAraQgjn5qg4UR7vXhgOQ==
X-Received: from ilbdv4-n1.prod.google.com ([2002:a05:6e02:4004:10b0:53b:d747:38b5])
 (user=zhenwenliang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:4fe7:b0:4f6:5279:5c75 with SMTP id 5614622812f47-57a0a50337emr26068171b6e.28.1795723260332;
 Thu, 26 Nov 2026 12:01:00 -0800 (PST)
Date: Thu, 26 Nov 2026 20:00:58 +0000
In-Reply-To: <awiDY0d9pRUzkV4Z@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <awiDY0d9pRUzkV4Z@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261126200058.2806412-1-zhenwenliang@google.com>
Subject: Re: KEYS: encrypted: encrypted_rcu_free() callbacks can outlive the module
From: Zhenwen Liang <zhenwenliang@google.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 26, 2026 at 09:07:15PM +0200, Jarkko Sakkinen wrote:
> This will be ultimately addressed by:
[...]
> As then operations will be always drained.
>
> It's actually somewhat tedious to address this particular issue
> without this type of architectural change but I'm open for fixes.

Thanks. For trees that will not get the series, I think a minimal fix
is possible here, because unregister_key_type() already guarantees that
no new ->update() can run once it returns: key_create_or_update() holds
key_types_sem across __key_update(), key_update() checks
key->type->update under key->sem, and the dead-type GC pass retypes
each remaining key to key_type_dead under key->sem before
unregister_key_type() returns. So every encrypted_rcu_free() has been
queued by then, and an rcu_barrier() after unregister_key_type() in
cleanup_encrypted() waits for all of them. trusted.ko has the same
pattern (trusted_update() uses call_rcu(), and none of the exit paths
waits for pending callbacks), so cleanup_trusted() needs the same.

I reproduced it in QEMU with KASAN and CONFIG_RCU_LAZY=y: add an
encrypted key, update it 20 times, and unload the module right away.
The rcuop kthread hit int3 at encrypted_rcu_free+0x1 in the freed
module text in 5 of 5 runs. With the barrier, 5 of 5 runs were clean.

With your series applied, the barrier is still needed as far as I can
see: the GC calls synchronize_rcu() before the module_put() in
key_gc_unused_keys(), and key_gc_flush() is only used by dns_resolver,
NFS idmap, the SMB client and rxrpc. On top of the series, the barrier
could become a key_gc_flush() call.

I will send two small patches (encrypted, trusted) with Fixes: tags and
Cc: stable; feel free to drop the stable tag if you think it is not
worth it.

Thanks,
Zhenwen Liang
