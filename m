Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC18390223;
	Thu,  9 Apr 2026 22:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775775508; cv=none; b=pAjtuExGkhWp+optwSKyEn0qUCWUHnSaOoId/BcSqrQdz6Pbz2RomXOvAFCjhUZO0hqzXBfiM0YFx5eAdMh6Dveew0uvcxlcvlZwnWmzjWc1CB6UOZLaOhedyEbjDkBEYdHZy3a5rvV4JwGa4FtwlAYAaAJiE2RkthZS2YdLL2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775775508; c=relaxed/simple;
	bh=qrSPnQzw/gdM7fHPn1fcyeOsexQXKfPqSvfyGGPJJrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPyIVLkyoGl41YqxBJ8IFsYmVHXwUd5vjF+90zGn7crH5r/AIoiqPrV5v5ow2QYC156YbrhNXuhsxnPzrHeBPNvEXtTNr7/68DgCbnHuvzeQ93ikDfN+97LVsBUDErcOAF4u+Zoehz8QqvTkereMbp85EoHpW0wBM0BsRFhnaYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qMZOHPM/; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qMZOHPM/"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775775505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2QmwkRKwrZzFhOxslhCRneQBH4U9C3GkVTQuu656kzs=;
	b=qMZOHPM/7ty4cnPkjzbbz6CmjOCC2XKzHAX7lpC2B2e9cQEhIkSFwPJIaVCahV5frckWaE
	3bMU5YFA/qqoP8621JrmvneahZFZ8TonJ9FI+JLq7h7GOvjl4vapOiQH1cdd6GVxTaqSpm
	jBoUiCYNArKPs8atoOEPv298StbT0Bg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v2 2/2] KEYS: annotate struct user_key_payload with __counted_by
Date: Fri, 10 Apr 2026 00:57:05 +0200
Message-ID: <20260409225703.158552-7-thorsten.blum@linux.dev>
In-Reply-To: <20260409225703.158552-4-thorsten.blum@linux.dev>
References: <20260409225703.158552-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=996; i=thorsten.blum@linux.dev; h=from:subject; bh=qrSPnQzw/gdM7fHPn1fcyeOsexQXKfPqSvfyGGPJJrE=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJk39I4s/9y/RLjCglO/XbLz4FJB70sJXLbNrz/3Pp5vG VOr1f+so5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACYSdpORoevz5+vKMqJbmiUK 4x23T/X6yCFg9OB320QXD3EZ/T1G/Ax/OL8e2hE1/1fwh8y73UsmC8/tu/tqpVRxpndHxaLLCy0 W8gAA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by() compiler attribute to the flexible array member
'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Use __aligned(8) as suggested by David
- v1: https://lore.kernel.org/lkml/20260409073711.57020-6-thorsten.blum@linux.dev/

Cc: netdev@vger.kernel.org
---
 include/keys/user-type.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/keys/user-type.h b/include/keys/user-type.h
index 386c31432789..c29ed9f5d300 100644
--- a/include/keys/user-type.h
+++ b/include/keys/user-type.h
@@ -27,7 +27,8 @@
 struct user_key_payload {
 	struct rcu_head	rcu;		/* RCU destructor */
 	unsigned short	datalen;	/* length of this data */
-	char		data[] __aligned(__alignof__(u64)); /* actual data */
+	char		data[]		/* actual data */
+			__aligned(8) __counted_by(datalen);
 };
 
 extern struct key_type key_type_user;
