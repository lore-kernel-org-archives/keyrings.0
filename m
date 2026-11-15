Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794782860;
	b=IeZuc1G9iHUGwEiSa7ZJTHelXJxTDMf4o7lT6yJekCk4MGOeVWn1reHlS/3ALBcc1pdT
	 gbIxnU0hA+YNhQ8tw+R9mXroIE+FrXD/ehlOVT+/tgFh9qm98K/clu9UZw7jgkCmLxdSY
	 WlTLkcxBioinwZtvNQxJCy4d4OCqNH9hoXcHlIzr6LIbOxPFdrac2uKP2Xbt7GepLDI2c
	 icFW7q8WbyhMUZCtHdHWr59xYC5fj2H5Pvcq0TjhDuJeealbq7nbPYDGAxwkX+e0TCIFI
	 xAl0Eq2nbUi1UKjcUua5bjocsF9Mf+fLasjGXxOJP0FxAwYXI3UWiyXuqlv6waUBSSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794782860;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=+Tf+UVJNNqwfQuJPLkLxjfIIKeJvdyIz5W+MkNPeNvA=;
	b=Mbi6eRWLEJFi0CbfCrCU6ASzjStKATJqpWJRV9+9T+bNUGDB1RNICUHR+RlvyW25EG17
	 8n+SHIN3/MgGIKRoffkcQsDNKR4J6g/lNzjzPbMNGIcdN29lGhjkyBrEcsfif4qKayBqq
	 Jj2CCZB+HVD29YhRUOGOF0WM7NLsGSGjLqf/iw7XuaRgyoyir90JMdLohzPiXzMoM6YKe
	 By8bvqPK5H2OlTrImb2fPhwras/i8AzaihKWUHPyfjYhgbKzDuLMWnvfFe3t0Txm6+8C+
	 VQmrfZahTHu9yw0aETnPDfMaiIcDSChU75cy0vbE+j0rVoQi2SSWKDggfzsK2zkryXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jf6C/4Nl";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0E513606A32C;
	Sun, 15 Nov 2026 22:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jf6C/4Nl
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 163671F000C4;
	Sun, 15 Nov 2026 22:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794782859;
	bh=+Tf+UVJNNqwfQuJPLkLxjfIIKeJvdyIz5W+MkNPeNvA=;
	h=From:To:Cc:Subject:Date;
	b=jf6C/4Nl3SYLAHyo0t06TyDs0NuudQLmj1HzuynYQTXevRLLNWMXhlaB6DOhshVr9
	 Lx3dRZfLLI8LtrNwSbvDcJwJqFKvG/1Y+rrxpmLFPJWdUCD0SPNWzWaiN8Myv9LxK6
	 bf3glI/kPXcbsVDyQXKUu8UTyn5UWHttP2s+BQZgPRgXfQ7OpziY/UfieTZcvNnI90
	 P4taU6k2WsZYrtbkQQmxMQ4x2QQWTzHMWBGKV2xC/U74UUY43D1t9TqQdL88EsXGll
	 MQvgwIsRQOc1zRPOz1AwsPOxQLkTpGnTYNrra2lf8vL2GzD571X75AIepYRtEmASE0
	 iukkkEY7lqqYQ==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Alec Brown <alec.r.brown@oracle.com>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	James Morris <jmorris@namei.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Jonathan McDowell <noodles@earth.li>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Paul Moore <paul@paul-moore.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Ross Philipson <ross.philipson@gmail.com>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: [PATCH 0/4] Unsorted tpm2-sessions improvements
Date: Mon, 16 Nov 2026 00:47:18 +0200
Message-ID: <20261115224722.1450498-1-jarkko@kernel.org>
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

Cc: keyrings@vger.kernel.org
Cc: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Cc: Alec Brown <alec.r.brown@oracle.com>
Cc: "Daniel P. Smith" <dpsmith@apertussolutions.com>
Cc: David Howells <dhowells@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: James Morris <jmorris@namei.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Jonathan McDowell <noodles@earth.li>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Peter Huewe <peterhuewe@gmx.de>
Cc: Ross Philipson <ross.philipson@gmail.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>

Jarkko Sakkinen (4):
  tpm2-sessions: Drop TPM2_NAME_SIZE
  KEYS: trusted: Open code tpm2_buf_append_auth()
  KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
  tpm2-sessions: Re-orchestrate tpm2_read_public() use

 drivers/char/tpm/tpm-sysfs.c              |   2 +-
 drivers/char/tpm/tpm2-cmd.c               |   9 +-
 drivers/char/tpm/tpm2-sessions.c          | 121 +++++++---------------
 include/linux/tpm.h                       |  18 ++--
 security/keys/trusted-keys/trusted_tpm2.c |  83 +++++++--------
 5 files changed, 93 insertions(+), 140 deletions(-)

--
2.47.3

