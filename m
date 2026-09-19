Received: from mail-pj2-f18.google.com (mail-pj2-f18.google.com [74.125.227.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA61332EBC
	for <keyrings@vger.kernel.org>; Sat, 19 Sep 2026 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850116; cv=none; b=oQxDKzBS5xAPpO+Ny1G6wyVKkBQ3wrd3Bzhjk2euEu0WXEoD+0S4xMLOjcKHlyr2jVUyMxx3/NGJgLFwCWTiR9G7FJGu0qiPS5KNhnhcOx1wWtF46UGVibKv7EqNDk6yiUBFdhbJ10z5KYLcfqfj/sb9TVXRsOEtUxaT5K6er8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850116; c=relaxed/simple;
	bh=6Dt0U3Nv3UU/hUnJU6VCs7akUfdBnup8mEUblwSfJH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X53FMPULDlX5/Sw2gAXAf77482hT5uHNR+5T138sZ+Sn88z9L7BI6NDOXeIpRy0F7xhyk0mxXXJUf7h/NyjjW9GIWJJV9zNXMzl1d05belXQiWR4YU7DH+pV7s9WCiH1b5KBel10Shmg8otba5rym3exUa6yLJNHT9zSD63/yxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gjdEI/D7; arc=none smtp.client-ip=74.125.227.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gjdEI/D7"
Received: by mail-pj2-f18.google.com with SMTP id d9443c01a7336-2db22383fe8so11650375ad.2
        for <keyrings@vger.kernel.org>; Sat, 19 Sep 2026 13:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789850114; x=1790454914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=sp+3MfHIef17t9guG27n3yYy5IMEoS4o2YkTC2fwCC8=;
        b=gjdEI/D7ejwEfIP57Q2RqSvTjh9zUVxZ/v1WQQLDawyy2eDEcq/afrD+zsuWZRckr/
         NrlwFlmk7sIcODlDIEP5HuBtQvCZaRvfhfgcx7USBmNLcKbe9e3nyX2K5mkHM/bqtosR
         X4Fc4o44crgF9N8MAqkM1gfjhL26vkjdfi6XYA+LO3ebAbNyZD33BCbLfRLHiFjdU3EP
         MTZyeb2BI0ad3uu6uN24DqgvzMafadSqqJXvOyL1PpuKl8/aOH00TEa6OW84XiySufpE
         vdvc1+Jnae6Cldt2YQiJz4/jUGc+ojaiy1UoKH3oJ67hSCpERD8TElBqho3/gIyVrQCR
         cr6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789850114; x=1790454914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sp+3MfHIef17t9guG27n3yYy5IMEoS4o2YkTC2fwCC8=;
        b=SLn7+vYElsXCBu3SthzEkusuZeciRH66dJkFYFs8ZU8OTCMAaHhEojgEH0rnKEp2+q
         W5EV7gWW5I3oFX+G4vTfujnyz0jQo3w5PIn+Z5gKOtn0PrLIjyUTHVEJ8ZzUP3yqoNdq
         okS8M3NRS7E0ASElHLK+6M8WHnw+s8pMKfMCCRlOS6Ef36s9DQ+2lkMzKRXaMKgG5QGg
         /dSDzSuCh5AiyK/bLZcQfOc62AfqoOuVuxD1FY0ca77TcND7O5tZal89mLTbKd9RGKYN
         47s5IAbSxJpRN9g63F/nZI2rIzA+am6cLibU8xo8Ff+xROJy6Dgmie/jQ1/3R+i7+JPA
         RP+g==
X-Forwarded-Encrypted: i=1; AKwUvBxvRBz3hVUW/G8GSy+BnOypUnCITEMPnmhfM5Uhw2agvFBhZlm++Yc2XcPe2g7/NfKnIwubSEgqpQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lR2zalZtdoyW5tvvKVk75N23LqT5oMepS/wgWh4jOl1mX+qHaS
	4TkSXd+0APno9ujjr0+Cgy7R86Smr+0nPzz46C984pFulNwk42KAZZEF
X-Gm-Gg: AYBFou29S+63tlmLPT+6hqTk2gHgJGodo90Eyr8gQKOWcB8mVvzElxrSNu0buTOcE7I
	3Vlw861NJ2MwcjPNek8bRItJ8MBXSkw2yb8yzbE6xP0cfvLl0Wx5PQN0Mh1GSBC42W6Si/gXkcn
	X2HouMA4RCQUjwdp+ZFL1lJpj4kRkbNPwPLfv+sP79FOPVkkN8KJUQyX9BVqc/JzlgJxPMcxjGZ
	67svPxzp6c7x3M2FmQXNS+zrVNLk3gATkg4y16lznC/q4tC5e4ebzQkoMFTYL1J2vdz5QlM2KTG
	pLEhU/c0okeaEBfaQ5qVvZ6wyOcesThJTEIu3hu9F22NqJ9j+hQaym6rl2/GWDgmS1SxHoAPPFb
	/eWDJRICcR7v9royUgPvGW0AlslSw8W9+I74gmMcfi72pmmejMJExffhW1mqxIx9ExCg62iYCwV
	+4Td6zszldjK0bG82VhURZuOonnTKgB1S/jg5MtYi4gB8Vlv5uu8cawtR8/8zIH2jY3675nd0Hh
	JpMDnaoGxr1VcXHdEFyCBRSOPPDV/VrT+RV02QC120A6hQHHj21wGyteC5BhFfpCrF33wEu0LCK
	rav0KPqrtw==
X-Received: by 2002:a17:902:f608:b0:2dd:c0ff:e724 with SMTP id d9443c01a7336-2ddc0ffe92dmr39228325ad.54.1789850113925;
        Sat, 19 Sep 2026 13:35:13 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17ff4d7sm12700145ad.74.2026.09.19.13.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 13:35:13 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] KEYS: reject descriptions exceeding U16_MAX in __key_create_or_update()
Date: Sat, 19 Sep 2026 20:35:11 +0000
Message-ID: <20260919203511.2580732-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct keyring_index_key stores the key description length in a 16-bit
field (u16 desc_len), and __key_link_begin() enforces
BUG_ON(index_key->desc_len == 0).

While add_key() bounds explicit userspace description strings to
KEY_MAX_DESC_SIZE (4096), when the userspace description is NULL or
empty __key_create_or_update() delegates description generation to
index_key.type->preparse(&prep) on the payload (up to 1 MiB). Key types
such as "asymmetric" (x509_key_preparse()) construct prep.description
from the certificate issuer, subject, and hex-encoded serial number,
which can exceed 65535 bytes.

__key_create_or_update() then assigns:

        index_key.desc_len = strlen(index_key.description);

without checking whether the length fits in u16. When
strlen(index_key.description) is 65536 (0x10000), index_key.desc_len
truncates to 0 and immediately triggers BUG_ON(index_key->desc_len == 0)
in __key_link_begin(). Lengths above 65536 truncate modulo 65536,
corrupting keyring hash and comparison lengths.

Reject empty descriptions or descriptions longer than U16_MAX with
-EINVAL in __key_create_or_update() and key_alloc().

Fixes: 16feef434017 ("KEYS: Consolidate the concept of an 'index key' for key access")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/security/keys/key.c b/security/keys/key.c
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -245,6 +245,8 @@ struct key *key_alloc(struct key_type *type, const char *desc,
 	}
 
 	desclen = strlen(desc);
+	if (desclen > U16_MAX)
+		goto error;
 	quotalen = desclen + 1 + type->def_datalen;
 
 	/* get hold of the key tracking for this user */
@@ -820,6 +822,7 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 	const struct cred *cred = current_cred();
 	struct key *keyring, *key = NULL;
 	key_ref_t key_ref;
+	size_t desc_len;
 	int ret;
 	struct key_restriction *restrict_link = NULL;
 
@@ -865,7 +868,11 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 		if (!index_key.description)
 			goto error_free_prep;
 	}
-	index_key.desc_len = strlen(index_key.description);
+	desc_len = strlen(index_key.description);
+	key_ref = ERR_PTR(-EINVAL);
+	if (!desc_len || desc_len > U16_MAX)
+		goto error_free_prep;
+	index_key.desc_len = desc_len;
 	key_set_index_key(&index_key);
 
 	ret = __key_link_lock(keyring, &index_key);
-- 
2.43.0
