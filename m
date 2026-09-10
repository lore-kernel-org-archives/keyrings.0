Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4A73E0258;
	Thu, 10 Sep 2026 07:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789026803; cv=none; b=TV0iBMeOymlc7t5o5FnSMh12T6sTypNFDEeGCW6Mne0OqfPhGo+KE/3+QomrvkTRWKDK+v6a2aXtOerZg+y0PxzfzswOYr2VL8bg3T04NyMkXP6ayc4t1nQLjQRqy6mYqpaql3TvQouqZleqrZhlpyaXewp6vyPeCW+pKInzzZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789026803; c=relaxed/simple;
	bh=gCjit6e7mvrERMH3YqOPzvrZKkDB3kXoPRr/joGHDF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h95GRbvSln9/SuG+HnUksaFkZ4IyADoZZZYLhKQ8928sp78XdiMfbq/egMnNBQo4q80wyS6j1H0lsmtihlMBgbE1D/9Fgt/Se6+4Scu4ExQwxk83GDwgHMuEDgV2aKyzWSJv2Hbuzx4P5UhggwjvBcTfp0JCWoXBSEW39+0dpSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M423Ix7P; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M423Ix7P"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5VSlp1996981;
	Thu, 10 Sep 2026 07:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=n4PZzZS4RONuLGcq47dTtbLBypkowFvL15Vdqf8rD
	6A=; b=M423Ix7PuoRrNXyg91LJrSqeaJYSS89ftz8DG1JmfSztsBTWcEm30qm6G
	4wbtwNny3JsmiGzwK7K6hdSX5bh5DaS2rg/VPTl7CDi8up8JCoZXbrRCl5TynHbp
	XiUj2sONKwiwB1yDt6/2/EigEVz8HsvcCQn7O7WasYh19yEdtAS/ou4O7Ul1Qr+n
	HoyyIQ6avpT7pZ/dmv/szCVMv8xTtmBaZPxU1O93FrIb9BR4UR4rsqnfwJn/V8vT
	R8Y7Gh7vLsgQmz16DLVXi6KRoWAZbjLXX4juVxTtoo/Ssmj78j1T99caziq99fex
	B9ggtTTI7252bWdSe6/9RhlL7IVIQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8qk4ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 07:53:14 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 68A7fQgT016952;
	Thu, 10 Sep 2026 07:53:13 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkcr3368p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 07:53:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68A7r94C31588836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 07:53:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C24F72004D;
	Thu, 10 Sep 2026 07:53:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6143820049;
	Thu, 10 Sep 2026 07:53:07 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.bl1-in.ibm.com (unknown [9.123.14.23])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Sep 2026 07:53:07 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, stefanb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        nayna@linux.ibm.com, rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v8 0/2] Move TPM-specific fields out of trusted_key_options
Date: Thu, 10 Sep 2026 13:22:30 +0530
Message-ID: <20260910075232.178855-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SpUFe/O0 c=1 sm=1 tr=0 ts=6aa261ea cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=lNJA1Ii_B3Svs__94W4A:9
X-Proofpoint-ORIG-GUID: 4_52HKeZMavGlAOtoFcUtvstan-QzZaQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4MSBTYWx0ZWRfXxcg2j/S15Gzu
 oxfuPFcBKO+D0BnkEPg+j8wsbW1BaP7cM5GFg7PrakKHvINMTBCqzfidtvYg1/gWnk+4Zjv6UJn
 zxMI/8FnWDUzjF0y6tOvHOE+ays14m1O+ihHlVmJ5gVI19ThgiFHNQqIX+5Y5VOBwKR7rWEVUeX
 0OBxQtfa9BpVZMK79PRXoMwevm5IBqVigOhQnhy7+1ynHCJrMpe4i0n90JbU3Ny6XZciH1Ua5oM
 qE9SOXdWv+UDaESZHnAoPpoXV9QUyNJYqexMXiLfJqpTCJ63mRBxq3En9Q36AMieVYZwM764G2D
 WFPcmzK+8WYs9Il3tRfg5IMBrADwVfbgfaCDx0b2X9CTnAsHmW/4kSfXIdqn1b3GNtZUItovfZP
 MhsD1DQiOu6GFbogiKyVBYEZE/FlCrSX7wu0HEsXwud3EdzA11P1MtWgxHrXlS5NO4nNQcauYj0
 D9GFFfHpzGFnnfnk2Ow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4MSBTYWx0ZWRfX4xoCj47Iou9c
 dVfj4WlFTn81fL5RX81MqVRp2Xg90/5RAyiJVdrbqriKEa3eZDYDTXPoctX3nCOf0FRdwWFlSB5
 bnrKWFnpc380r+ST/HiRQPXfygkibsI=
X-Proofpoint-GUID: 4_52HKeZMavGlAOtoFcUtvstan-QzZaQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100081

struct trusted_key_options contains fields that are specific to the TPM
trusted source, resulting in the accumulation backend-specific fields in
the generic options structure.

Move the TPM-specific fields into a new struct trusted_key_tpm and store a
pointer to it in the private member of struct trusted_key_options.

As a preparatory change, return immediately after a TPM unseal failure to
prevent pcrlock() from overwriting the unseal error.

Changelog:

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

