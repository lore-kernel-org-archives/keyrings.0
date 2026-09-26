Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1043803D2;
	Sat, 26 Sep 2026 18:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790448188; cv=none; b=sIDptHg+tl32qlnWjrSs65NMTlIHOMjzHWxqsdMtUv7Ks+nH/tPTCSaPPo/kFUPnBg63hb27nXNCmgqLun1wLMivuWuN/HQicVoOh3SsAc3Q2X7bhwgS5ovocutoawDDlh38nXRoNZvmTJEJanjzu8s6EcV069IBCKktdeKhM8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790448188; c=relaxed/simple;
	bh=xsGuJk232I4PLTQmWUF7L02T34ag+5omrFDsR297W3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fWX8Ke3zQqOrzUlTGyzcDUo1dFyW4WqWX1cTSh5nvFd8aBKmUDo8cZLKpvNfV5P+XjbnNeI17yVqiCjMTZps6U9vEC0yrgBBFiLgB3VQ6HcEvDILS1nDwXT6gvfNZPsBacv0sCiqOKRQXlO8oHE+e8y0p6RG1P9v1myfC1kbLlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JOdraxMQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JOdraxMQ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68QH6ptI3178453;
	Sat, 26 Sep 2026 18:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=5NWAaCwDcHhIw1u+lP8Elc0CPonTbbi0EH2sp3ZDw
	v8=; b=JOdraxMQfCw6O5nhANanq2KcsYdLDVbjNbD3pW5MZAjU9ZEisTxr59Cj9
	1qbwMrTigOdf6AJTWh+i62jFcM7b7AQOoCbbX5aI/HA2eQmux57ztqwhQfUoFWKu
	gfXjtwDHmk1ugIvHzITie9MXSR1MhLG/j1arAxroAwnstuI3BJdrBzoEa6nmIXWV
	G9DeDaMrhdvsRPiMv3ZRhW9GxLoArv4xMESmp1jhPIzXMlIARhdkoqctHkCqRGXf
	cE3AQd+HWrxkwQeL9/AENsJyWRRtSeTl1c9PujOvB14LGN53S79nhHav8mZTpi6M
	e86sEPvWg79+4DPm++XR7Hh+iEaZA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fdtey0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 26 Sep 2026 18:42:57 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68QH2Zrd1541370;
	Sat, 26 Sep 2026 18:42:56 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbu9730u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 26 Sep 2026 18:42:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68QIgqkW37814682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Sep 2026 18:42:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 120CC20040;
	Sat, 26 Sep 2026 18:42:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE50920043;
	Sat, 26 Sep 2026 18:42:47 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.84.252])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 26 Sep 2026 18:42:47 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, stefanb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        nayna@linux.ibm.com, rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v3] keys/trusted/tpm2: Validate TPM2_Create object sizes separately
Date: Sun, 27 Sep 2026 00:12:03 +0530
Message-ID: <20260926184203.479203-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6ab81231 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=70sryTsWxkqKhW1QF0gA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3NCBTYWx0ZWRfX6ms4ER1n89SF
 v5ScGXfhmUPBtnZVn7KNaLJsT9s68Huso7yXUvV1Ofg53TOR1JkJhC/qBipYrV/2k0Mi/PePA4M
 QlBSWpSJMWQfnJLkR1gZVAraRxrjExw=
X-Proofpoint-ORIG-GUID: nTdd4-vL3TZhM0jIA4rjZRaRNcD007tn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3NCBTYWx0ZWRfX2KowHOEgSA2O
 LSCnrc3hHUR0OVkJ85Ju2qaJRBhl/6jdLkO5ZkX6f8ScLS91RzEMmv5VRAP2XjEZD/cekDr5/MI
 5STEWF02USQm9vlWfM2Nku4e+28Zimg27SlWlI4RYTVaiCpWBJyqB4IFyxABjHsNbm3Lq3MUM5F
 vJ+emynSGR8CqPyKwc1SP4v1ihikbbABB5FjPV6K3VoAWznz2qGXtdNTIGSHY3+i/53znWG0BEV
 QOADBAr0kn2hqjxMDN2o6qSkwOfGETTJLRM4lAeVUSSA6nrD6982AttHc72Ej8KGEqfw0bybOhF
 qx7pFSTe6lBiA6rmz5hUDUw4imdJHW7KxG1WpIwFfm6KaAmDvYJ0ZEDjB2WWhJAwbpAaBee6QxL
 lMpHQHY+RbbmknVwvn9wgEWqdy4W3nbMdLGkw2JY8fijYAYpnf3zNMzyV4gbB74C+376YZbnkpc
 6/w6tMTY8PyUjTbz1Mw==
X-Proofpoint-GUID: nTdd4-vL3TZhM0jIA4rjZRaRNcD007tn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609260074

TPM2_Create returns outPrivate, outPublic, creationData, creationHash and
creationTicket in its response parameter area. However, only outPrivate and
outPublic are included in the trusted key blob. The size of the blob is
therefore not determined by the size of the complete response parameter
area.

tpm2_seal_trusted() currently compares the size of the complete response
parameter area against MAX_BLOB_SIZE. This can reject a valid response
when the remaining response outputs cause the entire response parameter
area to exceed MAX_BLOB_SIZE, even though the outPrivate and outPublic
TPM2B structures consumed by tpm2_key_encode() remain small enough to be
encoded in the key blob.

This is observed when creating larger trusted keys using the swtpm TPM 2.0
emulator backed by libtpms.

For example, requesting a 113-byte key succeeds, 114 fails.

~$ keyctl add trusted trusted_key1 "new 113 keyhandle=0x81000001" @u
520504613
~$ keyctl add trusted trusted_key2 "new 114 keyhandle=0x81000001" @u
add_key: Argument list too long
~$

Remove the MAX_BLOB_SIZE check on the complete response parameter area.
Instead, use the response length passed to tpm2_key_encode() to validate
that the outPrivate and outPublic TPM2B structures are fully contained
in the response before accessing them.

Previously, a response parameter area larger than MAX_BLOB_SIZE was
rejected with -E2BIG before ASN.1 encoding. With this change, if the
resulting encoded blob does not fit in payload->blob, the error returned by
asn1_encode_sequence() is propagated instead.

Also, use scope-based cleanup to simplify resource management.

Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
Changelog:

 v3:
  - Simplify the TPM2B_PRIVATE and TPM2B_PUBLIC bounds checks
  - Use appropriate error codes for failure returns
  - Use scope-based cleanup to simplify resource management

 v2:
  - Exclude a comment pointed out by Jarkko

 security/keys/trusted-keys/trusted_tpm2.c | 42 +++++++++++++----------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 906700c3d7f0..920f45c7864b 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -25,24 +25,36 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 {
 	struct trusted_key_tpm *private = options->private;
 	const int SCRATCH_SIZE = PAGE_SIZE;
-	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
-	u8 *work = scratch, *work1;
-	u8 *end_work = scratch + SCRATCH_SIZE;
+	u8 *scratch __free(kfree) = NULL;
+	u8 *work, *work1;
+	u8 *end_work;
 	u8 *priv, *pub;
-	u16 priv_len, pub_len;
+	u32 priv_len, pub_len;
 	int ret;
 
+	if (len < 4)
+		return -EINVAL;
+
 	priv_len = get_unaligned_be16(src) + 2;
-	priv = src;
+	if (priv_len + 2 > len)
+		return -EIO;
 
+	priv = src;
 	src += priv_len;
 
 	pub_len = get_unaligned_be16(src) + 2;
+	if (pub_len + priv_len > len)
+		return -EIO;
+
 	pub = src;
 
+	scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
 	if (!scratch)
 		return -ENOMEM;
 
+	work = scratch;
+	end_work = scratch + SCRATCH_SIZE;
+
 	work = asn1_encode_oid(work, end_work, tpm2key_oid,
 			       asn1_oid_len(tpm2key_oid));
 
@@ -50,10 +62,9 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 		unsigned char bool[3], *w = bool;
 		/* tag 0 is emptyAuth */
 		w = asn1_encode_boolean(w, w + sizeof(bool), true);
-		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode")) {
-			ret = PTR_ERR(w);
-			goto err;
-		}
+		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
+			return PTR_ERR(w);
+
 		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
 	}
 
@@ -65,8 +76,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	 */
 	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
 		 "BUG: scratch buffer is too small")) {
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	work = asn1_encode_integer(work, end_work, private->keyhandle);
@@ -79,15 +89,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	if (IS_ERR(work1)) {
 		ret = PTR_ERR(work1);
 		pr_err("BUG: ASN.1 encoder failed with %d\n", ret);
-		goto err;
+		return ret;
 	}
 
-	kfree(scratch);
 	return work1 - payload->blob;
-
-err:
-	kfree(scratch);
-	return ret;
 }
 
 struct tpm2_key_context {
@@ -340,10 +345,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 
 	blob_len = tpm_buf_read_u32(buf, &offset);
-	if (blob_len > MAX_BLOB_SIZE || buf->flags & TPM_BUF_INVALID) {
+	if (buf->flags & TPM_BUF_INVALID) {
 		rc = -E2BIG;
 		goto out;
 	}
+
 	if (buf->length - offset < blob_len) {
 		rc = -EFAULT;
 		goto out;
-- 
2.53.0

