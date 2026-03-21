Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD83242D9D;
	Sat, 21 Mar 2026 22:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774133030; cv=none; b=J8AKLsGydkJbJdCDjXhung576iWqEFPJ5J9ReDNCucw9Aocf2mOWuxKjtZOh0es/5duJCRx7utk1sCWRMJasF5Tu2Y6kJ9WyaUD1Ik5eqeS/Y0fPKmgfKw52ndEU2Vgj2Li+LTGGuHZRZI92HtWrXJwmIxNCawQn4fnPgXrcD2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774133030; c=relaxed/simple;
	bh=N81+17i5oYGVxtdvDVaBEgwZ/+w1fAdF0poOrxWOIts=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IdiQZY/tG2qjr9LnBCUQolx207q/KGGpvqT9bUaD1Xzjgi4EkrFHy94EqhUzdTSGHeUQk0J7osiIxmJdGl2Y9NNe/FgID1enwTfPm2N9gzBs2+Mq4Jd9exd6msOt5xiKBrnKZREJOSlxrY/lzmsKGcmhZ15FtoluaH2QiJNftJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUTpBjPl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUTpBjPl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7110C19421;
	Sat, 21 Mar 2026 22:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774133030;
	bh=N81+17i5oYGVxtdvDVaBEgwZ/+w1fAdF0poOrxWOIts=;
	h=From:To:Cc:Subject:Date:From;
	b=AUTpBjPlnwM6bNKKDU1+OLFeMJ/soI22qijEC6sbuUgF7cFkjmRDUlYJNS0cY+vp3
	 VGpr1tJ4D4dLxCR3PPlC0Bzbb8VCyFpzKo0aARP5jIdeTsSEga4teculhMVMlauU/U
	 KA9u6N1eJEu39CDxRrgvLk4Bn2zHnwEHdBRSu0Vu4uagyiTrP0+Ttv7fWbSaNf3HqJ
	 0YB/Kx/rtGCRN60aEtRUX8WbNIZHi1i1VU6gHo45ZzJ9M6HzXK45fZqTjTNzkRRI6v
	 6h2Odo9Qtm004Ra9JmLkBgeXpuXYGlil7SnD/5zrtzeMEvT2DCDAcahMJFB/mvVJq3
	 co6pI4QJ2nIqg==
From: Eric Biggers <ebiggers@kernel.org>
To: keyrings@vger.kernel.org,
	Jarkko Sakkinen <jarkko@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] KEYS: encrypted: Remove unnecessary selection of CRYPTO_RNG
Date: Sat, 21 Mar 2026 15:42:18 -0700
Message-ID: <20260321224218.60418-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

encrypted-keys uses the regular Linux RNG (get_random_bytes()), not the
duplicative crypto_rng one.  So it does not need to select CRYPTO_RNG.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

This patch is targeting the keyrings tree

 security/keys/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/security/keys/Kconfig b/security/keys/Kconfig
index 84f39e50ca36..f4510d8cb485 100644
--- a/security/keys/Kconfig
+++ b/security/keys/Kconfig
@@ -85,11 +85,10 @@ config ENCRYPTED_KEYS
 	tristate "ENCRYPTED KEYS"
 	select CRYPTO
 	select CRYPTO_AES
 	select CRYPTO_CBC
 	select CRYPTO_LIB_SHA256
-	select CRYPTO_RNG
 	help
 	  This option provides support for create/encrypting/decrypting keys
 	  in the kernel.  Encrypted keys are instantiated using kernel
 	  generated random numbers or provided decrypted data, and are
 	  encrypted/decrypted with a 'master' symmetric key. The 'master'

base-commit: 113ae7b4decc6c2d95bdbbe52e615a0137ef7f9f
-- 
2.53.0

