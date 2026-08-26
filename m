Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DAA30C146
	for <keyrings@vger.kernel.org>; Wed, 26 Aug 2026 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787759102; cv=none; b=OxxOuuGmkjJwPlROnnhV0rg2bgWdJ0MuqoeWOCVqO3pSrKOdj+lUTYof/vHGaNequWPR7l3bEPsfd3pl0l6wIE/IrzBRdG4O9/+im0uzuW4T9uVJ/zYJnoA51OKllWh5xDn6Mnx5qze1Pb9g18gZd2xV33LTwwolsy3pQreCaiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787759102; c=relaxed/simple;
	bh=Wpda8V4mB+G1v6M4jdRqgjIHcIik2OOufAHm4b1jPHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vGZ1Zl6EUlMtjpXauVZqQM9yCrBOvs0yLKIuOhuSfPc0RdkIhLO9yF8QxP+WmYDV7LtsxqI7pc90yGdTBEcuWlPBL8oaCfI9a5vYvgOjOa/eFiJ0kBWkgBxu78bnqNxB6HwN/TssgHFaxUfzCamKN3SbvEd52S6Jm4chaXmKyHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qk2CaZ9U; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qk2CaZ9U"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-836c91bd782so19340247b3.0
        for <keyrings@vger.kernel.org>; Wed, 26 Aug 2026 08:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787759098; x=1788363898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6lCs31xrtlUjQWf/CteVcVdyEY/EdqnqYRaq66tpHgs=;
        b=qk2CaZ9U0gqkZ5PqCfbI1b58hD7WoAkTG+Hqyn5puILDvhvskYa+qQQSPrDd9RMYyz
         gPvNbKN1tu2wdGA1bi7r2LPNIzFQEaTFQmoOH+pcqcwfVQYevTjeTBH3uI7vUj4fbWcg
         3G9uJkaIPTY0tK0GRGPnz6z0+LXjAV/S8Lj1s0Zl8EVU61cRexoqf0QyYJ+btMD1lgty
         i2PQU4380rdTyJk3hMtrYKkhRZCxGF3C/+02Z1LhlK3rWVy2Fpsrt2kxq91tYVCd2WxU
         qC62FAxt+jm3uApTkR2CVdk4ZutNcXAE2q/o6YBjHZQw7fB2nMvRnC5aeiUrc/nOyxa1
         vpwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787759098; x=1788363898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6lCs31xrtlUjQWf/CteVcVdyEY/EdqnqYRaq66tpHgs=;
        b=q5IXZ6jWSUyAUAs2NzGyVISzqjrc7Nnh7xyuysgRVcxBTuX9zMNBY4jIj61EUxL44G
         ZXJLKlWvVlnAAgzr2oLNC/LRtfUJ2wVQys1qeOfTotRJ+//8onN4IeLqaqEsvUtFx1o6
         uHLOUFB9gkyEgLp3B4rzv5i+BQ3JthWqrXiIf9aIppA3NCQmgtt4k+S7J1cmmmqLX8SV
         ac7tH6iq2354YPqLfkdtfcCDE9QxQvLoPY4ccyxABCcGDpkmqkpHUfPzhNxNYzSqXsyt
         y08I9EeDKNFaHjI7OaesIZL/x4S0uwJe2u6ZpPcQxZNxHW3PNuNeYVxaVCB1EC9hJFfo
         UhRg==
X-Forwarded-Encrypted: i=1; AHgh+RpsLtzjPXXEKpl8QHf7rAEeoYloyiReDvn5jWVHGtuHFGqvHLAlEE9YHHNVINtRDePbzXBWMkiMlQ==@vger.kernel.org
X-Gm-Message-State: AFuF++k3YskC2N/t9/sMDNcQZl63A9haQVt5akvGg4uqq/kQ6QyT6wDw
	bJJV8EDfGTkz0r9xNTX1PfVRy5Mxo1f/gXD1p8dnc+FEMb7iwKvx81no
X-Gm-Gg: AR+sD12saKdTlpjqtiiiaTwx7xiKGdAPjtVSouikIToswFlZUfuOnqBLkv2AjCW6LBy
	DV8z/56P7muAt3ObyG2SnSgO3BzKflJfSUUe7/vi8a87gJWOG4O7yawlaJzg2XN7izzSHYzvlSL
	/wx3oyjCrE3Xu+1Fp92raNjqB14qzdXvVeAdzZxhR9ertOC9N10V1F9GMuA6oIfU72S4/iq7AAl
	ixbt/VmHQH19fytuIeHKeY0oH/yeEzvyhu006Ckz77bsPALqxdiDoP7tf+8fQKrvft2sdu8iJtF
	8DX82WcAtI+Tlt56XEeQ4WbLNsJMPVeUNypiQPkFrY/1N/YhzZJnlehG3WBX28XbxMKoIfZhIy2
	+E/7HS+zccc0/RnygKP1nEhIzhG/+hzKB50GBq2rB+g36K/clmbH/XUUDtvTQw84m4jRcxdw2sl
	rGY8LX56pVHryOOGZX1W88tE8aHiEGIxsA5nlTLZzmMinv66kxSxubQFZHGHTN1LPh/rc=
X-Received: by 2002:a05:690e:1b55:b0:66c:e3b6:40c7 with SMTP id 956f58d0204a3-66d2580c8aemr2153868d50.47.1787759097975;
        Wed, 26 Aug 2026 08:44:57 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8570dfcf578sm18285107b3.47.2026.08.26.08.44.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 08:44:57 -0700 (PDT)
From: "Cen Zhang (Microsoft Security FORGE Labs)" <blbllhy@gmail.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Roberto Sassu <roberto.sassu@polito.it>,
	David Safford <safford@watson.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kees Cook <kees@kernel.org>,
	Francis Perron <francis@akrites.dev>,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Akrites SIRT <sirt@akrites.dev>,
	AutonomousCodeSecurity@microsoft.com,
	Cen Zhang <cenzhang@microsoft.com>
Subject: [PATCH v2] KEYS: encrypted: fix integer overflow of datablob_len
Date: Wed, 26 Aug 2026 11:44:56 -0400
Message-ID: <20260826154456.85974-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Cen Zhang (Microsoft Security FORGE Labs)" <cenzhang@microsoft.com>

The datablob_len field in struct encrypted_key_payload and the local
variable in encrypted_key_alloc() are declared as unsigned short, which
has a maximum value of 65535. The datablob_len is computed as:

  format_len + 1 + strlen(master_desc) + 1 + strlen(datalen) + 1
  + ivsize + 1 + encrypted_datalen

An attacker can create an encrypted key with a very long datalen string
(e.g., 32756 characters of leading zeros followed by "4096", which
kstrtol() happily parses as 4096), and then update it with a very long
master_desc string (~32760 characters). The combined lengths exceed
65535, causing the unsigned short to silently wrap around. This results
in a grossly undersized kzalloc() allocation, and the subsequent
memcpy() in __ekey_init() writes ~32KB past the end of the buffer,
corrupting adjacent slab objects.

Fix this by:
1. Using check_add_overflow() to calculate datablob_len directly into
   its existing unsigned short destination.
2. Checking the total payload length the same way before passing it to
   key_payload_reserve(), since key->datalen is also unsigned short.
3. Using kzalloc_flex() to allocate encrypted_key_payload together with
   its trailing payload_data[] array.

Fixes: 7e70cb497850 ("keys: add new key-type encrypted")
Cc: stable@vger.kernel.org
Assisted-by: GitHub-Copilot:claude-opus-4.6
Signed-off-by: Cen Zhang (Microsoft Security FORGE Labs) <cenzhang@microsoft.com>
Signed-off-by: Francis Perron (Akrites SIRT) <francis@akrites.dev>
---
Changes in v2:
- Keep datablob_len unchanged and check both unsigned short bounds with
  check_add_overflow().
- Use kzalloc_flex() for the trailing payload_data[] array.
- Correct the attribution and sign-off trailers.

The initial version was discussed off-list and is not publicly archived.

 security/keys/encrypted-keys/encrypted.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 59cb77b237b3..e07092ea301a 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -19,6 +19,7 @@
 #include <linux/parser.h>
 #include <linux/string.h>
 #include <linux/err.h>
+#include <linux/overflow.h>
 #include <keys/user-type.h>
 #include <keys/trusted-type.h>
 #include <keys/encrypted-type.h>
@@ -579,6 +580,7 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
 {
 	struct encrypted_key_payload *epayload = NULL;
 	unsigned short datablob_len;
+	unsigned short payload_totallen;
 	unsigned short decrypted_datalen;
 	unsigned short payload_datalen;
 	unsigned int encrypted_datalen;
@@ -632,16 +634,22 @@ static struct encrypted_key_payload *encrypted_key_alloc(struct key *key,
 
 	encrypted_datalen = roundup(decrypted_datalen, blksize);
 
-	datablob_len = format_len + 1 + strlen(master_desc) + 1
-	    + strlen(datalen) + 1 + ivsize + 1 + encrypted_datalen;
+	if (check_add_overflow(format_len + 1 + strlen(master_desc) + 1
+			       + strlen(datalen) + 1 + ivsize + 1,
+			       encrypted_datalen, &datablob_len))
+		return ERR_PTR(-EINVAL);
+
+	if (check_add_overflow(datablob_len,
+			       payload_datalen + HASH_SIZE + 1,
+			       &payload_totallen))
+		return ERR_PTR(-EINVAL);
 
-	ret = key_payload_reserve(key, payload_datalen + datablob_len
-				  + HASH_SIZE + 1);
+	ret = key_payload_reserve(key, payload_totallen);
 	if (ret < 0)
 		return ERR_PTR(ret);
 
-	epayload = kzalloc(sizeof(*epayload) + payload_datalen +
-			   datablob_len + HASH_SIZE + 1, GFP_KERNEL);
+	epayload = kzalloc_flex(*epayload, payload_data, payload_totallen,
+				GFP_KERNEL);
 	if (!epayload)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.55.0
