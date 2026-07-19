Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2934C3A4F5E
	for <keyrings@vger.kernel.org>; Sun, 19 Jul 2026 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784477724; cv=none; b=JpqjsfNvwc9s9cw9gU50a8xaYKne/jsKRGiLOBhJEkxEWA9+5tWkc+hAkSUGoW9vVCn3hEIe3Js0uW+T4k7GJAGmgDgOMyWC6jml+tSTqwKTr/C5kqh+ZkyYVCEVQpK5pFnfyu3cNGSeOau3uR2Z/MQroJ8BtaZZwGj2BS3rWe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784477724; c=relaxed/simple;
	bh=sLM500yHckZI96gdaqrzAndkSOc2GG8Oew7rzW2iE4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxRdcyxaUG0Hq+H7s9hx/IUhT51E0bqmN8nL8S4rRb4GcCZ8IzHjV8ksAzoXlXyLjnOY/F6aDax9a2zp3xJ9VaGgfOQUJNW5CG4x6d/BPtJyAhwH+O4LKe5JjEgUbqZj7C+jmYVoyeK0q9+Y0p2Qtho9x0I7yfA1HAxMtJBW8Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xvi+f0tx; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xvi+f0tx"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8efef6533aaso60878836d6.0
        for <keyrings@vger.kernel.org>; Sun, 19 Jul 2026 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784477721; x=1785082521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KmGHK7gXD3QQ+rsXKqEFIuK8Q+UTYgnfH59paMrURE4=;
        b=Xvi+f0txlDc5DzDpvfzXZM2GfMmfNeFC4ziDGcnF6/wmYc3+ZriVkf4BDA5YKIMhUN
         COA0Mxn+QHkCym6Qz6XC4/o3AXMw/okLcNgUFfVylcFqbzKdQtU+ajfnsMge23sBwLgJ
         is7o+bUEf88J+RB0qvf91mV0RTO8DYespPcWpPjsIqb/ZLjkL3kS31HOaLtYlUrg0c8B
         ESp1mgE9k/ddxvWScAYrKqVaEllUzVx3i6YdvS1W4v8Z769lbIhi8XhMkjLOx1lBuLj5
         vYLLiugSZkORscB2icocFl1CPEi1Z9nsZbOCW2fZ4/BJppj8ruasAfYysQxNDNxZPxv3
         elvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784477721; x=1785082521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KmGHK7gXD3QQ+rsXKqEFIuK8Q+UTYgnfH59paMrURE4=;
        b=RuP5mMv18JeufPO0IzDURsVAOa0nhsNWM0HOJk5KW/xT7pL0Jayetwv4bnjV51b3vV
         5R09qQuHX9aY8+yXX05LwCIKlfSSVK+sPNSmFWSYZVyoSZNWHA3civcvUUAL+gEDa9yP
         8gE696N52F/0eNqrbFmvEf+EZ7Bv/cfBnO1A4YSgfDwvXAj0W9sRzsv1cVwPo4RHV7IR
         9Mq8AHTaMg42ATxYDDl5z7BGx6OeOTJhyIAcH6/qcV5VaLKGGZdLKuRuZ/tn6focvRnc
         GreImMbQRAQUGNUPnJpIenpNNKHTcX/WIACNRvQc8oadFQROD+VejZc+VWhqux2edKhW
         oRXw==
X-Forwarded-Encrypted: i=1; AHgh+RppHx32M8TI3vFsw8srjMqRvtDmHowg1OUmUpiUEh92VuXKB43S/vfu0PC32UmcgyH9FhOPFqibXg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxwpVt/qCzVG/gW+ypUd+mbRvBxhzGgJ0NRDBgvhg12rWSrr480
	tRow4wKGXqEhnPU5395kj3VrLCek5bj4WYWplLgUjN5Ybbpl/s5Wc4gj
X-Gm-Gg: AfdE7ckf5NZwViTb9oqdhYOAfnMQF6F6GxZ0mFDxNVOHexlW1/3t8fYxh7Zveki94WD
	Cmo6BbZMG4idUWR2R/EpfNvrYvfKUcHMDie8M1AcuawZ3oMyS9e1Oq+hHyf8js32Gg+OKcfdSpa
	Ij9TFWQGupyRysIFoALkQ9aJ0xLda4UNsYmAaD7TfIixNt0FKQscbqFWj2DSV2/I3LQzMAFi1by
	8psar4xp3jlLxrELFflpqOMDN0Z0kqE8KSuF35gYki5uOHV5cKkkmYhRhspIKhdRptDKghLZi+N
	s6+luw7BkiyggLYvu0Q6RMP3q4ZPgoESKyzw4pTeD6hskQ6Z2wnGO81yLIrLR9jtdH9aBhdW4j2
	cfzbVE4c06gWiWAO6eqlaMIuP9i4hWKvqUWHA2zYAZEnWrsec9nGQIeuUe1CTWi2+57A24Ydttb
	3rX+mB/SdMIx/6kdVt0i/EC5pq2JGrCvu6EgAr8faZubP+4Yca4fuK35RHfWG7qxATqyi9NaN1T
	L6N+SsUAJMLjpAn8qd+WA==
X-Received: by 2002:a05:620a:19a2:b0:92b:6805:919a with SMTP id af79cd13be357-930b4353319mr1036758785a.66.1784477720740;
        Sun, 19 Jul 2026 09:15:20 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52fe271sm672374185a.16.2026.07.19.09.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 09:15:20 -0700 (PDT)
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
Subject: [PATCH v3 3/3] assoc_array: trim the final shortcut word using the current chunk end
Date: Sun, 19 Jul 2026 12:15:05 -0400
Message-ID: <20260719161505.2423935-4-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719161505.2423935-1-michael.bommarito@gmail.com>
References: <20260719161505.2423935-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

assoc_array_walk() masks off the bits past shortcut->skip_to_level in the
word that contains skip_to_level, gated on
round_up(sc_level, ASSOC_ARRAY_KEY_CHUNK_SIZE) > skip_to_level.

That guard is wrong in two opposite ways:

 - When sc_level is word-aligned (every word after the first) round_up()
   is a no-op, so the guard is sc_level > skip_to_level and never fires for
   the word that holds skip_to_level.  A shortcut that spans more than one
   word and ends in the middle of its last word leaves that word untrimmed,
   and its stale high bits leak into the dissimilarity word and can steer
   the walk down the wrong descendant.

 - When sc_level is unaligned (the first word) and skip_to_level sits on
   the next chunk boundary, sc_level + CHUNK would exceed skip_to_level and
   fire the trim with shift = skip_to_level & CHUNK_MASK == 0, which clears
   the whole dissimilarity word and makes a differing shortcut compare
   equal.

Use the end of the chunk that contains sc_level instead:

	skip_to_level < round_down(sc_level, CHUNK) + CHUNK

For an aligned sc_level whose word holds skip_to_level this now fires (the
first bug); for an unaligned sc_level with skip_to_level on the following
boundary it does not, so shift is never 0 when the branch runs and the trim
never clears the whole word.

Fixes: 3cb989501c26 ("Add a generic associative array implementation.")
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 lib/assoc_array.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index bcc6e0a013eb8..b6c9723e12ced 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -255,7 +255,8 @@ assoc_array_walk(const struct assoc_array *array,
 		sc_segments = shortcut->index_key[sc_level >> ASSOC_ARRAY_KEY_CHUNK_SHIFT];
 		dissimilarity = segments ^ sc_segments;
 
-		if (round_up(sc_level, ASSOC_ARRAY_KEY_CHUNK_SIZE) > shortcut->skip_to_level) {
+		if (shortcut->skip_to_level < round_down(sc_level,
+				ASSOC_ARRAY_KEY_CHUNK_SIZE) + ASSOC_ARRAY_KEY_CHUNK_SIZE) {
 			/* Trim segments that are beyond the shortcut */
 			int shift = shortcut->skip_to_level & ASSOC_ARRAY_KEY_CHUNK_MASK;
 			dissimilarity &= ~(ULONG_MAX << shift);
-- 
2.53.0

