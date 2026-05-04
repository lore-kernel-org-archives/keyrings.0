Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E28B37C0E2
	for <keyrings@vger.kernel.org>; Mon,  4 May 2026 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777887151; cv=none; b=rk6R9kpfw/0j7q91tdphxaowqCALX+XFJUyflElJUjig/AEzShKUfMWVpI24EvD4rvEcWnxz60TWM/LDfYOzSHvqMKXgW/fjSo8t44G8zusPVdubrnNxeRtQ0dG4opICLeJSwSwouyZE/op2ujUehtrLvj8p1A2ypHD5o6MKRts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777887151; c=relaxed/simple;
	bh=d3jjdlqxS6Pmw3trIxP6Y5gG4qE55vK24pn1BNcI6qk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oZXdsfJU4tB5Gtk2+2jhOfdFLN1O7awrp+CqqC1h83eXcF4gF/dRn+0WxH5K+5Uz9HpkyNycNuMVcV0NDO5Nb10I8pnsdmiN8/ZTgbmkfKh8dI20ldBlp4LappxgH7Ij4vsyefXh2stw/kzG2Xj8rBm/CIhEAo4ufy0Cwb28nQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YiHk0+5n; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YiHk0+5n"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777887137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mMEES11wDto3t464bsRDzt/19GId/Z9Kgc8sPF4Za/M=;
	b=YiHk0+5n1ReXGiQ/q24ADGzOzk56aJacS086ZYJDZwjoVt5jq9wd/7E5Iizc6F47i9lg5z
	3jQJ6VSo9my3OymkprP7/McKwjbakfKi1TCz10WqQehACDslRy+P8HTWctsyxQVNCh5VsO
	wlHJwf5LFkJu56RLs/C+LRatk2zpisI=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] keys: use kmalloc_flex in user_preparse
Date: Mon,  4 May 2026 11:31:00 +0200
Message-ID: <20260504093058.49720-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=809; i=thorsten.blum@linux.dev; h=from:subject; bh=d3jjdlqxS6Pmw3trIxP6Y5gG4qE55vK24pn1BNcI6qk=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJk/0oNnSO2vKRDKPudyZj5zmP3WvDeuBhxOAgyWiXP6W YJn1b/oKGVhEONikBVTZHkw68cM39Kayk0mETth5rAygQxh4OIUgInodjMyvHgRuuLkdENn0XsB UStrTpsu2Sv86bGIqcEtr2bWIiHWXYwMHbEOwoc0i1dK6BnenjfJ+8g9M8fFx0X8Hd7wTQ2dyxH NBgA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use kmalloc_flex() when allocating a new struct user_key_payload in
user_preparse() to replace the open-coded size arithmetic and to keep
the size type-safe.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 security/keys/user_defined.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
index 686d56e4cc85..6f88b507f927 100644
--- a/security/keys/user_defined.c
+++ b/security/keys/user_defined.c
@@ -64,7 +64,7 @@ int user_preparse(struct key_preparsed_payload *prep)
 	if (datalen == 0 || datalen > 32767 || !prep->data)
 		return -EINVAL;
 
-	upayload = kmalloc(sizeof(*upayload) + datalen, GFP_KERNEL);
+	upayload = kmalloc_flex(*upayload, data, datalen);
 	if (!upayload)
 		return -ENOMEM;
 
