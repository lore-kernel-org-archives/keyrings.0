Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739D5342509;
	Mon, 31 Aug 2026 11:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175105; cv=none; b=BOHcd3rlR3YyXCI3hNum+K4HC1d4E9YFGdioj7f3UYKzxbp9JRD794r2ahiW4zhxHU5RRNRDml3qsAGS4vgPQtmCjDa9ZxIfs34knkjXLXNsBbwiBCr9+YLrZjGwBmzv9eRnsn4tKH72HSMidlOqVotJ0+zmxjDDKTigQjBfJLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175105; c=relaxed/simple;
	bh=LjQU7Ma8Ue+xgyozbaFeJ7euvrxjPoYaqz7TpOW04xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qoJd0DWSuTFa/Qay42iG1yPrzWYUyH1mNcxtzdjIFYCsfpkfi6cQhbJBVJa0hqsEfy2KyH24sUunAeJbDnqxNPrGdjZFEFr6MVuqvxjSSBIDzsmWfNQXHSA824brvu4XMeDaZYB00FGW14BmI1B2HWgYu78YpxR1pAvXheGfgPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YGmaxDqv; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YGmaxDqv"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V82H561697480;
	Mon, 31 Aug 2026 11:18:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=w3Ht7jwaLfz5JWi1v
	2vUTqFscY0+qdcIxI1EC5n7pXs=; b=YGmaxDqvt+df9YDMY1m54PVLhLnHji3i5
	xnpS/KfeAYf6PMINeQ7KCmTTeq+gUFbL9U8XJdj4R+zhO3XgzTU2B/TT4qXobRMG
	FYRTAVNfWlBbZfV5v1o+vv2KosMGmVbbOMSy4hdUb+tAB1eIm9okoOJWkGxxhTlo
	DCzAq0EbV5WcWOGd8QsiVOHW1IzyJWbawJjNnUeM+NUB4Cr4uulzN6wwjCvUwih3
	R8NoqDYz0gCJDJZVelnlNvzlZQ+QwuEWu+oGszRzLgZV42XOBpqtWRSGf7W5eMlx
	S85mdroAZYoK6pVpw5lM6vuk1nH8CoxlXrv5h+TPuMIhBHORM9Jjg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq2t0pq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:18:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VBDNon007646;
	Mon, 31 Aug 2026 11:18:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq5pw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:18:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VBI54e39977416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 11:18:05 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 542712004B;
	Mon, 31 Aug 2026 11:18:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 036A020040;
	Mon, 31 Aug 2026 11:18:02 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.bl1-in.ibm.com (unknown [9.123.14.23])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 11:18:01 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, ssrish@linux.ibm.com
Subject: [PATCH v2 06/10] pseries/plpks: fix self-reference in plpks_var initializer
Date: Mon, 31 Aug 2026 16:47:34 +0530
Message-ID: <20260831111738.334857-7-ssrish@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=bc1bluPB c=1 sm=1 tr=0 ts=6a9562f2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=yo0uri9pEEIi5ApSFXoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfX0VTWcXKJcSo+
 Vb/0x8AzoGFca6UKjuLzbNWOOr3OgrjMyBIos7JZ9kjUaYxQntqJHIQGR206eT/JQbAHeu5WpnU
 3kocEYOWXwHMFHt/W9erT5+gK/0nzRI=
X-Proofpoint-ORIG-GUID: GwvuHEutnCeb4c21o8nvJVj8Mjp0s5H1
X-Proofpoint-GUID: w5ZmGw5Q36aGuR-2xXGTLi-eB92znNCq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA5NSBTYWx0ZWRfX1vJofBIIqFI3
 5l2rixZZqruGsrjYXv1MatQ+hx98UKzPHl4OtmJAtGkGm4nMh1weTlnCU+30kLKR9a3INL3nknk
 eyIMW/N3hbbF+7OM7vsjQYz9LkJJ1ypzOKTcFUmL79KhAvhWXkgAAb0NGYtQPEmkNhfylhUHnYX
 lIOvgdYEb9cD9FFcMKfcfQUeaJRYM6SW/PRIHgkGqr4CJI6kp5zk3gwLZcUHvE0ClRi+DzcMiWC
 6R0x0WLb5v0j0OruJwPSUrGTo2kgFNSi2XgWtcsUElY27DCPgMPbmkefc/T+MFZuLudH8toOFRg
 dfdMRO41weRqY6lyDzi/eCFH8DkxDTJDwtPdIETXap6dQxUhqT4jzMxffVUei+fuY6e7iTD5SUC
 S7qXaxokYDwgQf/Lp7ol2AhrDrzAiwDWlBBMNXWcTTpms6GrVKcYcZ+KKqclLndNTPOezNPN179
 3qYpMgOLTIcPrsI0b7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310095

In plpks_gen_wrapping_key() and plpks_wrap_object(), strlen(var.name) is
used to initialize var.namelen within the same struct initializer. This
references a member of var before initialization of var is complete.

Use the compile-time length of PLPKS_DEFAULT_WRAPKEY_LABEL instead.

Reported-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
Cc: stable@vger.kernel.org
Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
---
 arch/powerpc/platforms/pseries/plpks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
index b553f7b130b6..d582c786ccad 100644
--- a/arch/powerpc/platforms/pseries/plpks.c
+++ b/arch/powerpc/platforms/pseries/plpks.c
@@ -939,7 +939,7 @@ int plpks_gen_wrapping_key(void)
 	int rc = 0, pseries_status = 0;
 	struct plpks_var var = {
 		.name = PLPKS_DEFAULT_WRAPKEY_LABEL,
-		.namelen = strlen(var.name),
+		.namelen = sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
 		.policy = PLPKS_WRAPPINGKEY,
 		.os = PLPKS_VAR_LINUX,
 		.component = PLPKS_WRAPKEY_COMPONENT
@@ -1034,7 +1034,7 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
 	bool sb_enforce_bit = wrap_flags & BIT(1);
 	struct plpks_var var = {
 		.name = PLPKS_DEFAULT_WRAPKEY_LABEL,
-		.namelen = strlen(var.name),
+		.namelen = sizeof(PLPKS_DEFAULT_WRAPKEY_LABEL) - 1,
 		.os = PLPKS_VAR_LINUX,
 		.component = PLPKS_WRAPKEY_COMPONENT
 	};
-- 
2.52.0

