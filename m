Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBD238CFFC;
	Mon,  6 Apr 2026 17:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498342; cv=none; b=A6zQDdkoGdAzlLkFXEkJgGrQJ390A04b2oiM2iHUJfF+JQ0T5RCy3EumRx4zLumxB8iJ03qbDVFYot2hJyUbbZulcF5PTubR79OA76NveMU2JUYEH/g2uu3GFP+nYSawKNOT6zJ5WgHn00G4klP64aEoh6sq7w1iuqDoag92990=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498342; c=relaxed/simple;
	bh=WKatVZ4ijznTXfeAzfxBPkp0ScePMGQUAQ2+GI9ot5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KkaaqF8L4LFvbw86L73HaYqq7P5PEZUxFuHZsxktZr/ccdLoByrYO6Rn2sPlFX8agFhrODN8uVTop7E3gNM5hqQIrFWx/RUKEajmLtpcsEJeScjl17C4NIWE7+6J49OEzW3z6hbFL6ckx4xGFiFu8J/HclQOiRzLnjbZZ8uo2DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fKGHf8DK; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fKGHf8DK"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775498339;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GsA0DQ7RZ25+fuPh8E9nbhfynHH+2ccVrJP5vTigsvs=;
	b=fKGHf8DKSJ6N5tXqc6Yv5YQpuEsbs0mtXnxqRlrkOvO0on3gfEYEdFkV/IuUzYqJ/tVILG
	k3LB0F7bPedV91BXyF5/FmsD8Qu5xYKc2cK74vxN6qoH8v/ElX7drvZv2hdjXId7nR7Xnq
	X+YMqxaZS+FqMBHQR0z0yDT7V4HlofQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next 2/2] KEYS: annotate struct user_key_payload with __counted_by
Date: Mon,  6 Apr 2026 19:58:10 +0200
Message-ID: <20260406175810.1018681-4-thorsten.blum@linux.dev>
In-Reply-To: <20260406175810.1018681-3-thorsten.blum@linux.dev>
References: <20260406175810.1018681-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=834; i=thorsten.blum@linux.dev; h=from:subject; bh=WKatVZ4ijznTXfeAzfxBPkp0ScePMGQUAQ2+GI9ot5o=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJmXv1jzr01u3xn/MXrvXOn5BrseRLkuc7MKcOvhTyx79 azih4lgRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAExEWYCRYVFc6Yq7x8Lec72d +qVY5UfxRPuaO7cmm+4Nl3w3beFs34uMDCePXp9r0/7j+mu/mmZuVT3/+d07hEIvsTxaGNsz4Ur uLz4A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by() compiler attribute to the flexible array member
'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
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
