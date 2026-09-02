Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D68D45C6E4;
	Wed,  2 Sep 2026 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788345100; cv=none; b=looN4zIlUsbBRzIts2RTN1otMMNd13B01TgwQoj0C98RH5YQsLR5xZLxiT/R/DGlcixe0XqE2GaLLMlEMha/5Rbm6WK4b08yDpzQ6028Vqcxg8KkCv+6FvA0Sq1JUXiKiZ7SbBYOF8lRazinTwWJyzDHZSPLxZqGURys93a/ySI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788345100; c=relaxed/simple;
	bh=Mp9vcVPeJuoCFuP2qobrkkWmwmsNXzSKf0IJA6l8wlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+LZ64MhMizfLYvSA2MbHq1CmsIu9jYfCXL1t5EXanTgguVtENXhBYRIiEsZoMRD+uHpPk+D2VWFIqjABc0oKXFeywM+hNrSNMmCvKN8NlU4jPOrHVh6I7DEVbqicDa5/Q/VRo0/4cp5viFXOVxnEWATvGDhiVt4d27qBrUVrIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gr3393xy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gr3393xy"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6829VdLC3863347;
	Wed, 2 Sep 2026 10:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=V1eJ/saajOJ3TxYX0
	w5HqxnmEnklntwrhDW8E0myHDk=; b=Gr3393xyh8p9okOtkFxlv2V6zO7xu25/J
	0LhD/1mBOo9NnMOXD6tZhqzDEjPsrYzkD/CV9bO56qWXtlDpIotNmkoRzprxLQI2
	Y7hHbID1z8lfwIeVhU6i2tFbFyzSXVf6JSdMK0vn8lDRD+I6pBpsIdRL3WV6mbRp
	xNxyGB6mgz6P7DrhroKrDd4fo5IHRYJ/pT3NUkDxc7yp3CHpKOdTmWmIG7+QSoND
	jKqYwcW9ijiQqgN5umKbrANdVRnmhTrM3gOKLItFwUKxLRFrLwZ/x2QTEtEdGdBR
	lLr6tnpWGN2Z+1nt7mBuNBCY843K+xraM/taANUhDA0YB4Ph0FwuA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2tdb39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 10:31:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682AQQm9029990;
	Wed, 2 Sep 2026 10:31:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjahfea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 10:31:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682AVTTj53477660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 10:31:29 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5911320043;
	Wed,  2 Sep 2026 10:31:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D282720040;
	Wed,  2 Sep 2026 10:31:26 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.bl1-in.ibm.com (unknown [9.123.14.23])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 10:31:26 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v6 2/2] keys/trusted_keys: move TPM-specific fields into struct trusted_key_tpm
Date: Wed,  2 Sep 2026 16:01:20 +0530
Message-ID: <20260902103120.222326-3-ssrish@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a97fb06 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=l88gKiHFao-nr1m3x7IA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA5MyBTYWx0ZWRfXzfvXlzqzXQNR
 N3yxYZIWg2GqxS9GMO4FmU0IHVqs3lti58s57ijAkYzRsLzPCtCNhSwQYgo4cBsbgllefbVN7bc
 pDlJZBjevZPRrmQf7cqmIUslPRSbNoM=
X-Proofpoint-ORIG-GUID: lWTFltXUoM8ETmf5gnOtIcPqNcd5eiuc
X-Proofpoint-GUID: lWTFltXUoM8ETmf5gnOtIcPqNcd5eiuc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA5MyBTYWx0ZWRfXy/pGP6jdECDP
 KFcH14VzjAujV9UewSS2vMBEOvpkDcYCTASmj24EObxNDRmuDbcpswlZWZj8qRdszPCJVXtcAGn
 lW8dlJtQytRsS8+pJGtUrPg/zeQmHzfuWTahSNjYExRtk5rIvTjY4mbYGAuMs1KLy5AO5fnH7PW
 nC0LDYesjc+INgGGVixPgr2PRU0j+K0PSZd7vu75WB1imB7V1XtGmAC9EF8Fcple4lldCNLKswQ
 ON6BcYr4F0oLlYpzlGS9HW+DhorHyg4IyGQ4UcCJn7hSyui7iI0jkEyJZ2eMVvtMwbWO+Rr5gi2
 XS4ePrsL4xcBoa4iz2OP5YGzJKewEgBTNBMomBwI74jRapqzArhK7WfyJSVVH/7nYSYyuhbgGhB
 IagiGR2fYr8OPyN0FbPLjmvn1xFzsE2b3T7Npf6w64p6XM883iotMCNKv2i+ySQqMldCZoLM3CJ
 CAgQgRs8yDMxZu7PAKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020093

The trusted_key_options struct contains TPM-specific fields (keyhandle,
keyauth, blobauth_len, blobauth, pcrinfo_len, pcrinfo, pcrlock, hash,
policydigest_len, policydigest, and policyhandle). This leads to the
accumulation of backend-specific fields in the generic options structure.

Define struct trusted_key_tpm and move the TPM-specific fields there. Store
a pointer to it in the private member of struct trusted_key_options.

Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 include/keys/trusted-type.h               |  11 --
 include/keys/trusted_tpm.h                |  14 +++
 security/keys/trusted-keys/trusted_tpm1.c | 121 ++++++++++++----------
 security/keys/trusted-keys/trusted_tpm2.c |  50 +++++----
 4 files changed, 110 insertions(+), 86 deletions(-)

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index 9f9940482da4..3db61b57cf73 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -39,17 +39,6 @@ struct trusted_key_payload {
 
 struct trusted_key_options {
 	uint16_t keytype;
-	uint32_t keyhandle;
-	unsigned char keyauth[TPM_DIGEST_SIZE];
-	uint32_t blobauth_len;
-	unsigned char blobauth[TPM_DIGEST_SIZE];
-	uint32_t pcrinfo_len;
-	unsigned char pcrinfo[MAX_PCRINFO_SIZE];
-	int pcrlock;
-	uint32_t hash;
-	uint32_t policydigest_len;
-	unsigned char policydigest[MAX_DIGEST_SIZE];
-	uint32_t policyhandle;
 	void *private;
 };
 
diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
index 3a0fa3bc8454..dafbd4a84ddd 100644
--- a/include/keys/trusted_tpm.h
+++ b/include/keys/trusted_tpm.h
@@ -6,6 +6,20 @@
 
 extern struct trusted_key_ops trusted_key_tpm_ops;
 
+struct trusted_key_tpm {
+	uint32_t keyhandle;
+	unsigned char keyauth[TPM_DIGEST_SIZE];
+	uint32_t blobauth_len;
+	unsigned char blobauth[TPM_DIGEST_SIZE];
+	uint32_t pcrinfo_len;
+	unsigned char pcrinfo[MAX_PCRINFO_SIZE];
+	int pcrlock;
+	uint32_t hash;
+	uint32_t policydigest_len;
+	unsigned char policydigest[MAX_DIGEST_SIZE];
+	uint32_t policyhandle;
+};
+
 int tpm2_seal_trusted(struct tpm_chip *chip,
 		      struct trusted_key_payload *payload,
 		      struct trusted_key_options *options);
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 1168ca235205..3ec078ca3f97 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -48,15 +48,17 @@ enum {
 #ifdef CONFIG_TRUSTED_KEYS_DEBUG
 static inline void dump_options(struct trusted_key_options *o)
 {
+	struct trusted_key_tpm *private = o->private;
+
 	if (!trusted_debug)
 		return;
 
 	pr_debug("sealing key type %d\n", o->keytype);
-	pr_debug("sealing key handle %0X\n", o->keyhandle);
-	pr_debug("pcrlock %d\n", o->pcrlock);
-	pr_debug("pcrinfo %d\n", o->pcrinfo_len);
+	pr_debug("sealing key handle %0X\n", private->keyhandle);
+	pr_debug("pcrlock %d\n", private->pcrlock);
+	pr_debug("pcrinfo %d\n", private->pcrinfo_len);
 	print_hex_dump_debug("pcrinfo ", DUMP_PREFIX_NONE,
-			     16, 1, o->pcrinfo, o->pcrinfo_len, 0);
+			     16, 1, private->pcrinfo, private->pcrinfo_len, 0);
 }
 
 static inline void dump_sess(struct osapsess *s)
@@ -626,6 +628,7 @@ static int tpm_unseal(struct tpm_buf *tb,
 static int key_seal(struct trusted_key_payload *p,
 		    struct trusted_key_options *o)
 {
+	struct trusted_key_tpm *private = o->private;
 	int ret;
 
 	struct tpm_buf *tb __free(kfree) = kzalloc(TPM_BUFSIZE, GFP_KERNEL);
@@ -637,9 +640,10 @@ static int key_seal(struct trusted_key_payload *p,
 	/* include migratable flag at end of sealed key */
 	p->key[p->key_len] = p->migratable;
 
-	ret = tpm_seal(tb, o->keytype, o->keyhandle, o->keyauth,
+	ret = tpm_seal(tb, o->keytype, private->keyhandle, private->keyauth,
 		       p->key, p->key_len + 1, p->blob, &p->blob_len,
-		       o->blobauth, o->pcrinfo, o->pcrinfo_len);
+		       private->blobauth, private->pcrinfo,
+		       private->pcrinfo_len);
 	if (ret < 0)
 		pr_info("srkseal failed (%d)\n", ret);
 
@@ -652,6 +656,7 @@ static int key_seal(struct trusted_key_payload *p,
 static int key_unseal(struct trusted_key_payload *p,
 		      struct trusted_key_options *o)
 {
+	struct trusted_key_tpm *private = o->private;
 	int ret;
 
 	struct tpm_buf *tb __free(kfree) = kzalloc(TPM_BUFSIZE, GFP_KERNEL);
@@ -660,8 +665,8 @@ static int key_unseal(struct trusted_key_payload *p,
 
 	tpm_buf_init(tb, TPM_BUFSIZE);
 
-	ret = tpm_unseal(tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
-			 o->blobauth, p->key, &p->key_len);
+	ret = tpm_unseal(tb, private->keyhandle, private->keyauth, p->blob,
+			 p->blob_len, private->blobauth, p->key, &p->key_len);
 	if (ret < 0)
 		pr_info("srkunseal failed (%d)\n", ret);
 	else
@@ -697,6 +702,7 @@ static const match_table_t key_tokens = {
 static int getoptions(char *c, struct trusted_key_payload *pay,
 		      struct trusted_key_options *opt)
 {
+	struct trusted_key_tpm *private = opt->private;
 	substring_t args[MAX_OPT_ARGS];
 	char *p = c;
 	int token;
@@ -712,7 +718,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 	if (tpm2 < 0)
 		return tpm2;
 
-	opt->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
+	private->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
 
 	if (!c)
 		return 0;
@@ -726,11 +732,11 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 
 		switch (token) {
 		case Opt_pcrinfo:
-			opt->pcrinfo_len = strlen(args[0].from) / 2;
-			if (opt->pcrinfo_len > MAX_PCRINFO_SIZE)
+			private->pcrinfo_len = strlen(args[0].from) / 2;
+			if (private->pcrinfo_len > MAX_PCRINFO_SIZE)
 				return -EINVAL;
-			res = hex2bin(opt->pcrinfo, args[0].from,
-				      opt->pcrinfo_len);
+			res = hex2bin(private->pcrinfo, args[0].from,
+				      private->pcrinfo_len);
 			if (res < 0)
 				return -EINVAL;
 			break;
@@ -739,12 +745,12 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 			if (res < 0)
 				return -EINVAL;
 			opt->keytype = SEAL_keytype;
-			opt->keyhandle = handle;
+			private->keyhandle = handle;
 			break;
 		case Opt_keyauth:
 			if (strlen(args[0].from) != 2 * SHA1_DIGEST_SIZE)
 				return -EINVAL;
-			res = hex2bin(opt->keyauth, args[0].from,
+			res = hex2bin(private->keyauth, args[0].from,
 				      SHA1_DIGEST_SIZE);
 			if (res < 0)
 				return -EINVAL;
@@ -755,21 +761,23 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 			 * hex strings.  TPM 2.0 authorizations are simple
 			 * passwords (although it can take a hash as well)
 			 */
-			opt->blobauth_len = strlen(args[0].from);
+			private->blobauth_len = strlen(args[0].from);
 
-			if (opt->blobauth_len == 2 * TPM_DIGEST_SIZE) {
-				res = hex2bin(opt->blobauth, args[0].from,
+			if (private->blobauth_len == 2 * TPM_DIGEST_SIZE) {
+				res = hex2bin(private->blobauth, args[0].from,
 					      TPM_DIGEST_SIZE);
 				if (res < 0)
 					return -EINVAL;
 
-				opt->blobauth_len = TPM_DIGEST_SIZE;
+				private->blobauth_len = TPM_DIGEST_SIZE;
 				break;
 			}
 
-			if (tpm2 && opt->blobauth_len <= sizeof(opt->blobauth)) {
-				memcpy(opt->blobauth, args[0].from,
-				       opt->blobauth_len);
+			if (tpm2 &&
+			    private->blobauth_len <=
+			    sizeof(private->blobauth)) {
+				memcpy(private->blobauth, args[0].from,
+				       private->blobauth_len);
 				break;
 			}
 
@@ -787,14 +795,14 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 			res = kstrtoul(args[0].from, 10, &lock);
 			if (res < 0)
 				return -EINVAL;
-			opt->pcrlock = lock;
+			private->pcrlock = lock;
 			break;
 		case Opt_hash:
 			if (test_bit(Opt_policydigest, &token_mask))
 				return -EINVAL;
 			for (i = 0; i < HASH_ALGO__LAST; i++) {
 				if (!strcmp(args[0].from, hash_algo_name[i])) {
-					opt->hash = i;
+					private->hash = i;
 					break;
 				}
 			}
@@ -806,14 +814,14 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 			}
 			break;
 		case Opt_policydigest:
-			digest_len = hash_digest_size[opt->hash];
+			digest_len = hash_digest_size[private->hash];
 			if (!tpm2 || strlen(args[0].from) != (2 * digest_len))
 				return -EINVAL;
-			res = hex2bin(opt->policydigest, args[0].from,
+			res = hex2bin(private->policydigest, args[0].from,
 				      digest_len);
 			if (res < 0)
 				return -EINVAL;
-			opt->policydigest_len = digest_len;
+			private->policydigest_len = digest_len;
 			break;
 		case Opt_policyhandle:
 			if (!tpm2)
@@ -821,7 +829,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 			res = kstrtoul(args[0].from, 16, &handle);
 			if (res < 0)
 				return -EINVAL;
-			opt->policyhandle = handle;
+			private->policyhandle = handle;
 			break;
 		default:
 			return -EINVAL;
@@ -832,6 +840,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 
 static struct trusted_key_options *trusted_options_alloc(void)
 {
+	struct trusted_key_tpm *private;
 	struct trusted_key_options *options;
 	int tpm2;
 
@@ -844,15 +853,23 @@ static struct trusted_key_options *trusted_options_alloc(void)
 		/* set any non-zero defaults */
 		options->keytype = SRK_keytype;
 
-		if (!tpm2)
-			options->keyhandle = SRKHANDLE;
+		private = kzalloc_obj(*private);
+		if (!private) {
+			kfree_sensitive(options);
+			options = NULL;
+		} else {
+			if (!tpm2)
+				private->keyhandle = SRKHANDLE;
+			options->private = private;
+		}
 	}
 	return options;
 }
 
 static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
 {
-	struct trusted_key_options *options = NULL;
+	struct trusted_key_options *options __free(kfree_sensitive) = NULL;
+	struct trusted_key_tpm *private __free(kfree_sensitive) = NULL;
 	int ret = 0;
 	int tpm2;
 
@@ -864,15 +881,15 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
 	if (!options)
 		return -ENOMEM;
 
+	private = options->private;
+
 	ret = getoptions(datablob, p, options);
 	if (ret < 0)
-		goto out;
+		return ret;
 	dump_options(options);
 
-	if (!options->keyhandle && !tpm2) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!private->keyhandle && !tpm2)
+		return -EINVAL;
 
 	if (tpm2)
 		ret = tpm2_seal_trusted(chip, p, options);
@@ -880,24 +897,24 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
 		ret = key_seal(p, options);
 	if (ret < 0) {
 		pr_info("key_seal failed (%d)\n", ret);
-		goto out;
+		return ret;
 	}
 
-	if (options->pcrlock) {
-		ret = pcrlock(options->pcrlock);
+	if (private->pcrlock) {
+		ret = pcrlock(private->pcrlock);
 		if (ret < 0) {
 			pr_info("pcrlock failed (%d)\n", ret);
-			goto out;
+			return ret;
 		}
 	}
-out:
-	kfree_sensitive(options);
+
 	return ret;
 }
 
 static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
 {
-	struct trusted_key_options *options = NULL;
+	struct trusted_key_options *options __free(kfree_sensitive) = NULL;
+	struct trusted_key_tpm *private __free(kfree_sensitive) = NULL;
 	int ret = 0;
 	int tpm2;
 
@@ -908,16 +925,15 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
 	options = trusted_options_alloc();
 	if (!options)
 		return -ENOMEM;
+	private = options->private;
 
 	ret = getoptions(datablob, p, options);
 	if (ret < 0)
-		goto out;
+		return ret;
 	dump_options(options);
 
-	if (!options->keyhandle && !tpm2) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (!private->keyhandle && !tpm2)
+		return -EINVAL;
 
 	if (tpm2)
 		ret = tpm2_unseal_trusted(chip, p, options);
@@ -928,15 +944,14 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
 		return ret;
 	}
 
-	if (options->pcrlock) {
-		ret = pcrlock(options->pcrlock);
+	if (private->pcrlock) {
+		ret = pcrlock(private->pcrlock);
 		if (ret < 0) {
 			pr_info("pcrlock failed (%d)\n", ret);
-			goto out;
+			return ret;
 		}
 	}
-out:
-	kfree_sensitive(options);
+
 	return ret;
 }
 
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 67225dd562a9..29da1a3328ef 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -23,6 +23,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 			   struct trusted_key_options *options,
 			   u8 *src, u32 len)
 {
+	struct trusted_key_tpm *private = options->private;
 	const int SCRATCH_SIZE = PAGE_SIZE;
 	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
 	u8 *work = scratch, *work1;
@@ -45,7 +46,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	work = asn1_encode_oid(work, end_work, tpm2key_oid,
 			       asn1_oid_len(tpm2key_oid));
 
-	if (options->blobauth_len == 0) {
+	if (private->blobauth_len == 0) {
 		unsigned char bool[3], *w = bool;
 		/* tag 0 is emptyAuth */
 		w = asn1_encode_boolean(w, w + sizeof(bool), true);
@@ -68,7 +69,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 		goto err;
 	}
 
-	work = asn1_encode_integer(work, end_work, options->keyhandle);
+	work = asn1_encode_integer(work, end_work, private->keyhandle);
 	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
 	work = asn1_encode_octet_string(work, end_work, priv, priv_len);
 
@@ -101,6 +102,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 			   struct trusted_key_options *options,
 			   u8 **buf)
 {
+	struct trusted_key_tpm *private = options->private;
 	int ret;
 	struct tpm2_key_context ctx;
 	u8 *blob;
@@ -120,7 +122,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 		return -ENOMEM;
 
 	*buf = blob;
-	options->keyhandle = ctx.parent;
+	private->keyhandle = ctx.parent;
 
 	memcpy(blob, ctx.priv, ctx.priv_len);
 	blob += ctx.priv_len;
@@ -232,6 +234,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		      struct trusted_key_payload *payload,
 		      struct trusted_key_options *options)
 {
+	struct trusted_key_tpm *private = options->private;
 	off_t offset = TPM_HEADER_SIZE;
 	struct tpm_buf *buf __free(kfree) = NULL;
 	struct tpm_buf *sized __free(kfree) = NULL;
@@ -240,11 +243,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	u32 flags;
 	int rc;
 
-	hash = tpm2_find_hash_alg(options->hash);
+	hash = tpm2_find_hash_alg(private->hash);
 	if (hash < 0)
 		return hash;
 
-	if (!options->keyhandle)
+	if (!private->keyhandle)
 		return -EINVAL;
 
 	rc = tpm_try_get_ops(chip);
@@ -274,18 +277,18 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 
 	tpm_buf_init_sized(sized, TPM_BUFSIZE);
 
-	rc = tpm_buf_append_name(chip, buf, options->keyhandle, NULL);
+	rc = tpm_buf_append_name(chip, buf, private->keyhandle, NULL);
 	if (rc)
 		goto out;
 
 	tpm_buf_append_hmac_session(chip, buf, TPM2_SA_DECRYPT,
-				    options->keyauth, TPM_DIGEST_SIZE);
+				    private->keyauth, TPM_DIGEST_SIZE);
 
 	/* sensitive */
-	tpm_buf_append_u16(sized, options->blobauth_len);
+	tpm_buf_append_u16(sized, private->blobauth_len);
 
-	if (options->blobauth_len)
-		tpm_buf_append(sized, options->blobauth, options->blobauth_len);
+	if (private->blobauth_len)
+		tpm_buf_append(sized, private->blobauth, private->blobauth_len);
 
 	tpm_buf_append_u16(sized, payload->key_len);
 	tpm_buf_append(sized, payload->key, payload->key_len);
@@ -298,14 +301,15 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 
 	/* key properties */
 	flags = 0;
-	flags |= options->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
+	flags |= private->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
 	flags |= payload->migratable ? 0 : (TPM2_OA_FIXED_TPM | TPM2_OA_FIXED_PARENT);
 	tpm_buf_append_u32(sized, flags);
 
 	/* policy */
-	tpm_buf_append_u16(sized, options->policydigest_len);
-	if (options->policydigest_len)
-		tpm_buf_append(sized, options->policydigest, options->policydigest_len);
+	tpm_buf_append_u16(sized, private->policydigest_len);
+	if (private->policydigest_len)
+		tpm_buf_append(sized, private->policydigest,
+			       private->policydigest_len);
 
 	/* public parameters */
 	tpm_buf_append_u16(sized, TPM_ALG_NULL);
@@ -376,6 +380,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			 u32 *blob_handle)
 {
 	u8 *blob_ref __free(kfree) = NULL;
+	struct trusted_key_tpm *private = options->private;
 	struct tpm_buf *buf __free(kfree) = NULL;
 	unsigned int private_len;
 	unsigned int public_len;
@@ -395,7 +400,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	}
 
 	/* new format carries keyhandle but old format doesn't */
-	if (!options->keyhandle)
+	if (!private->keyhandle)
 		return -EINVAL;
 
 	/* must be big enough for at least the two be16 size counts */
@@ -439,11 +444,11 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	tpm_buf_init(buf, TPM_BUFSIZE);
 	tpm_buf_reset(buf, TPM2_ST_SESSIONS, TPM2_CC_LOAD);
 
-	rc = tpm_buf_append_name(chip, buf, options->keyhandle, NULL);
+	rc = tpm_buf_append_name(chip, buf, private->keyhandle, NULL);
 	if (rc)
 		return rc;
 
-	tpm_buf_append_hmac_session(chip, buf, 0, options->keyauth,
+	tpm_buf_append_hmac_session(chip, buf, 0, private->keyauth,
 				    TPM_DIGEST_SIZE);
 
 	tpm_buf_append(buf, blob, blob_len);
@@ -483,6 +488,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			   struct trusted_key_options *options,
 			   u32 blob_handle)
 {
+	struct trusted_key_tpm *private = options->private;
 	struct tpm_header *head;
 	struct tpm_buf *buf __free(kfree) = NULL;
 	u16 data_len;
@@ -507,10 +513,10 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	if (rc)
 		return rc;
 
-	if (!options->policyhandle) {
+	if (!private->policyhandle) {
 		tpm_buf_append_hmac_session(chip, buf, TPM2_SA_ENCRYPT,
-					    options->blobauth,
-					    options->blobauth_len);
+					    private->blobauth,
+					    private->blobauth_len);
 	} else {
 		/*
 		 * FIXME: The policy session was generated outside the
@@ -523,9 +529,9 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		 * could repeat our actions with the exfiltrated
 		 * password.
 		 */
-		tpm2_buf_append_auth(buf, options->policyhandle,
+		tpm2_buf_append_auth(buf, private->policyhandle,
 				     NULL /* nonce */, 0, 0,
-				     options->blobauth, options->blobauth_len);
+				     private->blobauth, private->blobauth_len);
 		if (tpm2_chip_auth(chip)) {
 			tpm_buf_append_hmac_session(chip, buf, TPM2_SA_ENCRYPT,
 						    NULL, 0);
-- 
2.53.0

