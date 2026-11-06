Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986338;
	b=Vnud95sr/ttBkkIdYnsGf8bSJ6HdPyHBFTrBzaeecV7W01rq0wmZovtjUKqRrhaMur09
	 9DM/EuVDRfwcmaVRnc+BJVSd/MBHkHsXULWddWZCaYr04BauBKHUhY6Ogim2iXOISkkPi
	 lkpNJG7guc88VKX8lhyxfWwswx5qLbcu4wtjCoTMi9+1PZtpPOeSLYLElFwx1QJUFbonY
	 LYxEYPbEy16htn+WE8Cn/cP+vkTpb/d+45XSe3cyPB5ss1EMgYl0dTcCSQIhNX7Hu6s0k
	 J3HFaPxatTQcNyx4ylTyGH3neujYzI6pHgplq5+suXRCtx6hIH3zTM5lmK7Cr+vb/nQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986338;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=IFqgPaQSsGAOAAXhAFrHMSwSNtbalnEkEWXg7ucBhqc=;
	b=OehEyMrFaXMwKqyc/wo08BcoquOAzSGBRT1h60+YQo50fFF4M070o4LspHRWEHHHmYJ2
	 qYC63fZtFu4bi+UUT1jprRihLnp72iksaekTVMZjFDPkSHIwQ+IQnVWJyyOgxn8zHNrBp
	 so+w/y51LPuoz5/AeDFdFaPGwEyDPI/TzoOfMQhlL/siP8StMVVdGGs5NyMDKLGYyhu6k
	 zVQPqniz1dEUT0OOWcnoLUmWxXeoMKyETG7MTjz7AOtFWIbjNYrhjiSHnE2UZF4Zp8TCG
	 C08UeL+yDoNZZ/JUL+vNzuQURX36FGmwrUAw7aVeQBCEgipJrjiMCaspjDCar63eQmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dKhY5+MS;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52596606A326;
	Fri,  6 Nov 2026 17:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52596606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dKhY5+MS
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FECLX1094596;
	Fri, 6 Nov 2026 17:32:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=IFqgPaQSsGAOAAXhA
	FrHMSwSNtbalnEkEWXg7ucBhqc=; b=dKhY5+MS94KiVuAagUKq9qGyFvlhWxu0D
	/ItrdSt/R4RTkWtJw2owWXW7FYEUSacuSaVbpRpx4/nYXvYoOE8lmUbJPx3BNvX9
	biNAQ14QFPa8E/Kv8B8nK8fSyN7Wq+We3wBg5vAFPn6/8xiU4kC7G9aDCZPNbQdb
	qWO43rXpPWiflwUNZc56bHWOqnsp1mbQDgnsSKE2BvvYcHbY0oiOFyZOfPd8H++C
	nWrT5u8j9u41r0KXgkljRz2JgDhBvyIzx1nX9bMtzUrRGJS/G4a+Mzagn//YOwGk
	HZY0EnAbK4AF91TZDdPg86WnqpFda2d/76A2ZkGFhTwWO2Ibq4v7Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3raxenj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 17:32:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6H0tr03538379;
	Fri, 6 Nov 2026 17:32:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrk9mtxxd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 17:32:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6HW0Ji48038318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 17:32:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AC1420043;
	Fri,  6 Nov 2026 17:32:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63A9B20040;
	Fri,  6 Nov 2026 17:31:58 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.47.32])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 17:31:58 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] integrity: use is_key_blacklisted() in asymmetric_verify()
Date: Fri,  6 Nov 2026 12:31:48 -0500
Message-ID: <20261106173149.707244-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106173149.707244-1-zohar@linux.ibm.com>
References: <20261106173149.707244-1-zohar@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=QYDzLcbv c=1 sm=1 tr=0 ts=6aee0f13 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=LZ98HGj1AhCkXw0SDaAA:9
X-Proofpoint-GUID: V-T_ekbUvd9Mvmika4XRy_aSwX2yneHs
X-Proofpoint-ORIG-GUID: V-T_ekbUvd9Mvmika4XRy_aSwX2yneHs
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX54cjb2XXAtWn
 RqcUcKpnR7hb0ndv+a2uqI53NvSyVjJJaU+sVqjRQA/HZuL5GW1GVOKgur8PpQ/cS/FNCGh8KzF
 SB+d/hzoDHpfs8Q7DPqBjqbTD4asBDY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfXylpNJJLAmoSS
 +YIdJqN32Z1Ec1JA3GY2l76R6D5EEaUOc4lJaB7hR0p2vi9NQOyGaVPUmhQq+Pf+6jmix2mCE1h
 Vymenj3SF7mQiSLMJyiDVotnuSSxT7v7WJGMROE9GbqcPMJXQvoILNGxT8f0EoH1oozu7mcBEB3
 KplYb7Ah8veU0tXYJVPply8+KPPtWQCFBU5M38KWBGH3Z4OxNh6J64KI78VT+hp8qUN7KP19ugE
 wtD5bdr7e/MjXxkfplNmCvywzQA+BKaPznqYYPZDBzUtNRbk5TuDlz3C1NoMusUH0VB95jgAA/X
 z7hd9yIKw3lxybrJWsuTPlRAznh5gKmvycaGmIdllNsvhKowiRUgRXIw/8zMximK+/Fiemxh0wM
 4XLEgnJBukec3sjXCkSL77njU37DINZWUGForsFlvH2OrzDn1RSsQICYvempImdwoaoWNMC+b9n
 jOk52wciDoPjyr+M2zA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060068

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

