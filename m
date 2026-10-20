Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792460350;
	b=NViioAxT3uLpNLIQPR4K6EdZKAy315QUsTAJOcfgIElcsXRj/ed/VPaK7vUlf2LrfABZ
	 Z+Q3ccUoJR2khuogEIK/aBRuF+wX4nXK0RqYcqNz7BZj8V+Rd52AFEe8ib/jOT3FswXpO
	 SI1wsDnAKc3HgLId+30b9ttfGk/+ArUZUs9OP44OKeFkzNQ1g9SsQrmFNGz3rF9ntIvzu
	 Bx9Z7peiCoppOcTFK55koZXpzg0MiDB9B9Z7YYGeFlt2knJTo6/iQ/GYOj0Dh/dr1+bJ8
	 IYwtZh9q5ZPONHpyshZFCOqgS9gKmVHGY9Z5AvqdmEBvS4iuF7ufkkEWjh/fI+fButg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792460350;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=dLS0cufrwFtFMb1oxfB7ExjLjEc9EXnk2SSrSKfhDjQ=;
	b=DMXBtVUhg9G3GkQ+fwEbyXIV0/0waLCiUuW1MEyx7/nFTsINnlVuAXudD+6A2hvpxvWm
	 F9LKwRULmT40KQbMM+oe5aSBQkiOvotSpRMDsSiDyrzXNyt7Z6/olxrMDb19Yl+EEeSGK
	 OOxo459ntYpxTu6q7wlodx3ZCTrbw+OdfZ+GXOF3SQ3Gos/CG7Dl8RsGeLuh/hJzAQXjT
	 F66Wvc78Q8RYxkzKndvJ89OebfDGxvUdtDfShSap/Mj676I4cdTzIqBUbZewGP07pax5+
	 P11RQvGx/aalPJZvVJHo242wWlYm89PGixDqCSFsvZeoATDxU4CHBVGYPtoQkP0pSGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dd9tk4Dq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0432D606A31C;
	Tue, 20 Oct 2026 01:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dd9tk4Dq
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1C0D31F000C6;
	Tue, 20 Oct 2026 01:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792460348;
	bh=dLS0cufrwFtFMb1oxfB7ExjLjEc9EXnk2SSrSKfhDjQ=;
	h=From:To:Cc:Subject:Date;
	b=Dd9tk4Dq7yT/b6TqAf+n04ND+Y5fYI6LcjvHjmWyfZhCVY8rAILmf5f0mhcTHNz1m
	 cdCwd+DO1BbCVNujYCqm0uKBS2euIuao9ZAUiCMu06Y1U983m+ORgenIhjbH7NFo9A
	 7JzIN+m4PYAoaHuLvXIkIxK5i7NbkLwohjHjv1TVtoT/lOyd92LjMVf1yMkyYbksO+
	 2gxOPu64CN/VYSyor40DLuXOO5LzAWKPW5Q4NtiF3BU3daCaXcC0ohG4FdvK8+XntQ
	 cU+QzuBuFAZ5ZokCXqpO/rHOGrcvMQ5NZSE/JKkOsZs+tFcvBvL23CtoW/UwNtoL+P
	 buavFj67UeCwg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org (open list:SECURITY SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 0/3] KEYS: rhashtable bug fixes
Date: Tue, 20 Oct 2026 04:38:54 +0300
Message-ID: <20261020013903.1244157-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My patch set that migrates assoc_array to rhashtable had some LLM
scavegend bug fixes. Unfortunately most them where either plain wrong or
not in the right scope. The bug fixes in this patch set are by human
labour constructed fully but they are derived from what I got out of the
original LLM source. Thus, they are tagged as LLM assisted.

Changelog
=========

- v3: Added couple of example, one of my own and other derived from
  David's snippet.
- v3: Removed bunch of unnecessary INT_MAX checks (Eric).
- v2: https://lore.kernel.org/keyrings/20261019181732.449591-1-jarkko@kernel.org/
- v2: Addressed issues pointed out by David.
- v1: https://lore.kernel.org/keyrings/20261019142516.300040-1-jarkko@kernel.org/

Jarkko Sakkinen (3):
  KEYS: Expand key->{datalen,quotalen} to unsigned int
  KEYS: Reject @desclen values >= KEY_MAX_DESC_SIZE in key_alloc()
  KEYS: Verify the key identity in __key_unlink_begin

 include/linux/key.h     | 6 ++++--
 security/keys/key.c     | 2 ++
 security/keys/keyctl.c  | 2 --
 security/keys/keyring.c | 6 ++++++
 4 files changed, 12 insertions(+), 4 deletions(-)

--
2.47.3

