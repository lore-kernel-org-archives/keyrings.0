Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A32453A29;
	Wed,  2 Sep 2026 10:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788345096; cv=none; b=EDXZ5iF6fQadiXqSvweDDkRUfWrvNWu1NV4ZbOZqYF5jLeJwgal0KleLcRZhVNHtceL02pPezVZCcX30HEqMQqnnCCoD3TUgk8NeqX2oAvYwrjCM7GJHpHyTNPoWln5F08frd1Icc2xr1z7NyLTgdYKiLXrl0piEjkJWhDrZWso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788345096; c=relaxed/simple;
	bh=6Tf+5Kv2AWp6M2ayoP46ROFq/JF/Js48EdcBCRE19a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YXuhWFp6xYNhx0zT5XYu9CblpXALmHSBS4Z4du2f1U7hO96ujbzDxfjd9Ht+/RqQguKUSTsnWnnkTyNeqL+gYPEclzZLz0s/zaY83gu7JmzTTtU+Xcc2ICZ9ZPtGRUduC7GQo+itj3TriHRwVdzbvvyQSCOxjyX+gjHqVWvF3bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WJF62tRz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WJF62tRz"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6829Vvwv3863862;
	Wed, 2 Sep 2026 10:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Jh6qCyRm2JaQCCgVc
	KUg5l7PIYgSTemQ+IJhVm5/vrE=; b=WJF62tRzu0o6JgxgMPzvx1c+gH+gHYAvj
	PKIiBbovOjlKpcVJA9e2dQ3kKchOJiC65Pevcye2STRjZ9+C0NAV23NrfWPrtFHZ
	yvHAQJq9r7rbsaVH85vwUnH8sPWmlATVXOw/YacZgaCowrDa9s7Br9t5R8OHvrm2
	IBkMZOjLbfNXXAzDEb9zTsvkuaiFIBdfv4c1QWBdBW6osJwQQilnUthcaOspcKUz
	0fm1pjk3g2T1f2mXNe6UQyI0MzgPRhHOFOe0fBh/XytIlaH8TcYCFNyQ2w/3DLiH
	8N8XW0KveF/eYY/431vdVYsECBuZlqBH9/hPZLtrq1Y+rBrMt0Lbg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2tdb33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 10:31:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682AQKQe029937;
	Wed, 2 Sep 2026 10:31:30 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjahfe3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 10:31:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682AVQ2330737022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 10:31:26 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 889EF2004B;
	Wed,  2 Sep 2026 10:31:26 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3ED3420043;
	Wed,  2 Sep 2026 10:31:24 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.bl1-in.ibm.com (unknown [9.123.14.23])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 10:31:23 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH 1/2] keys/trusted_keys: return immediately after TPM unseal failure
Date: Wed,  2 Sep 2026 16:01:19 +0530
Message-ID: <20260902103120.222326-2-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260902103120.222326-1-ssrish@linux.ibm.com>
References: <20260902103120.222326-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a97fb03 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Gb-tKBqSAOq4cnd-bv4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA5MyBTYWx0ZWRfX1LOKpVPDNS9O
 HxnoUoXX98DYDoNktIo+0uGYbMtLdqvoSjM/JsqVzjWYPpbDzvLjdfPHL7CYn8mEs5nfaGIfR0q
 eLikEyxPuVQYSMv0VKvHaYpIOQFKfmA=
X-Proofpoint-ORIG-GUID: _FXoqTpQZ2DOh0G0_gVlvdg5itjxKYPo
X-Proofpoint-GUID: _FXoqTpQZ2DOh0G0_gVlvdg5itjxKYPo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA5MyBTYWx0ZWRfX7xqXF1McRhp8
 7Qso8Nsan4DdzCjOs+RNMp4D1F+zidykjETYasqRN7LmIkBJx2cEE/aXn4HdjBYqJaPq1bzPxdl
 0GpyhKQPTDFNo8IgropRubXV2jwcvlBUdUcSOOdSMPV6A2Ks/IpKp72JiHf/MI39QEZYpKJ0cHi
 KdZKxRtK7wqYYCBSoCoHumcN4rhONhuNGT8O9HA1/bHmcCTw4bsAoJsP0G13+1SliVyavIxwe3s
 QFLtTiMfOZWz5WsJ4qfpf/+WWBGu9zhzLzP6mEdGoli3i8hwWEuzmcF9evsqj6+J2GI1OgO5Jr4
 qL3VHlxg+Io1bZs0ba0aE7TOzwUeOVpteZZ4GLo2X/zh2S1RloV98Rpuuh6e+LfDbbHo9wwl40Y
 VM+pHKPImRiMM7XMbjGjY8Kll9EE/Lr8Blbjphe3z1POt66I+8BAp1q83mgrWjA7TjYKho5xH3l
 AJlT/QSWL124SPHZmcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020093

trusted_tpm_unseal() proceeds to pcrlock() when the TPM unseal operation
fails. If pcrlock() succeeds, its return value overwrites the unseal error,
causing key instantiation to succeed.

Return immediately when unseal fails to preserve the original error.

Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
Cc: stable@vger.kernel.org
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 security/keys/trusted-keys/trusted_tpm1.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index bf0bf7f36970..1168ca235205 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -923,8 +923,10 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
 		ret = tpm2_unseal_trusted(chip, p, options);
 	else
 		ret = key_unseal(p, options);
-	if (ret < 0)
+	if (ret < 0) {
 		pr_info("key_unseal failed (%d)\n", ret);
+		return ret;
+	}
 
 	if (options->pcrlock) {
 		ret = pcrlock(options->pcrlock);
-- 
2.53.0

