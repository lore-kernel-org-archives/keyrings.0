Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF84E3D7D8D;
	Fri, 18 Sep 2026 04:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789705407; cv=none; b=COG2mJiTcSfVphccREIevd8wFwf+dp88oFg7mJOCReIm8KIMkASsmzt7jG8286uiOPcMNo8arUlEqDLoBPlL2sOix4LPp4wbgBsvtdzZudJSpMROXK+7mupuaeYAjMUXXKSsCujErtiMt/XmVb7J5GxwOkpC0+TNhrtf8vxmdVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789705407; c=relaxed/simple;
	bh=OYFLYzs65zTf5R7l1QWHf22dliRj+0HvzsvQGF6Q7FA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u1PkNAvcYEPqZ5CnhSRzZ3/w9iHTTYtIdIZ3rptzdtAQLCIESD3/EkG6Mi8cgU8sfaCQZsLXdjG6fnf5A5Lq/Ic6pXwR+ArVx0kNyix1CXYlqOxXlaZVJ9d/wAb+QaIAsYEj5yXS7M+fIBVeLIgk4zFT8PjICcbMGBNpW0ibHoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e9X4JR1v; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e9X4JR1v"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I2VZMX042853;
	Fri, 18 Sep 2026 04:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZmvDdD
	7G2DURdy007nTdLCWSY9iH77w1BX+yQJIUAL4=; b=e9X4JR1vlc0A3J50feqYUD
	GS0B1SBZaET1GXcNTdxg0/1/s7sknTinA0n21g3RmdRRoAUgmp4RX23dT2eWPa+J
	ynxUCQqjvko3X1VMu+1WZlpaEQpIbX03x2Sf5r44yiiO/Tx3o5H4EeRgjgENdUYW
	TmW8RFFIU+qVODruPAn8E6Lmqv94bZiCiP5piDobeTKv85jAssAXr0lu+eryTJxg
	KPWvZfQqmO2ofGapSBna2OCA5jubw0X6Npabql9bWgswb7ljaLyUyedoIUCuDMIy
	WIVUO3u/FLJuWpl+qc4wzGuQgG5GNb4DjmfvGiRJe01Jnranfy7Ww4ggo7fxKJcA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmx84652h-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 04:23:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I2ZKbU918969;
	Fri, 18 Sep 2026 04:23:19 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gr7gen9j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 04:23:19 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I4MYRR6816288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 04:22:34 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1476658065;
	Fri, 18 Sep 2026 04:23:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7C9458068;
	Fri, 18 Sep 2026 04:23:13 +0000 (GMT)
Received: from [9.123.14.23] (unknown [9.123.14.23])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 04:23:13 +0000 (GMT)
Message-ID: <31c1533f-7d2a-448f-a929-6fefe976de69@linux.ibm.com>
Date: Fri, 18 Sep 2026 09:53:12 +0530
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/2] Move TPM-specific fields out of
 trusted_key_options
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
        stefanb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com
References: <20260912062950.279104-1-ssrish@linux.ibm.com>
 <aqyeGbZKvLxaDwju@kernel.org>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <aqyeGbZKvLxaDwju@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA1MCBTYWx0ZWRfXx553KlEFs+EL
 77xN3bD6j5FSr3IQqWtCbXUrNlH0Zb6pZD39cuwbSPlxnK0/819ndZyx5xCknHx2YIiFxSdIohW
 yioz9KzzeJBALg8zMnQtlil+Rbpj3e59akiTf3Gg5Owt79bn81OtgrAF0KR6aVyYRPUKPRjOt/f
 pJK7wwmreBXfxX0e3IEffTsw1x9boRVBf3Eb6HDaJVptQB9QmZ8yKpBp85BgLnmWyRgX9b6DWuH
 ObZW1STejcdFJfu/swp/IlyVYhVp/1r8HKhHWqYbRvW4dI2S8wNw1mJ7nJYAFVIZR+HA56WYlHZ
 euLrUgQLImGPY/MfBbu+9BuMhTGzjmfUd2J9qdJI4OYmD8zIEJyTPM1js6VXIqHBA6BcpsomU/M
 z6Voh+ukTMwH4Eye3zpRQmiKAJaIz/uydCTqN8UWOHDTQmRlnhWczfgQJmlnGCl5bHB+oW+eBKS
 Rfafr3wJ0v3VJFxf4vw==
X-Proofpoint-ORIG-GUID: aLL5uXhr3XhPB-GJ-HsF_BWYGRVHovHg
X-Proofpoint-GUID: aLL5uXhr3XhPB-GJ-HsF_BWYGRVHovHg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA1MCBTYWx0ZWRfXy+dzJD1tkOV0
 utqHG+bLoRRraRkjJalRubuSRdP4n8PgHsrxkA13FEbZGVYSBmL1l1WZk4fB65t2EOnIB6jQi3N
 u+YLcT8+2GEdMnGt+pxdi5SnYOGFZqk=
X-Authority-Analysis: v=2.4 cv=cY9HPXDM c=1 sm=1 tr=0 ts=6aacbcb7 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=m1BUU5f1b-1mlk2DMncA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_01,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180050


On 9/18/26 7:42 AM, Jarkko Sakkinen wrote:
> On Sat, Sep 12, 2026 at 11:59:48AM +0530, Srish Srinivasan wrote:
>> struct trusted_key_options contains fields that are specific to the TPM
>> trusted source, resulting in the accumulation backend-specific fields in
>> the generic options structure.
>>
>> Move the TPM-specific fields into a new struct trusted_key_tpm and store a
>> pointer to it in the private member of struct trusted_key_options.
>>
>> As a preparatory change, return immediately after a TPM unseal failure to
>> prevent pcrlock() from overwriting the unseal error.
>>
>> Changelog:
>>
>>   v9:
>>    - Resent the full patch set with consistent v9 subject prefix
>>    - Corrected patch 1/2, which was sent as v3 in v8, which caused b4 to
>>      flag the series as incomplete
>>
>>   v8:
>>    - Rebase onto commit
>>      adc6a9f6d997 ("KEYS: trusted: Fix tpm2_load_cmd() boundary check")
>>      to resolve the merge conflicts
>>    - Include Jarkko's Reviewed-by tag
>>
>>   v7:
>>    - Fix a memory leak in the preparatory fix
>>
>>   v6:
>>    - Add a preparatory fix to return immediately after a TPM unseal failure
>>    - Replace explicit cleanup with __free(kfree_sensitive) in the TPM seal
>>      and unseal paths, as suggested by Jarkko
>>
>>   v5:
>>    - Rename struct trusted_tpm_options to struct trusted_key_tpm, as
>>      suggestedby Jarkko.
>>
>>   v4:
>>    - Rebased onto mainline after tpm-buf memory-safe allocation changes were
>>      merged
>>    - Resolved the resulting merge conflicts
>>
>>   v3:
>>    - Exclude the preparatory clean up patch as the problem has been
>>      addressed in commit
>>      9ec4175a30eb ("KEYS: trusted: Debugging as a feature")
>>
>>   v2:
>>    - Exclude the bug-fix patch as it has already been applied to 6.19-rc7
>>    - Rename instances of trusted_tpm_options from tpm_opts to private
>>    - Use pr_debug and KERN_DEBUG for logging debug messages (preparatory
>>      clean up patch)
>>    - Address other minor comments from Jarkko
>>
>> Srish Srinivasan (2):
>>    keys/trusted_keys: return immediately after TPM unseal failure
>>    keys/trusted_keys: move TPM-specific fields into struct
>>      trusted_key_tpm
>>
>>   include/keys/trusted-type.h               |  11 --
>>   include/keys/trusted_tpm.h                |  14 +++
>>   security/keys/trusted-keys/trusted_tpm1.c | 125 ++++++++++++----------
>>   security/keys/trusted-keys/trusted_tpm2.c |  50 +++++----
>>   4 files changed, 113 insertions(+), 87 deletions(-)
>>
>> -- 
>> 2.53.0
>>
> I applied v8 already. Please check from my tree whether this needs
> reapplying or not.


Hi Jarkko,

There is no functional change between v8 and v9.

As per 
https://lore.kernel.org/all/aqR1vX9u209mCHsq@kernel.org/#:~:text=ERROR%3A%20missing%20%5B1/2%5D!
v8 did not apply cleanly as I got the versioning for patch 1/2 wrong.

I fixed that problem in v9.

>
> BR, Jarkko

Thanks,
Srish.

