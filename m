Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB54E336EF8
	for <keyrings@vger.kernel.org>; Tue, 14 Jul 2026 11:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030100; cv=none; b=pj7/2YNsoRf1u5R55EorhnkkEKmubq1hWSTYWh0ApQPG1+l//QEQRRh7BTXG/F7BgieTKHs2JrDTGtqKAcKKh31ufaT4yESz4tmG0pPBE4b5cVkXkMRnOnn7H08IoUkTLjG0dbE9MtKpJCTzGXJBNqAIJ4EUe34mPGTFvRuGbsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030100; c=relaxed/simple;
	bh=9RRZcFgrtBWsMm88TekPA+n+ES8ipoI28R2xVaJ1owk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YtOgphM0K6LAcaYqJcxlCTxFaKkbfzGBljxQG+dgZehslLTVIgQHQXVjPOCxV9wBUShFrcwKuZ2EaCdWYRIzIhgpNsZ+n2wi4tHrOhoQ1X2ln+dfMciGaElaV9EyoqQGRN06R118CDsdKPwyJ7RNRoE696rpPYmfRruLQlLxb7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpClXGEf; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpClXGEf"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8efcef23d21so38707696d6.2
        for <keyrings@vger.kernel.org>; Tue, 14 Jul 2026 04:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030097; x=1784634897; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qTYC4WZ/uNDWSHxkWtJkYAaxtQ+BheOgFcuFhfNnJxk=;
        b=gpClXGEfxfL7j2nFBXqFrw0r99d9aHViGFW9h2OF+0ObBXOMJrajp0tORuZ34Q2iJq
         l6/G99oDTrxrphhEYPQm5kFN8odf8T/9xttT7kjhrqbLqbL/sIQZaK/+gLbYCnCpaQRg
         209Di8tAmiouJhVJBhMzDNGgyaHsXapJ/tuThpLX3QpjJTYZew1vAImSNuyKC9iqf7Ok
         lZt2zoHLiWmZ8YDKbZ8AohszsxwSybYtQQXVVNfeGYUNfOBhXPz9ZGvNhRztkuij5k0U
         y86KLuMhrutMFql276OFQ50pssoM7SLeZG9ndO6TFFQ/qITo7WzPLTHdeSywor7W7n88
         AGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030097; x=1784634897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qTYC4WZ/uNDWSHxkWtJkYAaxtQ+BheOgFcuFhfNnJxk=;
        b=odiS6xE/JA/dJ6pvZw+axupFp84UX/4/QX1RfGO0f/3zDGrARY6VVH2pKVPVx4v5h9
         5yT6LOFsy0qWRGDT4Dnue68xPZ+s3fJFX/bd9lD7qMt5D2XNNfidSIodFJik9lUjrcos
         CYx89873j6oG3NkOnAHCZkH/I1QGpCSLQVRqlLnKNu3YQSg8cPku48asJFFiqKePqaKx
         xdQTfcgfPAquLRSFM8mrkjZk1ORCAaAaZxVnmzewlbfII3tB7ZJFS/DZ4LyfgIuEPwEC
         ZAlQAM3XVK+zb9XwinwSZYtRLiyWKojAXVlSgmAn7+IZT6M7JWgcUeU70mA8aHY7ml0N
         2v0A==
X-Forwarded-Encrypted: i=1; AHgh+Row2L6uE6UQOJ/SYBbO+zbv/d/GjIenUIwOqnc0TeDH7ij0sSdFF1rFUcIIg3yAxOujRHRXTFNKlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzU6E1yIN86N9OL9qPiEREt0YTtXoMauIr07dS6ZDJ4yNmXraAI
	Rq9rPv80TNhgVoB+OUU934vI8CEfWsE8Sb6VfxLP4D/sgS498k0+k1PR
X-Gm-Gg: AfdE7cn4FMyUOyYMqZPiEYvytsLEy6mcwb1gZcmdexo3tTM1ddVjsFi/osAWq3E5WXr
	eT1592fBZx5CaVkktjtAKRTokqeR5KZ4E/Wbq2V3/7Nh77V3p3LDjyHPPH3ys8LLZxL5Xl01CkB
	vKWcF00tdhJMRiJiA3TRlSpXeFChglb0oCOOIAxlYx/LSrjqwM0X8u7EHXyqZnw6cGoz4F5cmY5
	JJbyntil5lGcbj58j4WjcLdcluZ6uZnz7TL9S1eWn8LkdvecJKZaxSze4UPMAZLgnFvz3kaMBOP
	rgeNQpXTJzV2UEL0i/FDHgHAgidPqA15tdo/iTcYuFW/S43Q7MDhcSLhjzjnLX0WsT3Oh15J/Zw
	vlYXfFnP2y6tM/bGphPp7Bkt7fNHFS4PSFO59n3L3TMSH3+MU7ApkchXjAuO82YCGp9L70/rwFv
	eX6cL70aKhWMFgXiefncNfQi745fWTr/P2y++YCxjv1dGnnmY1E8ZIcCygDbC5jYY6kb1SJRIwt
	YyOcdnCmg==
X-Received: by 2002:a05:6214:21e7:b0:8fd:6de3:dd7d with SMTP id 6a1803df08f44-9074c8b3fbdmr17351196d6.63.1784030097559;
        Tue, 14 Jul 2026 04:54:57 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fd492sm185100576d6.34.2026.07.14.04.54.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:54:57 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] keys: make keyring key-chunk byte order agree with keyring_diff_objects()
Date: Tue, 14 Jul 2026 07:54:50 -0400
Message-ID: <20260714115451.3773164-3-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714115451.3773164-1-michael.bommarito@gmail.com>
References: <20260714115451.3773164-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

keyring_get_key_chunk() loads description bytes into the index chunk low
address first, while keyring_diff_objects() numbers the first differing
bit from the low end and folds the absolute byte index into the level
without removing the inline-prefix offset the level already carries.
The two disagree on byte order and bit position, so the array can be
told two keys first differ at a bit that does not differ in the chunk
the walker uses, letting crafted descriptions collide into one node.

Load the chunk in the order keyring_diff_objects() assumes and drop the
inline-prefix length when folding the byte index into the level.  This
only changes the in-memory ordering used to place keys within a keyring;
add, search and read of non-colliding keys are unaffected.

Fixes: f771fde82051 ("keys: Simplify key description management")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 security/keys/keyring.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 1739373172ad5..e7066893e6ffc 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -292,9 +292,10 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
 		desc_len -= offset;
 		if (desc_len > n)
 			desc_len = n;
+		d += desc_len;
 		do {
 			chunk <<= 8;
-			chunk |= *d++;
+			chunk |= *--d;
 		} while (--desc_len > 0);
 		return chunk;
 	}
@@ -375,7 +376,7 @@ static int keyring_diff_objects(const void *object, const void *data)
 	return -1;
 
 differ_plus_i:
-	level += i;
+	level += i - (int)sizeof(a->desc);
 differ:
 	i = level * 8 + __ffs(seg_a ^ seg_b);
 	return i;
-- 
2.53.0

