Received: from cvsmtppost06.nm.naver.com (cvsmtppost06.nm.naver.com [114.111.35.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4B919E7F7
	for <keyrings@vger.kernel.org>; Wed, 30 Sep 2026 04:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790742503; cv=none; b=rDRj2nlQ26Zs2nR9v+hMyL9HKfeSEqa2TKHy3EvV7w5Km0tnjCs/PhQg8ABKkZuFkVBeVWeAlnDrC27N0bLWuByHNoB49+nb6fdmdlomwAGIapeG9XkejiS6e+Ta+SvsfpD2m47KyE6P01QFaC/9v2WTtojaRxuXHrfG+1X/slo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790742503; c=relaxed/simple;
	bh=ZjTG9yNUbRoiE0GdcobNdfLoGv9hmanVKYDsL9+gTPw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=agQ2vSkiP/Qj5Yi2HeIZi3gz08DKd/D+7NblsN/MKMASoP6MKZeC4A240OI+Ugxm3PLVuxDbyB071E4zEwcd3Rk1M9GWDjXkkf7JRYBhsXLU1mWCXNAJQ6pTOCyrADQICQoGZd2/B4ixFwxYJfS54EQAUW8ODly6n6q6WT0ZIdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=fRIwd/AD; arc=none smtp.client-ip=114.111.35.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="fRIwd/AD"
Received: from cvsendbo034.nm ([10.112.20.50])
  by cvsmtppost06.nm.naver.com with ESMTP id plFtRxPWSfiiY6U1wdphkQ
  for <keyrings@vger.kernel.org>;
  Wed, 30 Sep 2026 04:18:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1790741891; bh=ZjTG9yNUbRoiE0GdcobNdfLoGv9hmanVKYDsL9+gTPw=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=fRIwd/ADLOcVMSD0rt2/VRGl7w8YCSpPWHAQfJd8shwpMeJjMGJY5pj8pO1m0e+iK
	 c2VTMTK0ZH/8a8rMhl29OloJog6OVpWQj9aXeArr3mUw52IFOUM3/Vhdcana3aWqaR
	 QdyZpevwXg3CPCgG+SMDKSwcaHq7WbnSvL7jOHsmTxrxjtF3jVvFPh7Lzs08NdAjtG
	 fx4+8+4MrOZIuB4vscpX1vImOXsX6uA9VcQgFSmjdzj46Ns0HVduL5Ulx7lz2UX4CK
	 zqWDBJGHzKqNNG0YRDSaz0tz1xJVj3HoErb/6w52rGqjAswbJGFQjshvg+CBHQwVfy
	 BKdeylz6T6CdQ==
X-Session-ID: ns4qJ9EHSLqO6AP88x0C4g
X-Works-Send-Opt: OPRwpzGdjHmdKHFOMr39Ko3YKBm9jAudFqM9KqMqFxIYkEljxBmwjAg=
X-Works-Smtp-Source: /dYmFqglFqJZ+Hmwaxtl+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by mvnsmtp03.nm.naver.com with ESMTP id ns4qJ9EHSLqO6AP88x0C4g
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Wed, 30 Sep 2026 04:18:11 -0000
From: tjdqudcks0424@naver.com
To: jarkko@kernel.org,
	dhowells@redhat.com
Cc: keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=EC=84=B1=EB=B3=91=EC=B0=AC?= <tjdqudcks0424@naver.com>
Subject: [PATCH] KEYS: Fix add_key() race with keyring restriction
Date: Wed, 30 Sep 2026 13:18:01 +0900
Message-ID: <20260930041802.6114-1-tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: 성병찬 <tjdqudcks0424@naver.com>

__key_create_or_update() snapshots keyring->restrict_link before taking
the destination keyring's semaphore.  keyring_restrict() installs a
restriction while holding that semaphore.

This allows a writer to observe no restriction, wait for the keyring
owner to install a reject-all restriction and return successfully, and
then link a key using the stale NULL snapshot.  The writer only needs
write permission on the destination keyring.

Move the restrict_link read after __key_link_lock() and
__key_link_begin().  The read and the subsequent restriction check are
then serialized with restriction installation by keyring->sem.

The race was reproduced on v7.2.8 in 19 executions where restriction
installation returned before the link completed.  All 19 linked the key
despite the reject-all restriction.  With this change, 312 executions
reached the same ordering and every add_key() call failed with -EPERM.

The issue was found by manual concurrency analysis assisted by AI-based
analysis and independently verified with a QEMU reproducer and kernel
instrumentation.

Fixes: 5ac7eace2d00 ("KEYS: Add a facility to restrict new links into a keyring")
Cc: stable@vger.kernel.org
Signed-off-by: 성병찬 <tjdqudcks0424@naver.com>
---
 security/keys/key.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index b34a64d81d47..a438c4508595 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -840,9 +840,6 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 
 	key_check(keyring);
 
-	if (!(flags & KEY_ALLOC_BYPASS_RESTRICTION))
-		restrict_link = keyring->restrict_link;
-
 	key_ref = ERR_PTR(-ENOTDIR);
 	if (keyring->type != &key_type_keyring)
 		goto error_put_type;
@@ -880,6 +877,9 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 		goto error_link_end;
 	}
 
+	if (!(flags & KEY_ALLOC_BYPASS_RESTRICTION))
+		restrict_link = keyring->restrict_link;
+
 	if (restrict_link && restrict_link->check) {
 		ret = restrict_link->check(keyring, index_key.type,
 					   &prep.payload, restrict_link->key);

base-commit: 6f8319e3e9a44dd537d17f41565a8453c560a581
-- 
2.43.0

