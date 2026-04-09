Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D463164BA
	for <keyrings@vger.kernel.org>; Thu,  9 Apr 2026 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720318; cv=none; b=cRzLAdIwFgQ9KtMipG7yqnx720OZ4TbCTp/DNmIEEZGqcNtCKJbmBmAqhz59+3FpNmPsap2+Vpesk6tKsc+QlsTDB0gjbLKVKaZcGtHnaO06/ME5aU6CRfw/Gzy2uuC51Vdlt/JAeuuri0uv7dD/xZF2QoGF1xvnAWOpEob319c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720318; c=relaxed/simple;
	bh=jUVCD18qBj55kiQf5LCb0CfnXhvlUgd5d4yqTC7/xCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GvdRhCZk2p/GhdOi56VgEg1DBRaUka8muQVNAhVb35lZzaEuFquSlL0UJ0/tLQcjz+8Gxbl4TeMkGaLqVclW6Qp6sHf8BLIn5nuNtOOCPPlya45syTkQwqPadCSv/bJcw0r0HYP8PXouClgpN+uLStkAesNONSXdfxES6oOANcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZOJUrxfH; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZOJUrxfH"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775720315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AiTN0Mif+OlOP/8EPg85nSXf7Y5Nv8jHlAvMHMDCs20=;
	b=ZOJUrxfHxIiSMG4KLG5gzEWNzkptjlTg0dGlAbWcYpARzsszbaCh6rjBSg2l/hpxn74yun
	gcigbuZOgomb074+8LBZV6iYejbJjvrq9A1ZKjnHKcMjpND++QW/XOuyta5B/nJB/zjEwB
	HUJWB8BVcNjOggS16UcsgqU02Kj8uVU=
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
Subject: [PATCH RESEND net-next 2/2] KEYS: annotate struct user_key_payload with __counted_by
Date: Thu,  9 Apr 2026 09:37:13 +0200
Message-ID: <20260409073711.57020-6-thorsten.blum@linux.dev>
In-Reply-To: <20260409073711.57020-4-thorsten.blum@linux.dev>
References: <20260409073711.57020-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=930; i=thorsten.blum@linux.dev; h=from:subject; bh=jUVCD18qBj55kiQf5LCb0CfnXhvlUgd5d4yqTC7/xCg=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnXw9WXpfasVXvPK1hQdNRTsS/H/d9hIaVFq3ZMXxEoc eSmUtHNjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZhISw0jw436jQL9uVbnEyP2 NLP3affN2rMyLKG1To9TTvuA9W9hSYb/Ecfy1XQne6aeS/D/uVBHtKVurui6qkOBlkWsuxSctzR zAgA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by() compiler attribute to the flexible array member
'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Resending this because patch 2/2 didn't go to netdev@ (Jakub)
Cc: netdev@vger.kernel.org
---
 include/keys/user-type.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/keys/user-type.h b/include/keys/user-type.h
index 386c31432789..2305991f4fcd 100644
--- a/include/keys/user-type.h
+++ b/include/keys/user-type.h
@@ -27,7 +27,8 @@
 struct user_key_payload {
 	struct rcu_head	rcu;		/* RCU destructor */
 	unsigned short	datalen;	/* length of this data */
-	char		data[] __aligned(__alignof__(u64)); /* actual data */
+	char		data[]		/* actual data */
+			__aligned(__alignof__(u64)) __counted_by(datalen);
 };
 
 extern struct key_type key_type_user;
