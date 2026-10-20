Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792518221;
	b=q611V1CweRN/GbQsUhE24fjTmC3PbY4wQ7FFfaeesNgcNvvnfXD1fa74BBLfoecT5bv4
	 a+AhNE3ppw7uwWk6qLCKu3mpQdjrDsYD4egt0xstaFe8GqKOAIQYA6JS8hC4DEgKFkqEV
	 pfEw+L0om7wZXMtWzdaIYU0WnsTqWKKRXpQd9xKAo4ON2OADv0UOBplwYQkUcTUfXfssk
	 n6dcf9PMXLonbVl0ZaDX26eZcNA97kyCU5alyEEiyqesw2jiGZKaKAwJ5Tue2R66fjtaD
	 GpwJDwmHna/UJU8jDCk/RI7uIQNUXgNIXGi63gqoF5Nj70KZ2KUkpxvLPQ28DLtCS2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792518221;
	h=Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UsrPD1PNEgGqjdV4maZxwHGg+MywiYUtSmtE7Vzz5Pk=;
	b=AIxrBUFuOS24jUHz18g79BE9mHupoVZg69zyiGCy2QWmMR/uHgPjDzjtEELvp3stuIV1
	 RgMU0TM1LlUdAAv1NKzRAeopOLIHumocqp4ftVHApbXYvYz47yfWZ7mFiO+l2kpGLKb/o
	 y6vlH8OkcMlxNGKxtttRvhZmlYk1/jDt9C4pUufgMaS1v/5aMhxo99XZ6tSbQktHDUwPS
	 eyP5L+WaT87QiTniuDYWTLntKnhY1BNnMEygYFfQS39AGxl2xEQnRG9+gBqI0alFgsl0N
	 6dNlsn9uRRLG8gyHh04RBpVv51+yMUIRDCfk2IcI6WXg7na2X8sU+24BXaSXnBuEa/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 823BA606A31C;
	Tue, 20 Oct 2026 17:43:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8F4451F000C9;
	Tue, 20 Oct 2026 17:43:40 +0000 (UTC)
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
Subject: [PATCH v4 0/3] KEYS: rhashtable bug fixes
Date: Tue, 20 Oct 2026 20:43:18 +0300
Message-ID: <20261020174325.2229448-1-jarkko@kernel.org>
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

- v4: Based on Eric's feedback did inventory of sites where description
  can go unchecked and fixed 2/3 accordingly.
- v4: Addressed Eric's remark about cifs_dbg() statements that need to
  be changed in 1/3.
- v3: https://lore.kernel.org/keyrings/20261020013903.1244157-1-jarkko@kernel.org/
- v3: Added couple of example, one of my own and other derived from
  David's snippet.
- v3: Removed bunch of unnecessary INT_MAX checks (Eric).
- v2: https://lore.kernel.org/keyrings/20261019181732.449591-1-jarkko@kernel.org/
- v2: Addressed issues pointed out by David.
- v1: https://lore.kernel.org/keyrings/20261019142516.300040-1-jarkko@kernel.org/

Jarkko Sakkinen (3):
  KEYS: Expand key->{datalen,quotalen} to unsigned int
  KEYS: Reject descriptions larger than KEY_MAX_DESC_SIZE
  KEYS: Verify the key identity in __key_unlink_begin

 fs/smb/client/cifsacl.c     |  6 +++---
 include/linux/key.h         |  7 +++++--
 security/keys/key.c         | 10 +++++++++-
 security/keys/keyctl.c      |  2 --
 security/keys/keyring.c     | 13 ++++++++++++-
 security/keys/request_key.c | 14 ++++++++++++--
 6 files changed, 41 insertions(+), 11 deletions(-)

--
2.47.3

