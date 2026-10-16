Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EFBB3CFF6C;
	Fri, 16 Oct 2026 21:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187626; cv=none; b=lmZoM/+nvh9AZX4ieYPvtLjIsZjl+8IYf+VCyatFKeVVLssZbe7Gzp6W2yguW4A0lN2ym3pUapAzm4qSQFeZmnKhYvZZKdOVtCtfh5KIOMJ+fFZEV25PEdUSyNsARK13coZ/wFCXFPRkzyV2qj0aVvbx40z/02GBnUnBoxhgvzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187626; c=relaxed/simple;
	bh=5ncO26zUgAzacnJdmXq46ZrsrdttBtWumnVLKjBg57k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Crq68FsSp5dr4zjfutOz4F+KfMmcRYXNCoNdbcqgTvsegqzicsfkTZnKONmyu4NQPeLgQG5A5jPtSybJ4YY9HUU6Ymda7V8CgUjimkTVr/lu+nK6ENhzO6VqwDVtc3YDIjyKmCEl6LroZj77PLkB1KnfnpG0wUpgaFtfm/+mW/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cno4Pw5W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cno4Pw5W"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 30E251F000C4;
	Fri, 16 Oct 2026 21:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792187623;
	bh=qo8rbdOa6zlFJe2Zn3Q0iR8dm89CJ5tc0zSKYvSHs2k=;
	h=From:To:Cc:Subject:Date;
	b=cno4Pw5W2fB6YDg0qUH0bYiKM70JWeBLWZ6jLs0qV0UzdFAm0J9dPnJuWUaO6UkUG
	 T0N0NJsY/kwanan639lXilH3lncIG+xCoBVVhxr/UGAOoF1wx5CHBdA1KY/V7eIfod
	 Zz5+vZrsa2+xaCQcXSl7ZBRXn/CEgV7k2AnIBef7BniYptTY6gd0722PFptjz0TNc5
	 H6fWxKHDVwe5bVr9yu9tYQK58LRKJj4rxrfJ7bJoPvKCJ9TRPv0fyeAuID22SFE89a
	 rC3KTWqPuWG4yqcXBIIUXw9KU4qufjAx6Uynj3vDlZNHGzeorFGeFkgDmwehaPgkKP
	 F4IoZCMk9CFGg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 0/6] KEYS: From assoc_array to rhashtable migration
Date: Sat, 17 Oct 2026 00:52:58 +0300
Message-ID: <20261016215326.4110064-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As a constant source of LLM attention this must be done.

This patch set started from Claude Opus 5.5 generated code that I got from
Linus. I tweaked what I got over one day scoping it into a proper kernel
patch, fixing some minor bugs in the core change, improved the use of
types and basic stuff like that.

This felt a good chance to try out LLM in the kernel context and I used
Gemini Flash 3.8 to seek for out-of-scope bugs intersecting with the
core change.

Since this patch set is marked as RFC, I did not yet cut out-of-context
bug fixes out, so for most part consider them as white noise. This applies
to patches 1-3.

Jarkko Sakkinen (6):
  keys: prevent quota overflow and widen quotalen and datalen to 32 bits
  keys: reclaim link quota during keyring garbage collection
  keys: verify key identity on unlink and move
  keys: Add keyring_is_empty() for {fs,dm}-verity
  KEYS: Replace assoc_array with struct keyring_index
  lib: Remove unused assoc_array

 Documentation/core-api/assoc_array.rst        |  564 ------
 Documentation/core-api/index.rst              |    1 -
 .../zh_CN/core-api/assoc_array.rst            |  473 -----
 .../translations/zh_CN/core-api/index.rst     |    1 -
 drivers/md/dm-verity-verify-sig.c             |    2 +-
 fs/smb/client/cifsacl.c                       |    6 +-
 fs/verity/signature.c                         |    2 +-
 include/keys/keyring-type.h                   |    1 -
 include/linux/assoc_array.h                   |   88 -
 include/linux/assoc_array_priv.h              |  178 --
 include/linux/key.h                           |   24 +-
 lib/Kconfig                                   |   14 -
 lib/Makefile                                  |    1 -
 lib/assoc_array.c                             | 1724 -----------------
 security/keys/Kconfig                         |    1 -
 security/keys/internal.h                      |   10 +-
 security/keys/key.c                           |   33 +-
 security/keys/keyctl.c                        |    9 +-
 security/keys/keyring.c                       |  887 ++++-----
 security/keys/request_key.c                   |    2 +-
 .../dm-verity/test-dm-verity-keyring.sh       |    2 +-
 21 files changed, 478 insertions(+), 3545 deletions(-)
 delete mode 100644 Documentation/core-api/assoc_array.rst
 delete mode 100644 Documentation/translations/zh_CN/core-api/assoc_array.rst
 delete mode 100644 include/linux/assoc_array.h
 delete mode 100644 include/linux/assoc_array_priv.h
 delete mode 100644 lib/assoc_array.c

--
2.47.3

