Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBD32D0C9D
	for <keyrings@vger.kernel.org>; Sun, 19 Jul 2026 16:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784477723; cv=none; b=hEjE3Ybg7HNBti7AVyYYlhJkpgxzEp19VpSsaDxnkrc6kiYtPNAFP0hby3YtQJGCy0xaeEQVemjR7mECTtoF7VcwznXVS57tTP7kcnKVba4ktQ+P8LKjEbtbwqnInFg5u7lthYTAOmWtbCsfgJQ3r9RZD0MCIF3saSdcdA1NLss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784477723; c=relaxed/simple;
	bh=SEF6ayJP8+7gpjFE6bmH1rbtquW9LASsUXWTtKt0bQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8lZrEPSa4ty69ZGoRabT4CRudYE6CHhImMDQmecSqAH/nW6/bDWRIhMYYgsIdDaBdxasIl9bWLBwCoKKfQGKyFK2rhGWYeDWsC6LLEbJ0DQGCts3LplHvk+vHWAFYipU92zr/ctbt9KwOgBbL/qrtbQCkZSGbecnuu2kSAcgS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bAG1Juol; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bAG1Juol"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-92e5d50b0dbso455519185a.1
        for <keyrings@vger.kernel.org>; Sun, 19 Jul 2026 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784477719; x=1785082519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PKH5wh89OUjevntuqAupkpsV3/CURW4CLxf9HsZImsQ=;
        b=bAG1JuolGv2QecX1UTOPHT9so8mA4HO+MCVJE8WCA9ucJLHdioByVdbCTd70+6RQYu
         ijYKNC7SWoqGlKQAtuGjyUMvWtW2Ns/L4ymo86JStPzOhErmZtg2/TumGu4uuYFf0Jj+
         2g7eaUilPWLkD6UsveyZQAXqvryHUBggrznw7T9Zcm6NNDGfY6nL2TgUt/kcNl2nvW6o
         wx1O+48EMH5Ek++5+NQrbm4S8dpP4jmINbsV/+Zip3WLoo3QbNQ0PMx3dOrTCmuepGZM
         iZL3cZyk4qhk3kYgX5azcijeKowYVcgx0z8Rlr7QcjXYvw1iM9kOWkKx/Nuf+UWHN/gM
         UsCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784477719; x=1785082519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PKH5wh89OUjevntuqAupkpsV3/CURW4CLxf9HsZImsQ=;
        b=sc5rThux6ifHfz+Z9xD7YfNPseNTLoSfn6Yy6MVp3Xho4lMKCOifWMW2JxjoP/97WZ
         PgRptj0YwGNgDLbQQXO6judITgxsCXlhURmAj8tuhj006wQdKPcysOWfTHoqqqmrjkWw
         TTehLQkq1vzo2lQnVs2Bnm1x1+9urzlULVryzFPvjiBJI3unFHzEaskmKJms2GpsATht
         u0BYhxKLMlQP0n6/IuQY4zArAVtx6Mj9S1+w0woUAHPhYO/Q/sHHagVKPYISynnRjJP1
         66j7EUNOPkz6uGzka8ue5ONeceW3Hw0pof7SplegLcC1NmbjMW7sNBsHFVo5GbEtKJEk
         QMsg==
X-Forwarded-Encrypted: i=1; AHgh+RrflOdWyPtFmQIN+LOtT5Yhc8dfnHlNGPNtjld8/uuJyWROqV+G4hES16X6vaaH7dSwvQQunwQeVA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyfP6+EQykn9PGaVEeJjGbeD6zswEsXfl1ETN1H9LVdcdPfap5G
	2+49bprBlfF26Vm67dtjcRxetWC6/VkSMQhNtWoHWi9yWaNiG/daKqj7
X-Gm-Gg: AfdE7cmnqqZ/UvKaowFBVem0Y2Evd58kAQsxbyURvrCrAMmep3Kl9w8sOpTRmubd7Xf
	ev917CqFhntGzhgOxABNCp/UK3zhIEF/PmfjJq4SbpYjPwrEwEftnVwjjXfaGjx6aTHGOfGSYm9
	ifOm9qkL9jbqZuGnHCkWvnQMWZVkv5AV1QBDPKvodnsrjDZgBgEZE615OygoFUoDMyrqtrwgFw6
	4mMHGC2smIENIbAzz2CBKUeDq4TDb3tDG5o2+N2YltHKfmVj3ajplriaDMjzuP1DPuZbV6oU246
	ntVrpeNutV/hid+5RrWfcAvfe9k4PeJxFJikbmrWVhUTwjQlDZWbR4BseKjFfzPorCdVnOqSnvB
	grCbQsscbUnuoO6WF+GyrHRpZskRCvphoiBOIwiYgCG6yVInroFYVl6Sc5R3g1uQ8+1SsL96AgY
	FOjfk4U8Sn1JKcVsuXmOMw3LLOlr3apGRYZVl3zmtHWH7z/d+9PuvxQdWnSYxxEt7gwLxGfk0kw
	gfdzimGRofvH9Wu4eKo1A==
X-Received: by 2002:a05:620a:4483:b0:92e:dddc:6588 with SMTP id af79cd13be357-930b3ef648dmr933688585a.42.1784477719392;
        Sun, 19 Jul 2026 09:15:19 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930b52fe271sm672374185a.16.2026.07.19.09.15.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 09:15:18 -0700 (PDT)
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
Subject: [PATCH v3 2/3] keys: make keyring key-chunk byte order agree with keyring_diff_objects()
Date: Sun, 19 Jul 2026 12:15:04 -0400
Message-ID: <20260719161505.2423935-3-michael.bommarito@gmail.com>
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
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/keyring.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 085f7a743354c..15bf4af8f2821 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -293,9 +293,10 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
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
@@ -376,7 +377,7 @@ static int keyring_diff_objects(const void *object, const void *data)
 	return -1;
 
 differ_plus_i:
-	level += i;
+	level += i - (int)sizeof(a->desc);
 differ:
 	i = level * 8 + __ffs(seg_a ^ seg_b);
 	return i;
-- 
2.53.0

