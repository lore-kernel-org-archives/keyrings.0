Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951F346A604;
	Wed,  2 Sep 2026 23:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390266; cv=none; b=rmd9Sucl6XwWXc05HYyPBY5rZbNjiFOH3SxuZggLbQCA1dM/lBZkg1MV3mNCIhiLXgCot0gzIOPr2vKixQwTPVtlsSB4JLKPa2UWnEQBlOCgExc0sGCKlyvuSjPr3jNsVCiGOd+b4qcd2vID7L2rdIe+/H/ycLjp0+owBgTiZRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390266; c=relaxed/simple;
	bh=e2Z+apjWEmMw2ubmt73aGpdZr6SJ2kTBy4nYcMsyZVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQTs6lX3zduCCzcvgVctSdD0vbSALmcHcxV16hbq45vHyjY42efJpwDKJSmfsoH41v98yrxAClEOz03mSxVvCE9r0RiiUmJSOMj2SVUuZCZMgI03UEfWqSSt/NnvdkJZbtGYyDPXK5GrDAf14ZUSvgR+gbMYITjSeWQ4Zb9yp8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tHxay1bw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tHxay1bw"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KW3rQ932644;
	Wed, 2 Sep 2026 23:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ov5wT82R+0E0lKWkWgat0qs0fUOSo2U6ovfBpLbFv
	mU=; b=tHxay1bwtJkIsV22cpj2GLpqwjzfcXtZDUCqiHMokaUoarrk24uLltJv4
	f9m3+Zmd1ad6iE3F2BRcQxtzNx7/AviVWUs9auAglineziG+wHO4/UvgJS83Egr9
	T7IJ4QRUGLZQQmbWzvqdROvFCy7WxPuP1dTTxSYhMCyS2g0MPJOQB1imu1lhkq6M
	2gpjnJkEk6j0PCg029Ao8nfipZCDiI4028nmPBTqMMwArGbdvAzG+Rr42VQOQBp6
	v9x8cJgOq91a7R6ISNeUL9/9qF6Qxb1ahIIXDg4AbBcMRBrbnRYmD+DVleMgOEAM
	fRDchODjDfPmFRa1TsGNWOLXSzM4g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuj1tsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 23:04:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682MuHUB023785;
	Wed, 2 Sep 2026 23:04:18 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceycqge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 23:04:18 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682N4FBr45613560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 23:04:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 258D720043;
	Wed,  2 Sep 2026 23:04:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E906320040;
	Wed,  2 Sep 2026 23:04:10 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.98.186])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 23:04:10 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, stefanb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        nayna@linux.ibm.com, rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v7 0/2] Move TPM-specific fields out of trusted_key_options
Date: Thu,  3 Sep 2026 04:33:03 +0530
Message-ID: <20260902230305.118931-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k85tCxBAJvQlYRzUt-gDlCisgL-Xbkft
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDIwNCBTYWx0ZWRfX0BiKD6UDslxr
 2SeNP9jCXKIe/2fp/XKAjo/EU2cnVTHBUPgRaQ7MrV+c1Xos+Hj1R9/lhbeAAVyl7+q+1na3xjz
 uQtSrn0YJ4NREtdvBOqX9qu+PFe9pMS2SRcagPTMOdmSw9ALNTca88oomVs27ZYtfOCk0phP64N
 2bk3WNtTSiLrtkgrw4dvo7mqzRczSUSAR/z7OMp9fctKu1eVlNeSGjYLCZHFH+NKgFP4+Om5A0R
 2Q8vhgY8pGKwDfGB19M/QJ4ocRuhIe+s6wgdyYK1nbrnk8kPgcIo5u+/lzFfevFhByDvIlq9zCn
 hl/FNK2SlIuOgJnZfIxHXQq9NhzivQFvyM38d3aUeUxgKHKWlv7syzpEcdzvUf7IlhqV3BmHD+x
 s40q3CTB0ReuRL/GvreTu4XLfwJLlK8Lb3/5Z5uygqxVtEXH1ek6jzYfhcLl7fTeiev+/hP/+J6
 W/46o/ccvmRZmZP3hFQ==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a98ab73 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=wIrnhtCp3JY1rtXp-aMA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDIwNCBTYWx0ZWRfX1u7hZlln1g44
 b7XKDE87tmevPHXaiuHvPZUSrvDQ3VUkL62C7Fkz9CxwZMMVBIuV+tXkteqeQyjSN920mGHeO4N
 j5sMZTdm3BbNo62vKYsjhe7yBBBjQoY=
X-Proofpoint-ORIG-GUID: k85tCxBAJvQlYRzUt-gDlCisgL-Xbkft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020204

struct trusted_key_options contains fields that are specific to the TPM
trusted source, resulting in the accumulation backend-specific fields in
the generic options structure.

Move the TPM-specific fields into a new struct trusted_key_tpm and store a
pointer to it in the private member of struct trusted_key_options.

As a preparatory change, return immediately after a TPM unseal failure to
prevent pcrlock() from overwriting the unseal error.

Changelog:

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

