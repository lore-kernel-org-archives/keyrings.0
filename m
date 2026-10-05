Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDA9347BAF;
	Mon,  5 Oct 2026 06:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791181667; cv=none; b=kY3HjSoDLGyFmuBaLB2cRphQOYiBBsF4b+W2KNncouyqHG0lcc+pJuYwtK/VmBAdtLt9WO9Ald1zMGylDTK/g+HdSwhjtxIWtsM5FuOdyY3UebUlqL3OIqzC5Al1Qw4pQOti+95jlLHyD75nMb5f7LebwC2+AIn7UCMJk3vz8cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791181667; c=relaxed/simple;
	bh=YKhMdesrFcsShgS/YkWJwsmF+udLu87KaB0poBt6/tc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lBaU2aZMUf/nq0g9MJo8q4cJAxOL4raJEop/TVFnSlLZh35h8zQqtIrYqkPXpdHV/s7PoOtyHnm4WwDNdFjGnvZwLQJbzRjKw+FZrtxE6Kga2G2Grx1h64yZjpEXICq7I44vF3PwJyy6cfxVF76+5usJM1OnUOIzVC6WAPsYltU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TN915XRu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TN915XRu"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695165wP3291450;
	Mon, 5 Oct 2026 06:27:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=eBOdU4bbrn9Y819oJUNB6uuympUKXhDiDovpQ4qdW
	j8=; b=TN915XRu6jk4v126nzpgquifrDxKfX15SZDWRHZcD7X/VsJdN69qni2WV
	0Fm95qny2NxS6VyrfronwwEZQKh6kheRqQfdlZE+FkUjpzJg/qcl2Y5cHZHHmcF1
	Snnl1Wv1aL16qmhbadxcB88P/2oZDOtKjU6HW9NPjAWjh44Ml1d9NEN8jyerxC3b
	27d0mxqWKLUkgD8rQRRCDiSYGa60NoErDmaqBv/vnL3a4fIFzg4QRp8sfbida4oG
	xr91zO1pJrHkkX9ncmTtF/NiFFi+1cXFKtVYGgyOuVR+dPyNkcz2rBMHOVepKAI3
	o8RZPNlPT7EFEAWs0rG3c1c8r9HfA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbuyxm3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:27:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6956Exam2165217;
	Mon, 5 Oct 2026 06:27:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pmdf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:27:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6956Rbd240239500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 06:27:37 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C31452004B;
	Mon,  5 Oct 2026 06:27:37 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 555FA20043;
	Mon,  5 Oct 2026 06:27:35 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.bl1-in.ibm.com (unknown [9.123.14.23])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 06:27:35 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, stefanb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        nayna@linux.ibm.com, rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v3] keys/trusted_keys: reuse TPM version in option handling
Date: Mon,  5 Oct 2026 11:57:32 +0530
Message-ID: <20261005062732.140733-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: us9bSo0CG4I9kdkDzTr7YGN2CXd-y_ku
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac3435e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=R0B3_GDsR3QM9wD39lMA:9
X-Proofpoint-GUID: us9bSo0CG4I9kdkDzTr7YGN2CXd-y_ku
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX33SVWNkKhkSv
 tfgDs9deS1RNE1rgjvp+2sj0hEijc18RlXrK1VoNzjxsn4Lg3JgE+sTaA5ZD4M84PNwC62o+vT6
 2yD0uVT05AU5f+NjjZdHKl1rPtydG8vvD2TDPg9VNr0s0eqC79cKynIVKA83f9AZo/1cjk6ZbV2
 /1WdIFSDjLI1GOi/6BetKLR6QxOe1CaesB0jj6IDBa9UpS2ORLzVXI1nU3eFVBsepZ4DeyAsrTw
 2WEF/L7Fg1gWeC6cdn6eJ8Joxp90TY6YrLre5bsQjMsqzDv2RCxGN5QzXvHL2XGGoKQfZ99iTI8
 ci9+hxGM7CjI6i2uawsq9YbEolrLE/N/FKdLdmixiaNujvkLKVF20CqaCLoVzAYxokr3DHbm7j2
 0OomiMd/gmDSrSysBGC1dLstfL5qb4UIerkm7FokGVq7xOyD0k7fLt1SqtRvRsKHXf5XDcUk7oq
 9b/58LSCJC1bjEAcz5g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyNCBTYWx0ZWRfX/PdPXmo2Q2Xu
 Hv9BJSbrVpfnHrcdTyT+lhcaXSPhXmgMR1XuSdBXNSvfXZaXl+SZO27AWtDO6HjWm8h7lQlTrHj
 2DUMx5bUkeugxP1AO256r/oBKgEsOew=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050024

Determine the TPM version once in the seal and unseal paths, and reuse
it when allocating and parsing trusted key options.

This reduces the number of fallible calls to tpm_is_tpm2() and avoids
unnecessary I/O between the kernel and the TPM.

Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
Changelog:

 v3:
  - Tweak the commit message to highlight the reduced failure surface and
    TPM I/O

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

