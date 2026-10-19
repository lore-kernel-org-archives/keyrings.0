Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BD34DCB09;
	Mon, 19 Oct 2026 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792419929; cv=none; b=MdaN6gmSWhaQZi818RQcp1oXnIqDrJtkSmQVAfRDL3xYYGCQb8zh0l710NuvzXCw1KoeSw222pzbGmiyvHa6SUEXJx+lHZJ1hF2QcXBNzhDfI4Jgg83CekKXf0+sGxfXcpUrIzn/eIvwph5cctOhuzLj8+XlCp5zEdeZc1D1K2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792419929; c=relaxed/simple;
	bh=AkKljxyoIqR2RIyvk0/2XUONiXvWnnxFdHZ9MMJO+tM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JB7Hhvz2YX2En+DMgXUpfmKNl6VghT5r/PvEXbuQiUG8TUvAQZWRK+j8Ts+6bCMCXXnMHYwqu7K9SsO9jaYLWuVO3dPG4m7i+zgrOCbS9U+b1rfHCdPqXqU3iqkzLJt1tW0uE40m6QXPRyYwXeNLZ+EBwO+nmpQgRR9WimynGMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckkJpmjf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckkJpmjf"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4CEB61F000C4;
	Mon, 19 Oct 2026 14:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792419927;
	bh=DtqFb8ZOAZlbqLQ5DEJdHYSH01b+QPRSmC+3hrE7Q2E=;
	h=From:To:Cc:Subject:Date;
	b=ckkJpmjfAhfn5/vocRPNzjnEnpg6chpjqBwsAm5VgpwYpzAMHULxhgVKbC+MH1mlK
	 AD6lxcOG+MA4mcVmspMEQf8JiW/Rdw82+VlbsZCHCY+vpv8H6h4QYBrqIy+ElcZBqQ
	 IE0zC2DujX1Gt8p0plAn0fqimSv7oKUzV98JBxrTyIZQUwsDmWEXYjA3T1UfZziYMq
	 Y9iCSOFadLyFrsKGkU1mJXO8dHTiZcKxZxnd3hSudJybkIdb7xvh/u4fVHg2eWRXoG
	 VPvoVdLP5FcpxDFs2mbkz1We82FEP2x5J9rLAq60dhyj5bRYeNZKUaMmFCy4KV3VY6
	 fDOpswSgT8TJA==
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
Subject: [RFC PATCH 0/8] KEYS: rhashtable bug fixes
Date: Mon, 19 Oct 2026 17:25:00 +0300
Message-ID: <20261019142516.300040-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My patch set that migrates assoc_array to rhashtable had some LLM
scavegend bug fixes. Unfortunately most them where either plain wrong or
not in the right scope. The bug fixes in this patch set are by human
labour constructed fully but they are derived from what I got out of the
original LLM source. Thus, they are tagged as LLM assisted.

Jarkko Sakkinen (8):
  KEYS: Change the type of key->quotalen to unsigned int
  KEYS: Change the type of key->datalen to unsigned int
  KEYS: Reject @desclen values over U16_MAX in key_alloc()
  KEYS: Prevent overflow of user->qnkeys in key_alloc()
  KEYS: Prevent overflow of quota in key_alloc()
  KEYS: Prevent overflow of user->qnbytes in key_alloc()
  KEYS: Reject @datalen values over INT_MAX
  KEYS: Verify the key identity in __keyctl_unlink

 include/linux/key.h     |  4 ++--
 security/keys/key.c     | 13 ++++++++++++-
 security/keys/keyring.c |  6 ++++++
 3 files changed, 20 insertions(+), 3 deletions(-)

--
2.47.3

