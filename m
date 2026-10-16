Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3708A3CFF6C;
	Fri, 16 Oct 2026 21:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187635; cv=none; b=tLbstHbIP+/xg+byuOR0zT5WHmFzUDrPKy/aKc7BCyt2cx0P4q7ibObjUec1pOefkdgsb//tF1C/gTf3/lb9OawOyGQQQqM9CLut3YnvkRYGWLyFDBYps+4bsFaJOxEpwvbQnwuvXHdNcBKqPrKOGY12AsnI3wbRfHzKYJXVEfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187635; c=relaxed/simple;
	bh=ZcffgeoSSqWIABMNeSCGBrg4hjJ7aeGVv+K3tTqhG4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmE7mXExq8OUmMHdIvoc/AXnJXTHHbMmBrc4ArilN0Tr+9e4NexSv/7FpiO5Ns28opLPZll+76bOh2por2nUCg0Cvb/Z2LivTtt80hqbTPjzlUIvApVR2yJAZr8n9v9izellbhukLqXIU+glc/hwWAbZ5IYmEd14siVRCb6Ie+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+wo8n+r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+wo8n+r"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4652B1F000C4;
	Fri, 16 Oct 2026 21:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792187633;
	bh=F3CKgeXNXan1ZtlvQL5RMrO68jNwz1xB8OEfRsOXRsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q+wo8n+rTvYAW7V7h0awhBnIHMwyvom8iUNH5hAjJwbf7kjdpylSXHETmoPt4/t/j
	 7WfV7BGzhpx3Fc67d7EdR6PXqvKvv/31beG1fOx5wKoQB5sgolJkRW2MFRar36uqxM
	 wG6qYacqEqZ9aqw+xKyh9RMib9MoF1qjxb8SJlFGAWKlTHxwAPXxAGh0MHv4o8CFEQ
	 LieUTC1NyTJymDry2Y+AcZ5CQ0024iPivBWRwBenPelrauIouAZoTEzPD4rIt6VNX6
	 iXGjff7dOjXAf2HMU8HjfHxE8Cwb/6s825RWXypCF39ml12OTgHu7bgr3hogwpkUFE
	 puEi5uUB8sNMQ==
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
Subject: [RFC PATCH 2/6] keys: reclaim link quota during keyring garbage collection
Date: Sat, 17 Oct 2026 00:53:00 +0300
Message-ID: <20261016215326.4110064-3-jarkko@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016215326.4110064-1-jarkko@kernel.org>
References: <20261016215326.4110064-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Garbage collection removes dead key links without releasing their quota.
Repeated collection therefore leaves the owner charged for links that no
longer exist, eventually preventing further links with -EDQUOT.

Update the payload reservation from the surviving link count while holding
the keyring semaphore. If assoc_array_gc() fails, the tree and its count
remain unchanged, so the existing reservation is retained.

Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
Assisted-by: LLM
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/keyring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 7143f3079d20..db987c891811 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1755,6 +1755,8 @@ void keyring_gc(struct key *keyring, time64_t limit)
 	down_write(&keyring->sem);
 	assoc_array_gc(&keyring->keys, &keyring_assoc_array_ops,
 		       keyring_gc_select_iterator, &limit);
+	key_payload_reserve(keyring,
+			    keyring->keys.nr_leaves_on_tree * KEYQUOTA_LINK_BYTES);
 	up_write(&keyring->sem);
 	kleave(" [gc]");
 }
-- 
2.47.3

