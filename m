Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578609;
	b=PtCPFHt2xhb8jc+a3WCYFFKl8t87NgdiVRJNYTR6qjxrgIWgEZkqHcGJ/A2wx4FcEUX6
	 4IBymLu6HYASnfAcTiCCAzdi5w5eQV82z3Iss80SEqnV1lbt0c4Y6F7R3/jlTB3obIQ+V
	 h4XZo8bCO+9Md+EyAL4+Apk53qCZ8UwntPriWQCZkSQ2kjauqkRbEvQf9G+LplNEuwmb9
	 q/zUrQBaxzYgkkUSWJ5f2B0Flc15n5KhQhXSvO4DPJIzQuqyUcQ5hc8gApQMmcr9juwdH
	 h21PoKbaQhxjYzAN0nlnaJg1fm1nuDYVViS2cLEMJTiBLYdBe/jVZ+ZwVOlS/5StY3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578609;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=tvqygwyUVR4EPp0FlDryYT67wk1QCPl6+ronOyRVySw=;
	b=EEnLVK3pXhh4SAojwEMunVJIuEDmjFJwbz5kDni4+JSJ52JDwlsRkxMzPWV3vgTQkZhF
	 LDcBxk724+TkwcUb+Px+xz7k24Vi8Weq6JZRP1hqSNUF+zFtCKENFYhe3e/L+mI8f4tT8
	 EcgEUnJLTaOJWwhcviXiyE7QclW6nSt3HGNEhhfCMZI5poNx4jthtWCJC+6yxceXKQZyN
	 vOytKmBJAV4K2rOsXa4scOxt/vQb3hLYIYArya/eIv21TvPiC4bm57NvwYLrtAMmPyChA
	 sG35lYSlH77dZVMS5rAGwm0VWIiGHni9bCCUubMVqv9c5QveoKW1zcjM83mX1au2Gog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=A4WK0up7;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092CA606A323;
	Fri, 13 Nov 2026 14:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 092CA606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=A4WK0up7
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCEQ611667877;
	Fri, 13 Nov 2026 14:03:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=tvqygwyUVR4EPp0FlDryYT67wk1QCPl6+ronOyRVy
	Sw=; b=A4WK0up7FkOaDUyH7VfjvFWOpaP5iop5egxAPwYY/jT47b8YkCSaWo1sf
	A5GDxbFNJRB4FybHSipDPO/Lfv9dRonpwm+LdPgLsQPGVC8ZyGStTIanHSizNCN9
	gQQ86g9Ke3qH3k6sYpqjtpSSYh6U9VLhlzu5RBH9DDP9ynGAlzy2VNPjSa8KXiJr
	bD8Hu49XLEXOEX1OLVxZspvdCjks0qpBQm7iqhFmnALlK9ZnyMFkVoStFBbFMMvW
	mMUhz42ftdn7bGzVv64+KIYzi3oAIFomrR+SokYTqcgpXDadDXmgxxkxKOXKSmjW
	O/2L/SRAcfqpKH6rUL2jBNDFJ3APQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdgjsc1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 14:03:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC5FqJ2245052;
	Fri, 13 Nov 2026 14:03:15 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hwd85catc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 14:03:15 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADE3Ebg16122494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 14:03:14 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EF2858017;
	Fri, 13 Nov 2026 14:03:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0F935805C;
	Fri, 13 Nov 2026 14:03:13 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 14:03:13 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: jarkko@kernel.org, keyrings@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dhowells@redhat.com, Stefan Berger <stefanb@linux.ibm.com>,
        Florian Bauckholt <florian.bauckholt@cispa.de>
Subject: [PATCH] KEYS: Fix signature input size for KEYCTL_PKEY_VERIFY
Date: Fri, 13 Nov 2026 09:03:11 -0500
Message-ID: <20261113140311.1375048-1-stefanb@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af718a3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Dg1OHsfEkaJg19lmKZgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX94st5tQ0YWCw
 +kBMG6f3AyBENXkW0n8jepBcHCuHWeqPmszh+zC5b9gxPnWrkjJquFZHZGBQSoJSHujSFzU+yEM
 /fcGmjDF5OO4V1BL/R+A/SKbwTgX7o/7WomcDD43J/IpZ4akpO+TJVGMeFC1I5KRcu151YV+wqN
 4Xs4cC6ItZTPS1eFUVuU8DafOmpQJIQbH8c8Gf8nYmdQ9Hqh/GeE2noga/DJobQOz/NkwROFxkh
 +CrXRPJ8EiTeGdlr/BL9mNLjbhb0yNSTQzCd4WHAy+EO+fQxRaQmKWTgGA0zrmRftI7401o0ReM
 KmU4ogBAnLavLxSJadyq2aZyt+tbee086F5y8R7xhyr5dYUoMgiLS/DtZ9ZPWTB2Lbv2oZsfZd/
 56jDD3fMcdetL9RTk6o5Oe66lhJ2G+P17+b72VyWo1c8D7GivbfBAY44mzoNFp5CMu8/lsjQtml
 TlpgRvvW1RI2KyGxFtw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX2wAOMOX+bPr8
 OE7h506AZgvJ19z8pLIh03g9LzSYlj9Qb6AkMNWM6p34rrInd9HZTJBNaXhTxl5h5gJqgW7qr/r
 RMoeCJr8CKt6qplmB4kZWyoey6a64AY=
X-Proofpoint-GUID: efJEbBTl7iXUdL3vFKtIdO23gJuyoL4r
X-Proofpoint-ORIG-GUID: efJEbBTl7iXUdL3vFKtIdO23gJuyoL4r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130054

Revert the changes made for signature verification in cb481e59ea6c back
to the old behavior where effectively the params->in2_len was set to the
length of the user provided buffer uparams.in2_len (out_len is an alias
for in2_len due to the union). We cannot use the max_sig_size in the
case of signature verification since this is neither the true size of the
input buffer nor would it pass tests of size indicators found in the ASN.1
in the buffer comparing against the input buffer size.

Fixes: cb481e59ea6c ("KEYS: fix overflow in keyctl_pkey_params_get_2()")
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Florian Bauckholt <florian.bauckholt@cispa.de>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/keys/keyctl_pkey.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
index 15b6bf6399b5..794fa3d01911 100644
--- a/security/keys/keyctl_pkey.c
+++ b/security/keys/keyctl_pkey.c
@@ -160,7 +160,7 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
 		    uparams.in2_len > info.max_sig_size)
 			return -EINVAL;
 
-		params->out_len = info.max_sig_size;
+		params->in2_len = uparams.in2_len;
 		break;
 	default:
 		return -EOPNOTSUPP;
-- 
2.56.0

