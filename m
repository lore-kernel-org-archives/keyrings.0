Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872063CBE95;
	Sat,  6 Jun 2026 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777647; cv=none; b=Zi+dY5bd38HEoVdG6gQKOWWFCVoBi6SJolgcKe7eEDu5+OqHjX0Ec4IQasziAuzrU0+AsFrw3Fsi+roToh0EX8I1hhARKZ2vObmDu6R9uNzMZFMMcErUlDjAO04cGw+5QK2Bxb67EUkvtalsdNsL1+f+kRMKjTgvwyfk3zyyOb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777647; c=relaxed/simple;
	bh=yVaQLuXvuO1U/EDzM4sU/Zv0ZJik7tGVS8+oIVTent4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Gqf8cVFF/jFy+XYywy9RARCdIYQiOXA5hPeaJ5mt6OGuQ4k4WSpZdyOBmVxGwwF1sgf48sJzy5blpBRpDfap9dsgTXfC2ZknlbP4qCT7HliZ6Nav4bXcoyRxz0XcemzStBOwpbMhuwo01wpEkIoKuq4TnlbjnkB7GiJkT6TY4Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=bH32w8Ck; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="bH32w8Ck"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxc2-007cKm-2K; Sat, 06 Jun 2026 22:27:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
	Subject:Cc:To:From; bh=vGXFn2UvdIj9ETYsFlwDVkmlfUzPfMtPUYXWNHsGXF0=; b=bH32w8
	CkcpR+W561Oy/cQW4Evzp1bIO+GgsLgR1U4uvkJPsqMePP/CsWuhCUfDPMv8OxW7RLZvo49e84VZO
	6vKxCpMHpQQH+w4X3ivVMCFpcYfioNOcBQ8ftFsan1z/Gp8c5AFRTEg0ElMawBYF0zdvEvEh5cXj4
	fE7Yv5TgEPjf9YemdP1G1YO9fWJEa5clUm+RhmPNymkI5oTuejw04F5R6jPGInfqZSq9D39Vq9ojW
	B6iJ5dkowRIJjAnr8ZODvI1T31J1os23FslwmVSlOmUOxRUxPVdBSGhPnoV+Lj2DnApql68gZugRS
	/qY3qqF8+Ty01nvJkyllPJmK6OzA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1wVxbw-0005DT-Cf; Sat, 06 Jun 2026 22:27:16 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wVxbc-006V18-IS;
	Sat, 06 Jun 2026 22:26:56 +0200
From: david.laight.linux@gmail.com
To: Kees Cook <kees@kernel.org>,
	linux-hardening@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>,
	keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	James Morris <jmorris@namei.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH next] keys: Replace strcpy(derived_buf, "AUTH_KEY") with strscpy(..., HASH_SIZE)
Date: Sat,  6 Jun 2026 21:26:03 +0100
Message-Id: <20260606202633.5018-9-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

derived_buf is guaranteed to be HASH_SIZE - and it is more than enough.
The strscpy() degenerates into an memcpy() (as did the strcpy()).
Do the same for the associated "ENC_KEY" copy.

Removes a possibly unbounded strcpy().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
This is one of a group of patches that remove potentially unbounded
strcpy() calls.

They are mostly replaced by strscpy() or, when strlen() has just been
called, with memcpy() (usually including the '\0').

Calls with copy string literals into arrays are left unchanged.
They are safe and easily detected as such.

The changes were made by getting the compiler to detect the calls and
then fixing the code by hand.

Note that all the changes are only compile tested.

Some Makefiles were changed to allow files to contain strcpy().
As well as 'difficult to fix' files, this included 'show' functions
as they really need to use sysfs_emit() or seq_printf().

All the patches are being sent individually to avoid very long cc lists.
Apologies for the terse commit messages and likely unexpected tags.
(There are about 100 patches in total.)

 security/keys/encrypted-keys/encrypted.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/encrypted-keys/encrypted.c
index 56b531587a1e..59cb77b237b3 100644
--- a/security/keys/encrypted-keys/encrypted.c
+++ b/security/keys/encrypted-keys/encrypted.c
@@ -343,9 +343,9 @@ static int get_derived_key(u8 *derived_key, enum derived_key_type key_type,
 		return -ENOMEM;
 
 	if (key_type)
-		strcpy(derived_buf, "AUTH_KEY");
+		strscpy(derived_buf, "AUTH_KEY", HASH_SIZE);
 	else
-		strcpy(derived_buf, "ENC_KEY");
+		strscpy(derived_buf, "ENC_KEY", HASH_SIZE);
 
 	memcpy(derived_buf + strlen(derived_buf) + 1, master_key,
 	       master_keylen);
-- 
2.39.5

