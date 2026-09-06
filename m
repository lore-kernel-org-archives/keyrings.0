Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578C4CA6F
	for <keyrings@vger.kernel.org>; Sun,  6 Sep 2026 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788692535; cv=none; b=hekZR4NvTAGfG7ALFbtiU4ij/RXt4YU4bi1yX2/JIGk3nZVHTpFyXFQwKTk180a56RDQLpnrOzd+Zoc6jBgcTCqdhQorvxJonnFBW7XVbmonllWDfbE/UsOyJr1pp5qEyd+UaIB2kReXt144CbDpywqFGHtG5I/yHl7xn9B0rvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788692535; c=relaxed/simple;
	bh=xjHNZdArQMCZb650b76E3RrOioBC8s4U6npUhtP28jk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uiojRvS01YXm+BnLxalNVI4GotUgrfrjny5anB5+n+SmqW8CBc+Soo7+f34kv1PHuLdEAOQc0fmj3rxjBHr93hHl5mc2ihsBAKMLugvzdd1Q2KYLrr+bOzzATShmqXe4xTsGihGTUIQrcOe0XCKXLwSbGDqKpxqGUuQWan+tkzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iv1ANG1w; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iv1ANG1w"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-85c9a79590aso2453912b3a.1
        for <keyrings@vger.kernel.org>; Sun, 06 Sep 2026 04:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788692534; x=1789297334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zsoQ3WWbLMeracKBU+KB0eYOl3CW7WFSrJU6E+v+qnU=;
        b=Iv1ANG1wWZgpAPCr+lLGmw7SZUiypQkhxDVAFoyVJYNPZ7s3jNzNjngIfpsSRu3clH
         K0Om1YZ/e4ByFUr1kGpIpmAQcyx5WDeMunAhSQxFfaYZC7b8m6Yy6QouOaL7wiyM7Qxu
         TuQsHXq6q1qaf1vPXDyRp8Er3Y8WIgejlqsLohTVg4Bp9zoqhcJnbKq0z8dKuTo0EN7i
         hHdwLK3xSdKCcDdaBQDaLrABywg/f5wx2SuePusByIJDgHEVYLsb7FVvNxaMceCirH+a
         5dQDosqouGlEpIhTMdnq0PbpKGGX4JN4QO0qkmujDLOEzk1xqOHqilCxrFYFqcx2Xz28
         /VDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788692534; x=1789297334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zsoQ3WWbLMeracKBU+KB0eYOl3CW7WFSrJU6E+v+qnU=;
        b=PVDZUEa0pNBRaEEaXFazq72Q8gVxYqQcKIFoFKJyqatfSmLAhvMUJyPCr32z4/gNi7
         Ojjycf7F4Qs0yLWJx8W8rTdlFwz9jMEYrcJK3+/Ri8QR1C5VGQJqwm9kF3F07agxnkyE
         VW/RX1NrAY5rrGtSfcoCpYr2TpQCnDtOP5pu7EYTUw4eNvQURuxeIdqVXa76Wj/QGnLB
         0/UxJW+vTJnEuB14ezyAS/itcAhmAdgFN+ajdxhu+HSWWHxXrf/CEzT7wS6WC0rb676B
         Vfwf/8MGx06d4H1IU0v7k2KsLDygCYU7UQYRNWufIQFMAIJbSRjm/Fq175VYBS3KsUy0
         Yh0g==
X-Gm-Message-State: AFuF++lXNi3BdPhmkBWoOGzM5ZCNxx3SXhCoU4LUzHX8JhLWpqg6hms6
	WGPsnIrQk0xG+j/7MDBPFHQ0losT5RMn4PGUX14VrhkxCvY8Rlfvbt16
X-Gm-Gg: AYBFou0mt8OKqTGQfRHSqG/NPm2J3F20tBRzCDEJb/tfvXCrvRrjB8g4bl3rR6UmFFk
	wWRLdI4N4x0vuSKuHtj/2PYf57Hu7UX1iev4ffWJF8Kp45hA9FjnTfknQxVQyj4TXZUUjbASTJw
	9Pb/AXtCPeqgD/7/mmFQKZVLWc65lKKQVtSCJ4jVzWbCm06XmMRNmxrjXS1hXd+XsoHbYu8WQee
	k6BsKZMxDI9ehCWrXwW79/jLWvbGDxzvPVnBbg0prAe/FqA9sXX1SQ3W4h/ISqx/PODYQ9u6hg1
	s1TBfpBckHNFhPq3iD33wtZkqZjCq+Gq8sfJpkJVFkwKQLf/VxuPBpYYQVKc/UJ/uuA7az4ZgfI
	g765BBJih1cA/RFSTxVhLwWmGHodPaDHsoU+feWmKF9FcrApxe1GNZqVWCvuS96GrmfH5eJqL3p
	HsJ4JWU/UD6PIiHtCu/hIJNfZsn7FB7UurKx2uRRs7Ni5GdFRVRx98yKBsF2mIiaUFLqpQ2xX7+
	jxrJLGI5hvPFwuJ6zrd
X-Received: by 2002:a05:6a00:349a:b0:848:56ff:6ced with SMTP id d2e1a72fcca58-8616819d66fmr24558258b3a.8.1788692533606;
        Sun, 06 Sep 2026 04:02:13 -0700 (PDT)
Received: from 192.168.50.3 ([183.193.115.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-862810e0cf7sm2015708b3a.48.2026.09.06.04.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 04:02:12 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@linux.win>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>
Cc: keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Marcel Holtmann <marcel@holtmann.org>,
	James Morris <james.morris@microsoft.com>,
	Denis Kenzior <denkenz@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] asymmetric_keys: reject trust keys without IDs
Date: Sun,  6 Sep 2026 19:01:53 +0800
Message-ID: <20260906110152.240426-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260502163328.696098-2-bestswngs@gmail.com>
References: <20260502163328.696098-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PKCS#8 parser deliberately leaves the asym_key_ids payload slot
empty. key_or_keyring_common() unconditionally dereferences that slot
when a PKCS#8 key is supplied to a key_or_keyring restriction. Both the
plain and :chain forms reach this branch, allowing an unprivileged caller
to trigger a NULL pointer dereference through KEYCTL_RESTRICT_KEYRING
followed by add_key().

 Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000
 KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
 RIP: 0010:key_or_keyring_common (crypto/asymmetric_keys/restrict.c:205 crypto/asymmetric_keys/restrict.c:279)
 Call Trace:
  <TASK>
  __key_create_or_update (security/keys/key.c:884)
  key_create_or_update (security/keys/key.c:1021)
  __do_sys_add_key (security/keys/keyctl.c:134)
  do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
  </TASK>
 Kernel panic - not syncing: Fatal exception

Reject an asymmetric restriction key without key IDs. A PKCS#8 private
key cannot identify the signer of a candidate certificate and is not a
valid trust anchor.

Fixes: 3c58b2362ba8 ("KEYS: Implement PKCS#8 RSA Private Key parser [ver #2]")
Cc: stable@vger.kernel.org
Reported-by: Xiang Mei <xmei5@asu.edu>
Link: https://lore.kernel.org/r/20260429181629.110802-2-bestswngs@gmail.com
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes in v3:
- Drop the unnecessary find_asymmetric_key() check.
- Reject a trust key without IDs instead of continuing the chain lookup.
- Use the PKCS#8 parser commit as the Fixes target.

 crypto/asymmetric_keys/restrict.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 86292965f..0e4783ff7 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -243,10 +243,14 @@ static int key_or_keyring_common(struct key *dest_keyring,
 			if (IS_ERR(key))
 				key = NULL;
 		} else if (trusted->type == &key_type_asymmetric) {
+			const struct asymmetric_key_ids *kids;
 			const struct asymmetric_key_id **signer_ids;
 
-			signer_ids = (const struct asymmetric_key_id **)
-				asymmetric_key_ids(trusted)->id;
+			kids = asymmetric_key_ids(trusted);
+			if (!kids)
+				return -ENOKEY;
+
+			signer_ids = (const struct asymmetric_key_id **)kids->id;
 
 			/*
 			 * The auth_ids come from the candidate key (the
-- 
2.55.0
