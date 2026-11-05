Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880771;
	b=BTVNPYuhgydoWobr6+xhjmf1S4YeTy0iebMMDHn6EYYl7aiu2QmZRrMg9ycqGL8uD/k9
	 DJ6PpjF1RZ2sfbk5YnTTr+PA7PrjT0GLDBjKrx4x04ETgvHOSA6EfzxZt1aAaKI1N5jIN
	 qEFAvvSmDR2XCyZiwojG7DMLstWH1UCKLCF8sXNzdshJKfmMl2wcwbXis+m6H+k9nk33j
	 P6bFQHSUKNpPTHQa8agkQnrujlgpTHfEjDebZHUF+6/9jqui5pJbkJ+EmZ05igc2Jtb1Y
	 ArdJk2oOo4N2qQnt/Qaey6vmrEXJ7OUNjUZhTyoyHjsPs8ncI0qQEyI03SzK9q7yJzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880771;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=JwBvuE3bjt73zFG5tuWHoqrRtys0xckmF/DPCouW6rk=;
	b=Wv45nLCXYyxY2eXQ4ynRMQ2Sj3W1Yey6jTDAoHv2QDPvpAolXYQJzZtwVKSSSjFsi3ZE
	 YKoTdhsNjQclZXXX1gqvJWF73GfHR8bXZIh0PogNpt00bBpsuC43CobxOLLEVIzlRp3rY
	 hDqSEyixO80LUKJIIaYfRFiucVI75VrXiCvWHaAuf2rU+81tvs5Fg+HS3h21BMAyjJsAU
	 9qQDCyt+vxYEjR/c55reA139uyFsn2CiFVobQ7fncQ0jdmdmHkBCYsvn5lRdUgQKSHeNC
	 cco9h0LPWryKbb9xQEY6mQ40LXpK+LUXoK6t1RyT/xfCbFyOzbKL5LHZEQcby7Sdb9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PFmaoBLU;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8AC606D83B;
	Thu,  5 Nov 2026 12:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D8AC606D83B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=PFmaoBLU
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5AEFFo1609216;
	Thu, 5 Nov 2026 12:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=JwBvuE3bjt73zFG5t
	uWHoqrRtys0xckmF/DPCouW6rk=; b=PFmaoBLU3iIC2soaiHwssw93BL7a/tukU
	OhWQPYKgQjykxAle2x7Re17nLeKSFOrLZ6hOMwmzM6xyLoBSMfnuUo9ktfVVp1E5
	kn9gTpvPxNRkQX3asBi+6sbxFdj3xYoOTuuix7a+m6QfCRyL0nXGwsr7h2zwYAOm
	mUYDRIDHTvji94D4cnzufYAA2E0R9lrxGYYbLLA7DRzjCT5dfy/lDWss0m0GjVZt
	7VQcwVtLWFpWZDwKb6AHUoMIbh495bWCo2mBoFJoZXiX37YZZG11bf6obl/vqkbn
	3BHJWMXdE0rNUtVtR0jsWtCemTTa9WrKH+sSS7DwzSL+SGOZncQHg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn80t21st-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 12:12:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5A4x6b271729;
	Thu, 5 Nov 2026 12:12:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hqsf5gb5j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 12:12:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5CCdKF31785634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 12:12:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB8372004B;
	Thu,  5 Nov 2026 12:12:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E579620040;
	Thu,  5 Nov 2026 12:12:37 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.54.214])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 12:12:37 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] ima: remove the experimental IMA blacklist keyring
Date: Thu,  5 Nov 2026 07:12:27 -0500
Message-ID: <20261105121227.4089147-4-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105121227.4089147-1-zohar@linux.ibm.com>
References: <20261105121227.4089147-1-zohar@linux.ibm.com>
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
X-Proofpoint-GUID: VFjBsWZZOKBzGrxNHX9exw6sZR36JfWh
X-Proofpoint-ORIG-GUID: VFjBsWZZOKBzGrxNHX9exw6sZR36JfWh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0NiBTYWx0ZWRfXzqhyb1MmSsE1
 oEUu5U4B/f0aqtmimi+gh5jQEKMjCywV9y52l2LqKktoSYKl/uITbpReM1J+e4lOcrAdqmwVuKe
 Fw9oFOEfIZdoOJRb+BYNYQTjyynMlubGUDYNBM2AeRL/neLVVgmzIqRtTpZsfC8KO2ilMxHckIZ
 ZnPnqcLIiNW77ct4G0FTOubp2A3meyEttJye/SJWcq68Gak3SfnYeOZTpPWiEQlxQsqmZ6FtAkh
 cMPTQQj6tIR3plVdn2VxHcoNnHpaQw7T9mMUHJMqAm+w3z5ORRh3WPeFV3DDupx1F6MiD56/4VV
 POeyaEE54UZcF6uaOOQHOB9EKegrYrOxjmo5mq+mYbsEywzjhu42RAz7z6UvoYqfrQ2Rc65oQk0
 YYvlUX7Pt+jcD3bR6GnZ57f4lIFQlMvwm4aJiRQMyq4dRBOqrWpoWPgtVcrOFV1cDCw8F5fQZ7y
 72YXomAtfUfi3tKo5QA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0NiBTYWx0ZWRfX5m1XxGfZQqZw
 Sp64UUtDrbxIl67w9Cr4WEiOrxfBHMA/+n2a3JGWXLd6vzGhqtPXTWU8yLspOp3AvCnK0yxlycQ
 xNcnlDCJFlHp3JosqayXIUg0zuQw7VE=
X-Authority-Analysis: v=2.4 cv=FIqOVOos c=1 sm=1 tr=0 ts=6aec72ba cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=k-42gJp3AAAA:8
 a=aDROAyrWbko_J3lkjIUA:9 a=uCSXFHLys93vLW5PjgO_:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1011 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050046

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
index 48c830850b70..28695f96c091 100644
--- a/include/keys/system_keyring.h
+++ b/include/keys/system_keyring.h
@@ -115,20 +115,6 @@ static inline int is_key_on_revocation_list(struct pkcs7_message *pkcs7)
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

