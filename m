Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1869361976;
	Sat, 12 Sep 2026 06:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789194623; cv=none; b=SQvDZjKwueMjaLAY3jFudMdYbDIMJgScAaFtlbHoLLOvGgtgQF35J8Gl1ISD/eaFFhzGniIdxQorY12DCLlGoy24+z07SO/Xpcapl3RgwTcCQZCUE1QQna6ndUts9y+LFWsEtahMaFjynpO8xFtTpNwSqky68ohpGqXDaGmr70w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789194623; c=relaxed/simple;
	bh=BqnohiexbvkuaF6dfRHf74C64B1HfRgNqyF/dcygJac=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WQG0U+vlgU6/HofJC5veh5ucMjor6YhT9emMrq9DOZZOl4x9xKa4RRG9lheZnzMXcJ7mxKpaKAyb2qC66XXPHO+Pig1zaBrCLa6DmJMsonyhOoDBM9BnZBzi++XD8lSH9MmYEUshzT/nd3zxpU1XI4JH11QdcVFnZ93eodR07Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fhB/ab1P; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fhB/ab1P"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68C4XJVn1879596;
	Sat, 12 Sep 2026 06:30:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=i513bfpX8N4booJpGV08xSCNkRLi/2kmhpNrMYRcU
	8Q=; b=fhB/ab1PLglfeOw52+Ra5FYbnJy9XW+Zr7w1zh31u/YwlJZ/xrD2QWdty
	AZKMFypTppbn8Odg+G2MRc+vGj8XAcDLqPPWNwijSbOL/3wLz1hNMmg99TtM/JCd
	8qB0ohSLQa+HdLwBHigxDlv+pgkDkeEORN0LFsiY/8Vc/isL59/FTITOEwteBqw6
	QQlLyAsmePc4rHO/DesffXmJgpMc5c0cppgXa8Wvfc2rO5r+biSTdPcROI34Z9KR
	8ZHrwT5Y9xQNgwIaABja0Y+K3velaJQp1YXRcGEaFU1xUPFv2ulcsGCdgzVrD00A
	YuMgMGWIiLRWGF9H9cqW9Ewc2cURw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdprg22-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 12 Sep 2026 06:30:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68C4Z8O42798858;
	Sat, 12 Sep 2026 06:30:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvq328fv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Sep 2026 06:30:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68C6U8h347317350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 12 Sep 2026 06:30:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9FC12004B;
	Sat, 12 Sep 2026 06:30:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27E1B20043;
	Sat, 12 Sep 2026 06:30:02 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.123.78])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 12 Sep 2026 06:30:01 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, stefanb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        nayna@linux.ibm.com, rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v9 0/2] Move TPM-specific fields out of trusted_key_options
Date: Sat, 12 Sep 2026 11:59:48 +0530
Message-ID: <20260912062950.279104-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEyMDA4NCBTYWx0ZWRfX8GZ5z+k2MBTf
 ULGl2wUI8t1kLw2hNqwfP0NAkueUUzpVloEsr2utJo4Isqkl8gBqGi1K5VlC9O4lo9WZew6m3ew
 hCJdqMECQ/gc9ofnLvF6Q2BqFX40avHaIp+1X22LxVhnpby/5Z2qQMSdG+oTplYyNinIIntoR8X
 V4QeawDBR4Zjm1Z8bY+R+yAVQ4oUkK2WfPUw/iQGyxrzUEtaZxOh71nTFnNrB/Gx94luVSYsN9t
 z4d3ejifnlbEWSHqgjoYzeG2Q+zLYJH+nHLCvRE+tLQ8UX+kRpYu0FAxMonDmj9P/bf64MOFo8W
 eDwO1sTlgd9zehEVvJUJyGcfyYZPebjVY0PfSk7fXRoB2JOnxLl00poTfqyXgqjarVQdQKCNaPK
 Y0Mp3MAdKS53Bhrcj/9tAQz1Low9jNclJc22QIusd4bdNcKfPuFimSUSA1D9y3IFW1uRXMedRXd
 QnOoWzzrozMLLrmwItQ==
X-Proofpoint-GUID: KpGBOb3h0ghS1Y7JojUM7WCJw9mfyAN3
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aa4f174 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=lNJA1Ii_B3Svs__94W4A:9
X-Proofpoint-ORIG-GUID: KpGBOb3h0ghS1Y7JojUM7WCJw9mfyAN3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEyMDA4NCBTYWx0ZWRfX2qBGjf5LCEpW
 t9V6iqxmRwxy/hjk1Q4FxJKE7j+s9KJWVq9lufJEagoDj+gJ8ja1FKwKf2bhzQ/ojDXIVTw+nd8
 qU2ampLc/xu/oRwQvHmmBzqFeDwY8t0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-12_02,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609120084

struct trusted_key_options contains fields that are specific to the TPM
trusted source, resulting in the accumulation backend-specific fields in
the generic options structure.

Move the TPM-specific fields into a new struct trusted_key_tpm and store a
pointer to it in the private member of struct trusted_key_options.

As a preparatory change, return immediately after a TPM unseal failure to
prevent pcrlock() from overwriting the unseal error.

Changelog:

 v9:
  - Resent the full patch set with consistent v9 subject prefix
  - Corrected patch 1/2, which was sent as v3 in v8, which caused b4 to
    flag the series as incomplete

 v8:
  - Rebase onto commit
    adc6a9f6d997 ("KEYS: trusted: Fix tpm2_load_cmd() boundary check")
    to resolve the merge conflicts
  - Include Jarkko's Reviewed-by tag

 v7:
  - Fix a memory leak in the preparatory fix

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

