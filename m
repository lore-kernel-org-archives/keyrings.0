Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9860477E21;
	Wed,  2 Sep 2026 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788349437; cv=none; b=OPnF0eOI29sWxU1/7N4mVHLK0K4w89e3tvzgXmDX12xP1fgVomOUhw6OO5u9paxQKeDnn6l3sWkGmZncd1+R1QVIfhbgc0SJyzuOKNGziQRZT/oIvilYQ95rtPZ7IhI+iACWorwbDeedM5ZFWoyEcAX64dK/jC5m3lrw1ithbBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788349437; c=relaxed/simple;
	bh=ggKa7KIi21WU2uKOMS+p0bPnUnCubskpBwZvDZ/Q1xc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YmZQ4IW4T7Ynr7E2nqCmPpgf711CoxrXjte7SBJof5RBz953TrYV4hYIbcH4tbT34oSYNVupd/L4ZThvy1lGYyuMKdbrUXKkkpvQOVpCRHYnkFf+yuJ/Gjt/EkFcTlpX+jcLtK3FYmD5LXxNnp7E88dXcKgyG/fCy/PHi9glkao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BafiX/tf; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BafiX/tf"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6829VbQt3694126;
	Wed, 2 Sep 2026 11:43:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=BJrMRhmRwWTDTWuAzlgVProSEMH2U3ZCsw/nl0saE
	o4=; b=BafiX/tfZqnFRwrt697V9Eujq2MV1Y7IUJ2Vya6DkvJWAFt8oTjLMacbR
	oxYcWIHCSBjHo97HK0bp8T3fqiphlO/1eDHi3YBHfRDb61su3hzIkgPAE3TnKHqo
	Y01/SNjtvqBo7YCjeSZOAoINJW/cJOfWWY/TCxDYCWM9SEV0bTj8pcCOiWBrKUxb
	qMnQN1ssq7PqW4J4H/txzCS1aDppzfJoscLUFft0MNf9PVuP6tTAi8IFsyIngXzk
	xxIOC1c616SMuWQg9/rjTFJIZBJ/Tk/jRdv9aJ5k4otd5U6MYqRgVrR/6diV5tt1
	8JokiSgLByFu8d37QxKnUjk5XDV1w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhx13y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 11:43:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682BfMhI019060;
	Wed, 2 Sep 2026 11:43:48 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcark9dps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 11:43:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682BhiSq46072168
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 11:43:44 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4067E2004E;
	Wed,  2 Sep 2026 11:43:44 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD0842004B;
	Wed,  2 Sep 2026 11:43:41 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.bl1-in.ibm.com (unknown [9.123.14.23])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 11:43:41 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH] keys/trusted/tpm2: Validate TPM2_Create object sizes separately
Date: Wed,  2 Sep 2026 17:13:40 +0530
Message-ID: <20260902114340.268698-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HJVa7UfjiVPPT1e1wT2_mr01GN2buSJ4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDEwMiBTYWx0ZWRfXzeR40qRDoGJe
 djwYq7YHnEFNtJoPiGsDDWMtWxnZWdFWGWAAEun7g0UMt7kPIVMuFjefdsJ8xdDlt6ZmBa5gZn9
 9ManuMHDgjiT2ldfw26GqR+QypD7jmMnysLbVZ+fhpjOVZ+2rbOvMApSfc10EnskjtTfVkRwulu
 +YDHnFOPPGUu5OoGfYfxFzdjhWAXLHq9WCDr7XZDLt47Dko9d3Z5mm9vzAZImQnufDO2uKpvL1r
 PBAtX5FOwGzZX9EUdutnB2Rd0uc14VsaDnvHKfcT/XqmloACrT4oIfGvUs/ZZfFJk7PJTXq4v2b
 HlU/gCIR7DM42JelmzfX5XI+qLZcRmlilgIwxFeIUXgf4VMVSwiXv/U9l+uVBf6/JQd+lq8aY19
 nlWaoc/O0xN31EvKWS/pcAP0eZEde7WhgIb1SpIWKsU1cOEr/SNz8j76t9XvDCDoKE8lpy3oIGE
 DTBIDq5fG6eNJvMuH7g==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a980bf5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=f_b9kDos49BzVt9CYJgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDEwMiBTYWx0ZWRfX4kb4v573ZDk+
 3KCy/Pw9PDOB28muuB6pngVsZUpT4pnAxt2k2z2tvKPueWyBdJVyYzSH9wOammQt7EXqkeLTjxR
 4+pLMFyUEp/OsiMbciyE1O9sFoWwu58=
X-Proofpoint-ORIG-GUID: HJVa7UfjiVPPT1e1wT2_mr01GN2buSJ4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020102

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

This is observed when creating larger trusted keys using an swtpm TPM 2.0
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

Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 security/keys/trusted-keys/trusted_tpm2.c | 47 +++++++++++++++++++----
 1 file changed, 39 insertions(+), 8 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 67225dd562a9..efb016a6d4b8 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -24,24 +24,54 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 			   u8 *src, u32 len)
 {
 	const int SCRATCH_SIZE = PAGE_SIZE;
-	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
-	u8 *work = scratch, *work1;
-	u8 *end_work = scratch + SCRATCH_SIZE;
+	u8 *scratch;
+	u8 *work, *work1;
+	u8 *end_work;
 	u8 *priv, *pub;
-	u16 priv_len, pub_len;
+	u32 priv_len, pub_len;
 	int ret;
 
-	priv_len = get_unaligned_be16(src) + 2;
+	/*
+	 * TPM2_Create Response Parameters:
+	 *
+	 * outPrivate
+	 * outPublic
+	 * creationData
+	 * creationHash
+	 * creationTicket
+	 *
+	 * Validate outPrivate and outPublic against the response parameter
+	 * length before accessing them.
+	 */
+	if (len < sizeof(__be16))
+		return -EFAULT;
+
+	priv_len = get_unaligned_be16(src);
+	if (priv_len > len - sizeof(__be16))
+		return -EFAULT;
+
+	priv_len += sizeof(__be16);
 	priv = src;
 
+	if (len - priv_len < sizeof(__be16))
+		return -EFAULT;
+
 	src += priv_len;
 
-	pub_len = get_unaligned_be16(src) + 2;
+	pub_len = get_unaligned_be16(src);
+	if (pub_len > len - priv_len - sizeof(__be16))
+		return -EFAULT;
+
+	pub_len += sizeof(__be16);
 	pub = src;
 
+	scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
 	if (!scratch)
 		return -ENOMEM;
 
+	work = scratch;
+	end_work = scratch + SCRATCH_SIZE;
+
 	work = asn1_encode_oid(work, end_work, tpm2key_oid,
 			       asn1_oid_len(tpm2key_oid));
 
@@ -335,10 +365,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out;
 
 	blob_len = tpm_buf_read_u32(buf, &offset);
-	if (blob_len > MAX_BLOB_SIZE || buf->flags & TPM_BUF_INVALID) {
-		rc = -E2BIG;
+	if (buf->flags & TPM_BUF_INVALID) {
+		rc = -EFAULT;
 		goto out;
 	}
+
 	if (buf->length - offset < blob_len) {
 		rc = -EFAULT;
 		goto out;
-- 
2.53.0

