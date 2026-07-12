Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640302D9EDC
	for <keyrings@vger.kernel.org>; Sun, 12 Jul 2026 01:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783820726; cv=none; b=VubjedcHHu7PKzp9QEz+qNZeo2msQEkagmtfwUP9ZHjwl50uYkIGxLjR7nhLEhHktd08utWFborL3uyI0yIdvfLWfMwxEQCKUhBLEfcJZgsxhOkxCd+8az92PDat6Ynb09Y5efP3ZrkMkX6YZktMnnkfrQVBuyNeAh9j17oycLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783820726; c=relaxed/simple;
	bh=sFy8qILMfAGoiLxPSwx13K37dt1NP2wewudCUNeEkv0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SOcGs+J+Nb8iwvKS1SzJfAy5LTUPKj3srQhTMWDjPx791OFjj6A4G/X5OTuPdWwa+xs0n0oIr8zpY8X6hn2nuuOY7xu+NgvO4K0rvWZbv0ubO3/y12P4A6haS4+Vfp1seRL9nvg//NqDXFkuQxWWYP+EkqeY0Y0h+JLNXj5/z0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j6eyEdDh; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j6eyEdDh"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92e6391b114so143721685a.3
        for <keyrings@vger.kernel.org>; Sat, 11 Jul 2026 18:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783820721; x=1784425521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=11Jd0nBMDXDQ7WkO7ZlkesK7aFonenwrJQKgmL3sdEM=;
        b=j6eyEdDhrRiQENrFujo0j2+rdG4Zn5kBMFrdAyZ53JJUYpa98sKBzSHSUj1AMnMNlW
         /8rJVoc1tURUkJBHWQSVxmJxnbiFGuRAJuCDWOIRHO2OXuN2zZwSEo2/O1wqOizfa8f1
         +9Zc+a/NgYroMdw4I1BaUJR5tohhPvlAnhX8BSKl5+sBcg2dgo2yv1hB4jP6MtVKna7N
         psyNBmBBq8IX9kRuYkFaU6n8VzfByyut704FnphHCT1YKIUWke2ZLNZBKhUNFqnOEj9/
         wa+2FDJ+JqrfH0Ks2yJVMwOvKbA+5T/lbo+BQc2wOf4Rhka4BJC0kAED/DwsPHFAQJIQ
         ShRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783820721; x=1784425521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=11Jd0nBMDXDQ7WkO7ZlkesK7aFonenwrJQKgmL3sdEM=;
        b=rtpPy5Dzdvdlpt6nwxh2uFTPL/YYsrGay/dbfTYek7YWRFcerkkw+j+M3De1iVthj+
         FKnHZlYHuw0OhZGxNeZmgcQOnNBV2xh+iasOKrCqpM9b+cAq/Cxc2fuzRyWv5RvdDHgP
         EVxP9/oOIjZr9mZdKmfeo57qcgriCbIzgRzlxuz7GQDx5ALYedyN40/7TGnwe/a9C5fu
         Owg3LoZMoGaUpovRrpVexfAf0xplHvbFWy5m3NLY96LtxuwINDhn1H2dszdbhEZKHyOu
         Me2PhaVBxWs342+8hTaHZUKS4UH+hUekOAbWLdR9CrCCrFaWm4pRXijM02lap2XZkjg+
         0BsQ==
X-Forwarded-Encrypted: i=1; AHgh+Rouu2qFtn56IA0Mr8pAo9avRXRaKZb5Rr4fMadsxh4pqv4V77lnMSRxB+CXwtQUPEhJKgMB2TueJA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj1qq+zX0gvwtHxG5H4MezXR5EZr3mdbRjb8N4ylxAxmq1QRNR
	KOCdLaIHs6BJM8n9SsyjLsng8++1UU0XCQuz2hiTtmbtYAeoVEoK/rIN
X-Gm-Gg: AfdE7ckAvJ10u7U5WE7W8XcgkamcOnmamHfJlA5dluCzNHWSHBg1cuTlPqEhDGgzBaF
	IP3DS617ED5bZ4sWorJdYOd5dUO4Kr1kbcWJXcv3SZU3QUTh0R6CjlcIkeZodhGK0/D+iwyFqg1
	yCBONpfxbh8C4dN7DgfG3J1ZXcIb2FHb5mOUqV3bsZxEoicLPziRzMJ6227J4tqeQMjUY+G8u1g
	hNbXS7itBxAYGvkPjWAu2Iw0p416n7rnw0VHD054ddGyk6rIy3btEevKCcz8Z3So52zOyQvLnFQ
	aHlXgj9Jg/NJwPuw3bG8kQrWcWxliV9ZGmeGxh6qV15wggbZ6wbtlZmDaZghFh205G0SOtIQ2BR
	HN2zkGUfbY+5GyR9kD3qoGtkry2MmAOcAxqFdUKOj0Udap0M7tHLwPwq8rulXD5q88dmEaizCQc
	qfWRw64nj1ejatnqy+ZYvNeU8hvvT7cyfUhdYKoBMRHL2WTLRtpByiYcyCqwxqTjZAYuI2o/aoL
	3T0ied5cg==
X-Received: by 2002:a05:620a:404b:b0:92b:6805:9181 with SMTP id af79cd13be357-92ef2c1b30cmr461211285a.73.1783820721153;
        Sat, 11 Jul 2026 18:45:21 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b492ebsm624902185a.9.2026.07.11.18.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 18:45:20 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] assoc_array: trim the final shortcut word when skip_to_level is chunk-aligned
Date: Sat, 11 Jul 2026 21:45:00 -0400
Message-ID: <20260712014500.480410-4-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260712014500.480410-1-michael.bommarito@gmail.com>
References: <20260712014500.480410-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

assoc_array_walk() masks off the bits past shortcut->skip_to_level in
the final word of a shortcut before testing it, gated on
round_up(sc_level, chunk_size) > skip_to_level.  Once sc_level is
word-aligned (every word after the first) round_up() is a no-op and the
guard never fires for the word that contains skip_to_level, so its stale
high bits leak into the dissimilarity word and can steer the walk down
the wrong descendant.

Test sc_level + ASSOC_ARRAY_KEY_CHUNK_SIZE > skip_to_level directly; an
exact-multiple skip_to_level ends on the boundary and stays untrimmed.

Fixes: 3cb989501c26 ("Add a generic associative array implementation.")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 lib/assoc_array.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index bcc6e0a013eb8..1de2c337f8fcf 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -255,7 +255,7 @@ assoc_array_walk(const struct assoc_array *array,
 		sc_segments = shortcut->index_key[sc_level >> ASSOC_ARRAY_KEY_CHUNK_SHIFT];
 		dissimilarity = segments ^ sc_segments;
 
-		if (round_up(sc_level, ASSOC_ARRAY_KEY_CHUNK_SIZE) > shortcut->skip_to_level) {
+		if (sc_level + ASSOC_ARRAY_KEY_CHUNK_SIZE > shortcut->skip_to_level) {
 			/* Trim segments that are beyond the shortcut */
 			int shift = shortcut->skip_to_level & ASSOC_ARRAY_KEY_CHUNK_MASK;
 			dissimilarity &= ~(ULONG_MAX << shift);
-- 
2.53.0

