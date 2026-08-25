Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA253314C3
	for <keyrings@vger.kernel.org>; Tue, 25 Aug 2026 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787682003; cv=none; b=jQQMuOa6yFSL5bcoW7FmPgyvURBByBpdOVu8Wh3u2mWzJRVq9eo8VxnmojPOpxgCdEPHecfKveXeb3s9M+0V/nE7gbWGXbifu+77T3DR8y7p9VsGg14QDCzuiTLkAxYIczqEOhCElfYT5yzKl08xJE+FBELiaVByM+m4TKdIkDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787682003; c=relaxed/simple;
	bh=2LHAtjESN6S66Bv21aGOPHTI3dmXGbwU9JZCPapdB0I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m1zDgLG+Tfx7iAYEkHE+u5DD9/M+4NtG3rLj8DaZmNlQHWPCwIRKz+86rx4ihdswIZRj6gbT6McAOaWUDmDNcvkxKgSZ/fDsSDHpo96BgD3E0DrCmZLziKTilnM7wgIteTXxkOWtDOWYsq/wm8AIXZQfhdVR5LeNQ0noMeGJI7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMpgI9sG; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMpgI9sG"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cf50c6f235so2334945ad.0
        for <keyrings@vger.kernel.org>; Tue, 25 Aug 2026 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787682002; x=1788286802; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0VdoKFgGtyQlCKk61/VSjfvx4udEVyz2pZTOZw5/z+M=;
        b=DMpgI9sGJclX1xxeKPjHbtMyCOmhACBIszC94dwo5H1v+4wBqn8ST2m+ULyt2zGtC5
         BRtdlXBTEaOrVnwDZlPQT7smUYgjQYawCRY8wXzpC7aGkxwZLcjpkWLu2wrHHNEnNcYV
         OkmTGymwruXEbdOc6fDliAogswzipPLNuaJXeAXfYW4IPMsEYStBxI44q7s3vkuC8ph9
         Ia95U9lYsXjm3buFcznQLc0lSsadhnvSEoc+t/k78tWmrgcJVHkc6tG3U+YtC8YHNlbu
         DJjlDqweDSp1yNXLJaSGojHaNW1WdYnJ2vjjeV+ThKBsnJuBho8k8l5/A2iH0CTjGVdv
         O/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787682002; x=1788286802;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0VdoKFgGtyQlCKk61/VSjfvx4udEVyz2pZTOZw5/z+M=;
        b=G9PJNAJG+XdtbXa0ItkLlSEhxdoqMxw8gKVNn5tYrCOOz1LHrN/HSiBgwwgmr5yOs8
         PlQOuymtgFCh+bnwnIjG8CbKzte7Lh0Bk2lSN00pjwPx3jPcCFQRiWonXReOG1EwDwrV
         pQgHMoUx2FZZQb9HOkzwFdzhJSOAU6yIxgLUED/C9O92CYC58KSwFv2GiKnLY+lD87KI
         9qeyHsxqHtNE7VGs+wcywro9UQ/70lAR76V2rfH5DdiYTUiYnzP209fBan+mmljKw6zY
         Q9Gr8ceJ7VQv6VVrJXX0L10azX4LL4pP0sVA5Hi3HKK6ysFY2tR65NhGsdythPYWKnYT
         /igw==
X-Forwarded-Encrypted: i=1; AHgh+Ro/sjxWqY7q8Um83791gK5hRsNmbg43+wCns/GpDOVHEIUfnfSSQFUWAeuYcfR9SooWdWj9/CZ4fg==@vger.kernel.org
X-Gm-Message-State: AFuF++ny6UzzCi/qA1mXRo9E9wF/C5Hpt+TdYhSjRcxiehNa+zE4aWxg
	Nu5vH3qD74t8WC1ta84UCP3eka/+Z9royDg6m2olFaInFSmhHc6dbdcf
X-Gm-Gg: AR+sD13kOJ7TruTthzQxnb//Jkm1jz66/vQKMDCN31HMzJdWw99SJrikbfBzIUvyVtG
	SV2NqGWhi9csYaHxcxTpeAy4sEGpB1dkjVz/+bjbTCHgFIUBp1JV+koZTi30KDCowsCy+fkVdBK
	kRO7jIjCOtqVcaPoINl2JopSgBoOChrq8t3uDARpEIdWD7VcegsCTZozjH0LMry+QEHYdBwEqE1
	er+GqbFQxKXO5D80cozxnZcW6lWdqwt7Pg0DDxvQt34h1P9Uq4bx89tk52aGnn2vlZyM7Y3pX8s
	05+WUpSQ9EgEjNGy83UlX/qo/2n3Bl3Gbee7BzyscXxhZX6NLDcJ7W86Vala1wySx3DNbTBXegG
	txj9e+CBy6+RqeNpX+8Hilgt+gO56LpEK9C3/vfWFNdvPI+1CWxPcbO9pfz9wrwbKJf2eqfMLnz
	7oKv+h8qGBvX40w6j3XDewJ8PJKBoRJocGeyfqHn33Kg21qfjrnRxRU6/4WceYvH1EY50ZP4lNZ
	O5ClF8SEzNFwUAq7jt2dVKRnArY43fYMHM1el6UEN2khcRj5SOI/Dsr9Fxy2lu1MbsWFA==
X-Received: by 2002:a17:902:cf0e:b0:2d6:fea6:fe28 with SMTP id d9443c01a7336-2d707a8eb67mr2980285ad.4.1787682001776;
        Tue, 25 Aug 2026 11:20:01 -0700 (PDT)
Received: from MSI.localdomain ([157.20.184.42])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d60c291sm1480549eec.6.2026.08.25.11.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 11:20:01 -0700 (PDT)
From: sn0x-sharma <sanketsharmacsec@gmail.com>
To: jarkko@kernel.org
Cc: James.Bottomley@HansenPartnership.com,
	zohar@linux.ibm.com,
	dhowells@redhat.com,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	w@1wt.eu,
	sn0x-sharma <sanketsharmacsec@gmail.com>
Subject: [PATCH] keys: trusted: tpm1: add bounds check in tpm_seal() before memcpy
Date: Tue, 25 Aug 2026 18:19:53 +0000
Message-ID: <20260825181953.15566-1-sanketsharmacsec@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tpm_seal() computes storedsize from TPM response fields and passes
it directly to memcpy() into a MAX_BLOB_SIZE buffer without bounds
validation. A forged TPM response can set storedsize to 4086,
overflowing the 512-byte blob by 3574 bytes into adjacent slab
objects.

Add a check that storedsize does not exceed MAX_BLOB_SIZE before
the memcpy, returning -EINVAL on oversized responses.

Reported-by: sn0x-sharma <sanketsharmacsec@gmail.com>
Link: https://lore.kernel.org/linux-integrity/
Signed-off-by: sn0x-sharma <sanketsharmacsec@gmail.com>
---
 security/keys/trusted-keys/trusted_tpm1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 8f57c6111..d47cb7108 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -531,6 +531,10 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t keytype,
 
 	/* copy the returned blob to caller */
 	if (!ret) {
+		if (storedsize > MAX_BLOB_SIZE) {
+			ret = -EINVAL;
+			goto out;
+		}
 		memcpy(blob, tb->data + TPM_DATA_OFFSET, storedsize);
 		*bloblen = storedsize;
 	}
-- 
2.53.0

