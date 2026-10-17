Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D78435A3B1
	for <keyrings@vger.kernel.org>; Sat, 17 Oct 2026 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792250502; cv=none; b=GXG/V/mStKEiVJs5MyoOlzToa1i6MTkg0ort/MkYWMe1aOfrrTmr+W+L14iP+urSAH30klNUblBNlhrHKsORJh8G267ndPw8OYmBZ+sTEzHmB0w0miJBXrE+usrjpGv63+wLtJ/QQcqSevs5b8qXnM+X5EgvEgpZ1L+WYh876T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792250502; c=relaxed/simple;
	bh=mmkEj2/6FluSuVa6kOpFI+95vVAVdqDsent70A21+zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgS4FQcnkAmzRz+lsxO6rfGCCHot2bMIa18r7NaJtXKwlH1FNwIC0QygKNOXID4DuezICHg6adnA9iYDajrfrwKO0dvMQg+zt4uc1Xde+y4aK9XOGKaDoOas7nlEMnoQhDKkPXNxxDd28XWCK34GxGjhjpf/dbl8cj+oXva6tBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/og+7vw; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/og+7vw"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ac77270fbfso507079a91.2
        for <keyrings@vger.kernel.org>; Sat, 17 Oct 2026 08:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792250500; x=1792855300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bHLEUnpsV2P3ynQ8MKirB0DKPzZUp3tF3QyWRet8Yzk=;
        b=E/og+7vwzpPF1cy2RTRCcS6f0NnfQ6gmDiTk5XOEiRIHyz3R0W8YXMC5PHQtS2Lmhg
         RuKXapg42VAU1HUyTDSMNyUJL9CZhc7sJGmaX2DFZLwkdDvAm8gDsc11Icci3URXOVhl
         +WuSLPq5CmU52fZpZpb/hmAUft+EagOsBfiEyy9mRIYbAeZ7owUmcxPvKB+eFVqn16FQ
         CAVH2ZBLhsEM5aJpIODrOu2MAAN7VHWdaeGG68CGZemrJ2biKOSpCT+b+y7wRmZhT1a3
         s4dhXKiAYLNoRx1imsrvm0qxZVbbXA6qFzDWOqfcepG+pObA1y9ImQplJnQ9KEajOwDV
         q4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792250500; x=1792855300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bHLEUnpsV2P3ynQ8MKirB0DKPzZUp3tF3QyWRet8Yzk=;
        b=YGmhLdC7TJqwEHcwdZR/5dSDsREowspMdWLWisrCJgdKLWPAW/cmy3mqIiOsTN8R0i
         cXuNz7lF5/ZSpQw8257udu0uVtgALuHYYIhqMMJ7fCIz2khcKNwHUNe/MiXqkSsAyPaS
         ibz/PQO8p4ELfA0ZiIQVxgZpdd4F0YvCRyWgc/BDtgXMVlzVVvz7AdaKNQMbFGn9wDSi
         N7UykfhGROy4L13MC3lYDMQfcyonSAYNXYX6v7KgHpDFqMJNwhtCOotFEJrgXxdJek3e
         VAVdzInOui4igavX1rP+6Gpu2lUe/zyBNDULy/vbb1xngk0068ixD3+ZSp+i1V3GXd1q
         qjTg==
X-Forwarded-Encrypted: i=1; AKwUvBw0LMI8rL8W6Rre+/eAM//Fz/5sZxAcLnHgiDbxVQaGMuSVO/+DcAqJrLTfJ16MdwTlyW1ki4FAvQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJPojdhikgVPv2MW4PJdB3QNvf9JJLPHNQH9EIetvUPKfWLNRUY
	e0VKl/NbnYrodeMk673C/JzGTQOPaxBDd/dStulrS1Z5qn6Oov8ovE/t
X-Gm-Gg: AYBFou2h+kY7EssuMqx7KYgKA+YZ9ChSrn9J3K2yRIHeTYmuxO1ZymLzqCSWfRyLtML
	4cVgjVW/goLHrWE3gtAUTIK18WJDzLiVDYS1eNeUmks6s+dc8DEFgZhoNnYRuvq5lJrffAGMLmg
	Ci0ZJxypy8DXkBu9MGjh3jK3snf7gShTNxOqvUgN34R34McrPZnpQpvtEAVEyKg9C2wnjJXNZ0t
	Wa+M9MN1BiSYNyN88neLwIb9cqZuknmE5hqHN1iAhRVt69iBWZ/BTIM5ip8ugZpvf5OpKQZXHIS
	UzvppTSB+VAIZWX16d/Si3hdnNdh2XDxJDd3AmYDT9xT+7NZTP8vGtGvPv53cxpRvF5+au3I3TA
	E/YsMqeywQP4q7Y298Gvfv5rfhFSNjHACr5CuAIR4+WLMiNm9eOvnZEP0n3bFR/5mR+E2bznarz
	E52W5YxGixMtDnozvwmwH+fPCplQ7ZNk3pat89cSb95m17SFC/WbYyXInfmK3lBlmkzhb3/0K7P
	Tngu1871so=
X-Received: by 2002:a17:90b:4b04:b0:3a8:f70f:2437 with SMTP id 98e67ed59e1d1-3acef52ae13mr2520951a91.50.1792250500220;
        Sat, 17 Oct 2026 08:21:40 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc48f19d9sm8511142a91.11.2026.10.17.08.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 08:21:37 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] keys: big_key: Remove the redundant quota reservation
Date: Sun, 18 Oct 2026 00:21:23 +0900
Message-ID: <20261017152123.1200429-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <atK186hMPBhYyPCN@kernel.org>
References: <20261016040004.324286-1-4ncienth@gmail.com> <atK0MnGM2h9IH6FD@kernel.org> <atK186hMPBhYyPCN@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A big_key is charged a fixed 16 bytes of key quota, regardless of its
payload size.  big_key_update() nevertheless reserves the new raw payload
length before destroying the old payload, and generic_key_instantiate()
then reserves the fixed quota length.

For an update shorter than 16 bytes, the first reservation temporarily
returns quota.  Another key operation by the same user can consume that
quota before generic_key_instantiate() reserves it again.  If the second
reservation fails, the key remains positive after its old payload has been
destroyed.  Reading a buffer-backed key or revoking a shmem-backed key then
dereferences a NULL payload pointer.

On a KASAN build, reading a buffer-backed key reports:

  BUG: KASAN: null-ptr-deref in big_key_read+0x110/0x310
  Read of size 64 at addr 0000000000000000

Revoking a shmem-backed key reports, with oops=panic:

  KASAN: null-ptr-deref in range [0x68-0x6f]
  RIP: vfs_truncate+0xa2/0x730
  big_key_revoke+0xbd/0xe0
  Kernel panic - not syncing: Fatal exception

The first reservation is unnecessary.  A positive big_key already has a
16-byte reservation from successful instantiation, so the reservation in
generic_key_instantiate() has zero delta and cannot fail after the old
payload is destroyed.  A negative key has no old payload to destroy, and
generic_key_instantiate() performs the required reservation before
publishing the new payload.

Remove the redundant reservation so that the update path adjusts quota only
once and cannot expose a temporary quota gap.

Fixes: b6f61c314649 ("keys: Implement update for the big_key type")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Changes since v1:
- Remove the redundant first reservation instead of changing its length,
  leaving generic_key_instantiate() as the single quota reservation on the
  update path, as suggested by Jarkko.
- Verify full-quota positive and negative updates separately.  A positive
  update keeps a zero quota delta; a negative update can still return
  -EDQUOT before publishing a payload and succeeds after quota is released.

 security/keys/big_key.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 268f702df380e..ef707f2a81a98 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -193,12 +193,6 @@ void big_key_destroy(struct key *key)
  */
 int big_key_update(struct key *key, struct key_preparsed_payload *prep)
 {
-	int ret;
-
-	ret = key_payload_reserve(key, prep->datalen);
-	if (ret < 0)
-		return ret;
-
 	if (key_is_positive(key))
 		big_key_destroy(key);
 

base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
-- 
2.55.0

