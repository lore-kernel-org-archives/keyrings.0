Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2CE35C69F;
	Thu, 27 Aug 2026 06:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787811890; cv=none; b=hbhnHjZWDdxlkyW13TdLI7pkde4V26hqqAHqjNEzRG8WJqvd24FeUjTp+FTIOwB/GVQSdzAagqsnU5w5d9buVxYGBWXtyc74M0hQGEnQYMtH2PePxj7lGbnonJd1Ulv/ER68u6/L5C1jhae9t93y2A4E8W94Tk+fL2Y/6UYoF5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787811890; c=relaxed/simple;
	bh=9L8rmOpeSKap62LUW4zSsvE84i9y85+ze77IM79wJeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lzb600MVuPpFNxLi7tqwmuyngZcOFll/6dnjAnVYsU8Q5YH3cRGSF+fJAiGAAHsn/0KqfqqI2huhRXfE8rX517rdxUvlwZ6jo0b0L4I2dDHbDnfDwMx9CPXS5wI08RkxLGOqTvN64T20nzgGNbHLEIXOiV6wsSo++cis2oPfKS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HKqd375+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HKqd375+"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R3Vklw1715331;
	Thu, 27 Aug 2026 06:24:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=k/H8sfpIq20rBYe8K
	YZJHelmYkcLEhaFVHitAkdt8LM=; b=HKqd375+Af/1Qhi87QWJRSBMhCh144MkZ
	OBYfJsMkB3i359tZcBoQMgdr+0FHMbun44wkhctBVhgv2d1t3z31wg096hKiLNB4
	z6DEeT7r7wDnmo6QM5vYG5I6UUq+gOy08EjqIKga+pdzSpI/DEVNjjLIzscmhDdl
	L6Sotr7GIIsGEzNEfDe/xxcEuIku/Piw18YUwq34+4CkXEB2lbib4GaYUacOOyxr
	tTljqW0dnfbFoR/knQbuw7lngDZOuYZ80NKssuF9Tz7El1qrMh15wuKejgW6Q/dN
	80gAH5KVVQ2uZ3hShSIjRAtDvDSU8Syp9i3I1xtRtbbDwuk8M3dbQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716j3nhd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 06:24:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67R6BF1I013824;
	Thu, 27 Aug 2026 06:24:32 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7ragpb1x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 06:24:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67R6OSXL38928702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 06:24:28 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFACF20043;
	Thu, 27 Aug 2026 06:24:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 267EC20040;
	Thu, 27 Aug 2026 06:24:17 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.76.202.253])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 06:24:16 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH 5/8] pseries/plpks: hide wrapping_features when unsupported
Date: Thu, 27 Aug 2026 11:53:05 +0530
Message-ID: <20260827062309.724808-6-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827062309.724808-1-ssrish@linux.ibm.com>
References: <20260827062309.724808-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA0OCBTYWx0ZWRfX0uOi/RcrTijL
 oC9eUoQjvfJAb4snONYEY8uTbNDw/y4HWYQ0nDDaW4MCUP31iojddeNVsxxDpwCUVfCVQlvY05L
 doty31Y6svRmmq4QaW/3mkLKzd/PEAM=
X-Proofpoint-GUID: 0sJKQR3k2h17EYTSSyCOZ1QNbnfu--X-
X-Proofpoint-ORIG-GUID: 999WyhPe0QqdHMdlrRsZ6ViMpxpevS2a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA0OCBTYWx0ZWRfXxpIKykJreSHs
 vNDWI0znHlcu0OsyomSVBVCr4VI4BYlxEH66gXoHZlUMiBf1SnLkrih7oJq039RxYLmdOmyqU8F
 JGZhIxHj8D3kJ1ZR8N77a9nbjaTD2NPEfbWYTvdLDMh3VejG0zEQryBU2WmItPTL9Jad2MqrNem
 DdyRBEQPp8h3WmGRu2JzohV4HMrw7CYpwhhztEgoduWL3z1TE0gCH2dA5jbbVUKBqoC0bl9P73A
 1LLtUyf8p0KO0o0uUWb9mPFbfrVoklPwVpO4iqrqfkb0yoeKVVET8VfRkV6ce/uz0KzATY7fXFN
 CTH9ycYxDyjcoGyJThAzHb/vUfYYct4SCZEhsbL+jo80kGG8WxHqyM3jz+F+w1Qf8zLa8Ve1CRo
 aFGlX7JIt6ASqAzTEWS9pPnRCJrXfFKJ8LY6KvdXKfY6ySIHBSBH1NCv090lmDCQAzwM0952Ysb
 6/QNPHxQs6PjpA2o/AA==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8fd822 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Lnrgi2ogIeW2OlIaXxgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_02,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270048

The PLPKS wrapping features config is only valid on systems that support
the "Key Wrapping" feature. Currently the config is always exposed, even
when the feature is unavailable.

Add is_visible attribute_group callback to suppress the wrapping features
sysfs attribute when the "Key Wrapping" feature is not supported. Declare
the attribute group static const, as it is not modified after
initialization.

Fixes: 447eb1d5ef00 ("pseries/plpks: expose PowerVM wrapping features via the sysfs")
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

