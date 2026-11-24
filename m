Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556497;
	b=w5UDGg3U1Q/V53K1Q7bkOgAm30ntcxVhNoJ1oQhtWO2C6uZQdTCa60jouY96rwrUQKEc
	 V1BrPerd2vbYaMNa7Ji8WpDZ4Pn6aOlL5NGW5JSgchpZ/GQtffQmhHpw8nOD261ePYN/R
	 RI2tqnGFTzzkOatVtFKGqyCewtlHpwM0zToHwykHB3Uiqda6+mY8rSbazIq29ZtgpEVct
	 B/dUltCGpg+O/wIxbikSorEWYKQRNC/WtG4IQ2g3I21whhnUl8hogd546kuOm7nXmNpCc
	 SCWKUm6/dRNFZ57hnM/C9q/ZyOTWleeTg/w2ReImHDUxhvzXzBamkuyPs4Xx6rPJT0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sC418Lw+Cxfpv60Ui/bgj9nml+ea5R2G+4fhinGo4II=;
	b=UFJE+If7X+FUNy3lxLvTT0zE2Q4ES+RJzHaicuIYPGMhJ4wCHcBR9LZAyIdoPkF0fY/w
	 h65S3PFz22NApJjNY/5ey2wJtrEAzbS2ky4tynPXqNqlQR0bJPN0y45OC+sVpKt7QmCgU
	 dopz7cdorBomNygWR3ghnOqaZBsLYQTdIMCECReDf12nIT7+f+KXSEvLmNGk2JohpRUbd
	 su8fenB/cjFimwlYq0/fa0+gVLASfwXfr8GDpwWQmos02w0D8KEYZwmqwkCj5qF82rI6V
	 odadk8p3y7Rs41/zZHD1vowtVjmqksvTg/gi2qR4IR1i1OzFS5HROadgjeyGlmGDJrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MtSrbVdv;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9912E606A323
	for <keyrings@vger.kernel.org>; Tue, 24 Nov 2026 21:41:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9912E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MtSrbVdv
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e46e449e8so3261854f8f.3
        for <keyrings@vger.kernel.org>; Tue, 24 Nov 2026 13:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795556495; x=1796161295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sC418Lw+Cxfpv60Ui/bgj9nml+ea5R2G+4fhinGo4II=;
        b=MtSrbVdvXPESULp49wFyKVViyU6uV845m7VObPFqQPp+cyXIAZJY0lPMcSZaqh9RMU
         N1tn7Cskb/nzr5TmOpSei1JbApwJPvIUOkkSfAmWzK/tZT6ItSWCfbM8Dqt8uRrm6ILw
         uAxYcp3P/gS4qEes1+47utnIUp6VHolN9lPusRgZZNHcsMeZ4aRO6PXyE7zt9JRzN+of
         s7geRWDZ2G5R369y+x98KK0gmNXD5A+NLVUkRHcLq6qgLwbJ523zzN2yhGFEmYMiWxsk
         XHOahvLYAKaR6JTglJyNLuiV8s4uu39q9ZuzK277Cjv85T9Pg0iVNzTDL3rWXY+2B0vz
         bRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795556495; x=1796161295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sC418Lw+Cxfpv60Ui/bgj9nml+ea5R2G+4fhinGo4II=;
        b=TABQIbfK8O9FS1D7T+VMF756cf8USq5PmYIQvQibOx6yuQKt1+CFt4ncqUoCcUTO6r
         1R2dfRzCccNLR/7jc45cX9vgr/1WBwofbqvq9NNyEja5t53cUEMMxwpT2JgZHARdNWed
         uxhrZI3x7Lt71BFxlMxRycWAX5pcVsLJbKEKN8F39DfLNEq7vlSsyN9asASQk9nM2cWU
         Q3wyvB6UZyCY/oUGTrXjqSTA1kc1fWK0i6ewNwpt4BoPH9d/h3K/TViDMOVZ8b/WIWym
         CwEViw/5EsSonPHSgbVlNJ1HacCOOm8cex4+X6Ci8lAlsN4eobxBz9jiFPaAREXlMRvX
         +JjQ==
X-Forwarded-Encrypted: i=1; AL+hErHTyD/FieiA0C2qlfH+KJ7Dabx25tR41mNlRhmroJZ/ll+O4chT0Gc40ECZq0rT9DNt6rvX1DH9Iw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/kPYGmkQMTe+pRmjG05fqUXLfG4FeeUBv42SeObA/KADKqTcas
	e6oBM2OcyqJBCpAclOUjk2LB48lOo6r5ePkL2M0U0Ob9seY09lCHtpo=
X-Gm-Gg: AZFdTZc+asIoYDabXA7mZ9aVqe837XPKdQbxl1wxX83VKk/ihMKSaZAShxSqWWc0JDJ
	RPMaYJfcYB3+5aOF6xzirdCHEgAc610Thfzl7F4wRV13ggWhVCvwv/3Mwq0ojpSqHeX5JjU3KQO
	TzoFUWBGha2ShKGXgt6p6BeXo8B+Nft325CtRdzsqnkwupd2xC6LOesS6/50wv1kDIjOA2KqnUF
	59LghI/8IkGPdpezAmwVVQ6ueIGtvMFjnArGimuAeTpgKWKvLUNla4igQeBD+89/W9gHMKeQ3Ri
	IyiXlux0c340mr3Ht2wLsX15We/3NfShghS9SU4Eua2P36XDYJzn0UOFIlC2MjsuobESiJXbq7d
	YIdYd9iM73xtgCWyeYI3srevRjYpDdaBPEqMHcg722IZXvVNnb5frZvm9+ZQMwOk9kjN2ZO7KEa
	w82Mgpurjlh0m1fq9jlOe2zfAqkl2w/pT0gBfYvC3tD6UgLcoAeb04iWizAtxwQsUKuPi0FMfxU
	vekamC8dnZGoE8Anpq7IebexRvCtzsH3h+B5vHdd+5M+kMv/ADzTXSPt65J1hNr+7NpSdcEHzTT
	auqR8ZxWXYeAxxk=
X-Received: by 2002:a5d:64c9:0:b0:4b3:f000:1bdc with SMTP id ffacd0b85a97d-4b3f0001c13mr12286559f8f.45.1795556495020;
        Tue, 24 Nov 2026 13:41:35 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb98b4dsm31041908f8f.53.2026.11.24.13.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 13:41:34 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v3] KEYS: protect construct_key type dereference with key semaphore
Date: Tue, 24 Nov 2026 21:41:25 +0000
Message-ID: <20261124214125.3198541-1-tristmd@gmail.com>
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
then calls the resulting actor function pointer.  The key garbage
collector retypes keys to key_type_dead under key->sem write lock when
their type is unregistered.  Without the read lock, construct_key() can
observe a stale type pointer if the garbage collector retypes the key
between the pointer read and the actor invocation.

Take key->sem for reading around the key->type->request_key lookup to
prevent concurrent retyping by the garbage collector, then release the
semaphore before invoking the actor.  The semaphore cannot be held
across the actor call because call_sbin_request_key() blocks in
call_usermodehelper_keys() with UMH_WAIT_PROC until the userspace
helper exits, and standard helpers such as key.dns_resolver and
nfsidmap take key->sem for writing via keyctl_set_timeout() before
they return.

This follows the same defensive pattern as commit 925c84e3cc21 ("keys:
Protect the read method check against type removal") but narrows the
lock scope to the type pointer read to avoid the deadlock.

Fixes: b5f545c880a2 ("[PATCH] keys: Permit running process to instantiate keys")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
v3: narrow the lock scope to the type pointer read only, releasing
key->sem before the actor() call. Holding the semaphore across actor()
deadlocks when call_sbin_request_key blocks in UMH_WAIT_PROC and the
userspace helper takes key->sem write via keyctl_set_timeout() (Sashiko)

v2: hold key->sem across the actor() call, not just the type pointer
read, matching the established pattern from three prior fixes (Sashiko)

Build tested: x86_64 defconfig + CONFIG_KEYS=y, gcc 14.2, W=1,
0 warnings.

 security/keys/request_key.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index a7673ad86d18d..ccc4e94197423 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -241,8 +241,10 @@ static int construct_key(struct key *key, const void *callout_info,
 
 	/* Make the call */
 	actor = call_sbin_request_key;
+	down_read(&key->sem);
 	if (key->type->request_key)
 		actor = key->type->request_key;
+	up_read(&key->sem);
 
 	ret = actor(authkey, aux);
 
-- 
2.47.3

