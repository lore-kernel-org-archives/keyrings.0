Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116B8418A33;
	Fri,  2 Oct 2026 07:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790925081; cv=none; b=g4xptxrB7iqEaNzjLuQ8vHrLE8KPBWNJmJsV4WvZ2ys4oopgAGN7gWs5P8PWpVHM5lx62G+6sFDM9Z6aLNN53CkVW9oH8mPT1HzK0Godn4aGAgsGDMN2e9cGorEKYqVIadrMH2UwTj85Vyddnso0GqVyl2Rh4tDTec87I/b2LA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790925081; c=relaxed/simple;
	bh=yDCRRgDd0sb5f/bBTA2w/WwIAnw4vFHFS80lhIyLL3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lAgNNkTtDsPNGgOLlXTShcpSD9T8Uf04jkWK8KZvDq3fEgZNXhomWysrcZtZ4qECvujFDsen4u9pq/U9WBu2IxsSkBq6GL8XLLpqQjLVTEGlJ7RDv0vNJNoCzeKVkUL4F/n3+OMvL2UBBMRi3k8gZTH1FD1GYqYRCNp1qFwXop4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aF9vYtMr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aF9vYtMr"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69266gZi2684610;
	Fri, 2 Oct 2026 07:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=79K4JGGj8PXo7JbUTPqX7WgOYDnMsT4XTaPOSfQIm
	Wc=; b=aF9vYtMrjJE5dz+hQN6Um3KTNoC3oGuNWvfSZhna9joKP/HLQcYNZ7O+U
	FuX0p8K6BhXqa+FlHmBvoRkw/+rUXewZUWbxz526NUgSWdvI2Onu9ozUxhX+o0AT
	M3SBItvJahOoRf7X71h6nT8vnPliJNKXhJSbyP0sUuZKu5BxMIVUBM+2uhI+pUhS
	Zz+YaG3E8cRr/5HyycOBVn0fl1VuZOzAf3HBgQCrJE7rnHVhIrUZJs0o8v7+h4WQ
	3UQjBttyFaJXV5tMv05BEISlO7iT4YuxDodl7H4oovIGYMVbN4hg8D5nYgO5j2Sf
	nrZUYQUVL7cQ7epLaeRC9ZT/ldcYg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fepm1b-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 07:11:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6925lVgw2088576;
	Fri, 2 Oct 2026 07:11:16 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h21nu150m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 07:11:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6927BCIU38339048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 07:11:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23D1320043;
	Fri,  2 Oct 2026 07:11:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8ED7820040;
	Fri,  2 Oct 2026 07:11:01 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.94.93])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Oct 2026 07:11:00 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, stefanb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        nayna@linux.ibm.com, rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v2] keys/trusted_keys: reuse TPM version in option handling
Date: Fri,  2 Oct 2026 12:40:50 +0530
Message-ID: <20261002071050.179879-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abf5914 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=R0B3_GDsR3QM9wD39lMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAyOCBTYWx0ZWRfX6b2lljiTufGn
 5be/k+hI53UadjEWAqfITaPgjQsDIjL7T/6hNZJLKE1OcM7vkGc3/5RAHyIf+Hpq4yyztQGxvCE
 Kb7vEhwaEvuY3IE4dYTO3y0o5Ni9Oe8=
X-Proofpoint-ORIG-GUID: EVSJl2fUxA04MaxYYCxGH8dAZskXpvh4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAyOCBTYWx0ZWRfX8lQPPGKRuZpa
 sCKTfxHH8qLHFs4te8EyoGtvysL2XOKJKgC4VdqcGliuj9UIIy6ANZJX+gdp9Kcamhncuf+3coh
 A8vheHpKiY3o33JKmpcmIqhyUlGX2TLqa5bYvz/ebFfb5rZSTEhKISc0NnAjBeALyBn3JbWqAwK
 yT50G/h144lFupleUGwsY+x6ZD3bdyguxn18sLExWB6H5nqYb0NlzevElbrBdx8OC9fvMIJv836
 ic6CUlIxx8JlOpF4C+DidREmXwEsyvdX0kA8XGE80TOjlpdpkKps+DH0Q7LgD3wBOKVuCBCPHtZ
 e22nBB5oC/HE9LIZRbBWX57fEqlQRbWI6bonBQDfgqjzJLHKG3kjNgkvrSXJtbf7Jx2vYmn4zhj
 hDLzgnc7C4DBl68zE1DBcFGH2o+IJemx8a0O/1SCf/cmWq6+PqMuGktnLy031OtiW+mupw9dsVd
 AGZoho0PwjDzqTIivyg==
X-Proofpoint-GUID: EVSJl2fUxA04MaxYYCxGH8dAZskXpvh4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020028

Determine the TPM version once in the seal and unseal paths and reuse it
when allocating and parsing trusted key options. This avoids redundant TPM
version checks.

Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
Changelog:

 v2:
  - Use bool to indicate whether the chip is TPM 2.0 in the option helpers

 security/keys/trusted-keys/trusted_tpm1.c | 35 +++++++++--------------
 1 file changed, 13 insertions(+), 22 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 3ec078ca3f97..6dbce058368f 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -700,7 +700,7 @@ static const match_table_t key_tokens = {
 
 /* can have zero or more token= options */
 static int getoptions(char *c, struct trusted_key_payload *pay,
-		      struct trusted_key_options *opt)
+		      struct trusted_key_options *opt, bool is_tpm2)
 {
 	struct trusted_key_tpm *private = opt->private;
 	substring_t args[MAX_OPT_ARGS];
@@ -712,13 +712,8 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 	unsigned long token_mask = 0;
 	unsigned int digest_len;
 	int i;
-	int tpm2;
-
-	tpm2 = tpm_is_tpm2(chip);
-	if (tpm2 < 0)
-		return tpm2;
 
-	private->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
+	private->hash = is_tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
 
 	if (!c)
 		return 0;
@@ -773,7 +768,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 				break;
 			}
 
-			if (tpm2 &&
+			if (is_tpm2 &&
 			    private->blobauth_len <=
 			    sizeof(private->blobauth)) {
 				memcpy(private->blobauth, args[0].from,
@@ -808,14 +803,15 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 			}
 			if (i == HASH_ALGO__LAST)
 				return -EINVAL;
-			if  (!tpm2 && i != HASH_ALGO_SHA1) {
+			if (!is_tpm2 && i != HASH_ALGO_SHA1) {
 				pr_info("TPM 1.x only supports SHA-1.\n");
 				return -EINVAL;
 			}
 			break;
 		case Opt_policydigest:
 			digest_len = hash_digest_size[private->hash];
-			if (!tpm2 || strlen(args[0].from) != (2 * digest_len))
+			if (!is_tpm2 ||
+			    strlen(args[0].from) != (2 * digest_len))
 				return -EINVAL;
 			res = hex2bin(private->policydigest, args[0].from,
 				      digest_len);
@@ -824,7 +820,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 			private->policydigest_len = digest_len;
 			break;
 		case Opt_policyhandle:
-			if (!tpm2)
+			if (!is_tpm2)
 				return -EINVAL;
 			res = kstrtoul(args[0].from, 16, &handle);
 			if (res < 0)
@@ -838,15 +834,10 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 	return 0;
 }
 
-static struct trusted_key_options *trusted_options_alloc(void)
+static struct trusted_key_options *trusted_options_alloc(bool is_tpm2)
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
@@ -858,7 +849,7 @@ static struct trusted_key_options *trusted_options_alloc(void)
 			kfree_sensitive(options);
 			options = NULL;
 		} else {
-			if (!tpm2)
+			if (!is_tpm2)
 				private->keyhandle = SRKHANDLE;
 			options->private = private;
 		}
@@ -877,13 +868,13 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
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
@@ -922,12 +913,12 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
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

