Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A575A2E888A;
	Wed, 30 Sep 2026 06:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790748184; cv=none; b=bLHLZDd+CPsvSKs9x96SV7B9wwzKVVU4DX/YLMboH7330/eVxtpiL+PRQD4RCZfKMGFMGFYBA5/5iTC1PD2Hvzj3ZVCKwiCuka02K3uJwbnF03yRWnTC/SdYeqpp6TGSE43Q+iB9MSQVHeCIrFks13bjn0YRwQNS9O5Fg0kYB6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790748184; c=relaxed/simple;
	bh=x7yxzvbk/nwx11GtQSiP+q0wSkfeUYzZsQna6Vk+UWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lghvvXbHeClGVvkZiF/SEFz7pv0uGAk3pC7CTWqMUs0zR09YIs9xKb+wycCN+LhHG15kSNOcV4Twt/KjmvcTFo4H78JYH1hbGLHG51cD9NGESfQSvQqCmuCae/tkaFkG8p+VW+Ezw5luOuYx/hMj1WksIKC1k+4XsZIcT+5dJ/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gGjmOtLD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gGjmOtLD"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TNZNWK1395004;
	Wed, 30 Sep 2026 06:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vmWm2plfEN+MPd5QTMzUjqr0h4xUJjNCITuZYL+U9
	64=; b=gGjmOtLD8ymNbi361IJWqP7HbjaB/x7WZ4przRQJG8LnthTGu3r+rwaHM
	X3F67IFuLWN/Gs0GmRqlVNI66g/rXLPNj+lVpklTLAZruGHkWWxXKv9tigsNnB5o
	pNT18Ld0HUmpoBH7vYtlbvrl7fft5VTaYEz+IrlBPG8oqhDzu1PPG8kBUG+pgFa7
	6WmkACXMdereLW/7JFudkZezOaNer8QEts/6nFbccovQ4a7fJqtDzGDNWBJK6anN
	t++QEqNasS0T3hlYuF3wT8UeXsSmkHzpLVj7g11ma+wH84iTttqDohiKyfDdzN0h
	rvoIi1wLv2u4wrFx0Kq77if7nv7+w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5b9s8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 06:02:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68U4s4BF1288981;
	Wed, 30 Sep 2026 06:02:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4p93ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 06:02:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68U62oou41222488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 06:02:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3421A200ED;
	Wed, 30 Sep 2026 06:02:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20A0A200E8;
	Wed, 30 Sep 2026 06:02:46 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.100.83])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 06:02:45 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, stefanb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        nayna@linux.ibm.com, rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH] keys/trusted_keys: reuse TPM version in option handling
Date: Wed, 30 Sep 2026 11:32:17 +0530
Message-ID: <20260930060217.112471-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyMiBTYWx0ZWRfXwXA4jSUT2JSH
 GTA2cXTqxJ1shaNMKvaqtHOnKzyCLlfTnwhpw8V/rN2DpOf+9Iih7efgTdQoy9kCm0a8KPbv0gl
 fzqIIHmfz/aeo1mFNR/A9CWi/IMVWws=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyMiBTYWx0ZWRfXz+84avMd1P/K
 gnynRfPtwsHKP1nEzcFmEfRAUOdEZAPo5z4HfcCZC6Kgno37EQtJ6ciwW41N7SU13ygJkH9YPZb
 dtaBYK4VoV2ff5l0hGWrFYQVTS1SyRTR9Oe/5GnjBH3cngfEllxxdeWXAWOJZ4OVIc2aLveOR04
 KIcVqXQ2pHtKhLTartE6JK/2vAxdiGOTwvHUaR8UqjiVe6gyzg/NqvceCC3xrklr534/F6eBRPf
 SimAhAUUrpmO9O7CY/bNTmttElRwU/23ASSmmYD+E1PsgOZEgOK/P+z1HUjg94UHqhVMCUXK0Kr
 U6MFIyks/cPdizwHHw5eZqqDkZz4KCKksOb/wxMETAgR6KTJk3oGYxI+3o96jbunrejLXhS5Xbn
 OHDkCKF3ctrsdNRGAbrG82Li+JcSGoq39TmBcNBvEYsl/broSC19DOZBNqgMNi3Pl2kp/evdmkp
 hptiI6T1JwggwBF2OZg==
X-Proofpoint-GUID: pD4QnmUGBZJan8AVVXFtNzFhT0W68Kzz
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abca60e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=KeO-EBKqL_xBPfDdp0MA:9
X-Proofpoint-ORIG-GUID: pD4QnmUGBZJan8AVVXFtNzFhT0W68Kzz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300022

Determine the TPM version once in the seal and unseal paths and reuse it
when allocating and parsing trusted key options. This avoids redundant TPM
version checks.

Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/keys/trusted-keys/trusted_tpm1.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 3ec078ca3f97..70de4101923f 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -700,7 +700,7 @@ static const match_table_t key_tokens = {
 
 /* can have zero or more token= options */
 static int getoptions(char *c, struct trusted_key_payload *pay,
-		      struct trusted_key_options *opt)
+		      struct trusted_key_options *opt, int tpm2)
 {
 	struct trusted_key_tpm *private = opt->private;
 	substring_t args[MAX_OPT_ARGS];
@@ -712,11 +712,6 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 	unsigned long token_mask = 0;
 	unsigned int digest_len;
 	int i;
-	int tpm2;
-
-	tpm2 = tpm_is_tpm2(chip);
-	if (tpm2 < 0)
-		return tpm2;
 
 	private->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
 
@@ -838,15 +833,10 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 	return 0;
 }
 
-static struct trusted_key_options *trusted_options_alloc(void)
+static struct trusted_key_options *trusted_options_alloc(int tpm2)
 {
 	struct trusted_key_tpm *private;
 	struct trusted_key_options *options;
-	int tpm2;
-
-	tpm2 = tpm_is_tpm2(chip);
-	if (tpm2 < 0)
-		return NULL;
 
 	options = kzalloc_obj(*options);
 	if (options) {
@@ -877,13 +867,13 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
 	if (tpm2 < 0)
 		return tpm2;
 
-	options = trusted_options_alloc();
+	options = trusted_options_alloc(tpm2);
 	if (!options)
 		return -ENOMEM;
 
 	private = options->private;
 
-	ret = getoptions(datablob, p, options);
+	ret = getoptions(datablob, p, options, tpm2);
 	if (ret < 0)
 		return ret;
 	dump_options(options);
@@ -922,12 +912,12 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
 	if (tpm2 < 0)
 		return tpm2;
 
-	options = trusted_options_alloc();
+	options = trusted_options_alloc(tpm2);
 	if (!options)
 		return -ENOMEM;
 	private = options->private;
 
-	ret = getoptions(datablob, p, options);
+	ret = getoptions(datablob, p, options, tpm2);
 	if (ret < 0)
 		return ret;
 	dump_options(options);
-- 
2.53.0

