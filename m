Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748406;
	b=D8J2+nbw/2d4EIo+YSDQCTJhVOJsinxKH/zDN+43q2fYl6PlbsknDEWkZY7gLoygfDe/
	 mLNlU8FAsHxkaq6gvZLr6xVLFY2j0yjexyy+3HMy64nVS+VR7945T1Uy/2/3sCAd1UvIH
	 qXU5932tWVrc9RXkd9qT2ZIRhdVzQRBZEu+zpZfcr7fZKguy6fGXpE97rKkI/2KLnzq6m
	 yEkv5QYuuYpGLSesKdFSj2kDfLcmgD9pEAer1Mk1+shm4qbrdKyLiZyUpXVFvQSHBcV9o
	 lBKQkjn2+d00GTIQY4bhi5yPpewmhYJnGG3N3BG1Z6mXsRbXD/vbCqxtYQsf7GMwkpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748406;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=cXL13ZdaJrq8Pxpnq5CNNNCF9aHaOxDVvF8l/dqqouA=;
	b=WWfhH2/ZB9RdrGLHG23NjOpHPPqle/rv3UL3ZzMj3/boFSD3DrJSmMItnca0phgouvVC
	 +zQbLj/6xc5XUk0EXwELJy2ZC8YNKbD4roPNrJLyhmsrGpLrzqUb5i+d9JGwhyLZ+V1wj
	 xVs4S+FpocYyfP26AdiMR55fPz6pMA7jTo9Adwk6Bg4klRCo7B1FcFseI0yLnPK6duVOD
	 5a5x7fuA+odIUYX7IJxh51pF2oa8Ri8zS3yFWAkDnw14qw4N4+WyH4e88hRWtwmF06fZh
	 j/QJO1X7pb13vRZEh91vOWBgIRsEzJoXce6E1PxWBky7D/RthvkiI/7pjKTwpSnfCMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CWH63XtD;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BA4606A33D
	for <keyrings@vger.kernel.org>; Fri, 27 Nov 2026 03:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0BA4606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CWH63XtD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795748404;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cXL13ZdaJrq8Pxpnq5CNNNCF9aHaOxDVvF8l/dqqouA=;
	b=CWH63XtD1HZ42HfvJCwFZS7qxrNNWNUz51fNXS/ErFsdA/G9RDC19pS3cREdXo6h72vzf2
	by5FztVbis2TlBtHIb/rAg1t5/a9jlBCQcQCleY8w/yr0RbNFzAc8BvGtWbPrTkFyl80+b
	UB6lXDHKG7VwDyuLTdzEMH0ko13Rz+w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-hP5MrW1yPRqequ3ZQpQFRA-1; Fri,
 27 Nov 2026 03:00:00 +0000
X-MC-Unique: hP5MrW1yPRqequ3ZQpQFRA-1
X-Mimecast-MFC-AGG-ID: hP5MrW1yPRqequ3ZQpQFRA_1795748399
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5AA7193FAA5;
	Fri, 27 Nov 2026 02:59:58 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 343595B1;
	Fri, 27 Nov 2026 02:59:57 +0000 (UTC)
From: Bruno Meneguele <bmeneg@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dhowells@redhat.com,
	bauerman@linux.ibm.com,
	Bruno Meneguele <bmeneg@redhat.com>
Subject: [RFC PATCH 8/8] ima: check the digest of every modsig signer against the blacklist
Date: Thu, 26 Nov 2026 23:59:11 -0300
Message-ID: <20261127025912.1383750-9-bmeneg@redhat.com>
In-Reply-To: <20261127025912.1383750-1-bmeneg@redhat.com>
References: <20261127025912.1383750-1-bmeneg@redhat.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

When checking the binary blacklist, traverse every signer content digest
appended to the file. If one digest fails (-EPERM), the content is deemed
blocked.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 security/integrity/ima/ima_appraise.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 8aeec2778984..a62dc1aa93b4 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -432,18 +432,23 @@ int ima_check_blacklist(struct ima_iint_cache *iint,
 	const char *sig_algo;
 	const u8 *digest = NULL;
 	u32 digestsize = 0;
+	unsigned int i, count;
 	int rc = 0;
 
 	if (!(iint->flags & IMA_CHECK_BLACKLIST))
 		return 0;
 
 	if (iint->flags & IMA_MODSIG_ALLOWED && modsig) {
-		if (ima_get_modsig_signer_count(modsig) == 1 &&
-		    !ima_get_modsig_digest(modsig, 0, &hash_algo, &digest,
-					   &digestsize, &sig_algo))
-			rc = is_binary_blacklisted(digest, digestsize);
-	} else if (iint->flags & IMA_DIGSIG_REQUIRED && iint->ima_hash)
+		count = ima_get_modsig_signer_count(modsig);
+		for (i = 0; i < count && rc != -EPERM; i++) {
+			if (!ima_get_modsig_digest(modsig, i, &hash_algo,
+						   &digest, &digestsize,
+						   &sig_algo) && digestsize)
+				rc = is_binary_blacklisted(digest, digestsize);
+		}
+	} else if (iint->flags & IMA_DIGSIG_REQUIRED && iint->ima_hash) {
 		rc = is_binary_blacklisted(iint->ima_hash->digest, iint->ima_hash->length);
+	}
 
 	if ((rc == -EPERM) && (iint->flags & IMA_MEASURE))
 		process_buffer_measurement(&nop_mnt_idmap, NULL, digest, digestsize,
-- 
2.55.0

