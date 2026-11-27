Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748393;
	b=VLZONPZuJoTziMc+AnteC8revyyCoGHS6kwb3l+bJVkQHf8lsOrS7QTZc34jHZRj5tt2
	 HD8fpF+OJrW2UEJhpflTtTdKeeE1DzsZDqeSkGXAaontGno0/I7ERAFv9gLReDEiFdLVf
	 XINQfrAlo1hrDD5FLrDKD0JGcB5tjTm9VSA6x1HH6FIh2D37V2SkKW8Pu2PBVjwz3/U8E
	 QJJbHq4WNntQfnuE5/wISopGHTCjgpYRr099/rkEFitiAFMxyTh2xRxFuavh03JBOoPzB
	 zSu1jIPDP2LVnEv/RmAPAmeCwhpp41bo4wzYsIaYOqokbXhojUB8Nl5isu+zMOKpSBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748393;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=BnpcY/RP8pAgh3oqyYEmVM75f0YFNk/KISru1SjfUyU=;
	b=HtxVuneJb51VBvu8ztaZGcxQt5M2jp7OtdgTAD3XloX0pL8LfZgqAowTGs0yLMSdnStv
	 c24/4oliq9Emlt/iuDip3lXe0n43UoLr0kQ/og0MlvEuVR9Li+hllZ3ZkR9VZqyqYT19K
	 RYdl8zf5R+EzXBFBQy7jSn8FOVuNTAaaw50loVlbyxaSd5NVxtF2VXtKAYory2kCN7AAK
	 uhsMRymTsJv4l0TT43NAqd9nr0tXIiwMWUs4+lalhURGpYAnAQAEzME0pkuHwd9W59aHk
	 gN7jloa19t2nw1I2SFsc6/+tXpEWWJCyAgCanvq7q4tEQIj9cGeJMKsFHUdkrjCijEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XdnrDW0A;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC9B606A326
	for <keyrings@vger.kernel.org>; Fri, 27 Nov 2026 02:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BC9B606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XdnrDW0A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795748391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BnpcY/RP8pAgh3oqyYEmVM75f0YFNk/KISru1SjfUyU=;
	b=XdnrDW0AsRoeCDau02QMlU9sBh2c45oywcjF0EOkzP0XwOQrfKVC9dzRF6B9ufXVF49ijZ
	J1zHR5zT72wiT3Dpc9fsGH2QI5a4VdzY+BgQyxgEUx5sVODjjCyXyJagbJ6L3lzpgdkIFH
	7jbwtogDXfShaRCnlUxLsxCvgbkftYs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-298-8R38NC0SN8iRyitTqk3DlA-1; Fri,
 27 Nov 2026 02:59:49 +0000
X-MC-Unique: 8R38NC0SN8iRyitTqk3DlA-1
X-Mimecast-MFC-AGG-ID: 8R38NC0SN8iRyitTqk3DlA_1795748388
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A48B91800372;
	Fri, 27 Nov 2026 02:59:47 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D263B18011D3;
	Fri, 27 Nov 2026 02:59:46 +0000 (UTC)
From: Bruno Meneguele <bmeneg@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dhowells@redhat.com,
	bauerman@linux.ibm.com,
	Bruno Meneguele <bmeneg@redhat.com>
Subject: [RFC PATCH 3/8] pkcs7: support multiple signers in pkcs7_get_digest()
Date: Thu, 26 Nov 2026 23:59:06 -0300
Message-ID: <20261127025912.1383750-4-bmeneg@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

Current pkcs7_get_digest() code fails with any message that has more than
one SignerInfo, so the content digest of a multi-signed message can't be
obtained, and it also doesn't support signers whose algorithm signs the
data directly (eg. ML-DSA) without authenticated attributes, which has no
content digest to report.

Give it a signer zero-index and add pkcs7_get_signer_count(), so callers
can get the content digest of each signer of a message. Report a signer
with no content digest as a zero-length digest rather than an error, and
return the name of the signature algorithm when it signs the data directly.

This commit prepares the ground for ima-modsigv2 template, maintaining
current field templates behavior.

Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 crypto/asymmetric_keys/pkcs7_verify.c | 63 ++++++++++++++++++++++-----
 include/crypto/pkcs7.h                |  7 ++-
 security/integrity/ima/ima_modsig.c   | 10 ++++-
 3 files changed, 66 insertions(+), 14 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index db3f6d080ccf..bd55f86b9464 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -140,17 +140,61 @@ static int pkcs7_digest(struct pkcs7_message *pkcs7,
 	return ret;
 }
 
-int pkcs7_get_digest(struct pkcs7_message *pkcs7, const u8 **buf, u32 *len,
-		     enum hash_algo *hash_algo)
+/**
+ * pkcs7_get_signer_count - Count the signers of a PKCS#7 message
+ * @pkcs7: The preparsed PKCS#7 message to access
+ *
+ * Return: the number of SignerInfos in the message.
+ */
+unsigned int pkcs7_get_signer_count(const struct pkcs7_message *pkcs7)
+{
+	const struct pkcs7_signed_info *sinfo;
+	unsigned int count = 0;
+
+	for (sinfo = pkcs7->signed_infos; sinfo; sinfo = sinfo->next)
+		count++;
+
+	return count;
+}
+
+/**
+ * pkcs7_get_digest - Get the content digest of one signer of a PKCS#7 message
+ * @pkcs7: The PKCS#7 message
+ * @index: Zero-based index of the signer, in the message's (DER) order
+ * @buf: The content digest (NULL when there is none)
+ * @len: The content digest length (0 when there is none)
+ * @hash_algo: The digest algorithm (HASH_ALGO__LAST when there is none)
+ * @pkey_algo: The signature algorithm name if the data was signed directly
+ *
+ * The content digest is the digest of the signed content under the signer's
+ * digest algorithm. A signer whose algorithm signs the data directly has no
+ * digest when authenticated/signed attributes is absent, we return 0 in
+ * this case.
+ *
+ * Return: 0 on success, -EINVAL if there is no signer at 'index',
+ * -EKEYREJECTED if the messageDigest attribute doesn't match the content, or
+ * another negative error code.
+ */
+int pkcs7_get_digest(struct pkcs7_message *pkcs7, unsigned int index,
+		     const u8 **buf, u32 *len, enum hash_algo *hash_algo,
+		     const char **pkey_algo)
 {
 	struct pkcs7_signed_info *sinfo = pkcs7->signed_infos;
+	unsigned int n;
 	int i, ret;
 
-	/*
-	 * This function doesn't support messages with more than one signature.
-	 */
-	if (sinfo == NULL || sinfo->next != NULL)
-		return -EBADMSG;
+	*buf = NULL;
+	*len = 0;
+	*hash_algo = HASH_ALGO__LAST;
+	*pkey_algo = NULL;
+
+	for (n = 0; sinfo && n < index; n++)
+		sinfo = sinfo->next;
+	if (!sinfo)
+		return -EINVAL;
+
+	if (sinfo->sig->algo_takes_data)
+		*pkey_algo = sinfo->sig->pkey_algo;
 
 	ret = pkcs7_digest(pkcs7, sinfo);
 	if (ret)
@@ -166,9 +210,8 @@ int pkcs7_get_digest(struct pkcs7_message *pkcs7, const u8 **buf, u32 *len,
 		*buf = sinfo->sig->m;
 		*len = sinfo->sig->m_size;
 	} else {
-		pr_notice_once("%s: No digest available\n", __func__);
-		return -EINVAL; /* TODO: MLDSA doesn't necessarily calculate an
-				 * intermediate digest. */
+		/* No intermediate digest and no hash_algo to match. */
+		return 0;
 	}
 
 	i = match_string(hash_algo_name, HASH_ALGO__LAST,
diff --git a/include/crypto/pkcs7.h b/include/crypto/pkcs7.h
index 38ec7f5f9041..b237fe01b2f4 100644
--- a/include/crypto/pkcs7.h
+++ b/include/crypto/pkcs7.h
@@ -41,7 +41,10 @@ extern int pkcs7_verify(struct pkcs7_message *pkcs7,
 extern int pkcs7_supply_detached_data(struct pkcs7_message *pkcs7,
 				      const void *data, size_t datalen);
 
-extern int pkcs7_get_digest(struct pkcs7_message *pkcs7, const u8 **buf,
-			    u32 *len, enum hash_algo *hash_algo);
+extern unsigned int pkcs7_get_signer_count(const struct pkcs7_message *pkcs7);
+
+extern int pkcs7_get_digest(struct pkcs7_message *pkcs7, unsigned int index,
+			    const u8 **buf, u32 *len, enum hash_algo *hash_algo,
+			    const char **pkey_algo);
 
 #endif /* _CRYPTO_PKCS7_H */
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index 632c746fd81e..15e499f7dba1 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -99,6 +99,7 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
  */
 void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size)
 {
+	const char *pkey_algo;
 	int rc;
 
 	/*
@@ -111,9 +112,14 @@ void ima_collect_modsig(struct modsig *modsig, const void *buf, loff_t size)
 	if (rc)
 		return;
 
+	/* There's room for the digest of a single signer only. */
+	if (pkcs7_get_signer_count(modsig->pkcs7_msg) != 1)
+		return;
+
 	/* Ask the PKCS7 code to calculate the file hash. */
-	rc = pkcs7_get_digest(modsig->pkcs7_msg, &modsig->digest,
-			      &modsig->digest_size, &modsig->hash_algo);
+	rc = pkcs7_get_digest(modsig->pkcs7_msg, 0, &modsig->digest,
+			      &modsig->digest_size, &modsig->hash_algo,
+			      &pkey_algo);
 }
 
 int ima_modsig_verify(struct key *keyring, const struct modsig *modsig)
-- 
2.55.0

