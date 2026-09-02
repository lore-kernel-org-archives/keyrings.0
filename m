Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE284ADD90;
	Wed,  2 Sep 2026 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788387895; cv=none; b=gGJnHI/xwl7BL2Mlcu337jbrSXXX0hIl1tAX6XE0q/K3DpuCkiZB8ISIX6PyfSSYw5/uDVppTEQ4dc3Nf+5gdXpzAKxD5+FolxCDLwB9YxaRhq5LzjmiCITbG2MlzWxSunHbLKkYvxkYtMXsaADaJQeZh5KmPDCx4W9C5wis3BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788387895; c=relaxed/simple;
	bh=D6bkpoIpcIYOnZZyO6lK4ItdOwuknHRlO1Z8sHXjL6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AP8epyQOCcV0rZwrGYow22L6YGfSBiBaoH8j5Eo7HuCwjLSmTMtqDw2O8Ub65Qi2o4ywXAqvYRFR2ABUvhhg/vdp7RpsHkJ1aDzkEB8tLsy3wacZZ7+MuscMp8iAccZg351L8Tofazu6Ef0HG+/kJz8g02OzVyJtLuTQO/NFAm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X4Vu2QtD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X4Vu2QtD"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682KVV4u3367009;
	Wed, 2 Sep 2026 22:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jxIqqe
	Ksku6ms7BZZ9tYTyFuKkIPq5UjiX6SWrdx6hk=; b=X4Vu2QtDEpA7K9cWhaKhY4
	Z6PJzwo+j71oQttr8O2b7fuY4p/1nLwsaHCreY/M1XGAxiWFROOsAg/gEVPDZRA0
	g2NmOFvu7v+shALYBhI9RuOYD8fRPkez/SZqYJp0gN6ZJM0tqfpDuR7jhM3Feywx
	wrfePnmWoR2IU6H2doo6kPT0IEQmgQh0AX+zrObeOjDChW0CYr4EmYXLkWP3yWDm
	dYxg0mQAZHPs9PKv3EraJUDRU57AaCDaCeNTiNIsan8B4OGL8QxQ7YAQBI8i+4Do
	VzJm4tyxy11j1GJcYhsmurc1vThUbsfWLB4Z7BMlCw4IQ5OQwYUKPCoXjGy5pe3Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3rhua9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 22:24:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 682LuY4W030585;
	Wed, 2 Sep 2026 22:24:43 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gecjan46x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 22:24:43 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 682MOgwR19989100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 2 Sep 2026 22:24:42 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 630A758056;
	Wed,  2 Sep 2026 22:24:42 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9959E58063;
	Wed,  2 Sep 2026 22:24:39 +0000 (GMT)
Received: from [9.67.98.186] (unknown [9.67.98.186])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  2 Sep 2026 22:24:39 +0000 (GMT)
Message-ID: <b2d390dd-3ba0-4faf-967b-d1188da12e62@linux.ibm.com>
Date: Thu, 3 Sep 2026 03:54:38 +0530
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] keys/trusted_keys: return immediately after TPM
 unseal failure
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com
References: <20260902103120.222326-1-ssrish@linux.ibm.com>
 <20260902103120.222326-2-ssrish@linux.ibm.com>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <20260902103120.222326-2-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a98a22d cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Y-y2Im-bRa9duunfRGsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE5NSBTYWx0ZWRfX3PxBAJMX5NU1
 YKCe2YMNrQeY54PsYfBlvCKv28mWayPk8iRBmEnM1baoCAtPfuvoXn30rYRGAK7fQ7QD4mLJCeD
 SB8H6xRe3NCmJjFH2jslQUVos+NNZ4EtxiRTg8aj/Pbq9DnCHUDFJtifPovPeZ/GLAeXom2j15t
 grt9Xs9iWn8rp47FzBwCFIv43r1KqFJe+HugzZ/vKlA6e3HKrg3E1WvMwmEIUQ8gnKXEpRSK4Eb
 upVIaxDHUpi9Mg9elYidDWX5CgqBFBw4iG/X+L3rMYhSW961l2W+I/LEOahO6Oqbxi9BFNEkp7Y
 fda7IYZ4B+1G5ok039CmzVSjne7puMG4yHJDoHFvL97xAulwXVKvnJSvNsgr07Gk/ojvbHYpI5Y
 Lh66xFuN2aXm3Oy3r4nmWILRWfMam07vXrtRsG4lQoMLZXrMGnbrPEym3ad67+aqWpYxEZfBA3/
 6I9MmMoTvcu5s8NafGg==
X-Proofpoint-GUID: a4VYTaxDfaTffOkljByhbbMBZnHapPtp
X-Proofpoint-ORIG-GUID: a4VYTaxDfaTffOkljByhbbMBZnHapPtp
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE5NSBTYWx0ZWRfXzGkBGzAc61jh
 MEFbVliPiV+D965upWYoi/s6Ena9FYRLqig6LuTdPpAYENTmWUfBDAqM2oAxi0MxNkhfcFX6wX1
 6JkTIRUlsONS7vN8VAoJehHVt3vKjaY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_05,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020195


On 9/2/26 4:01 PM, Srish Srinivasan wrote:
> trusted_tpm_unseal() proceeds to pcrlock() when the TPM unseal operation
> fails. If pcrlock() succeeds, its return value overwrites the unseal error,
> causing key instantiation to succeed.
>
> Return immediately when unseal fails to preserve the original error.
>
> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> ---
>   security/keys/trusted-keys/trusted_tpm1.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index bf0bf7f36970..1168ca235205 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -923,8 +923,10 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
>   		ret = tpm2_unseal_trusted(chip, p, options);
>   	else
>   		ret = key_unseal(p, options);
> -	if (ret < 0)
> +	if (ret < 0) {
>   		pr_info("key_unseal failed (%d)\n", ret);
> +		return ret;


This should be "goto out;"
will fix this in my next version


> +	}
>   
>   	if (options->pcrlock) {
>   		ret = pcrlock(options->pcrlock);
