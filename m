Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BC6476699
	for <keyrings@vger.kernel.org>; Wed, 12 Aug 2026 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552448; cv=none; b=pNouVYTblpr/sRrKMT31kSta6nsqt7TFclHEpImj0t5sjNGZznrvb4sx5XvYW4wkfPzGHrmq/DMGWOyY0nFgpBTQDkmPT0b/IheN6n1s1Wav0jh3AFU7bgHCgnCGYo6+Zd1qQttuttN+lIItHRZNHw+ogVqN7f3JZmJYByu8zQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552448; c=relaxed/simple;
	bh=bxV3nNhujFCo/j0BBm3SWAO2vxLMMMF8yj/eOkRK/js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uk7vW51AFUu5qkngFICmrMsCyZef2HxSyDjrFoB6o0zGoUb2eOj8ZjSHlRIbDKvQTGYOAxxZZ5zuEdNGqbeDzlsrQaIUk/+S6ZzjNB77DIA5AqNglusih/Pt8os8FemTrSo2q7C86Jfm63u42ZjyFXWfBfI7tH1h+xZKAwS4IgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YdA+p2W9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdA+p2W9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786552445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UGIFpIHoV2cEX83WsLrSc51nn4LgmfnamxTBBgPZei0=;
	b=YdA+p2W9V2CpavTzcvhLTBcEVixsxJz3/8nfuVUSX4KZkPfxpEKpn1YDyepu+RuVYzfvEO
	Be8Vn+AftRdfWcQf/K7hG3nPCmZKakUhb4NUFu/mQexuUTkd7nFhYacTn+X90Had5Y86av
	Whc0SMfygUrt3TpRoRoSCreekQfuD6c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-xyxIukceP8Sy5-O0EseSwA-1; Wed,
 12 Aug 2026 12:33:52 -0400
X-MC-Unique: xyxIukceP8Sy5-O0EseSwA-1
X-Mimecast-MFC-AGG-ID: xyxIukceP8Sy5-O0EseSwA_1786552430
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8563B1956042;
	Wed, 12 Aug 2026 16:33:49 +0000 (UTC)
Received: from thuth-p1g4.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 116733002D26;
	Wed, 12 Aug 2026 16:33:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH 1/3] crypto: Provide a wrapper for zeroizing hmac_sha1_ctx
Date: Wed, 12 Aug 2026 18:33:34 +0200
Message-ID: <20260812163336.3103835-2-thuth@redhat.com>
In-Reply-To: <20260812163336.3103835-1-thuth@redhat.com>
References: <20260812163336.3103835-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Thomas Huth <thuth@redhat.com>

Some kernel code needs to zeroize their local hmac_sha1_ctx structures
after use to avoid leaking sensitive material on the stack.
Provide an hmac_sha1_zeroize_ctx() helper that can be used with __cleanup()
to automatically zeroize the context when it goes out of scope.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/crypto/sha1.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/crypto/sha1.h b/include/crypto/sha1.h
index 4d973e016cd69..888dfc62e1c65 100644
--- a/include/crypto/sha1.h
+++ b/include/crypto/sha1.h
@@ -7,6 +7,7 @@
 #define _CRYPTO_SHA1_H
 
 #include <linux/types.h>
+#include <linux/string.h>
 
 #define SHA1_DIGEST_SIZE        20
 #define SHA1_BLOCK_SIZE         64
@@ -106,6 +107,22 @@ struct hmac_sha1_ctx {
 	struct sha1_block_state ostate;
 };
 
+/**
+ * hmac_sha1_zeroize_ctx() - Zeroize a hmac_sha1_ctx structure
+ * @ctx: The location of the context that should be zeroized
+ *
+ * This function explicitly fills the hmac_sha1_ctx with zeroes. For
+ * example, it can be used with __cleanup() for local hmac_sha1_ctx
+ * structures on the stack, so that their content is not leaked via the
+ * stack when the context is left. Note: This is only required when not
+ * using hmac_sha1_final() that already zeroizes the structure at the
+ * end.
+ */
+static inline void hmac_sha1_zeroize_ctx(struct hmac_sha1_ctx *ctx)
+{
+	memzero_explicit(ctx, sizeof(*ctx));
+}
+
 /**
  * hmac_sha1_preparekey() - Prepare a key for HMAC-SHA1
  * @key: (output) the key structure to initialize
-- 
2.55.0

