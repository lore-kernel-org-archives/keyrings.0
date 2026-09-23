Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EED940B6EF
	for <keyrings@vger.kernel.org>; Wed, 23 Sep 2026 17:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184917; cv=none; b=qufd4pchAyq9i4oYV81HIC3SiD2Uv92z1KD+nJIKNtMd9oDaRv8Bk3VZXZWPN8x+OWtf6YMN2iJXKpyrMhc9yhC4YZDfIkGvhvsGbpN923jW1MzzgdkL1QTzCFBrBP6KvV9aNEHbE+6YkE4tOFAyVOwaWzMyUefPpcriG/RChk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184917; c=relaxed/simple;
	bh=EMiwijCSi9gVRyUeRj2kGmZadFEy+BUHc+JcXjP3tuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bHtrvcMbcQzfeHxUmjaW7cc+pPjzywacG0nRsi8JttMArmeJmRxjpCdfQv95dXgzK8QmV0Kzx5WuHMC74MqpN0izjHHaFBcJCNNCz1Bdp1zaG3zZ+VnTPjl0C+pK7KkuKY3D3XWr/oVU8/MkialeRuOjDV9iWsYKJkXAyypmXOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h8KrrFVw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AkpsI+tn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h8KrrFVw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkpsI+tn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790184913;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/r6AwuaWI+e4d7iGoKYDG/9yrPmbnqwvnnzXS2lDObo=;
	b=h8KrrFVwXB1kuKfAG2d33cG/GYsn939nIdUPfbw84F4K1IT158i/FyZ8cvK5b8Zk6NSwPT
	pnuvcyVZCRaNB9ZO8yMzRQkPri7AWd8mLWUlG39ilZnseMYJ4C5HeJIOfdE1Akjo4zEGJF
	CT/5kUUF7JlYeHavRlPt0vam12J3MeM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-zDVVQ-gKPuu3OXRUcqqPjQ-1; Wed, 23 Sep 2026 13:35:10 -0400
X-MC-Unique: zDVVQ-gKPuu3OXRUcqqPjQ-1
X-Mimecast-MFC-AGG-ID: zDVVQ-gKPuu3OXRUcqqPjQ_1790184909
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso8850465e9.2
        for <keyrings@vger.kernel.org>; Wed, 23 Sep 2026 10:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790184909; x=1790789709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/r6AwuaWI+e4d7iGoKYDG/9yrPmbnqwvnnzXS2lDObo=;
        b=AkpsI+tnAbCar33EsO9QJ5QWszH96Oje2QnIarK3fKSN0j7y2gnkrnDO4X4wrwrNTE
         UlcFPzyCy3xnoMOgYeCf4RYYJ9BleSbkrl5CyHSo8ItcrQA0GLXRgmztvmyIAspwrGDo
         W48a6i2CcG7lHwRK8XeFiO5/7WKa1GoBXNV9AwMcwTy7r2TbHvNlBp/SfLwG7tprlczS
         GIuZKwzRj1mVFW9Zhz4TrYAv9wd/Q9gt19TsPUaDrsZugM2ovIEPJlJ1qDHF/l5h2btK
         Y9iGKPrzI4iNxHA3HyNo4i7+aX6A2RP8VsWJDamMV4uuezZxuMkcpCNKZGoHzLc/lkET
         90/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790184909; x=1790789709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/r6AwuaWI+e4d7iGoKYDG/9yrPmbnqwvnnzXS2lDObo=;
        b=cBqaaHv7eMhweN3j1dBAKVezfodeaadCwq1klUrKRDG9Owme2JmqEGzAowDLXzuYw4
         6mPfcRSkqJb3n+rfKynr5k2jVGQB0nn1kHMz/5s7lK5gc/TULNCGcK/p7eW/Rd0EtLOi
         aDed3/ULFjYhRNcW2ugN7ejM0fJ+7B8AM0fQUPiWBweFsgwFYC+0kxvSovXbcmWKLgQb
         9QarP4wFHKhkkz7sAygYcesOGopKoTmIIqzt02ujlqdb8DL4kIFNiR/8LiFKPlp0BhbJ
         6tFZOtUF/v///LCou27Zxyjyx003EL0+giJEPm6mFg4BwVgBiB3EHl0aFSf4BeDN/ztE
         trRQ==
X-Forwarded-Encrypted: i=1; AKwUvByVK2Dis1FZhDfsoyMm/i44ENArtCGyrxb+HQh2D70SBgt7WqKAosMwiErArn8ZkRuKZpjhzoxX9A==@vger.kernel.org
X-Gm-Message-State: AFuF++lw/AviHIyQLBm71e7+dei+113gHbUkHC4+zjloXn/cViOLYElD
	VWrs4XeBidA1+6L+bAPyXgQKHpoVk/e/0hw1RZxJsv8WZ4lq96glNfQW+C59oOK2K6zz6zspgOo
	rUxWxwBB2RxTBY0k/M9jtiuNdM1/dl3tlF8DzQ/Lh7agWSJ5x1JJPiK8hrrAa
X-Gm-Gg: AYBFou1e9tCd2xXsj35cXnCFKIyAD84IfIYrRgQZK7PBeV47JxkbwPysdrGNTIMde4u
	6YivnSxezUsUn3YbC0v9gZbWXh2rYfZiHbYl0H1tP/Jkq64VOi4J8s9fs4WeKQSbpa88Mnk6eXd
	tanTSXmtnFK4rieQj2/4EGCWNIYUhetxJ8osv/yEffFpvwNZOJNchNKV8WADcjY7zN9NjT4OtmN
	8M+4bCbeZtuxMR71jZ2hRguRTn7dpKZv4h6+0QgeBeGiNrpKgLH3ehw2T51ixcLxzYie0dEffAj
	v+9Wf0Fi/ZWuODqtxspucp3XAAcc3xUnrnCEBB+6IIoUZxZZ7uz6Vnw3fB5ZjMua6NqOvvsf5Wl
	d7TeNJylh831jYXCjKxBHeV71Qo6gyecOM5By68m56yigmNs/W/hNdA==
X-Received: by 2002:a05:600c:468c:b0:49c:fc6c:be06 with SMTP id 5b1f17b1804b1-49fdf15a3e6mr54024025e9.29.1790184909125;
        Wed, 23 Sep 2026 10:35:09 -0700 (PDT)
X-Received: by 2002:a05:600c:468c:b0:49c:fc6c:be06 with SMTP id 5b1f17b1804b1-49fdf15a3e6mr54023415e9.29.1790184908631;
        Wed, 23 Sep 2026 10:35:08 -0700 (PDT)
Received: from stex1.redhat.corp (host-82-53-134-131.retail.telecomitalia.it. [82.53.134.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5dfbc0csm1404045e9.13.2026.09.23.10.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:35:07 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Paul Moore <paul@paul-moore.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH] KEYS: trusted: Fix blob allocation size in tpm2_key_decode()
Date: Wed, 23 Sep 2026 19:35:06 +0200
Message-ID: <20260923173506.41519-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

tpm2_key_decode() allocates 4 bytes more than needed. The ASN.1
callbacks tpm2_key_priv() and tpm2_key_pub() provide the lengths
of TPM2B_PRIVATE and TPM2B_PUBLIC, so ctx.priv_len and ctx.pub_len
already account for the 2-byte `size` field each of those structures
starts with.

I noticed this while reviewing commit 114f00d738f1 ("KEYS: trusted:
Fix tpm2_load_cmd() boundary check"), which correctly reports
ctx.priv_len + ctx.pub_len as the decoded blob size [1].

Let's allocate exactly that amount, matching the data copied into
the blob.

[1] https://lore.kernel.org/linux-integrity/apfoKo-BdwaLXtkT@sgarzare-redhat/

Fixes: f2219745250f ("security: keys: trusted: use ASN.1 TPM2 key format for the blobs")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 security/keys/trusted-keys/trusted_tpm2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 01f18bb37047..a9b8a31a637c 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -115,7 +115,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
 		return -EINVAL;
 
-	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
+	blob = kmalloc(ctx.priv_len + ctx.pub_len, GFP_KERNEL);
 	if (!blob)
 		return -ENOMEM;
 
-- 
2.55.0

