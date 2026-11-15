Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794785524;
	b=IdMlDzNfX4knRAZLqRCiFDbfRzOivtD36xUFz0DfskDflHBZhI2V2s1KVL3vXM6v1y7t
	 sktG+iW/U8jwW1Q0JsWbg57ojiX6vq1hn/gUUDkZ09qFCCbfME0/F+YTK5RgI2B0r6ZVw
	 Qdnc/lA8DAabe6zSx8NIzDNuPqMQ7HZa16XNHMmiQ3tcHlxqB44FQlc+3EeInEuUDouG5
	 LpAULRSiebUrpwPNVThXr18PpCLyBYfZOw2KbXlikm9vDxP6j8WwA3ySYtvbi02tus7Dd
	 no5PwwnjzabgzhAUqvX4KwpZHxZI2bubbCgnJDK9RYkCXNzHtxNCAHfYb5i1ejzo2Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794785524;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ytIxIwr6br8Q7j4ICaVLl42bA9q2oRyUdCjL5+um0dg=;
	b=LnxYX5ayiNqgQMiyZpvi5tA6+8fsIzL7nP/MKEWDuaVDu9JcuTiAgO7sW0QFQzN6YmoM
	 peDJGFVYv4p+MiNwxinYzQZz71YBcoXpDAgbA46yoSki3doetjTGZZZUGstW6Mq8qgZpx
	 +afr79JmEzaVBBfVyY96jJKRblwF9IBMq2nNCNeOqLMHN3HhniCKljRCPZlp/iOI/+qK2
	 EaCh/b8BVZ3LOrK3Zih7+5GOcr5/cYxqVzSwLx2QMIncWDmzHGI48VpdZtZ7hfKCk/bCk
	 NEIxCxxTf9WgO8XX01BPxNbf5sPUMFDG86y2Pt57l5e/yHr/9u63CsC8SkUFciq5Bcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EJC8gV5C;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E311A606A31F;
	Sun, 15 Nov 2026 23:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EJC8gV5C
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E4C741F000C4;
	Sun, 15 Nov 2026 23:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794785523;
	bh=ytIxIwr6br8Q7j4ICaVLl42bA9q2oRyUdCjL5+um0dg=;
	h=From:To:Cc:Subject:Date;
	b=EJC8gV5CW1Yu5WUDHiifadjpuZBnFwthH883SK9t2s1KjiK5Dc3fvZ4BoqCNkxQrt
	 Ub//qOXwD+2s9O8qg9+mN08vvm63bpi5pzevjAxFd6ElUx47N3FPU4biTSKHqqhlf9
	 /O8pgKSdAKUw1nGxZwFYvBOVTeqer1Lj9/mKACEt/lj9bLoTseowRf4vSaI5M7v6Vx
	 +xovIVxL/COIMERG+SIvnWdx5nhHcVlPcIZ3xEWp071bcXVH5bIlnVkk3ZLVV0gsNO
	 4lN/MMBW7NZAvBZcWA6DNPoN/XpLLNiVQ5yHSdf821/DbqxBNOi1imvd/PSgZa4DJl
	 6t2EK65oAzjyg==
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Alec Brown <alec.r.brown@oracle.com>,
	"Daniel P. Smith" <dpsmith@apertussolutions.com>,
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
Subject: [PATCH v2 0/4] Unsorted tpm2-sessions improvements
Date: Mon, 16 Nov 2026 01:31:52 +0200
Message-ID: <20261115233156.1485238-1-jarkko@kernel.org>
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

Jarkko Sakkinen (4):
  tpm2-sessions: Drop TPM2_NAME_SIZE
  KEYS: trusted: Open code tpm2_buf_append_auth()
  KEYS: trusted: Remove dead branch from tpm2_unseal_cmd
  tpm2-sessions: Re-orchestrate tpm2_read_public() use

 drivers/char/tpm/tpm-sysfs.c              |   2 +-
 drivers/char/tpm/tpm2-cmd.c               |   9 +-
 drivers/char/tpm/tpm2-sessions.c          | 124 +++++++---------------
 include/linux/tpm.h                       |  18 ++--
 security/keys/trusted-keys/trusted_tpm2.c |  83 +++++++--------
 5 files changed, 95 insertions(+), 141 deletions(-)

-- 
2.47.3

