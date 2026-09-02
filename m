Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7AA372EF3;
	Wed,  2 Sep 2026 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788345093; cv=none; b=NH8qrsieq9lmIcBPNYb48vKtwWneG+Wv/s6cOoheb0iHEcoyyqDg3cW/DAZ31M2dxJp5FbswZBo35w2t7o5toONyJouK4Ol1M+TUQkPDFR8biRHTUyKJj4IeRRU6grVM/3PQTpqNsMNZUmR/+m//alV0gK+kedpT8XE5H5lcFPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788345093; c=relaxed/simple;
	bh=ZQPpTtjCF+tpIaDRehby+0XUM/E3xSwEP5nTbBzhFvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G3PghjbHE+hrGtCmIauJkhA6Djt0L6v6UOk7hXjbFcTe2S86zdyaydyktto1xk1jBa5f3lYjHZLp4GNVloKJczVNjmE3kJp6w9BzK9y/VAgBUUY57UugAA+RkxhN6jy3rwmKHt+qHQxYY7mQtGy+RQUQIserwPrJ1P9bgYmrmwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ba7ncZZZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ba7ncZZZ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6829Vgvm3694182;
	Wed, 2 Sep 2026 10:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=l7MEQHy/jGT9zEOmcLhUVNZtZV731geedEGuzsXfB
	HM=; b=Ba7ncZZZnKs4Qa0FTUkH4ZXq9hO6XEsZXyZX2vX0CMUXHMsogeBuMZkji
	cG6EdHkWCx+PhsaDN4zdQBPJa2q3cOlUawL5ngROvVTSX9TlA/0GbENcnz8BAdVA
	AXxEGpWLZNUQrMwbLQr1YMlwpXIjNXLstKcc7zWOuwDu3JM6dG6w8GnT+0Z0Oabv
	sUcv6Xo4aJ/O3lScnoTNwoWJNd/4kgK9mYUKaTb3u03bu1rF3uFFwfouz9zbqJXe
	HRdiLA/yKRER7z1UFDwB0OGnb2bJdZAphosxidEYAbAaeG+MCDiT9nsesfXlpn/U
	rlK3/B1v4Uv/WXVNlqHG7afZegeeQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhwp1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 10:31:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682AQOsJ029968;
	Wed, 2 Sep 2026 10:31:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjahfdw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 10:31:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682AVNjX43188672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 10:31:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0B552005A;
	Wed,  2 Sep 2026 10:31:23 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78BA820040;
	Wed,  2 Sep 2026 10:31:21 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.bl1-in.ibm.com (unknown [9.123.14.23])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 10:31:21 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v6 0/2] Move TPM-specific fields out of trusted_key_options
Date: Wed,  2 Sep 2026 16:01:18 +0530
Message-ID: <20260902103120.222326-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: plITP7sjoaAWtiCHUIdxTesiJbPK8AeD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA5MyBTYWx0ZWRfXxjWq7M/8E1ll
 W54/Q+R9fs//V7swUruRpv6T6jSRUq5GftoG2Br6HeCWe2toDq5pKBr6ud/kdEIMk41d/QXYj1b
 5O0qiQrvTNROYt4ckK0SUxyKAxeFs97ZZa7toq/ApF+oDi0WG1P+ohpynkgaLj7PhXF4DMnZSOs
 fajdw6SZHZTtXDbIO63PePZKuLGEgDLgWw4YlW68NTU0y3x1RYqk0BffOAd9qcgswddTBwRbcXP
 NttS7W6je4tvjz36IFAi29SVUOXQtWqARzj7jBM6HCaFx4nKyxBfDHEcfiyeP0zJwrZQTVGnD+V
 c9colnmsw7IclDr99LIJ2cFSA6kSh3vst7ovBp88iBHFAIYL9weD1JH/83WJzQL1y/nP9GQuVr1
 9Tt1hCOGgd2mijWMBNMEQA3biLt8q1zUPYAUWnw10jEmnmvt4HbFfnBPAv/n0NwJWn1mFnbEs3g
 yyezVBvZ7/+EOSPbPwA==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a97fb00 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=wIrnhtCp3JY1rtXp-aMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA5MyBTYWx0ZWRfX8iTEXFZscKkR
 kIkKEkJMZngIAhms74H5lH/fNyihQwT5HSi4U25Hrgq5+OqGnfE6YEns0UEHJxh7UtIfUUHResR
 hmGtNv2U5wIazgl8MDM4Mg0JaYQp2f4=
X-Proofpoint-ORIG-GUID: plITP7sjoaAWtiCHUIdxTesiJbPK8AeD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020093

struct trusted_key_options contains fields that are specific to the TPM
trusted source, resulting in the accumulation backend-specific fields in
the generic options structure.

Move the TPM-specific fields into a new struct trusted_key_tpm and store a
pointer to it in the private member of struct trusted_key_options.

As a preparatory change, return immediately after a TPM unseal failure to
prevent pcrlock() from overwriting the unseal error.

Changelog:

 v6:
 - Add a preparatory fix to return immediately after a TPM unseal failure
 - Replace explicit cleanup with __free(kfree_sensitive) in the TPM seal
   and unseal paths, as suggested by Jarkko

 v5:
  - Rename struct trusted_tpm_options to struct trusted_key_tpm, as
    suggestedby Jarkko.

 v4:
  - Rebased onto mainline after tpm-buf memory-safe allocation changes were
    merged
  - Resolved the resulting merge conflicts

 v3:
  - Exclude the preparatory clean up patch as the problem has been
    addressed in commit
    9ec4175a30eb ("KEYS: trusted: Debugging as a feature")

 v2:
  - Exclude the bug-fix patch as it has already been applied to 6.19-rc7
  - Rename instances of trusted_tpm_options from tpm_opts to private
  - Use pr_debug and KERN_DEBUG for logging debug messages (preparatory
    clean up patch)
  - Address other minor comments from Jarkko

Srish Srinivasan (2):
  keys/trusted_keys: return immediately after TPM unseal failure
  keys/trusted_keys: move TPM-specific fields into struct
    trusted_key_tpm

 include/keys/trusted-type.h               |  11 --
 include/keys/trusted_tpm.h                |  14 +++
 security/keys/trusted-keys/trusted_tpm1.c | 125 ++++++++++++----------
 security/keys/trusted-keys/trusted_tpm2.c |  50 +++++----
 4 files changed, 113 insertions(+), 87 deletions(-)

-- 
2.53.0

