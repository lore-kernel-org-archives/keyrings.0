Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795748393;
	b=e9Y/V1Ez3sYNgmVTbgMTVz7IEvJCpVd3T4DB4lPGB6grCPVLvJdkF1afqdkSacGATF6C
	 DfA1rOJOhwxXAgSM8+ftFbBPn6xu5L8S7hbEq66wKMeYsMbsVdxZ5Of3R1tEjr5lpcjmD
	 /ZtpcuNS+0eq1mCZdP6GitvZ0/Y3ZQ7T9Bf82Nu7iWaElNGrQ1mo193BoeXIrupHVnTRu
	 7c3RZdtQSgTW1+cD2u/G9ImCLCoiwMzBl3Qgl4DvYlRIX2MXQwXdRes2cwwM7UzWAPC0W
	 dtwiQ2qXrtx0SoHE84tgvrFRsnXhXAEFyAdmvU1Mqdz7yxwDfT3DcEqPBH7gnr7agwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795748393;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=YLKuwFmn5et2WB30Vt1Z089OBLtt75KOTkLy3vZE0Vo=;
	b=RbTuOIZpMqJ2j+cZEJrRTIHZOqfxn0QvlySs8pnYjH6/nABjHhKi4v3BJmc9YAt4Crro
	 dgsr9Fd4nyMRkKaiA9Ae0P/+1VKEaA5PuG7Nrwi7HZwAAHjK4+s/pH2ae/kN6wEdlL3kR
	 rf2/p149S3u0eVlgogR+zt98DN37pClhiFDXWr5zEdiKwmiEcHVW1YyRKRaU+Dpp3peV7
	 o0D7p2nAWYBpuRczgJavJ0foVj0pVgPK6kn+6Q2aPElpuKcAkW/MDF+8hBbcjngv+n0dJ
	 1xCioV5sqGPL5LKXT/OIkfZIAsarWpPRiANhy4pSUtIpf6DFidCSq1XtHrvdUaxWx1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ipRxfbJP;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA51A606A336
	for <keyrings@vger.kernel.org>; Fri, 27 Nov 2026 02:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA51A606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ipRxfbJP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795748391;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YLKuwFmn5et2WB30Vt1Z089OBLtt75KOTkLy3vZE0Vo=;
	b=ipRxfbJP3AJ2LTbi6fen4Vvzka8khhJg4Ep/dINdr5hvHjzPEH7B+vWSWNlH7oGISkRPkv
	CL1Wa76z1DLLbGeWFRjom8V/iHKKesHT+jY2kJyTlffibfKmM6UEj4RdkEY61ghw2h3NWR
	r1WCwM/++9pC12NcQxiwFJ4n41TFN9I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-D3it3B1tNY-zFB3Aq9SGew-1; Fri,
 27 Nov 2026 02:59:46 +0000
X-MC-Unique: D3it3B1tNY-zFB3Aq9SGew-1
X-Mimecast-MFC-AGG-ID: D3it3B1tNY-zFB3Aq9SGew_1795748385
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4FFE418005BB;
	Fri, 27 Nov 2026 02:59:45 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 899D6180054C;
	Fri, 27 Nov 2026 02:59:44 +0000 (UTC)
From: Bruno Meneguele <bmeneg@redhat.com>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dhowells@redhat.com,
	bauerman@linux.ibm.com,
	Bruno Meneguele <bmeneg@redhat.com>,
	stable@vger.kernel.org
Subject: [RFC PATCH 2/8] pkcs7: return the content digest from pkcs7_get_digest()
Date: Thu, 26 Nov 2026 23:59:05 -0300
Message-ID: <20261127025912.1383750-3-bmeneg@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When generating an appended module signature with authenticated attributes,
allowed only for ML-DSA with OpenSSL v3.x, pkcs7_digest() stores the file
content digest in sig->m and then check it against the messageDigest
attribute, later on it overwrites sig->m with a copy of the whole
attributes set, setting sig->m_size to its length and returning it to the
caller.

As consequence, a caller like IMA always fails on its binary blacklist
check because it's, possibly, comparing a file digest (blacklisted digest)
against the authenticated attributes data (computed and stored at sig->m).
On such case, return the messageDigest attribute instead.

Fixes: f3eccecd782d ("pkcs7: Allow the signing algo to do whatever digestion it wants itself")
Cc: stable@vger.kernel.org
Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
---
 crypto/asymmetric_keys/pkcs7_verify.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/crypto/asymmetric_keys/pkcs7_verify.c b/crypto/asymmetric_keys/pkcs7_verify.c
index 356570b6d6aa..db3f6d080ccf 100644
--- a/crypto/asymmetric_keys/pkcs7_verify.c
+++ b/crypto/asymmetric_keys/pkcs7_verify.c
@@ -155,15 +155,22 @@ int pkcs7_get_digest(struct pkcs7_message *pkcs7, const u8 **buf, u32 *len,
 	ret = pkcs7_digest(pkcs7, sinfo);
 	if (ret)
 		return ret;
-	if (!sinfo->sig->m_free) {
+
+	/* 'm' holds the digest or a copy of authattr, if the algorithm signs
+	 * the data directly.
+	 */
+	if (sinfo->authattrs) {
+		*buf = sinfo->msgdigest;
+		*len = sinfo->msgdigest_len;
+	} else if (sinfo->sig->m_free) {
+		*buf = sinfo->sig->m;
+		*len = sinfo->sig->m_size;
+	} else {
 		pr_notice_once("%s: No digest available\n", __func__);
 		return -EINVAL; /* TODO: MLDSA doesn't necessarily calculate an
 				 * intermediate digest. */
 	}
 
-	*buf = sinfo->sig->m;
-	*len = sinfo->sig->m_size;
-
 	i = match_string(hash_algo_name, HASH_ALGO__LAST,
 			 sinfo->sig->hash_algo);
 	if (i >= 0)
-- 
2.55.0

