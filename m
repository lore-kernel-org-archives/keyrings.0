Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F3E3B14AB;
	Mon, 31 Aug 2026 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175109; cv=none; b=VXWo59EJIqRsw6+r3nDfik0eYBKKMphTJSeEcvegGRkeAi/1rNSqYLlYQZh20Nf1HgzlFHxFSkB2TWxkdVvi9mNB//Wce+cLK37KpQIPJS7BOgxhAtgqt8vDWa5MPGiLVTjQYJV3pnvd7dNss9c9EM8VUorJBf4umX/jFpiH4uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175109; c=relaxed/simple;
	bh=ppOq9YOpmGywaNuX1inE/XhGeWpNGHm+tW35VvMwni0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EKQLNj7O+710gogGH+it56ZG9gNS/9HTEr4LEnr/DS92+3wFQTdZhAcJ3X2eOorgBL9G/AKT5sNj6fGBx0N3aXRFGpYr2XH79FiwMrDJeAZW5oXy3uNrtdUYeUiy0CTvA+dXIDE7V8hgd7kJXVWQMp5A7ZGt1PWaj2S5ZTx9YCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PedxxZTO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PedxxZTO"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82IoZ1697486;
	Mon, 31 Aug 2026 11:18:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YKwCvUdoAOC3svV0Z
	XnY6wMaAycWuH2JbGu1LQVNZ0o=; b=PedxxZTOIEE2QaF791z3yiso25IUM5wyI
	XQWH9SGzbhF1E0I4OrlQ+gL/lBdjpGZgfYgfyevNPrIZfjFffmszYWViqx694/b0
	oTbRD1bzhFVFgN8QS3+a27/PK/JpT5rfKZ1DKI41VwvFD7t7rf43Nr79X/kUb6JA
	AqlElq+p3wAHeKy622um8/xTAOvzVBageRtadn7SfghwY8/gd08ejvdzcFX0WUpI
	THTNZ9sUizJky31bIJVvsC2O+NJyDr8+QuC7qeHg/gPi9ddu3N2D9yZlxINA82dT
	YAng82kk4vjTYeI9rtIx+3z2DVbcDvf57QoMHfL816Xcd5S4YUoqA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t0pqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:18:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VBDHsq009196;
	Mon, 31 Aug 2026 11:18:13 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gca4vwm64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:18:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VBI9wP41484750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 11:18:09 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 375FF2004B;
	Mon, 31 Aug 2026 11:18:09 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAA9120040;
	Mon, 31 Aug 2026 11:18:05 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.bl1-in.ibm.com (unknown [9.123.14.23])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 11:18:05 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v2 07/10] pseries/plpks: hide wrapping_features when unsupported
Date: Mon, 31 Aug 2026 16:47:35 +0530
Message-ID: <20260831111738.334857-8-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831111738.334857-1-ssrish@linux.ibm.com>
References: <20260831111738.334857-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a9562f6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Lnrgi2ogIeW2OlIaXxgA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfX3U/JLDnmVfCA
 1IVH9EQLtjted0Xt4sdm4SgrbVntKJBMNrptHZgXCtocHs5qRgLi4ArwQHgtUHmp5V4iJMDw30c
 2eSQHmR4YvMv3M1+A6w2Zgi8gJ0oChA=
X-Proofpoint-ORIG-GUID: eubbGhSrzusjcLOREbg1CxAp5KI2130N
X-Proofpoint-GUID: ZNgizUtJ58x0q8Ed72G2juWvjoLK0iI2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfXzR6Ogb9xWALY
 6rSlJftl/ApkGQf/GfsZOzzakRkOTzcUx4E3ICJe+KmooCmE7ofUsY5gXcyvJJ7CxAoGz2/ceZB
 mf2+2k68dQQ+u+NNcpoxEIKdKnCKSMnN5l29ml3zWnOP9/8zc3NeL+RJGMrQyKmhZXn7pyJQuT3
 xfdgDLKGyJZDqNicoXIJew/2MAk1Fq1k01EvKXYQ6c0pPuyHXiGtBvHsn/fPIK9QIRKu3U7asl6
 WCMCzqfOhkVj3diun6WMwA+X/WIMj6W6QB8TtrRcXTcMHZ3V9o67DgIOquJlX/mM6q0ISBhMhc9
 xJToEHOx0pDR+foRhmhAHrZxrCB5v6o5br5cfVBbibw/MJvJKrbORFqjM3lNj3jziRz5V/2OBP2
 bn37vK9yv0wgfxAWCuJfMRl/Czxa/v59YM4Gvk7yrmABi/5bQO8vsaKocvefOoP/eKnvxCr8Hsw
 cDIQe8SEPX3pvUe4BTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310095

The PLPKS wrapping features config is only valid on systems that support
the "Key Wrapping" feature. Currently the config is always exposed, even
when the feature is unavailable.

Add is_visible attribute_group callback to suppress the wrapping features
sysfs attribute when the "Key Wrapping" feature is not supported. Declare
the attribute group static const, as it is not modified after
initialization.

Fixes: 447eb1d5ef00 ("pseries/plpks: expose PowerVM wrapping features via the sysfs")
Cc: stable@vger.kernel.org
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks-sysfs.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks-sysfs.c b/arch/powerpc/platforms/pseries/plpks-sysfs.c
index c2ebcbb41ae3..f2436229f323 100644
--- a/arch/powerpc/platforms/pseries/plpks-sysfs.c
+++ b/arch/powerpc/platforms/pseries/plpks-sysfs.c
@@ -45,6 +45,16 @@ static const struct attribute *config_attrs[] = {
 
 static struct kobject *plpks_kobj, *plpks_config_kobj;
 
+static umode_t plpks_config_attr_is_visible(struct kobject *kobj,
+					    struct attribute *attr, int n)
+{
+	if (attr == &attr_wrapping_features.attr &&
+	    !plpks_wrapping_is_supported())
+		return 0;
+
+	return attr->mode;
+}
+
 int plpks_config_create_softlink(struct kobject *from)
 {
 	if (!plpks_config_kobj)
@@ -52,13 +62,13 @@ int plpks_config_create_softlink(struct kobject *from)
 	return sysfs_create_link(from, plpks_config_kobj, "config");
 }
 
+static const struct attribute_group config_group = {
+	.attrs = (struct attribute **)config_attrs,
+	.is_visible = plpks_config_attr_is_visible,
+};
+
 static __init int plpks_sysfs_config(struct kobject *kobj)
 {
-	struct attribute_group config_group = {
-		.name = NULL,
-		.attrs = (struct attribute **)config_attrs,
-	};
-
 	return sysfs_create_group(kobj, &config_group);
 }
 
-- 
2.52.0

