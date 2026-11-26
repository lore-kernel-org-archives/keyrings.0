Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795702377;
	b=LheqmyvWWDEfCf6z/0L93Y4lh1EasAs/ysTTZtVLRzhI1HXAgJIxp33ustubBYwpMdbw
	 U7XKdYyEsjnywAkIRpt2UxX1+shBp/H0ee3MuF3NDORV+0xlijbNrjwflXAOLa60L2h2T
	 DMMsjzobi+oih6ZRtnmsgZlJKsZvsZazLp38FKZd42tra7VpxwOuHsbqIwZnSeUWyng90
	 6j43DoDWP+kCiJqHeBPQCGWzE8eQTQQDTYZgTUGsuKuwfaur+/7X+nOoEFbaZKAxkRGqJ
	 PSQgpmdojKvyxgIeofDvP5J6rDOf9lg9mqVsEko4h/9hTCVj3TTUe+StNLPv+d304Tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795702377;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=LYH/RuGe2aPlDUYuIjnhsmnOEU9dOO/cT5aSku50wtw=;
	b=VxNG/7gY+btw/OPt4ywV/ulPf3Yx+hnvrsP/uY2QwnWswrgbiO1iftpcAmTr1uaTbVgt
	 7j2IztZWt2ddkBH4Dw3MIRnfbktFK0Ys9gBEXYyzXqOYIkaZFOXvwxOy+t4DlmA6U3LPo
	 3DnpQ0lCo4WNERArrnVy7VcG1KpFRkGB7N/TU9DvOO6rC2d/SA+N5Ovav4Znjp9ZPZ9uN
	 uqz82B4qdjOfqSR9S7LoINp0+2z9BWLgMNpcZKz8EyOWO2Usm6P2G4Bl4rEuJmXSoCxNO
	 oQ6YuVmT22jDMtMyY4eqdiTw+bhrFe0LkglPAyCP1M60Y2NKBDgqILzGM7m7OFnyyZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8LBLd+V;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7A606A327;
	Thu, 26 Nov 2026 14:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b8LBLd+V
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C101F000D1;
	Thu, 26 Nov 2026 14:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702376;
	bh=LYH/RuGe2aPlDUYuIjnhsmnOEU9dOO/cT5aSku50wtw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=b8LBLd+VPQQFjFhqxExt51TYZ2xkGRP2MqALpxn+CcsE2bE0Pqqj7IHbI+60bathp
	 YjakAVIinpyruwjbf8AXU6zLLab9NfUkGt4Dfq173InYnq+sBhLdyjWacLSfj6ICNW
	 Md0RuoH+kxD0bLR7oKp96lTSZlxSVJKRYPAb8UX+IjXR6WWboJAn8tcGoLHcWL9IBX
	 sYeeoF8J2v+ZLk7iMfgb7Ckk92RlmpzslJwo3G6whZ6NNTON4LIQL/yd/pOPZIzVd6
	 IRTogM8nzR7/gO/mMO6Viy3RVV6Nlwwk6Y3bd5CgVo7C5EuIGIZx6gU5VmuEOnsWVL
	 +j+Ea5UdC0gkg==
From: Hannes Reinecke <hare@kernel.org>
Date: Thu, 26 Nov 2026 15:12:22 +0100
Subject: [PATCH v7 04/14] Documentation/security/keys: fixup function name
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-dhchap-keyring-v4-v7-4-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
In-Reply-To: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Eric Biggers <ebiggers@kernel.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702352; l=880;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=yIHvpiweIAuxxVqephqS1I279bBXE9X6X4rNhWIZIWw=;
 b=P9JCvPHoMBUj6S7ZxHEhzE1AXDiyS5VrkA3bvYtWeIngAo8wZLiynveeddkoMeMszxGqIE9Wu
 g3IRJ19DLkHA8O5SJXCqMhrlDbD4AikMM5f8RrmVerdMWj64F+5qi75
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=

The function is called 'key_validate()', not 'validate_key()'.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 Documentation/security/keys/core.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/security/keys/core.rst b/Documentation/security/keys/core.rst
index 37ed42382f1672a5c822e7a042b077ffb84c7abd..c0f69e93e0c5f0efe0ae2e7a45a3a40391346423 100644
--- a/Documentation/security/keys/core.rst
+++ b/Documentation/security/keys/core.rst
@@ -1306,7 +1306,7 @@ payload contents" for more information.
 
  *  To check the validity of a key, this function can be called::
 
-	int validate_key(struct key *key);
+	int key_validate(struct key *key);
 
     This checks that the key in question hasn't expired or and hasn't been
     revoked. Should the key be invalid, error EKEYEXPIRED or EKEYREVOKED will

-- 
2.51.0

