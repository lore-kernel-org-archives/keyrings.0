Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794790274;
	b=fNW5SCwEgjI5H2p4BlSJ06rcsVu0SPGWWMqf2wMsFRAX5s9mz0+GWID7Er77EugrksoD
	 +7tZioJHcQeVt7IL6mQZtWUI976FR1+fnrhQNFUr2zNQUdva3iGp42cKYOgtj90esYLIr
	 R12hR14babZGEt0YKj6Iq70ijx0dJH8cBmD7JgS/ixnSTOpvbbN3883sTgTTjyxWd3BgA
	 RpPSc6OCTxZnWTHx2f/p8lPQbsrI2+wItzGezMjV8BJlu3SCy/atNGTU3UKnxxS137PDv
	 hEbJ622dMXP4AvwBZfPLfvIt5l729S2lE4AXa5LenihG362+1gSjxPcyz7fG1GOX5fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794790274;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=MIjM5AQP/1CG/3Cir93oUp7YXAhmVFmDtgGmXBS6BRM=;
	b=DhtZ8Cn0n3TiJ6P14JKPFMiktqvOrveEt/NdFxkXm4cjrdUEjvUJARr61m23cF2vTTOj
	 eSHr3XiiA3W3Nu/mPZcCwysxHJEfONY6FExuRVbmkLybWUk4MLIwe3cCTM0sXA39JtnPc
	 8OEqc3cgXb8tKcvtsDFQIG48+JjuvCV5rG540adXPyh+LHVxtFzlgCmLYAobXeSxtZ2dQ
	 N+uw8FaVDhgNDLFm7x2JPyE8JvU/f2GHli2wkc+9coKqmJCYo4Yh1fPuHXgJeXbCC7BC0
	 oarXKxCIniSiCeUjIUsx8jvYuGvAbx24XNOl2uDxGxnx9dFwkqB/k7e3pJ5HeXz7J8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmz705tQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C0E1B606A31F;
	Mon, 16 Nov 2026 00:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gmz705tQ
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D0B6C1F000C4;
	Mon, 16 Nov 2026 00:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794790274;
	bh=MIjM5AQP/1CG/3Cir93oUp7YXAhmVFmDtgGmXBS6BRM=;
	h=From:To:Cc:Subject:Date;
	b=gmz705tQclk5xa4yWgQ5iErGq5k+nHHE1YUrcp844z2f7SUoydNA3zjR3CDWNoUu1
	 FWKl6Kb5vEABJJZTgUHus7BxN7mSTvV52iK+xuOyAoCaw9QX+G82DDtlzdc5byWlmk
	 A78qxv7yQeVK/hTm/ku8eeVGU7NlJGSFDS9ZTx2EgDJazz9vxRsJgJ2l36X0iBRBnd
	 UWWVARrsYG5X6KnUDIrhPHB4Mir4qsVqliDYC+FEk1h7sJSLkoARPqoiwqqQ+TU+Mm
	 XCzcmAOvcLNsAIUGs6V9hE/GbZw5t5kwUYvk4HH30S5puLfgKFzE6v1PzsZXtH6gfI
	 WWCAuGRnzYeZA==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Alec Brown <alec.r.brown@oracle.com>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	David Howells <dhowells@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	James Morris <jmorris@namei.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan McDowell <noodles@earth.li>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Ross Philipson <ross.philipson@gmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH v3 0/5] Unsorted tpm2-sessions improvements
Date: Mon, 16 Nov 2026 02:50:59 +0200
Message-ID: <20261116005105.1573016-1-jarkko@kernel.org>
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

Collected patches that still make sense from [1] and tweaked where needed.

[1] https://lore.kernel.org/linux-integrity/20260125192526.782202-1-jarkko@kernel.org/#t

CHANGES
=======

v3:
- Add "tpm-buf: Make tpm_buf_read*() fallible".

v2:
- Based on Sashiko feedback I changed "offset += tpm_buf_read_u16()" into
  "rc = tpm_buf_read_u16(...)" and "offset += rc". I'm convinced that this
  was necessary but since it does not have a cost, at least this should
  mute Sashiko.

VERSIONS
========

v1: https://lore.kernel.org/linux-integrity/20261115224722.1450498-1-jarkko@kernel.org/

Cc: keyrings@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: Alec Brown <alec.r.brown@oracle.com>
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jonathan McDowell <noodles@earth.li>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Ross Philipson <ross.philipson@gmail.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>

Jarkko Sakkinen (5):
  tpm2-sessions: Drop TPM2_NAME_SIZE
  KEYS: trusted: Open code tpm2_buf_append_auth()
  KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
  tpm2-sessions: Re-orchestrate tpm2_read_public() use
  tpm-buf: Make tpm_buf_read*() fallible

 drivers/char/tpm/tpm-buf.c                |  56 ++--
 drivers/char/tpm/tpm-sysfs.c              |   2 +-
 drivers/char/tpm/tpm2-cmd.c               |   9 +-
 drivers/char/tpm/tpm2-sessions.c          | 306 +++++++++++++---------
 include/linux/tpm.h                       |  18 +-
 include/linux/tpm_buf.h                   |   6 +-
 security/keys/trusted-keys/trusted_tpm2.c |  93 +++----
 7 files changed, 270 insertions(+), 220 deletions(-)

--
2.47.3

