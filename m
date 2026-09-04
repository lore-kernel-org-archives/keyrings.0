Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76783ECBCF;
	Fri,  4 Sep 2026 06:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502423; cv=none; b=GCTa6pCvXSy6T/S4TbK8NZx4WwP/NYD9KmESx0ZSAlYTND93qJoVtF/MdAk4o94TC6wtYfUIRq6cwiw3ToIqTZsmQ1WqkYBIiXURzOWUqDl4QESNCX932dFfFBCjG+jOsQ6Pej+zDxKSNjG4/eOQr4n3k1QbEdncLEMtFAfrDAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502423; c=relaxed/simple;
	bh=adMK/Wxbt1OgPGIFVMT0FK7zRuOmnvONKI5RSaumWRM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WGgNkwyWjlVyZK9YPlcSBNawbLRu+GIVsm7sxtFrG4Wpc/gHSKT1K7OM0IahIV+3MzM4tsb1NIjduu3m6wBnq4hddWTe6IQ5dW8AR1t6uGtKyQIT3sSHKsIh/JDqiO6ivqQUWFagWmQ477sEft0UOzlNyTCwL6g1nCShrx4epzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oxjsSuJd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oxjsSuJd"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464hWB815320;
	Fri, 4 Sep 2026 06:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6n1JxR
	uSL8vaIscXA3VKgpNWi7ByB64W0wt/XykGF/k=; b=oxjsSuJd7cfTloEQXqJG/r
	HDwiL1BJ+1e3DjuX3UWdX4cRNTZ9Skc8wy+XRM9Vwx2uNiDRaOzkLYQvL+quVu2t
	IemwploS0SUECVEv8i5M8NkP5bp83G/+LbovLbZulFdDKRXKYbLstz+heCuEI7w+
	PeOMfhJQeWHhwyjgfOHbM50Y/cnd2A0opVdG//MHymiV+wY+06qfQHBshbeYYwCy
	KSJ8fLodoLW0Ivw5LbiIuQqHbRIf940j2/nBX9G20e7xGDbIa78VeAyqKc8tyd18
	DhrAgFykrb3CdwD8tAsLWlPWle/2TY3/FVVy+1F/FR3KvRu4hmrfh69zUR3eU6nA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuj8q78-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:13:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6846BikZ023276;
	Fri, 4 Sep 2026 06:13:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rqup4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:13:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6846DMCd30737110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:13:22 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B88D820040;
	Fri,  4 Sep 2026 06:13:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89B7920043;
	Fri,  4 Sep 2026 06:13:16 +0000 (GMT)
Received: from [9.61.247.46] (unknown [9.61.247.46])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  4 Sep 2026 06:13:16 +0000 (GMT)
Message-ID: <5eff9ad8-a772-429a-b313-b1bf3571206b@linux.ibm.com>
Date: Fri, 4 Sep 2026 11:43:12 +0530
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/10] pseries/plpks: rename the default wrapping key
 macro
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com
References: <20260831111738.334857-1-ssrish@linux.ibm.com>
 <20260831111738.334857-6-ssrish@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260831111738.334857-6-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: qQXQqPVto-QjaQ-JmTFPCZ0s9scTMzxH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfXz9yZmZHQ50jJ
 ggaLMrl10AUoSGhPQ9qp4/Zp2Bh8pg2QVOh2qnHPwTVX+uDkfGdzhzOPFblrDcUcuArBn/0Y1M0
 BuTVWU7fcd4YDHmAT6OBFGkWHIvZU3fkaiDY273hPbVVsBdoxgK8nUW/WEtzutQJKAiOkR9N9cE
 gPf1BA/sOOY5Qw85SObp8X4tRX8jJx0asEowu98RQL68hKnnju5OHlG+Lgu8Ke0MTHFPCwJn2nk
 c9dX8rdG0vBnFzzj095fI/nM3BnP7hRuhBqK3HBuYls3+CKcMBQJWBSVoIM2XjpzG41P6bDseyH
 HXm1ak2VfxdrOENpvfBHyCLpuDe03AM1J2gIdblCcE7HyG+Fm9Fby4N6zto5ar1mIOSv24CY0I2
 hv9L/DxDbHBx+0QWuD/RJxrdcD2OlNjihj8c+F/axciHYpSjHMuVE1wz7tu1GYv7VTD5RqSK0WA
 Ni8jizfzUcZuIv6QTnw==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a9a6187 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=3Kc4Bribtl25CmZOErgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX2Jd7gKuVHjbQ
 +1vmSVtFKy9HP0suNG2lyWImTd88GKX7RJSgOzZ8n+C0q4cctNEA0lJE2an8/WS4WmC0Y5/3Yi7
 ogTUaZWzw5+yeZkS+/IHVkHYp0Zg5Y0=
X-Proofpoint-ORIG-GUID: p7HtDouQjYyjllcRxaW5zj0nA3fyakWH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040054


On 31.08.2026 4:47 PM, Srish Srinivasan wrote:
> Rename PLPKS_WRAPKEY_NAME to PLPKS_DEFAULT_WRAPKEY_LABEL to clarify that
> the macro represents the default wrapping key label used by PKWM.
>
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

Tested on ppc64le PowerVM LPARs on firmware with wrap/unwrap support,
with and without Secure Boot enabled.

Verified that PKWM initialisation and trusted key seal/unseal continue to
work correctly after the rename.
> ---
>   arch/powerpc/platforms/pseries/plpks.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
> index 45278c5a45c1..b553f7b130b6 100644
> --- a/arch/powerpc/platforms/pseries/plpks.c
> +++ b/arch/powerpc/platforms/pseries/plpks.c
> @@ -10,7 +10,7 @@
>   #define pr_fmt(fmt) "plpks: " fmt
>   
>   #define PLPKS_WRAPKEY_COMPONENT	"PLPKSWR"
> -#define PLPKS_WRAPKEY_NAME	"default-wrapping-key"
> +#define PLPKS_DEFAULT_WRAPKEY_LABEL	"default-wrapping-key"
>   
>   /*
>    * To 4K align the {input, output} buffers to the {UN}WRAP H_CALLs
> @@ -938,7 +938,7 @@ int plpks_gen_wrapping_key(void)
>   	struct label *label;
>   	int rc = 0, pseries_status = 0;
>   	struct plpks_var var = {
> -		.name = PLPKS_WRAPKEY_NAME,
> +		.name = PLPKS_DEFAULT_WRAPKEY_LABEL,
>   		.namelen = strlen(var.name),
>   		.policy = PLPKS_WRAPPINGKEY,
>   		.os = PLPKS_VAR_LINUX,
> @@ -1033,7 +1033,7 @@ int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
>   	bool sb_audit_or_enforce_bit = wrap_flags & BIT(0);
>   	bool sb_enforce_bit = wrap_flags & BIT(1);
>   	struct plpks_var var = {
> -		.name = PLPKS_WRAPKEY_NAME,
> +		.name = PLPKS_DEFAULT_WRAPKEY_LABEL,
>   		.namelen = strlen(var.name),
>   		.os = PLPKS_VAR_LINUX,
>   		.component = PLPKS_WRAPKEY_COMPONENT

-- 
Thanks and Regards
R.Nageswara Sastry

