Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880770;
	b=TCCUwHjSDdGKOcqogfH9i1ThpdVYlkZDi3VsGX6H8rjLIVLFgV31QW9UjLsHPAAVk5Wy
	 dr+ZF2T+kuO4zjoj25E5s4+FdQoxGhg3i86Zd4q89YTehYkqjLuU2kg59OGpOxrflFIqG
	 mSHFmJD7iV6EmWORINi3URQIUEipfDcoHEMM4d+fFrP61ZzuXkyTk8ww2Quam1dEvKQP0
	 hul8tbaA/07PQdqJZVCjQ3Tb2Zs06T7fQbPA+0/JeEkk4Y2OLL34+sKfKC4B1YNyB9LFA
	 C1UDCxeVVi2T4S+/WUog8i5Yx/vJqgUeZS5xWXGkXPGmYTwpWp514PNQq1+Oy56Je+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880770;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=IFqgPaQSsGAOAAXhAFrHMSwSNtbalnEkEWXg7ucBhqc=;
	b=I+5Z0gLhWClOhjmtlbc4ymcx8Yc2V7FBTfoMmmWfvb1G843mG0xk15WC3DvJV+ne5uMI
	 ui5XJV+PLW223xeGkADwW4/qwIuLqpqsr9S5yG6N6oqrPHIsQiNJQDSd8GPWwrPXL+f6G
	 h0qplnfrNw/aRmo+NfPrKBW0pVxD3Nw9aGCMFf4gKBMYVYmtfb7Yr8X4QGOOye9HnYUsV
	 w4NLXlAR13r8h+OBO/wHik1rqRpNZ8Q7ZNzpjOIC5GwEEb6ffoUr3oWvPtKtTyDXvnLrO
	 BRluzFIwd9czrM18wswGXcFwFiwSL4W+Zg8KxMfMmNp/7WFEYjgb5hUfTnkaaPQnDOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JPFI2PFr;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E0E606A32F;
	Thu,  5 Nov 2026 12:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79E0E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=JPFI2PFr
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5AE8cf3220038;
	Thu, 5 Nov 2026 12:12:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IFqgPaQSsGAOAAXhA
	FrHMSwSNtbalnEkEWXg7ucBhqc=; b=JPFI2PFrJ6LhQK7J3OTqWDR+V7F7Yk+BG
	J61ehfUWPZNDzJ05NOO/fks2zA16fB0fYPM+ehbYXcnLCYjtrCnBgFY5cUoJlO7x
	O02e3znkuXcM8vBrLYOVt9EhmUTShTaMbSCcIMam9V6vWa68+MhnYMYZBRQn93Wg
	k642saESY0RgZARtoDAcm7B32Zs7zEsTBId97fSvGDp33ofrgfnUs530gsnGt2I3
	CJC/CAfUvui2qxFEkR+0BPT3OY5eeKoapX0nphdFIUs6xtUvIA1Q8yGNQbHmua4f
	jsS/7WwILtfpRzycoStFmSHi7tzwyDsDq2bclUnKE08y4ayyTyiRQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn8271xwg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 12:12:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5A4x2j271775;
	Thu, 5 Nov 2026 12:12:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqsf5gb5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 12:12:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5CCbgZ49545704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 12:12:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F57820040;
	Thu,  5 Nov 2026 12:12:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B166F2004B;
	Thu,  5 Nov 2026 12:12:35 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.54.214])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 12:12:35 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/3] integrity: use is_key_blacklisted() in asymmetric_verify()
Date: Thu,  5 Nov 2026 07:12:26 -0500
Message-ID: <20261105121227.4089147-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105121227.4089147-1-zohar@linux.ibm.com>
References: <20261105121227.4089147-1-zohar@linux.ibm.com>
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
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HnIv8YPjX3e11p2uaMAObk7O7_EtXwxx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0NiBTYWx0ZWRfXwzZvhEKiMqVy
 XGM6va8geLz9qyMPsFg/6Ek9xjryJDMzi9P1quESh2H0cxnMKwRZn6TEii0EgrHCsCU6FrPQVDD
 /ZspUp6p0nScGkhVdD2xtE0O9c36eEASP317jwCxRFJ2cFWPyvSB0dEfIDgHSLJoOKnR6jTA7CD
 XrtKjRkUCKKg7q/+syPW1YwE/yWyjPllSsCR1FLXmiP6umRGtSnE8+70Y/kDigaEaqliRrVpq7p
 dzBdbJkg682Oc3NQTvjCcu/dDHHq8bUnRrfzl7try44IPyNF402vKDtOtSvgYVVLi2YMjElBX4j
 BrX5jB7y8YttwS4IDblV0yRAYggo6scwkmiASEZP2FGzB4mmIGR8zCDFrX2eyvqYr6yphrviqxS
 +60s+yjfQnplncGG7qSAvkEYkzUSz3uwXe21Zz8hHyi0uUH9lybtus1VTpNO62e9SW5oZHhuy3u
 qepebnIGxd1SW3HFvtw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0NiBTYWx0ZWRfX29lc0Ai7csjR
 2leO4MQSHyiuMlzjVU7RiGWJG+5mIDRCqXZF6cFGLZitQsI7yT0g5Um7djF/TDw84rOzGUuitRV
 QP7/WZQrW7UvH7RSebTvPbAkzcHj8QE=
X-Proofpoint-GUID: HnIv8YPjX3e11p2uaMAObk7O7_EtXwxx
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6aec72b8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=LZ98HGj1AhCkXw0SDaAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050046

request_asymmetric_key() checks the key ID against the experimental IMA
blacklist keyring before looking up the key.  The key ID in the
security.ima xattr is only an abbreviated (32-bit) form of the SKID, so
the key must be looked up first to obtain its complete SKID.

Look the key up, then pass the key found to is_key_blacklisted(), which
compares its complete SKID against the system blacklist.  A blacklisted
key, or any error from the check, rejects the key.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/digsig_asymmetric.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index b4c23a0ed68f..731f3b0009ab 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -23,23 +23,12 @@ static struct key *request_asymmetric_key(struct key *keyring, uint32_t keyid)
 {
 	struct key *key;
 	char name[12];
+	int ret;
 
 	sprintf(name, "id:%08x", keyid);
 
 	pr_debug("key search: \"%s\"\n", name);
 
-	key = get_ima_blacklist_keyring();
-	if (key) {
-		key_ref_t kref;
-
-		kref = keyring_search(make_key_ref(key, 1),
-				      &key_type_asymmetric, name, true);
-		if (!IS_ERR(kref)) {
-			pr_err("Key '%s' is in ima_blacklist_keyring\n", name);
-			return ERR_PTR(-EKEYREJECTED);
-		}
-	}
-
 	if (keyring) {
 		/* search in specific keyring */
 		key_ref_t kref;
@@ -74,6 +63,18 @@ static struct key *request_asymmetric_key(struct key *keyring, uint32_t keyid)
 		}
 	}
 
+	/*
+	 * Check the key actually selected by the lookup against the system
+	 * blacklist, so that a revoked key stops verifying even if it cannot be
+	 * removed from the keyring.  Fail closed on any error.
+	 */
+	ret = is_key_blacklisted(key);
+	if (ret) {
+		pr_err("Key '%s' is blacklisted\n", name);
+		key_put(key);
+		return ERR_PTR(ret);
+	}
+
 	pr_debug("%s() = 0 [%x]\n", __func__, key_serial(key));
 
 	return key;
-- 
2.56.0

