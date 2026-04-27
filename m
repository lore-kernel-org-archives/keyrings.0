Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59083128A2;
	Mon, 27 Apr 2026 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777290390; cv=none; b=qC1XJkQUvJiQOk+R3xvaJ8tRB6RSjNYz55WsnqZR30kgd0NKKbbBI/6XVe/dMpk9Y8wxNElUBIepL/rcvov7xjGwQJVuSR4wp6CfuQLBzt7T1rJyy5BmUEDGmzCqoTQe6k5Y5hg5p1RG0Jle+WtTHRfCxKAIyO3Q3zWtiCTpuNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777290390; c=relaxed/simple;
	bh=CTj4QwE1RWL3i8XJdtIRCIYzLjALNk996d85++ya1yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XtawYUFLIa4yw0S5k3Z58sKWSbf/ju5lpnAcji+OvL0sVmI/R7lgGzkAqEeuzG6uJKa2gmatBj8sO/k0QdvHgxfF2Q/P4cqHNBtx3hkJeRZGrBqrzLmQrL9yp4A4doJVNeC13FB4ha5CQ6bksmNktPCzCEIRXtayKCtK5qUUWBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u42SxLhm; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u42SxLhm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777290386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8BW7GQeRm82gJgeFBqFgMlL65ttm9v5/emTGsqLJjPc=;
	b=u42SxLhmacDDfSoqTNO7eZKLEI4/AT+EWlfQ70vVOUGJgV2BGvJWs08GcF2zqA9A69iAp6
	CyTBrphoHtXre1Ecn3a9gTWizlZT/P84UDC/qOXl9aUEdVH9oKZhLOPz0yhC+UIi85pWUC
	ghzX2OW3Z49wv8eC8wqKyGwa28QJViw=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Tim Bird <tim.bird@sony.com>,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v3 1/2] keys, dns: drop unused upayload->data NUL terminator
Date: Mon, 27 Apr 2026 13:44:23 +0200
Message-ID: <20260427114422.313356-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396; i=thorsten.blum@linux.dev; h=from:subject; bh=CTj4QwE1RWL3i8XJdtIRCIYzLjALNk996d85++ya1yw=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJnvfcQUg7vf8P+dzX5OviQ+4rP+j+/zndlcSsy5bwXbH d54ujOyo5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACZifo/hv9PZgomXW4/nr2Th vHFP5l3aBnHfCR/XVX0WOffhlMnUWQoM/32nTq1+tc6kaAPf9gfKpyr0YlwL5wavEWnqNH9nopo sygIA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

->data includes an extra NUL terminator despite never being used as a C
string and only accessing ->datalen bytes. Remove the redundant NUL
terminator and allocate one byte less in dns_resolver_preparse().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v3:
- Update commit message
- v2: https://lore.kernel.org/lkml/20260409225703.158552-4-thorsten.blum@linux.dev/

Changes in v2:
- No changes in patch 1/2
- v1: https://lore.kernel.org/lkml/20260406175810.1018681-3-thorsten.blum@linux.dev/
---
 net/dns_resolver/dns_key.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index c3c8c3240ef9..451247864a63 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -203,7 +203,7 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 	kdebug("store result");
 	prep->quotalen = result_len;
 
-	upayload = kmalloc_flex(*upayload, data, result_len + 1);
+	upayload = kmalloc_flex(*upayload, data, result_len);
 	if (!upayload) {
 		kleave(" = -ENOMEM");
 		return -ENOMEM;
@@ -211,7 +211,6 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 
 	upayload->datalen = result_len;
 	memcpy(upayload->data, data, result_len);
-	upayload->data[result_len] = '\0';
 
 	prep->payload.data[dns_key_data] = upayload;
 	kleave(" = 0");
