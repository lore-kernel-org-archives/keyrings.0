Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748400;
	b=HSu0jHz8H9xeZvwoIiPVy7e6Tx1ouihyYdn+OieyevtUrNx+zj2jdoHAEedkgp0WpkOv
	 cY5B2pDACXx/kM5mlz2yxFHupE27ms++IOnToWkbxWv6NwxrQ+FYeEdq2wVI/5gFBM4+H
	 xi4rvccG1ktLCbYB0Hhou3oOejJ/lk0dNga/6TWUWpEnkycVHhyyGhZ+ZHi+IU1ikiUKJ
	 BfO2VzHsSK+lC7yoT7aP/+vvohzqA4ns+o2gx0Utkig1m5s995G2ABqqtHlQNrbmackti
	 EUj6DmgydvAt1oNxmF4n5uQ38CUwTW02vM38pMB7X52GJ/Vrj1Q2j+txPKa746DhSsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748400;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=hUYCifz4koOk35hOpkO8+YZBCYRBdzcePLVU8Gz4jgA=;
	b=Ys6sgasZKpxWwnDB/swfX7jIKNls5yB7FUYYnHzEuOa1D9pLhCU2PIgv0gpp4nZET6TV
	 h1Dp/H7Hrr92oBogImEHF/4s2HVZmyx8VGGeLrKTur39ctRK7Dr0uC31OPq/kw4bM6brf
	 txZoJaYDAtcON8P1IluPhTw7Qunh8qDbHxtcO7ArM07jdt6o2YVK+OcFrVkjfwjUrdlGT
	 kJ0Pa/48M39V76VynjaeUPLWT872/YRcotbOKcO0Trqy09qhJk3ltU2jjCESEruWYDB3Q
	 3EH3yI7IfnctM9Lh7sWgFjvbfFen4pmXyDsLpg64OHOJJsG+WwY2Rrm0Z1J/aWaznKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eih4Opix;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AAB606A33C
	for <keyrings@vger.kernel.org>; Fri, 27 Nov 2026 02:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01AAB606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eih4Opix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795748400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUYCifz4koOk35hOpkO8+YZBCYRBdzcePLVU8Gz4jgA=;
	b=eih4OpixECQoO+HBb1tPqmFhIdD0NxLnGThfWEdGN2hyEh//mLb7kuXPfgaStRTPnJ/wjH
	++6wTdhR7QuSvhXKciF6Zbvoz5lhpyvGi3GU8sUmk8DwdpMgtEKAAVABPX4JED24X1ZsOQ
	ACQAerG2bqaQrePaYuzESrseipJjR14=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-35--7xE4pU0O7u7AlZGlrtWyw-1; Fri,
 27 Nov 2026 02:59:53 +0000
X-MC-Unique: -7xE4pU0O7u7AlZGlrtWyw-1
X-Mimecast-MFC-AGG-ID: -7xE4pU0O7u7AlZGlrtWyw_1795748392
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E2361800592;
	Fri, 27 Nov 2026 02:59:52 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A4E0B1955F75;
	Fri, 27 Nov 2026 02:59:51 +0000 (UTC)
From: Bruno Meneguele <bmeneg@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dhowells@redhat.com,
	bauerman@linux.ibm.com,
	Bruno Meneguele <bmeneg@redhat.com>
Subject: [RFC PATCH 5/8] ima: record data-signing algorithms by name in 'd-modsig'
Date: Thu, 26 Nov 2026 23:59:08 -0300
Message-ID: <20261127025912.1383750-6-bmeneg@redhat.com>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

A signer whose algorithm signs the data directly (eg. ML-DSA) has no
content digest unless it carries authenticated attributes. With
authenticated attributes, which sign-file uses for ML-DSA when built
against OpenSSL 3.x, 'd-modsig' holds the messageDigest attribute, while
the signature covers the attributes and not that digest.

Record such a signer by the name of its signature algorithm instead of a
hash algorithm, with an empty digest (e.g. "mldsa65:" '\0'), with or
without authenticated attributes. A verifier needs to traverse the 'modsig'
field to find out authattr's presence. Signers that sign a digest are
recorded as before.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 Documentation/security/IMA-templates.rst  |   4 +-
 security/integrity/ima/ima_template_lib.c | 113 ++++++++++++++--------
 2 files changed, 75 insertions(+), 42 deletions(-)

diff --git a/Documentation/security/IMA-templates.rst b/Documentation/security/IMA-templates.rst
index 15b4add314fc..4ec0440b27f1 100644
--- a/Documentation/security/IMA-templates.rst
+++ b/Documentation/security/IMA-templates.rst
@@ -69,7 +69,9 @@ descriptors by adding their identifier to the format string
    algorithm (field format: <hash algo>:digest);
  - 'd-ngv2': same as d-ng, but prefixed with the "ima" or "verity" digest type
    (field format: <digest type>:<hash algo>:digest);
- - 'd-modsig': the digest of the event without the appended modsig;
+ - 'd-modsig': the digest of the event without the appended modsig or a signature
+   algorithm name followed by an empty digest (<signing algo>: \0) when direct data
+   algorithms are used, e.g. ML-DSA;
  - 'n-ng': the name of the event, without size limitations;
  - 'sig': the file signature, based on either the file's/fsverity's digest[1],
    or the EVM portable signature, if 'security.ima' contains a file hash.
diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 0609a8f7a127..a2aeaae83065 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -286,24 +286,27 @@ int ima_parse_buf(void *bufstartp, void *bufendp, void **bufcurp,
 	return 0;
 }
 
+/*
+ * digest formats:
+ *  - DATA_FMT_DIGEST: digest
+ *  - DATA_FMT_DIGEST_WITH_ALGO: <hash algo> + ':' + '\0' + digest,
+ *  - DATA_FMT_DIGEST_WITH_TYPE_AND_ALGO:
+ *	<digest type> + ':' + <hash algo> + ':' + '\0' + digest,
+ *
+ *    where 'DATA_FMT_DIGEST' is the original digest format ('d')
+ *      with a hash size limitation of 20 bytes,
+ *    where <digest type> is either "ima" or "verity",
+ *    where <hash algo> is the hash_algo_name[] string.
+ */
+#define IMA_MAX_DIGEST_ENTRY_SIZE (DIGEST_TYPE_NAME_LEN_MAX + \
+				   CRYPTO_MAX_ALG_NAME + 2 + \
+				   IMA_MAX_DIGEST_SIZE)
+
 static int ima_eventdigest_init_common(const u8 *digest, u32 digestsize,
 				       u8 digest_type, u8 hash_algo,
 				       struct ima_field_data *field_data)
 {
-	/*
-	 * digest formats:
-	 *  - DATA_FMT_DIGEST: digest
-	 *  - DATA_FMT_DIGEST_WITH_ALGO: <hash algo> + ':' + '\0' + digest,
-	 *  - DATA_FMT_DIGEST_WITH_TYPE_AND_ALGO:
-	 *	<digest type> + ':' + <hash algo> + ':' + '\0' + digest,
-	 *
-	 *    where 'DATA_FMT_DIGEST' is the original digest format ('d')
-	 *      with a hash size limitation of 20 bytes,
-	 *    where <digest type> is either "ima" or "verity",
-	 *    where <hash algo> is the hash_algo_name[] string.
-	 */
-	u8 buffer[DIGEST_TYPE_NAME_LEN_MAX + CRYPTO_MAX_ALG_NAME + 2 +
-		IMA_MAX_DIGEST_SIZE] = { 0 };
+	u8 buffer[IMA_MAX_DIGEST_ENTRY_SIZE] = { 0 };
 	enum data_formats fmt = DATA_FMT_DIGEST;
 	u32 offset = 0;
 
@@ -451,6 +454,44 @@ int ima_eventdigest_ngv2_init(struct ima_event_data *event_data,
 					   field_data);
 }
 
+/*
+ * ima_modsig_digest_entry - encode the content digest of one modsig signer
+ * @modsig: the appended signature
+ * @index: zero-based index of the signer
+ * @entry: output buffer
+ *
+ * The entry has the DATA_FMT_DIGEST_WITH_ALGO format. A signer whose algorithm
+ * signs the data directly (eg. ML-DSA) is recorded by the name of that
+ * algorithm instead, with empty digest (eg. "mldsa65:"), regardless of
+ * authenticated attributes being present or not.
+ *
+ * Return: the entry length on success, a negative error code otherwise.
+ */
+static int ima_modsig_digest_entry(const struct modsig *modsig,
+				   unsigned int index, u8 *entry)
+{
+	const char *sig_algo;
+	enum hash_algo algo;
+	const u8 *digest;
+	u32 size;
+	int len, rc;
+
+	rc = ima_get_modsig_digest(modsig, index, &algo, &digest, &size,
+				   &sig_algo);
+	if (rc)
+		return rc;
+
+	if (sig_algo)
+		return sprintf(entry, "%s:", sig_algo) + 1;
+
+	if (algo >= HASH_ALGO__LAST || !size || size > IMA_MAX_DIGEST_SIZE)
+		return -EINVAL;
+
+	len = sprintf(entry, "%s:", hash_algo_name[algo]) + 1;
+	memcpy(entry + len, digest, size);
+	return len + size;
+}
+
 /*
  * This function writes the digest of the file which is expected to match the
  * digest contained in the file's appended signature.
@@ -458,39 +499,29 @@ int ima_eventdigest_ngv2_init(struct ima_event_data *event_data,
 int ima_eventdigest_modsig_init(struct ima_event_data *event_data,
 				struct ima_field_data *field_data)
 {
-	enum hash_algo hash_algo;
-	const u8 *cur_digest;
-	u32 cur_digestsize;
+	/* 'd-modsig' (DATA_FMT_DIGEST_WITH_ALGO) doesn't contain digest type */
+	u8 entry[IMA_MAX_DIGEST_ENTRY_SIZE - DIGEST_TYPE_NAME_LEN_MAX] = { 0 };
+	int len;
 
 	if (!event_data->modsig)
 		return 0;
 
-	if (event_data->violation) {
+	if (event_data->violation)
 		/* Recording a violation. */
-		hash_algo = HASH_ALGO_SHA1;
-		cur_digest = NULL;
-		cur_digestsize = 0;
-	} else {
-		const char *sig_algo;
-		int rc;
-
-		/* 'd-modsig' supports the digest of a single signer only. */
-		if (ima_get_modsig_signer_count(event_data->modsig) != 1)
-			return -EINVAL;
-
-		rc = ima_get_modsig_digest(event_data->modsig, 0, &hash_algo,
-					   &cur_digest, &cur_digestsize,
-					   &sig_algo);
-		if (rc)
-			return rc;
-		else if (hash_algo == HASH_ALGO__LAST || cur_digestsize == 0)
-			/* There was some error collecting the digest. */
-			return -EINVAL;
-	}
+		return ima_eventdigest_init_common(NULL, 0, DIGEST_TYPE__LAST,
+						   HASH_ALGO_SHA1, field_data);
 
-	return ima_eventdigest_init_common(cur_digest, cur_digestsize,
-					   DIGEST_TYPE__LAST, hash_algo,
-					   field_data);
+	/* 'd-modsig' supports the digest of a single signer only. */
+	if (ima_get_modsig_signer_count(event_data->modsig) != 1)
+		return -EINVAL;
+
+	len = ima_modsig_digest_entry(event_data->modsig, 0, entry);
+	if (len < 0)
+		return len;
+
+	return ima_write_template_field_data(entry, len,
+					     DATA_FMT_DIGEST_WITH_ALGO,
+					     field_data);
 }
 
 static int ima_eventname_init_common(struct ima_event_data *event_data,
-- 
2.55.0

