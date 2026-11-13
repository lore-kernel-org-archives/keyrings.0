Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597271;
	b=YZr+UEi4qUGXlgkYoe/1c3ybkkGM/EG6LeQLgc17P8FFKzZIbeQJHTjAhf9QbNXpegGg
	 CAs7yoKxG2z2n8NCflwShUU5xmhgXeQw5gYuDVv9MVQKQoSp96B+VU0i1UmPIBfaB9PIa
	 d/aJc57wBPxk2uRp0N9xKHZdgpGxbOc6V6MoMlEdIhgz37ecLog6ya7BTrEE8vRpNCcS2
	 lDutVFqFjKKaF5C08SQ0gdBbGQahEhI7aKfim9ZBGK/+5/vg8WvIKps51IUTlBtQPlz7n
	 sxTlYOeCKUUc1H8NoX9HUfug2WiXfinSCqMx85d6KbrnxwG9NSmop1iz8o9tENUSVKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597271;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:X-Mailer;
	bh=Z4yYXkmxh701AcFaXQRx0Ej7ViNSTX0++LPPaE17898=;
	b=TOCux05iBOlbsn0uO2KTsxXfC4jFjwYz8KQSQrdpLNuFnGiDafLln4T7MXbgyFtCmU4C
	 eMk/dpoA1k1A0lans+KxkMZ5RzKWR4Okn/YWKn7ij0vQZtsiXx6QcdnPH117XAM+Gh8sJ
	 qjGYpL51ynL9+Lfb4foFGF4hd1jKHHEYLC4UViP0SPKtzhJ5/U+uKDOW8EmyjIYM66xMe
	 ajIef4mysZKubQ1yaPw0Kxaa59HKX2rw33uz+E94MyRXtMiVeHCOhcgOBFEfbbozCK3qN
	 hQpPzVuzI7ZKGW25bR0r5UR1U6mS6l4zpdzXSh5XcC6NOLfy/wWznCgZqleZ91djEdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IsfoCP0+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 91510606A331;
	Fri, 13 Nov 2026 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IsfoCP0+
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A4EAF1F000C4;
	Fri, 13 Nov 2026 19:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597271;
	bh=Z4yYXkmxh701AcFaXQRx0Ej7ViNSTX0++LPPaE17898=;
	h=Date:From:To:Cc:Subject;
	b=IsfoCP0+CDhYTRrZNsK/b4g9RK3UIcQVMNMgpANt/1EpdCj7xaIdHl42GPoBQGX22
	 m3s3OfkXqnIanESxvpudAZx5OhG/73L8PF0wI2y0HVRlOHxMjNH1ATKBZ/K+bzyZcG
	 4CM+YfwTuxi8LJWSED6SBAZpGS3QxsFNESup2Ep8novQzbeM5OLV8gqkAKeNsCyO6Q
	 2J7tAzZH1Pqm4MPPKVf8mmBtHfetAI9vBwFvxbSuPm+4WgMLwilNFkux3lC5rWh7Wk
	 voU2xPl7SmELbCpGnXNtWS7FoE/K9AhG1pLek/J4yTLwd7EIthfAN1HT9SbYi6gti1
	 rK3r0BaokaV5A==
Date: Fri, 13 Nov 2026 21:14:27 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Eric Biggers <ebiggers@kernel.org>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] KEYS: changes for v7.4-rc3-2
Message-ID: <avdhk_n9dwfd4jVk@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: aerc

The following changes since commit 7e1392a42ea288d70a266f6553fe06f57f8647ea:

  Merge tag 'net-7.4-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2026-11-12 12:26:14 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/keys-v7.4-rc3-2

for you to fetch changes up to bab48a1044475f62d6e910c6d7267ce4bae847f9:

  KEYS: Protect pkey method checks against type removal (2026-11-13 06:28:55 +0200)

----------------------------------------------------------------
[GIT PULL] KEYS: changes for v7.4-rc3-2

This second PR for v7.4-rc3 bundles two bug fixes:

1. Invoke the match callback before the state checks in
   keyring_search_iterator(), so that a non-matching revoked, expired or
   invalidated key cannot decide the search result.
2. Take key->sem for reading around the ->asym_*() method calls in the
   keyctl pkey operations, as a key reference does not pin the module
   providing the key type.

I decided to send this in order to get the remaining key type fixes off
the way.

As said earlier this week, I have made a patch set, making the life-time of
a key type dependent of the keys that use it at the kernel module level.
My goal is to land both rhashtable changes and key type changes to v7.5,
as that would provide a nice baseline to further improving keyrings (and
IMHO best picks as starting points overall).

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

----------------------------------------------------------------
Guixiong Wei (1):
      KEYS: do not let an unmatched key decide the search result

Yuansheng Yang (1):
      KEYS: Protect pkey method checks against type removal

 security/keys/keyctl_pkey.c | 100 +++++++++++++++++++++++++++++++++-----------
 security/keys/keyring.c     |  12 +++---
 2 files changed, 82 insertions(+), 30 deletions(-)
