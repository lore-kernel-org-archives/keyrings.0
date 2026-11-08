Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.115
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143690;
	b=Mq2EjjEdFnU3XVPLIkLZmx7mp6vWkiAezG0+LKOV3kkXfLD8BeHV5NcY5ZPTGlATuZtO
	 31dYe3z0349CIbQxJfd8TFfb2lzDaGqSBuxfVPBDxSjT4ea3/DFiIXJXnyPDCZ6Nc1u72
	 aHLS0F3u3Tyc1H4aodHA5x0Dfobs6aJAbT2aXsFangtYcrrHN4Z4URZSdAlmLGc0TiypZ
	 30ZxpD9g4SZFbDah+sUOz0btbCavdtcA4RAeNKNye608fFRGN5ZT6QdOMR1NUzkCJ0dp/
	 i79PGID1H/bfUd2t4o8VEQiwwGCDD3vYtyrHEIkRYR98tw9CqaE+PDu12qkmS7w+05w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143690;
	h=DMARC-Filter:DKIM-Signature:Date:Message-Id:
	 Content-Transfer-Encoding:Subject:To:Cc:From:Mime-Version:X-Mailer:
	 X-Original-From:X-Lms-Return-Path:Content-Type;
	bh=JVZkFHZMBuxh3jQ8RaeKoy1cY+ZxSziZ3LFHcJBqQa4=;
	b=QsrSQ6GAHQ3T+XjewJzI9V1HKzAJQL05y5KBJPk2FCnoGV0uAIFo3hnKSWKSU2/Hi1rf
	 KNqXvhupPb7UWHrWZkfuYt/Sz4waKHF/zDoDhKyMv184DLGJy3+1gC+Tgb5whzPNSFfHd
	 r5FTVHg+QxC2KRIP2/MFMT16vs5kUMwlFff57PC0lOLsStA5jJlL95BBfdTlahA+VbhJu
	 Nvgd+WyQ+UQquDwDGmPN+bIRzLRGEJF7snW3H6q8S+6qzCu2OHCJYJnvUE7FzU8A4LSbS
	 7WDQAJHgIz376wQHTppqcobv6L1Ld1g2DI3wPKywJHK+OxBNGHXyRBHuI5FZCXbM+pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=PLLNgX+n;
	arc=none smtp.remote-ip=209.127.231.115
Received: from va-2-115.ptr.blmpb.com (va-2-115.ptr.blmpb.com [209.127.231.115])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655CD606A31C
	for <keyrings@vger.kernel.org>; Sun,  8 Nov 2026 13:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 655CD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=PLLNgX+n
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1794143682; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=JVZkFHZMBuxh3jQ8RaeKoy1cY+ZxSziZ3LFHcJBqQa4=;
 b=PLLNgX+nRfTT7dFGdBUkr0QwIMB26rkDNDDJ+hRbjsOhU1c8QBqbEvdbKyV25AMqz/cwtp
 QR6TuGJUkvPzcQ8U7rQ66cD5Cy2K1xJ5kUefMZtAnypQa1MmaphDFuTUNVFrBK2ejPNyPZ
 9JMrjuLXGyBtvVR1c/0gVrq68Ag7grYNKLB+CVOCIvegy9Ybfkc7HWod3KupnWpSmpm4lc
 JksSa35jlteEPjLJizEJcRaiLUJIhDzGeDm3p0uJXy7aKbrKW4WGJ2w0zHd1XyM+sg87YT
 UrCjiPNmxhiwu1+aooZNZrdMJNuxuouvcx+CVvyKwr5qua2kQmjC4iQz/2EDjw==
Date: Sun,  8 Nov 2026 21:14:12 +0800
Message-Id: <20261108131413.12012-2-weiguixiong@bytedance.com>
Content-Transfer-Encoding: 7bit
Subject: [PATCH] KEYS: do not let an unmatched key decide the search result
To: "David Howells" <dhowells@redhat.com>, 
	"Jarkko Sakkinen" <jarkko@kernel.org>, <keyrings@vger.kernel.org>
Cc: "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, 
	<linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Guixiong Wei" <weiguixiong@bytedance.com>
From: "Guixiong Wei" <weiguixiong@bytedance.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0
X-Original-From: Guixiong Wei <weiguixiong@bytedance.com>
X-Lms-Return-Path: <lba+26af075c0+212135+vger.kernel.org+weiguixiong@bytedance.com>
Content-Type: text/plain; charset=UTF-8

KEYCTL_SEARCH returns -ENOKEY, -EKEYREVOKED, or -EKEYEXPIRED for the key
selected by type and description.  keyring_search_iterator() currently
records revoked or expired state before asking the key type whether the key
matches.

Direct lookup visits the indexed description, so that ordering normally
does not matter.  Iterative lookup visits every key of the requested type,
however.  The in-tree asymmetric id/ex/dn lookups and dns_resolver use this
mode.  A revoked key with a different description can therefore make
KEYCTL_SEARCH return -EKEYREVOKED instead of continuing the search.  It can
also prevent request_key_and_link() from issuing an upcall because that
path only upcalls after -EAGAIN.  An unmatched expired key similarly
pollutes searches that do not set KEYRING_SEARCH_SKIP_EXPIRED; the request
path itself sets that flag.

Run the type comparator before recording state errors, so only a key that
matches the caller's criterion can decide the search result.

Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
---
 security/keys/keyring.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/security/keys/keyring.c b/security/keys/keyring.c
index 7143f3079d200..39645b8f9b30c 100644
--- a/security/keys/keyring.c
+++ b/security/keys/keyring.c
@@ -598,6 +598,12 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
 		return 0;
 	}
 
+	/* A key the caller did not ask for must not decide the result. */
+	if (!ctx->match_data.cmp(key, &ctx->match_data)) {
+		kleave(" = 0 [!match]");
+		return 0;
+	}
+
 	/* skip invalidated, revoked and expired keys */
 	if (ctx->flags & KEYRING_SEARCH_DO_STATE_CHECK) {
 		time64_t expiry = READ_ONCE(key->expiry);
@@ -617,12 +623,6 @@ static int keyring_search_iterator(const void *object, void *iterator_data)
 		}
 	}
 
-	/* keys that don't match */
-	if (!ctx->match_data.cmp(key, &ctx->match_data)) {
-		kleave(" = 0 [!match]");
-		return 0;
-	}
-
 	/* key must have search permissions */
 	if (!(ctx->flags & KEYRING_SEARCH_NO_CHECK_PERM) &&
 	    key_task_permission(make_key_ref(key, ctx->possessed),
-- 
2.55.0
