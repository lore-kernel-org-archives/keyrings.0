Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792433858;
	b=riZD/W9FGWh2CXUBU2CRhQHCCexTSy9bl6T+cZjuABZq4uLi2bRtee00mBwGg8N734Zt
	 fNL0ROb7IegwHeIXGO26ZgGDJp+nimTMqOXRrNUWLGG5WEqwguOY+Rf25SoMhPjIH9JOP
	 W3B/xIybrSJRwTZlT6psPIoG8+YyyaBsIU50Ape0hDhl89dd51CUeaOFPY3190YxlM0rx
	 yUuVa6p/gBwdVlXtajf7D4k+IUE2TsXuf22qu4BIrOOaB44GOwg0rHCOOt44QHQRS2IGN
	 7800Ol3QmuFzTrx3xpDbxWjCXmkPypQQzbyv/O5PmwF7Qv2EjGnU4IxvSrbz/SIoF7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792433858;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aIXqP5xcCwN986YiwPF3T/ChOzOXIuGm6THVEZcd/4E=;
	b=iAS68yQ1F24QIQsZk73zDICd6TbpdQoPu041OJ5/FNhSl0O4kvrq2FQX5lJaOe/EUQxC
	 kmmJ5/I38Z7R6L3DITj4aPrxpIfU94jLvmHZGYp3KO2nIizTHJAS/ibEs2FLDaVcmwMz7
	 nYgCgGHpGX6nB69A1vCoZYDPcG/4M7MtzNFKcL7T+Tcwru+uIG/L7wMyxkWwn1gjpSiox
	 8dqiwmcfwQclMO+z5E7h+vMsXU2ovq0B1k7M3uBsT3v2LMEpY9IUFC7iemLpp7fVV071D
	 ULX4IZ4jJyac3E9uRuznpw2LOt05PKtqgprOLEe9udKz3wVZkQYqYqRhgfwM5e4YYpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxO1vz7H;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id CD4F1606A31F;
	Mon, 19 Oct 2026 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxO1vz7H
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DDE111F000C4;
	Mon, 19 Oct 2026 18:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792433857;
	bh=aIXqP5xcCwN986YiwPF3T/ChOzOXIuGm6THVEZcd/4E=;
	h=From:To:Cc:Subject:Date;
	b=UxO1vz7HGnQtLAcQjnMScWfVmCdrxwREufqiVqufjrVV0fTiCfZJYUzDmne0894Fl
	 3Lexw/BjZ83jtspbrr5f9Aktiav0+lhRuoshoLHq1BkONmvKglMlvriMgQzkWO1oBg
	 DN2tOwQH/PPSRJOuMzrIY/ifzMcC4LJ56KEB78z3And9ZAzr+CLR60bclLV6GNnbof
	 3ookaIUFPvYYSohLTl1XI0T+ljuDwMCT1Mr1I1bfaqKsr6eeYcF8mCjA9Kkw65Wcoc
	 BdvFGU1WjBZyC0L/VOjTce/Hftpo3GzMWd7NgSmN9H05/wcV7pCU8DF4ydFyIYAZNv
	 FqQssgU1+57zQ==
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
Subject: [PATCH v2 0/6] KEYS: rhashtable bug fixes
Date: Mon, 19 Oct 2026 21:17:20 +0300
Message-ID: <20261019181732.449591-1-jarkko@kernel.org>
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

- v2: There was enough tweaks that a sanity check round makes sense just
  in case.
- v2: Addressed issues pointed out by David.
- v1: https://lore.kernel.org/keyrings/20261019142516.300040-1-jarkko@kernel.org/

Jarkko Sakkinen (6):
  KEYS: Expand key->{datalen,quotalen} to unsigned int
  KEYS: Reject @desclen values >= KEY_MAX_DESC_SIZE in key_alloc()
  KEYS: Prevent overflow of user->{qnkeys,qnbytes} in key_alloc()
  KEYS: Prevent overflow of quota in key_alloc()
  KEYS: Reject @datalen values over INT_MAX
  KEYS: Verify the key identity in __keyctl_unlink

 include/linux/key.h     | 6 ++++--
 security/keys/key.c     | 9 +++++++++
 security/keys/keyctl.c  | 2 --
 security/keys/keyring.c | 6 ++++++
 4 files changed, 19 insertions(+), 4 deletions(-)

--
2.47.3

