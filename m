Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17F424BBEE;
	Sat, 17 Oct 2026 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792223379; cv=none; b=e/UZvYPDRK+VRAcNNLgs8Wx5ITYnUOTdXVwXMWbRh8kRSkv7+LppNeF1oGoMQS2rfKL+5qo0+IryavcvxwJZoUbFf+NlHm6ndB8BPZ7/+Aanz5qBaMuXYkCjm3dV2p39EXTqXwIWtdOJf/SgnkmjWTHvbcvVJ/a7/Tqtl67fEy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792223379; c=relaxed/simple;
	bh=6cslxTpKE7DTbBqDVM3iRN3tpZ/3SnjQURFg7VcJZ7k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OgnfjFKYnjlAU4C8D4980DXJGl236cFSMR5n6die9yVXsxFU0HOiQzQ6pNlJLDbrnhd/sQ8+P+hu8R/UDwFc2OsOSe4IGhUIfZ1c3GGUYHI9eA55hRGKTbvsIeG3ar5Pkw7TTcqIVHU3EYzwJYVP6mUavRuOiRMKdAuKvvrDviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BnyR++cR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BnyR++cR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69H7EG0Q096800;
	Sat, 17 Oct 2026 07:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=YGtmJBwKncS1PAThUiWF9iq283hv0ltSY2UFhEGST
	Pw=; b=BnyR++cRw9tUnJHWX5DmTr2Os/iwMF1c4FW8yTIFEix1KdfrMhMSgX8Dz
	6TLqT4VnAeo4EZ6Ax+JU+9h+mHy0y2gAZzwTyGJMQYCpUWXUGe3Mtv0+6IjVWejT
	QRdSWxn/rqw3MpxLvbb3ZRKcC42B5jES46OQthhjuFho8o006Cg+Ut9sWkAcJqOy
	/NWLl2SozF9IMdm+V8uiOZQe1zgp0Y32mx1Q4EKpv5WmedDoFJSFocFu7IHB2x9F
	B1XMbcmsIAr5X3BP1z/c6IFntbj3JvwSPjZQkpOuQ9qvo5wCjAkw7Ghf1wf0kmOF
	jgVrc9vonz8ftB10kuMBopAHPOH8A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hc0pt8s5x-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 07:49:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69H6o5HW729247;
	Sat, 17 Oct 2026 07:49:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hb36wpuuk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 17 Oct 2026 07:49:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69H7n8kJ52953590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 17 Oct 2026 07:49:09 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DC59E20043;
	Sat, 17 Oct 2026 07:49:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFB9A20040;
	Sat, 17 Oct 2026 07:49:00 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com (unknown [9.67.66.83])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 17 Oct 2026 07:49:00 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v3 0/6] Extend PKWM to support user-created wrapping keys
Date: Sat, 17 Oct 2026 13:18:44 +0530
Message-ID: <20261017074850.164031-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAzMCBTYWx0ZWRfX8+mGcT6BvRW1
 zuJLWEiN9oB/KMyRIIf/n+acoPjcx46L8HxGkJXtbZbdiUeYQ/fhFz/rLlyIAJk3jwZOcrQUlg1
 v1mEX8VHZk7pFEIbYbpGv1wfWKQnM4N8/7eVbqzdWKl1EFTzznXT6DzLe+ssrbfmph9MORzG8gn
 HLsj4EZNzdxP4h/EbNMgsLwNk+buKXZ/s8OciMx2dv+ke/DDsyVMkzoyqMomMU4FH4c7JKkXnEk
 fUlaGmVHCcLBB2jjK0zTyKaqRE/jRb9Au8d+/IlDvXXVb7FeC0WiLmsFCZAVwK+N63ibccklIPQ
 1nrEK56MAVAp0ymP+S2nNcr/BkO0FY2M1NobYfzIe4YhAFXi/0mRqfmgi1yvuIHSVpR9ssiG8Jr
 470EyZDqR3sTCpSHi2d42MysXGH4yV5W4mmS4pEZT+gx61W50VyfCpYrnNTULYy5qos0Lfk9sh2
 frpyKitvd9ckmppzh9Q==
X-Authority-Analysis: v=2.4 cv=WNvqzXsR c=1 sm=1 tr=0 ts=6ad3287a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=UMd8ISttMeN8S66s6c4A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAzMCBTYWx0ZWRfX4yaf8oFa67a9
 h8EBVoi994u4nJjED2M0/cBs09OfjwYkFsuG+w/fgLNr5228tEkZTE9avjmVWtRrxFTYR59biYg
 Oi8cGVYFbn9vNsW61yBlIxp+qm9R2Dk=
X-Proofpoint-GUID: oyrami6cW6x-CayfwHU7c7pVvgygQcB9
X-Proofpoint-ORIG-GUID: tca4IdchuDNSe4N3CVqNcUUFkAcn0Skj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-17_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610170030

The PKWM trusted source currently uses a single default wrapping key per
LPAR. This key is created during trusted source initialization, and all
trusted keys backed by PKWM are sealed and unsealed using it.

Recent versions of PKWM allow users to create and manage their own wrapping
keys through a set of lifecycle operations. This patch series brings these
PKWM capabilities into the kernel, allowing users to create, manage, and
select wrapping keys for sealing and unsealing their trusted keys, rather
than requiring all trusted keys to use the default wrapping key.

This series extends PKWM to support user-created wrapping keys. It adds
the required hcalls, allows users to select a wrapping key by label when
creating PKWM-backed trusted keys, and introduces a sysfs interface for
managing wrapping keys from userspace.

This patchset also includes three fixes: one aligning the PLPKS wrapping
length types with the underlying hcall interfaces, another preserving the
original error returned when default wrapping key generation fails, and a
third clearing sensitive PKWM seal and unseal buffers before freeing them.

This series depends on the following PLPKS refactoring and hardening series
and must be applied on top of it:

https://lore.kernel.org/all/20260923182816.151451-1-ssrish@linux.ibm.com/

Changelog:

v2 -> v3:
- Moved most of the refactoring and hardening patches into a separate
  series:
  https://lore.kernel.org/all/20260923182816.151451-1-ssrish@linux.ibm.com/
- Added a fix to clear sensitive PKWM seal and unseal buffers before
  freeing them
- Retained Nageswara's Tested-by tag
- Refined error handling and documented default wrapping key restrictions

v1 -> v2:
- Addressed parameter validation issues reported by Nageswara
- Tweaked PLPKS_WRAPKEY_SYSFS Kconfig help text
- Added two preparatory bug-fix patches
- Cc'd stable@vger.kernel.org where applicable

Srish Srinivasan (6):
  pseries/plpks: fix length types for wrapping operations
  keys/trusted_keys: propagate wrapping key generation errors
  keys/trusted_keys: clear sensitive PKWM buffers
  pseries/plpks: add HCALLs for PKWM wrapping key life cycle management
  keys/trusted_keys: enable PKWM wrapping key selection by label
  pseries/plpks/wrapkey: expose PKWM wrapping key management to
    userspace via sysfs

 .../ABI/testing/sysfs-firmware-plpks          | 116 ++++
 Documentation/arch/powerpc/papr_hcalls.rst    |  33 ++
 .../security/keys/trusted-encrypted.rst       |   4 +-
 arch/powerpc/include/asm/hvcall.h             |   5 +-
 arch/powerpc/include/asm/plpks.h              |  40 +-
 arch/powerpc/platforms/pseries/Kconfig        |  15 +
 arch/powerpc/platforms/pseries/Makefile       |   1 +
 arch/powerpc/platforms/pseries/plpks-sysfs.c  |  11 +
 .../platforms/pseries/plpks-wrapkey-sysfs.c   | 399 ++++++++++++++
 arch/powerpc/platforms/pseries/plpks.c        | 502 ++++++++++++++++--
 include/keys/trusted_pkwm.h                   |   3 +
 security/keys/trusted-keys/trusted_pkwm.c     |  48 +-
 12 files changed, 1126 insertions(+), 51 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/plpks-wrapkey-sysfs.c

-- 
2.52.0

