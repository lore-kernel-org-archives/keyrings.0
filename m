Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76EA3644C3
	for <keyrings@vger.kernel.org>; Tue, 14 Jul 2026 11:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784030098; cv=none; b=DqHB+yaYp4PEkUbbcxphAG/B8IbWmqkhYbaQwP/+3Ta+FYDvdQijycBJEEs6QFrdi37gsm3RwtIcSvTrvzT5kS+z9Ue29ZRwuCzBs8etk2jW7mBaMUKmHb1/Yby1U/S3WEIEpsj4Uu7sNThnsloWt3BV11zKDzOtJQ2+uuv3dMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784030098; c=relaxed/simple;
	bh=4U8q91HPFoRFicOXzoAa63H08lLHbCXfw11y7FazoPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K4Bjx9bNT48+uZcWC+pilfhMPFbye+y18w6HNRwaQyahn9/q/hgKHEXvpIy70sRu7zd5Kc36YiDWDhCM1qYsOp6NIH5bmIJMoicX7/yHBUg0Vs3aSHsUbfZ7Sx8ca729Nej1fjoZlquAhrZB59xr76VyUjySGLpR5T4i8bKQCgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ojC3dWLT; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ojC3dWLT"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51c15bf5000so25298411cf.3
        for <keyrings@vger.kernel.org>; Tue, 14 Jul 2026 04:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784030096; x=1784634896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=l7ADB8De/whZT8e+EWVqNZCd354WcrnrJ/amnwN8jVI=;
        b=ojC3dWLTfIAjG8tQjrw+5rUHqwlVF2Wn7EC3GI6jfsOwfBTgQ5o3k317l1coVsTyn+
         ZM5pwzr9GYSdc3UHrzRMfxnzI9xREvZ5FFY73O+iNZ1y2917uqMi9gK2qk2PXwacz3Bs
         m1LjVgm9upyxV1xt0EgC4WmtUpdPVfHdC/kKd2V3bLuV/8PTLSzeOlrOtGhpUwuVGH8m
         YYN1TbD4f2VP5A3YpOJn8c8FavIIUFz21ZZ3Aae/riqy86av7dS+7xyrQkCrBg61Iack
         2pwPqbPADt3kbaFpBc5FCuaTUmjBBuecAV9pFiyHatiMy72MAq7mhMxvYsJQyQchisuY
         GslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784030096; x=1784634896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l7ADB8De/whZT8e+EWVqNZCd354WcrnrJ/amnwN8jVI=;
        b=kSQwTk1/KeQD3OLKdsuzE5zCzx8Uau/qaOGCg0wESn42mYKchkCLX+Xb203uITjR8M
         m0c1e1Yg5rknytv0/IUn/Up/SKutgzLJo9SRshIaqk6P69p8reQl9OX+VO6zHAmNv3CC
         wxDTbTkk+NRNv3xSoUlqspqLTFJAk1IWE25vdn0S6OlQ6rQHVblCbKFV4ojVI+/qfQ1o
         So6cyscnRdRsE8Ce2gQJF/PwlLVXWGPKTp0hyBWDxrZS2YjGQuE9DtoWKZ9UMMzJsssh
         hU7+KwZBSbH0Pqcv+KjWFY/EiqfSMUATrHweOfPJJ2I1c0/bIYZeT+pHMmeNZdSV8GNa
         811w==
X-Forwarded-Encrypted: i=1; AHgh+RqMXijZikPLb6YB9AOrrE2w/jstY+q39Lz+hSzRd7UDXMoRN883LkJx/IEg+f3Ls603ay1How4+WQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw60MvDPy1ztNeX1hrCnuLFRAiVpEShhwX26IbIl6CXTbe6zcx
	voCXzqVDIr5kJWpA1N2A3KB18rqviHKd/PqZ2WBLC8QXcebM790ESnN6
X-Gm-Gg: AfdE7cnhSjsl0Zr+d8jZo4ixnCMgzEYLLxFg/fx96V7gO8yShW3O5UUNwSxhtNQkd2K
	uQP9wWICI7FdWUsTp+wsbA4cXNQ4CfjA20YKuXOa+kZQ6KN8uBMfHuA0YWCiYGY8YQiyxaKODhA
	zVu9WnnzbNNeAIao01umRvYKVERgEY6Z8xe38HbCntDpJjtDNksImVzP1fLnp2jhbI9NM+npf6Q
	Iwq66cvYApqZU/1Us0gxWi4yIeB5vGfcEE8UGEINam6HDGtEoq6p/PpKI+WxdcbeYJPT/bzszup
	j5pTCe6NDSaiJlAK68Bo7v0e0Rhgn2tzejzFPtjwzHsS0UHJ9zQSqZC91bEMaPVr1aYbk2ILZff
	hLL/KXabuP+j3MQux9/tBOungZOgBUH0BY+XVyluPMHZbzsl2cIQOHJLwDwiRElaJiwaDanTHP4
	2OQAkNRUkYSTXIzFX+U2/CHlEB+eMnVI2AYiYViz/CBz/GedF0oDOrZCCxv9Z9UDee+pgHhlrRG
	aYXutRCSw==
X-Received: by 2002:ac8:5ad2:0:b0:51c:1967:5098 with SMTP id d75a77b69052e-51cbf147113mr127640941cf.38.1784030095442;
        Tue, 14 Jul 2026 04:54:55 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd80fd492sm185100576d6.34.2026.07.14.04.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:54:55 -0700 (PDT)
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
Subject: [PATCH v2 0/3] keys: fix keyring assoc-array out-of-bounds read and index inconsistency
Date: Tue, 14 Jul 2026 07:54:48 -0400
Message-ID: <20260714115451.3773164-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

An unprivileged keyring whose keys collide through the description-chunk
path can drive assoc_array node splitting into an out-of-bounds slot write.
Patch 1 stops the out-of-bounds read in keyring_get_key_chunk(); patch 2
makes the chunk byte order agree with keyring_diff_objects(); patch 3 fixes
the shortcut-walk trim so the walk cannot be steered down the wrong
descendant.

v2 changes (patch 3 only; patches 1 and 2 are unchanged):
As sashiko pointed out, the v1 patch-3 guard (sc_level + CHUNK >
skip_to_level) fixed the word-aligned leak but wrongly fired for an
unaligned first word whose skip_to_level sits on the next chunk
boundary: shift = skip_to_level & CHUNK_MASK is then 0 and the trim clears
the whole dissimilarity word, making a differing shortcut compare equal.  v2
keys the trim on the end of the chunk that contains sc_level,
round_down(sc_level, CHUNK) + CHUNK, which matches a brute-force oracle over
every sc_level/skip_to_level pair; the original round_up guard and the v1
guard each disagree with the oracle in one regime.

v1: https://lore.kernel.org/keyrings/20260712014500.480410-1-michael.bommarito@gmail.com/

Michael Bommarito (3):
  keys: fix out-of-bounds read in keyring_get_key_chunk()
  keys: make keyring key-chunk byte order agree with keyring_diff_objects()
  assoc_array: trim the final shortcut word using the current chunk end

 lib/assoc_array.c       |  3 ++-
 security/keys/keyring.c | 15 ++++++++-------
 2 files changed, 10 insertions(+), 8 deletions(-)

-- 
2.53.0
