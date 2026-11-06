Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986339;
	b=zbf9CuhEll/LaC1H3B+D9O9IIS13Fpmc5PDWWKZTQW1UiwRd2bNdmIxtE2C9njpuN6aY
	 peH+IV99kYvg68bodHgpgprCEOzIz9ArUjp2XTnLkS6OFLbHXcOhEvcd+1yuHxy2utaHD
	 uLE7XDMbZzDEgnCbZzygA3xxC2QF50Xf7+9NWu47uMWuud0sPizXlCzqe6A8Ccw3vRFnr
	 Vz1/xc2KBNd+U6f3O+tceTEKVFMQMcUHMNPDrxPvdVSyhHIwmePuBmpWOoVcQp22m6C/o
	 ehWcW4mYQk7vXU4Ky/DfOptKY2NMQFlXIobfQbR/d0eXQIyFPNsF+H6JAZeslyWkcXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986339;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=UnR2psYG/ks2tFhuBhZhgUCGkijI/HQcEJkVdPOQ9zY=;
	b=StupcNqbehyDWzc2W4e23GIV0fHGgYgqbXBNWFgGQWeeVoiHjp/DUhNsdZmW1Dx8PuWq
	 k904VsPdME3JA+FOFFeSCUdRQk7oMOu8++IZekVsOhfzNVIj5zj0BfBuaQeVO9vK6knxA
	 YhRQ5GA/R81yukwinwOeLv6teYW0IDzwBGgrtZqMgf0Z0vnf2++0jPezWOavZWiC0kGeE
	 fGtvVj4mTDmv/gGCmZ9DoBywWJujY5CurDQRqCrAcbL6vEcFyow1CitM19cVOFIA3zDuW
	 MWLMiw/7SR6XpCe5Dec3q6QAocAzlslBIFHupLHN6US64Yc4KJYvZJbM01PN5qhWqSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gYnSUU4p;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5F4606A338;
	Fri,  6 Nov 2026 17:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B5F4606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=gYnSUU4p
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FE7rG2935684;
	Fri, 6 Nov 2026 17:32:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UnR2psYG/ks2tFhuB
	hZhgUCGkijI/HQcEJkVdPOQ9zY=; b=gYnSUU4pEgM48rSgE2WtMUgII8tZh8KI2
	a+DQYwRQ2UPxDv3mZsLzYaQK+/+LOnjsUYxDqKJ+H07o3ipFpLKSMoDQ4Ej3pk8o
	+dTLCAVjoP/IOhrlv+TJDKVW1gPsyETkIqKC209YEh29eEUVkWjYGGCVV9fmO92M
	UikYTsLHWN8frJL2pAgkkwHWAQhEV798DsEuaVDszLmVF58YZ7sdcSazxd6KmdEl
	uQlqwUOT5q8QWpAJXJDqJDrSrG0wfuOIlpIHEgV0+yayItpi8nUjwPnHPdqYvNx6
	ctsCCHIN9yET3Vd7XM+kJ0n3tEGdEB6cA2J30iJYeGLXv63EeKVYQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rcedsh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 17:32:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6GxONR3617269;
	Fri, 6 Nov 2026 17:32:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrdd7vdm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 17:32:05 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6HW3jl48955830
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 17:32:03 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DC352004D;
	Fri,  6 Nov 2026 17:32:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC79B20040;
	Fri,  6 Nov 2026 17:32:00 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.47.32])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 17:32:00 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] ima: remove the experimental IMA blacklist keyring
Date: Fri,  6 Nov 2026 12:31:49 -0500
Message-ID: <20261106173149.707244-4-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106173149.707244-1-zohar@linux.ibm.com>
References: <20261106173149.707244-1-zohar@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: nlC2Z7uONPi49pq1mGwYTkCJ4D9u2NNf
X-Authority-Analysis: v=2.4 cv=A635rKWG c=1 sm=1 tr=0 ts=6aee0f17 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=k-42gJp3AAAA:8
 a=aDROAyrWbko_J3lkjIUA:9 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-GUID: nlC2Z7uONPi49pq1mGwYTkCJ4D9u2NNf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfX2jQmC4iaZmzJ
 gkM6IzCTNNbcBhtvibZ1MrwhDegVEA7efBt/oUc2hEywo/sAbnfioiC7jrrBiaB6KKJIcp1mTvC
 xsjPD9NWQdXPMXur6K9u+vPZOQCQ+SLyxS4iY0v1pq+cAzLtnAQXPISDF0PC5QxsAtpUbOpD0JQ
 Pr9ACEDrvtnI/ueSZl30gFEObKPnLnOriXMg2Ba6VCX4YFSeHkTSj6IbNKwEF2+IzVWwCqzYBLb
 83v+h49PrF6gh4dDUDpKofTWkt7vF+vkUGpJREqVOFCCkoDdJKWolcRv5PgmLpMQ8ObfRz98A3s
 yMC89QoRPyDhr7OnotMyq9TqUOBL4zTh6dl6Rf+2o5FgL2BNR9XfUDAnYvVEMqoeIy5/gwbgddC
 8458hi9ei7+ji2antH/5W9SWfPUM9t0MMYSTvKXBo5k3KGDtT5uF9DwaWOddXUPTsZm4zpOlRPW
 C+p1k4PtGpQZ1wxBeww==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2OCBTYWx0ZWRfXxZLe9EePp/Ix
 FLRYwQZgK7SuZ7uhCkhcZOr8tAMkGGVI8uUSuJWEElxq/YJftaJBIFniTXO3bPrdC3ywSZAqOuv
 KLdSV7s7blTDLbAdhKx/lnxMf9lcBak=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060068

The experimental IMA blacklist keyring accepts any certificate signed by
a key on the builtin trusted keyring.  Since every certificate issued by
such a key qualifies, root can add any of them, including legitimate
ones.  Nothing differentiates the authority to sign from the authority
to revoke.

Remove CONFIG_IMA_BLACKLIST_KEYRING, the ".ima_blacklist" keyring in
ima_mok.c, get_ima_blacklist_keyring() and the related Kconfig help
text.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 include/keys/system_keyring.h    | 14 ---------
 security/integrity/ima/Kconfig   | 13 +--------
 security/integrity/ima/Makefile  |  1 -
 security/integrity/ima/ima_mok.c | 49 --------------------------------
 4 files changed, 1 insertion(+), 76 deletions(-)
 delete mode 100644 security/integrity/ima/ima_mok.c

diff --git a/include/keys/system_keyring.h b/include/keys/system_keyring.h
index 2ac1dae2063a..61e5aba26e24 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -119,20 +119,6 @@ static inline int is_key_on_revocation_list(struct pkcs7_message *pkcs7)
 }
 #endif
 
-#ifdef CONFIG_IMA_BLACKLIST_KEYRING
-extern struct key *ima_blacklist_keyring;
-
-static inline struct key *get_ima_blacklist_keyring(void)
-{
-	return ima_blacklist_keyring;
-}
-#else
-static inline struct key *get_ima_blacklist_keyring(void)
-{
-	return NULL;
-}
-#endif /* CONFIG_IMA_BLACKLIST_KEYRING */
-
 #if defined(CONFIG_INTEGRITY_PLATFORM_KEYRING) && \
 	defined(CONFIG_SYSTEM_TRUSTED_KEYRING)
 extern void __init set_platform_trusted_keys(struct key *keyring);
diff --git a/security/integrity/ima/Kconfig b/security/integrity/ima/Kconfig
index 72654cf797cd..fc42ddd34385 100644
--- a/security/integrity/ima/Kconfig
+++ b/security/integrity/ima/Kconfig
@@ -255,7 +255,7 @@ config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 	select INTEGRITY_TRUSTED_KEYRING
 	default n
 	help
-	  Keys may be added to the IMA or IMA blacklist keyrings, if the
+	  Keys may be added to the IMA keyring, if the
 	  key is validly signed by a CA cert in the system built-in,
 	  machine (if configured), or secondary trusted keyrings. The
 	  key must also have the digitalSignature usage set.
@@ -265,17 +265,6 @@ config IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY
 	  provided they are validly signed by a key already resident in the
 	  built-in, machine (if configured) or secondary trusted keyrings.
 
-config IMA_BLACKLIST_KEYRING
-	bool "Create IMA machine owner blacklist keyrings (EXPERIMENTAL)"
-	depends on SYSTEM_TRUSTED_KEYRING
-	depends on INTEGRITY_TRUSTED_KEYRING
-	default n
-	help
-	   This option creates an IMA blacklist keyring, which contains all
-	   revoked IMA keys.  It is consulted before any other keyring.  If
-	   the search is successful the requested operation is rejected and
-	   an error is returned to the caller.
-
 config IMA_LOAD_X509
 	bool "Load X509 certificate onto the '.ima' trusted keyring"
 	depends on INTEGRITY_TRUSTED_KEYRING
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index b376d38b4ee6..ad5840ba085e 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -11,7 +11,6 @@ ima-y := ima_fs.o ima_queue.o ima_init.o ima_main.o ima_crypto.o ima_api.o \
 ima-$(CONFIG_IMA_APPRAISE) += ima_appraise.o
 ima-$(CONFIG_IMA_APPRAISE_MODSIG) += ima_modsig.o
 ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
-ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
 ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
 ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
 
diff --git a/security/integrity/ima/ima_mok.c b/security/integrity/ima/ima_mok.c
deleted file mode 100644
index 14d93d573a6a..000000000000
--- a/security/integrity/ima/ima_mok.c
+++ /dev/null
@@ -1,49 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (C) 2015 Juniper Networks, Inc.
- *
- * Author:
- * Petko Manolov <petko.manolov@konsulko.com>
- */
-
-#include <linux/export.h>
-#include <linux/kernel.h>
-#include <linux/sched.h>
-#include <linux/cred.h>
-#include <linux/err.h>
-#include <linux/init.h>
-#include <linux/slab.h>
-#include <keys/system_keyring.h>
-
-
-struct key *ima_blacklist_keyring;
-
-/*
- * Allocate the IMA blacklist keyring
- */
-static __init int ima_mok_init(void)
-{
-	struct key_restriction *restriction;
-
-	pr_notice("Allocating IMA blacklist keyring.\n");
-
-	restriction = kzalloc_obj(struct key_restriction);
-	if (!restriction)
-		panic("Can't allocate IMA blacklist restriction.");
-
-	restriction->check = restrict_link_by_builtin_trusted;
-
-	ima_blacklist_keyring = keyring_alloc(".ima_blacklist",
-				KUIDT_INIT(0), KGIDT_INIT(0), current_cred(),
-				(KEY_POS_ALL & ~KEY_POS_SETATTR) |
-				KEY_USR_VIEW | KEY_USR_READ |
-				KEY_USR_WRITE | KEY_USR_SEARCH,
-				KEY_ALLOC_NOT_IN_QUOTA |
-				KEY_ALLOC_SET_KEEP,
-				restriction, NULL);
-
-	if (IS_ERR(ima_blacklist_keyring))
-		panic("Can't allocate IMA blacklist keyring.");
-	return 0;
-}
-device_initcall(ima_mok_init);
-- 
2.56.0

