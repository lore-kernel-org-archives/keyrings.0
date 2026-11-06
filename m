Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986333;
	b=RSZYYwiF1LWhcF5qnKtnSqZFns8FxhcozJ5uqh6sOfLiX15JeirQAqQofGFV9buhuXN6
	 K6Yj+aZzyDSbZ4iv4dkLUXxO8LHXJpI0vXZlvvzdJ+LcGoPcALpeizoybipbWoTItkslM
	 rPmKzu76EP5OH59UfDiWcOfsbzd0QvJVOQPLidFCmVM0q8Lzy/2PbYVzz/Th/S9ZoFq+3
	 CCUkQ6WmXu3yjgKaURKvMq7cdKyhPAgX4HriQ/8q7zl32PN/Fg2uvamSZiaJTbMHHSEae
	 CFZDE5GByImRUxcd3H18umeLRkiM+kJkLZXL5gxROHhQLEPoTD6W/AOXo8c+rCcWKOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986333;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=0gdqHym3akFKLre06jtI7PzOfjrwM4XU3jpMtUW/72c=;
	b=J20z9GQTkOckg7l/awr6w1kXCfFwsSSwEBlI2Gl2WdwUqMdx4Kw4q+jQLtGXhIACoE03
	 y4+2uJJDktv+qxkr15XEp7YfVIXw8sBhP70XMIN1Sp1iXAAKaS2Zw/5H7xBRQzde3Py22
	 QQe8H/6z4LPjthqeZjeWBoT3FTUtlXA/tvAe36L/Mkk16avAAr/dNxnW0kv6Iiwst+VyE
	 ans/gUb24LT58XfFX2T4AMv00hv5q7tMnCZSHJqJe3CAyW1CvLQzhtammnnbS552qxyDu
	 Ll3Hu5robIAVL62Z3frgVRM3M1vllENGFOPjT2enwri1aCy3dRUepT/sKCDKu2JV3UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qxB18Hc+;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D5D606A329;
	Fri,  6 Nov 2026 17:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85D5D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qxB18Hc+
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FE5TO1094483;
	Fri, 6 Nov 2026 17:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=0gdqHym3akFKLre06jtI7PzOfjrwM4XU3jpMtUW/7
	2c=; b=qxB18Hc+YZsduxuxaXEH5rMDVQATueWlJjuA6bebI9R+OYMkafWdmMn59
	r5vBqgDEILLdBFHOpJBKNdyfjopHcROQw/Bih3PtKJ9kJRCXlieFD3t+hlIFkRbM
	u7WoPLWgaKNO3zTYGEIAXwYfl4U+VGhENLBYHEL3AxJf2peKrnyqxjU/ZfxZNSII
	chiuGS2zMQJt8OEQvWe3bBMSV7slCQJ1XkgPOXhIVcsqmjLV7YCBWfM8anPoBb8A
	x7YeQjPVDTyxPh62GK4M7SjoVbxRiVk5SLYC2ScipwXSFG/jGQZmtf5W4RG4Rlxk
	+SA89wqLSbzVPiLgQO7FVbGKwko/w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3raxem6-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 17:31:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6GxrSL3584920;
	Fri, 6 Nov 2026 17:31:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka72xkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 17:31:57 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6HVtJR44499384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 17:31:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 636AF2004B;
	Fri,  6 Nov 2026 17:31:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FA9120043;
	Fri,  6 Nov 2026 17:31:53 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.47.32])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 17:31:53 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] ima: use the system blacklist in lieu of the IMA blacklist keyring
Date: Fri,  6 Nov 2026 12:31:46 -0500
Message-ID: <20261106173149.707244-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QYDzLcbv c=1 sm=1 tr=0 ts=6aee0f0e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=E4YdAB1t0zyyqKEc0TgA:9
X-Proofpoint-GUID: PssQDz4LAqtCFmu0Sr5ARqd2cBVsAzTk
X-Proofpoint-ORIG-GUID: PssQDz4LAqtCFmu0Sr5ARqd2cBVsAzTk
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfXxogpmN3O7sPT
 fd1zF2yum2jWtme54jIqjRu532AP+UnUVuPWmUvJDPwFy5IVxOou2LN9tSYTsvddFSkruIQDcVt
 Gz+zCaKcBfd/6nvlWWkWRRbvjuzofZU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX0WeiywnDLaRE
 tFe/vV0X0kQgKGfooJjBe4S+nDYJ1L0O3HGZ/LpIOAyTc7rwA8kSgur32U9Njy5tAazETWe08CL
 fUM5zkwmJsjvUtaLIDXy+HgpraJnv1/d9yUIZxi/uZRGs73WA2vk38x28m6aRKJlVrCODyfMhcc
 uS3jGtNxcq44yLB8W5HqqNPUygU/KSkp9/YMMCfcYOZLzMvWevw+Ukm8O38T5sHcyYgyu9V4EDG
 JoJML0bEEtJuqScj6ztAsOqn0Q0wqmojrAjGX4ncvOuM2GZsfU4cgxyFMZuh4aVsOAtULqAP2d/
 lSxZDAdULkkCbE+olxbtuFmZMn+PP7sJ6CunwSd2RCyl828TBhEIQS5UgThpmWluZfiv0SVRenZ
 wPuGNrm1bUCV4p6WFH6FTF2o8kSGO84uBwV2x3p+lh6jfsDgMxnDWIoPA6Gjc3yY9/VeBLEPYCt
 CATgBaCP7KPViMf13Xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060068

The experimental IMA blacklist keyring accepts any certificate signed by
a key on the builtin trusted keyring.  The certificate being revoked was
created by such a key, so root can add it to the blacklist.  Nothing
differentiates the authority to sign from the authority to revoke.

The system blacklist already supports signed updates
(CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE), but cannot revoke a key that is
already loaded on a keyring.

This series defines "skid:<hex>" entries and adds is_key_blacklisted()
to the system blacklist, has IMA's asymmetric_verify() call it on the
key it finds, and removes the IMA blacklist keyring.

 1/3 certs: blacklist: define skid: entries and add is_key_blacklisted()
 2/3 integrity: use is_key_blacklisted() in asymmetric_verify()
 3/3 ima: remove the experimental IMA blacklist keyring

Revocations for keys on the IMA keyring are now "skid:<hex>" entries in
the system blacklist.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Mimi Zohar (3):
  certs: blacklist: define skid: entries and add is_key_blacklisted()
  integrity: use is_key_blacklisted() in asymmetric_verify()
  ima: remove the experimental IMA blacklist keyring

 certs/blacklist.c                      | 83 ++++++++++++++++++--------
 include/keys/system_keyring.h          | 26 ++++----
 security/integrity/digsig_asymmetric.c | 25 ++++----
 security/integrity/ima/Kconfig         | 13 +---
 security/integrity/ima/Makefile        |  1 -
 security/integrity/ima/ima_mok.c       | 49 ---------------
 6 files changed, 84 insertions(+), 113 deletions(-)
 delete mode 100644 security/integrity/ima/ima_mok.c

--
2.56.0

