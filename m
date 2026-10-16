Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6302F1EB1AA;
	Fri, 16 Oct 2026 21:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792187649; cv=none; b=I+ZrPJxbDWajwjele0AgHeYoX0UPhre+Imsh524cILdM6CDbIbSfNPx92S9YIkDBeUgkVu4XlgIMQFTVqR86ZtUSN6QDd8ijT47RFpew5kiQFN/CJuQ+c93RxKHN/FAXSfSvD02dcd5ksJC6PKjVfwf4jYX7DHVGFJZBhVBJyJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792187649; c=relaxed/simple;
	bh=0kflb0bWLtmbVOFU15VI9Ds3NqHTTDUOX6Jy3xj/Qzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VaMxSqaBePaMfx01VU/wkvmPMC9NgSxkVahikeiPP+kyPfStacbQCFCh4x1ceU7bf93qD8WnUcy5AqCCkz7E4dUnj7BqBhtTLXNX4FEFOCOdv3Q+Wm3C0UNPUpzEXdyqxzbqkdQARYY9ro+XWWBdGLJytgp4sTk+e7QUApr6FQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9Vnkdvj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9Vnkdvj"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7EB741F000C4;
	Fri, 16 Oct 2026 21:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792187638;
	bh=oWcjka98DvyVnPt0ruaStqzY6PCBNQcRZpwZCmuhhwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k9VnkdvjYlBB54N86aLoq1CYzO83nai+xhwgmfQ+BpBA/jgsnSlu03m+KCtZWGrgh
	 7xewEWq96w9l343tp1kwVyY2nRhhkhpjJkzsUTjEPzJBa5s74Z8210L7whnkIcJ97D
	 vXIixBTGJuKavjMNniI8j1S8yDTtJM0uP9oN6ufAoY4khi8dauIoSu8pdsczhsl+bP
	 v9Fgq9DEUh0+uD3d5sJE/eAp5kUZd8NCWjUiWeaN7s85WtHTbnlvwXdzmacd1T72Q+
	 tgX6c/NPZ7OQaH3vyHyBSg42KqgyjrV4TB7I3d3MQtjLhHpPkg7NxpnjnM+n9NbJUJ
	 AO2JcUe0w6DXA==
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
Subject: [RFC PATCH 3/6] keys: verify key identity on unlink and move
Date: Sat, 17 Oct 2026 00:53:01 +0300
Message-ID: <20261016215326.4110064-4-jarkko@kernel.org>
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

__key_unlink_begin() matches keys by index key without checking pointer
identity. If distinct keys share type and description, unlinking or moving
one can mistakenly unlink the other.

Verify key pointer identity before unlinking, returning -ENOENT on
mismatch.

Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
Assisted-by: LLM
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
 security/keys/keyring.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index db987c891811..9ccce0db0665 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -1501,9 +1501,15 @@ static int __key_unlink_begin(struct key *keyring, struct key *key,
 			      struct assoc_array_edit **_edit)
 {
 	struct assoc_array_edit *edit;
+	const void *object;
 
 	BUG_ON(*_edit != NULL);
 
+	object = assoc_array_find(&keyring->keys, &keyring_assoc_array_ops,
+				  &key->index_key);
+	if (!object || keyring_ptr_to_key(object) != key)
+		return -ENOENT;
+
 	edit = assoc_array_delete(&keyring->keys, &keyring_assoc_array_ops,
 				  &key->index_key);
 	if (IS_ERR(edit))
-- 
2.47.3

