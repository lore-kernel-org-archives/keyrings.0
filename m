Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97F438B125
	for <keyrings@vger.kernel.org>; Tue, 14 Jul 2026 11:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030101; cv=none; b=E8nkzQxUwwOrv+ssrlY9ldfB4wKr5oleiVCoFqYl/jb0iMgutOqAE/VvoX4uVKGp1Is/Gn+3f3KTAz/OHsJFSIkyTD6kf2GIBFzs9xrOel8ct55VempLaoUYQaI+60THVCToOAxlb3eNDUP0su2QrUS2zFs0MrsIpFPcqzeHN1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030101; c=relaxed/simple;
	bh=UHv1T3fOghMVYFifd053Xj7nHxiOMCVDbE/j9zIifYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SRX4h/jAqJrSLwQ2pj/n/LHQDa/AQJZvEmCfNvRlFAItgZNfumegMr4v1WYypBEhRwnnYaoVNf2vsJrrY0vf7cx09WOUljpOoaDM4rtPyGuNIG5IMQrm2glQH0Omz8uXg8C3cdVUz1QXddPXhVee8V5APwiZGnt3EKVuP6bwRgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+KwXu9m; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+KwXu9m"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-90327237340so6381836d6.1
        for <keyrings@vger.kernel.org>; Tue, 14 Jul 2026 04:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030098; x=1784634898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vn9mpDo3PjDMuGJGUk3sc9YpQTuMN47dq6Ned6oNhVo=;
        b=g+KwXu9mLrVue1LvNa/U7KpkwXgik8sQ1yu7xyyUWS5baaMo3+v2qUn2G9L6i4Uehf
         MMdfnMn7LcDzDONhRoIytX0RMfuyimN1lQ7VA0NT0myW3iViRACxTRCWMSx4RwCBDcGf
         QAeS9PHT5d6fD79sqzvvyZjxuD9MyXwRoyW84RCpGrVrlJwbriWowBzWt8bDUW79cihS
         e27uHbZ/2/G/6QoTfxCptX089r3sHiWDmazUpTgbCuhqDcxMwmxaEGg6AjXNbtq3M8Gq
         V1flFNnqgxZm3ihrFbbYTIyTQiHVtW25sdphOudXUnMrBJTEx3U2zw+5OGU/9Pi+ghIX
         C9QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030098; x=1784634898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vn9mpDo3PjDMuGJGUk3sc9YpQTuMN47dq6Ned6oNhVo=;
        b=bDPBlCsRGuw89gtnUu2XioDcQbcfpCGCllMIefy8h62hl40IK0mXgtRM0BuLVsVFAU
         vp8dJbIfQt1jsrEEbi46Jd/wSOVTSG1RfzDW+ifyIO02NEzUKWXc6n6Kcrsms3NjIOAn
         Uw83TNUL1Iil2ezbV2Q3sMTQ836F7p/OE9LBPotjO3FcQSlNEy4cMqpKQX/mMmXGULxP
         h4CQt949X3kvMbIoZC6t4qGVaV9Kj3RpTIDvXEKM28DYwFCwwyt+elanZAhN0EhIMQrQ
         ye0DJqt7Ylb3syLQMTGBXTFQcO4mXUVhVnF9dR82JOEo47qAUMH9Ha6CY1aPyGjmwQXM
         6NEQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJ5cT28xV6ppHp6hgoBNll+OUG3QO5PC5HS5yDrpSOusgEillQM/co32WLj/o0T1WJGsjHfMhhMw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlr+a2eVvqc8YeUSO3I11Ej/x9B1QkikakzLVrEqtKE9THQO9/
	zokHbgNiEH4hhrjdubm29Qa2z6lIRZszTGTKvM++ZgMoY8QGO4VVZbntJXVVDnVfX9M=
X-Gm-Gg: AfdE7clT8j2Mm/PGfS5eJmeClIyUAxFx4a/hDdMg7HaFKCkuAPOqMh1+VBGWMiZgREX
	D4jAZ+dPOLLWCwfGLMHhvXQiNKQDGtyPErb6UKywOytuFo/eTVsEwNh1SJpwQYKE2J4kQ9TjUH/
	WPUPErwl6xgW9MuTcR0PdZ6h4z1EfrKeNHd+9Xx+hQS73opzMpcJeudN7dFZ1Cpl9nXye+h3MW2
	36psEFQ8kJZtivuAqWHYj8In/YedWLcRLHfbAiAqsZ1QNyUjYZRDWgusGs1xApA/pqzbVbiArVv
	eC8Y67rg86c3mwxeRI6Yp3HGawqahdzbELkHTU/jr0P2Av5+Rt4FX1wdSYyW28DRBNj/kGsjz4B
	K0pRKYVPtLbrmR+BXh321gEmN8/gsk7cvRGMC+s3eN4E+YP0uiC8ImuSQOGgXjFY2sy8iEHSAmM
	v49X57K+FD91QxqIrwS6lSgGUhjfo0zWsqdvcThJmk3BLR87H8HdL75eWPFwNbmhQ5E8SWOy2QS
	7vY8qkH8A==
X-Received: by 2002:a05:6214:2583:b0:8fd:6e22:6634 with SMTP id 6a1803df08f44-904172f8cf4mr150704096d6.32.1784030098556;
        Tue, 14 Jul 2026 04:54:58 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fd492sm185100576d6.34.2026.07.14.04.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:54:58 -0700 (PDT)
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
Subject: [PATCH v2 3/3] assoc_array: trim the final shortcut word using the current chunk end
Date: Tue, 14 Jul 2026 07:54:51 -0400
Message-ID: <20260714115451.3773164-4-michael.bommarito@gmail.com>
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

