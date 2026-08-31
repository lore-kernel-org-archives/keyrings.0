Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AEF3D171B;
	Mon, 31 Aug 2026 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175085; cv=none; b=UTha7qDCbBO8I4X+gJh0XJrbmUcwp6tMM05AESGNIZdfP/rpZHG1ukUlFua00uqbLA/KeX4pMNYcIyhgpf3x57eUzJiQMR45MKGS1RaWioOgQGVYMw3noi9WgCo/WSXNczpcbI3SfbGO1fwac+sHBNRp9XKkdsqaGrnYBtnk84k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175085; c=relaxed/simple;
	bh=FS/J6aBHDygSdSXGmePKCR0eyxpsRO34CbhD/HIureY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uw8VDhD7TDbnc3PXvU95wUGX6gA0A2xif8OU9h2qrJ3alzvHj6NsnRDA1ETk50ZBxptk+EdalrMJ4vxpIPOrSEa++juQwDqRwCmydKsom+gpXpPvUKMbXEpAUgQKUfaCQQilrC6KR9Ya+t+ld2NvdKlwgqsg8wPQf2dC1F5NZZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZMJa3+h+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZMJa3+h+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82MuO1640462;
	Mon, 31 Aug 2026 11:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=D8oFSxQDdU5s+9mMREcnsOc7CgzaIj/jUW/WT6lXa
	M8=; b=ZMJa3+h+jVReUtUjSEw1DGX8+anATYaA9mE/hIFV+FAVcrCONC2s+Vk3c
	f7lvY4VBMIOsl5AuJziSpSbW6v8ckvHy3VvjMb0+d6ewep+h2LQOHYdhO7jG7kfF
	0zAd+JJY3GReKJhmZYxLfWfvVaKdnDGYdBA844rTyOrT4BVnj4iUnvM+of71V9Co
	sB5IRPKrw8XgCBi7v31J5COiQkOecUnwErGgX5xh/h3ryFxIJkV3FA6E85gH+0Hd
	qUFDXLm/2Nk/1eHaenNL+0fH8FeVV71fi3jZjYI7oBGaykvW9nzM4YQve297YscL
	+XObUZlG/rQ6+dk2jRPFBTCi3xnAw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx58vt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:17:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VBDJ4p008540;
	Mon, 31 Aug 2026 11:17:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8h5f46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:17:46 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VBHgQl50856338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 11:17:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 65FD22004F;
	Mon, 31 Aug 2026 11:17:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 367012004B;
	Mon, 31 Aug 2026 11:17:39 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.bl1-in.ibm.com (unknown [9.123.14.23])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 11:17:38 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v2 00/10] Extend PKWM to support user-created wrapping keys
Date: Mon, 31 Aug 2026 16:47:28 +0530
Message-ID: <20260831111738.334857-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9562dc cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=jXZBl2vuKrkg1_MI_zwA:9
X-Proofpoint-GUID: whz4q49IN8Olb62AN7MKimLRZsscfrtt
X-Proofpoint-ORIG-GUID: ChfKTTpnEcbq8QL7jSIWQEneuq1p8QmW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfX9YafB7IdOSG0
 u2pI2i2XQTfW+tQNSKjq/aNCp4JeyU+hxQ9lXtnpodeOrC+TzjQZS5W/MKV0N7TvSTaUS2TKoAP
 ui6bY1dSu8OeDU/1K0sBE+R2SUeLu/o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfX/SgAwkz6osRT
 n10f63sUoDNy0lIYMwlOtYznknV++7LS9lO3WI11E/osy04Q1S62SjrDJpBw4SesyvjIWQgZjxA
 Y+2dDDOms9RIMsBPvH2oQO4F0hzAL7YjLqeLi+f8Zo89xe55X1FHTtL93wlqjIXOYvnf9s55JrO
 faxnL8qX00w0R2s1XIiISdG73DXBUtWiW67pvvkLRAABaekwPKEhkzo8CY5nnDk4G+ZOppsgDfI
 n8UXSDua9DujzDJH5vCytr/Wdu/veWoM5XM8PtUPymTURMu/bHjh4/QkhDkD5+BuxmYMwZIkz5p
 7s6VsNZcefePz/Dh28fRe2eMDpDIAWQRtduQSSrlypQXLqZprAd0envnO81fjr5qusL6TLw6qQy
 hkb/5wddBXbmttDSPLRzYC302ijg5smxF60Nuo/wUmmS+5adVbiPBs5SnDqgg+hPJX8PplOgZGL
 JXwlenvuL3y2Ql2/fXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310095

The PKWM trusted source currently uses a single default wrapping key per
LPAR. This key is created during trusted source initialization, and all
trusted keys backed by PKWM are sealed and unsealed using it.

Recent versions of PKWM allow users to create and manage their own wrapping
keys through a set of lifecycle operations. This patch series brings these
PKWM capabilities into the kernel, allowing users to create, manage, and
select wrapping keys for sealing and unsealing their trusted keys, rather
than requiring all trusted keys to use the default wrapping key.

This series adds support for user-created wrapping keys to PLPKS and PKWM.
It begins with seven preparatory cleanup and bug-fix patches that improve
error handling and type consistency, clarify macro naming, prevent
unsupported capabilities from being exposed through sysfs, and update the
documentation and MAINTAINERS entry.

The final three patches add the required hcalls, enable wrapping key
selection by label for PKWM-backed trusted keys, and provide a sysfs
interface for managing wrapping keys from userspace.

Changelog:

v1 -> v2:
- Addressed parameter validation issues reported by Nageswara
- Tweaked PLPKS_WRAPKEY_SYSFS Kconfig help text
- Added two preparatory bug-fix patches
- Cc'd stable@vger.kernel.org where applicable

Srish Srinivasan (10):
  pseries/plpks: update PKS documentation and maintainer entry
  pseries/plpks: fix error handling in plpks_read_var()
  pseries/plpks: improve type consistency and parameter validation
  keys/trusted_keys: propagate wrapping key generation errors
  pseries/plpks: rename the default wrapping key macro
  pseries/plpks: fix self-reference in plpks_var initializer
  pseries/plpks: hide wrapping_features when unsupported
  pseries/plpks: add HCALLs for PKWM wrapping key life cycle management
  keys/trusted_keys: enable PKWM wrapping key selection by label
  pseries/plpks/wrapkey: expose PKWM wrapping key management to
    userspace via sysfs

 .../ABI/testing/sysfs-firmware-plpks          | 106 ++++
 Documentation/arch/powerpc/papr_hcalls.rst    |  49 +-
 .../security/keys/trusted-encrypted.rst       |   4 +-
 MAINTAINERS                                   |   2 +-
 arch/powerpc/include/asm/hvcall.h             |   5 +-
 arch/powerpc/include/asm/plpks.h              |  40 +-
 arch/powerpc/platforms/pseries/Kconfig        |  15 +
 arch/powerpc/platforms/pseries/Makefile       |   1 +
 arch/powerpc/platforms/pseries/plpks-sysfs.c  |  31 +-
 .../platforms/pseries/plpks-wrapkey-sysfs.c   | 407 ++++++++++++
 arch/powerpc/platforms/pseries/plpks.c        | 577 ++++++++++++++++--
 include/keys/trusted_pkwm.h                   |   3 +
 security/keys/trusted-keys/trusted_pkwm.c     |  40 +-
 13 files changed, 1210 insertions(+), 70 deletions(-)
 create mode 100644 arch/powerpc/platforms/pseries/plpks-wrapkey-sysfs.c

-- 
2.52.0

