Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500A1484223
	for <keyrings@vger.kernel.org>; Tue,  4 Aug 2026 17:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785864443; cv=none; b=dydhets5dLcnD5NMPB6WK4DXzoXgLSSBne9QRsIl2sBqYgxg2vs4s1cY6x9A4Smqv6qVunI+RlZYMujIrCZqWyCLl+dQSz7/+rbIh8QtUcUHemmgSTzktyGnKvoV4EmLZs4C09nJ83nIzruMipgd3nXCcW9EeGLWMCYKRAeIuVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785864443; c=relaxed/simple;
	bh=8xYe1xVOymzfUL3FY35nN2xScs1Bzzf+To/adTMsX10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ldWn03AJ/puboao9kJ20amJRRgqUSEpuOAtIo7MwNlAn5eFjH4fArcZgTZKOVyS+c4vAiWdg0nmHIM81RsT48oB9kyrgIK2LeSD1M6KzM0TFhm4RI93uwTDDU7Mqp9S4maa1Ncwk/dHBhK/zX59ckUzb02MoFG5MB7ZUCxWzZCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jTFLrpRj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jTFLrpRj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785864440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6bsxuWrGjCNJ9G3R3V0fM/GxuviKNyJjBl9DCZXobyc=;
	b=jTFLrpRjY3czviwZX99hAfI5ZC4mdBXaoxpi8ArK/hcwlBFOJ0LucP2NJQ3V1q5dtbXzGG
	3bXfXVcoiD/nrs0TySjCn9yLgjCgGA0uUl4R8PaK9YAxJbAOsKuYOWZjHr6IKN0MVfq3ct
	Cpx9UNyGKXR2a9E+OA98k/BmbLBp7+k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-h8o9_ZQuMQedxvo-7XuKMA-1; Tue,
 04 Aug 2026 13:27:18 -0400
X-MC-Unique: h8o9_ZQuMQedxvo-7XuKMA-1
X-Mimecast-MFC-AGG-ID: h8o9_ZQuMQedxvo-7XuKMA_1785864436
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B58FE1956053;
	Tue,  4 Aug 2026 17:27:16 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.44.32.44])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E2E7130001A4;
	Tue,  4 Aug 2026 17:27:12 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	stable@kernel.org
Subject: [PATCH net v6 06/10] keys: Add refcounting to user-defined key type payload
Date: Tue,  4 Aug 2026 18:26:33 +0100
Message-ID: <20260804172639.2844491-7-dhowells@redhat.com>
In-Reply-To: <20260804172639.2844491-1-dhowells@redhat.com>
References: <20260804172639.2844491-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Add refcounting to user-defined key type payload so that a kernel service
wanting to use such a key can hold onto the payload without the RCU read
lock held in order that it can do an allocation without having to be
concerned with the key getting updated.

This is the first part of the fix for the AF_RXRPC challenge response
generation code.

Link: https://sashiko.dev/#/patchset/20260624163819.3017002-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Jeffrey Altman <jaltman@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: Jarkko Sakkinen <jarkko@kernel.org>
cc: linux-afs@lists.infradead.org
cc: keyrings@vger.kernel.org
cc: stable@kernel.org
---
 include/keys/user-type.h     |  2 ++
 net/dns_resolver/dns_key.c   |  1 +
 security/keys/user_defined.c | 23 ++++++++++++++++-------
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/include/keys/user-type.h b/include/keys/user-type.h
index 386c31432789..7002a993a472 100644
--- a/include/keys/user-type.h
+++ b/include/keys/user-type.h
@@ -26,6 +26,7 @@
  */
 struct user_key_payload {
 	struct rcu_head	rcu;		/* RCU destructor */
+	refcount_t	ref;
 	unsigned short	datalen;	/* length of this data */
 	char		data[] __aligned(__alignof__(u64)); /* actual data */
 };
@@ -37,6 +38,7 @@ struct key_preparsed_payload;
 
 extern int user_preparse(struct key_preparsed_payload *prep);
 extern void user_free_preparse(struct key_preparsed_payload *prep);
+void put_user_key_payload(struct user_key_payload *payload);
 extern int user_update(struct key *key, struct key_preparsed_payload *prep);
 extern void user_revoke(struct key *key);
 extern void user_destroy(struct key *key);
diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index c3c8c3240ef9..aa3c058f4095 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -208,6 +208,7 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 		kleave(" = -ENOMEM");
 		return -ENOMEM;
 	}
+	refcount_set(&upayload->ref, 1);
 
 	upayload->datalen = result_len;
 	memcpy(upayload->data, data, result_len);
diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
index 6f88b507f927..90c1bd5d7dfe 100644
--- a/security/keys/user_defined.c
+++ b/security/keys/user_defined.c
@@ -67,6 +67,7 @@ int user_preparse(struct key_preparsed_payload *prep)
 	upayload = kmalloc_flex(*upayload, data, datalen);
 	if (!upayload)
 		return -ENOMEM;
+	refcount_set(&upayload->ref, 1);
 
 	/* attach the data */
 	prep->quotalen = datalen;
@@ -88,12 +89,22 @@ EXPORT_SYMBOL_GPL(user_free_preparse);
 
 static void user_free_payload_rcu(struct rcu_head *head)
 {
-	struct user_key_payload *payload;
+	struct user_key_payload *payload =
+		container_of(head, struct user_key_payload, rcu);
 
-	payload = container_of(head, struct user_key_payload, rcu);
 	kfree_sensitive(payload);
 }
 
+/*
+ * Free a user defined key payload.
+ */
+void put_user_key_payload(struct user_key_payload *payload)
+{
+	if (payload && refcount_dec_and_test(&payload->ref))
+		call_rcu(&payload->rcu, user_free_payload_rcu);
+}
+EXPORT_SYMBOL_GPL(put_user_key_payload);
+
 /*
  * update a user defined key
  * - the key's semaphore is write-locked
@@ -115,8 +126,7 @@ int user_update(struct key *key, struct key_preparsed_payload *prep)
 	rcu_assign_keypointer(key, prep->payload.data[0]);
 	prep->payload.data[0] = NULL;
 
-	if (zap)
-		call_rcu(&zap->rcu, user_free_payload_rcu);
+	put_user_key_payload(zap);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(user_update);
@@ -134,7 +144,7 @@ void user_revoke(struct key *key)
 
 	if (upayload) {
 		rcu_assign_keypointer(key, NULL);
-		call_rcu(&upayload->rcu, user_free_payload_rcu);
+		put_user_key_payload(upayload);
 	}
 }
 
@@ -147,9 +157,8 @@ void user_destroy(struct key *key)
 {
 	struct user_key_payload *upayload = key->payload.data[0];
 
-	kfree_sensitive(upayload);
+	put_user_key_payload(upayload);
 }
-
 EXPORT_SYMBOL_GPL(user_destroy);
 
 /*

