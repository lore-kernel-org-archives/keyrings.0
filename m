Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C35619067C;
	Thu, 10 Sep 2026 10:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789034567; cv=none; b=sgj0KivlK9ELm2c/CCd1whTG1hQA3cWYmb3lWLJAWps8rs+qZGEA6pXTCQ/v6hFluhD0L+3J3Bh4zfbi3UbIfSXxcudx19QHsBfNJWTnhDjnplxJHJrYxC6twjKqztTHb0EvtiT10BH7Js4BkSwE3Hr4sv7l+z/8/WcLCz4H7Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789034567; c=relaxed/simple;
	bh=DDfaf6hOW2Rl83gQzqeRWx28zRRb3DAHa1A2uePKIlo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VprtSVCvTKIq5enyTIG7QjgG3eHetiLDV5k0RsJJXcPCn2kNmTZ2gGRh3LOUsGltwMZcX6R/jXPqGQrNkP3uzVzOqHr+sK5E/4jqZH5n3vVshn64L0BrzUPZBEPU5HwlNve13EHNonlg+/jBzPcCt96LgDKpPQNxc/8b84BlG9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=czOWLV2v; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="czOWLV2v"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A91eNb2313761;
	Thu, 10 Sep 2026 10:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=59CCezJVCLokFqKTPVrNA/f/TZyMDjaI6QeJdHscc
	Es=; b=czOWLV2vTqusBqPHi267HY1NnOa/gFOxsZlWfVKpDMudGsECIBjA6Si0Y
	VFE7if83p4KiYnxwbUt4w+oLcmbaAw1NHcxTAVyrNhkBu6vyzVj1+vdBz9UdYy1z
	dCBcuscu7hjlNnsodmjxGx3Z7gRueSPUm18w6P6yemYrJBed+ZcqPJw0jeus9koQ
	90jy+xRUlynhXV/u1WeRdbohZ4FYS4gVvTgpaVK1T+eDvVaJtuNJwdkJ4XV+Z15b
	UMygY/6WRqB9f0qeK+0mh6voIr8R6QJdXSCZ8NHEyN4rU8psUvONynL/Pdd03qFN
	NMR5dtcxbfKKDwbmMxJMmu9LYHfQA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8s3rpf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 10:02:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 68A9ueJ3008828;
	Thu, 10 Sep 2026 10:02:41 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gkcr3br6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 10:02:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68AA2bZi46203198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 10:02:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CCE02004D;
	Thu, 10 Sep 2026 10:02:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53D2220040;
	Thu, 10 Sep 2026 10:02:34 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.bl1-in.ibm.com (unknown [9.123.14.23])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Sep 2026 10:02:34 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, stefanb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        nayna@linux.ibm.com, rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v2] keys/trusted/tpm2: Validate TPM2_Create object sizes separately
Date: Thu, 10 Sep 2026 15:32:22 +0530
Message-ID: <20260910100222.247529-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w4_yC2HgGYrTPnXJnbtA5bgWntGAvE_D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDExNSBTYWx0ZWRfX5N+q8NWvEsz7
 uHxE/MM404MLN4ic955yHRraThjxequE2BRoKSTxflVewlsmf3CWmGHzeTbINzbIILBp3Vqh6Q7
 SltVaYAgi8+woAHKtTioO97ptteZtgwwkp+sDAF+Xwl0O2Oou/Jnw6cp8gqL1epkckLJxqw+ObE
 wfZFWFhWPY4Z0J1H5oGrFeeaYgUrQb4US5KU3KVdW/xYw2PzZQBRsdsEa9QJhORpRMIXSzLYP0S
 ii1Q3q38BNbqxiZ/Gav2SOZ2iDKNFN3nywEy/yOp/K94CZREt5/gxxbdLnPXQS1TnHGPFya+scI
 5vFc6GG9Gsxa5sBP8h8tcw6iExOYunTjCkotw0bry7cE9gHbXTBq97nQlNHrI+qVKgy9Sfd79Zx
 jvL5ofej9fIART+tEJu36C1hsjBuGwtECg+hD94Q0ykXWABw3x0KWfTFNSMaVaHJuw2u3BA3rYk
 V7eMRiYtYLvlBTjWChA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDExNSBTYWx0ZWRfX+2fo60+siTXU
 XnDIqNliPhJKINkwQ4fJvAVWjBQ1fdldSdEm1NkoUrAsaxiefjTpL9tfrb7aKfXe0zOWXpQX7os
 H/E3yg1GWxqCNDybutXWQNzoHToXIXE=
X-Authority-Analysis: v=2.4 cv=MpXHeGae c=1 sm=1 tr=0 ts=6aa28041 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=aqo0NMv67lMbywGzRV0A:9
X-Proofpoint-GUID: w4_yC2HgGYrTPnXJnbtA5bgWntGAvE_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100115

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
Changelog:

 v2:
  - Exclude a comment pointed out by Jarkko

 security/keys/trusted-keys/trusted_tpm2.c | 35 +++++++++++++++++------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 01f18bb37047..cbec4f591952 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -24,24 +24,42 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
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
 
@@ -336,10 +354,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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

