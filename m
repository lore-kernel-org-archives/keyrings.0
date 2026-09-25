Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3206F4C0420;
	Fri, 25 Sep 2026 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790349161; cv=none; b=N0Gah9a9bNQpUk7eFC9ACNrLyzpraibv89VQjSJiEWzmLtqcAuKYnm561DYinZSfuvjji/JyJJIXr82MndtLHmjTl8hGTAQpK7GW5GhXS+52q7Q40vDb3wkyg+pX0b7ropiDoJ1Xx5KRKe+wSNwmbg+ZTSlQ7DQwZscLM5z8/90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790349161; c=relaxed/simple;
	bh=2elrDbX/NlXH7RzOPTvy8hlhrXvGNVJvHgVuv6UCe74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ko5myFXk+4zwiBQ72I30RbXaVFgiEe7HcRFyHupwXxpGfH2kURJdp3rle+bSshsnFt39FdCp7VgruGQAkNLrpHiwTfSCz5FVCTrt3yLMBsdgidBNtLmEU1Quj7TLI8ubRSGTRLsa46hSlDNrYKnGySgva42W3k6umZOn63+Rbdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S+CxK6y6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S+CxK6y6"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4a55s2393056;
	Fri, 25 Sep 2026 15:12:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mP/Kai
	p5jZa3Z7/p9TCf8x+xaNOHNLRwsB4L6MUYeKw=; b=S+CxK6y6NiKmVB9CEq197o
	oiaS6Ar9TLggDHiHtzRwHhhPXQuxGqah6wJ9H0sPZqirqxw13NZYAwg5+YT/EKNf
	sr5DAlQsnQKFKSRC0/OU7kggvUFeMPacAmf/3QC+AR0RMFUVKlnt54bQoS9GvFSe
	rFGeXB3IGhu+oUnebWNm+4TXlEk+IEemOxHNJxsnt7Wh3+jRszkbrHAc8eAKA9rd
	+3a7WET+VOZlUpJ2Xj8VEztBgt520VYuAyAUgov7Dj+pQdcr6CuICmGLZi0/v3VI
	1CUpRzh1dGo0jSAuP0WpuNpbBaZK1aSnPQ7zhBFYL31ofmR/14KPqxbDG3AkCvXg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske27r8k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 15:12:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PF2GPF3298398;
	Fri, 25 Sep 2026 15:12:23 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8k2whh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 15:12:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PFCLFS28181200
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 15:12:21 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B77FA58059;
	Fri, 25 Sep 2026 15:12:21 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B27CD58063;
	Fri, 25 Sep 2026 15:12:16 +0000 (GMT)
Received: from [9.67.80.68] (unknown [9.67.80.68])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 15:12:16 +0000 (GMT)
Message-ID: <bec84181-565a-478e-a485-7f63819024cc@linux.ibm.com>
Date: Fri, 25 Sep 2026 20:42:09 +0530
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] keys/trusted/tpm2: Validate TPM2_Create object sizes
 separately
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
        stefanb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com
References: <20260910100222.247529-1-ssrish@linux.ibm.com>
 <aqydqxpVmp67kTQO@kernel.org>
 <e05d8ca7-ac48-47ef-bc47-bef5b22cb723@linux.ibm.com>
 <arZZTGtmo1ZLit0j@kernel.org>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <arZZTGtmo1ZLit0j@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: cw5-dJcHoqIW8XebBrAdJKZ_3qTipvlh
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab68f58 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Zt5nyZx9-DG17LY-_NgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfXzFrCzH7gRpsb
 0ybFv/occYpLflRqAi2tCtn+oazNKjNAegH5jCrbez/mhvpCRe3u8FL4zxUp84CmHHBk1whc9AN
 yQ3+rd+I7lYJti3VCWlvFezMqk14L4k=
X-Proofpoint-GUID: cw5-dJcHoqIW8XebBrAdJKZ_3qTipvlh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MCBTYWx0ZWRfXxkV2MVsuuRI+
 7kA05eSKDyqA4PDAc6HX00Rb4A4diuBmgihelYIeZ0J4beMje8hMspy/Af90+ZSMyVVO1YnGnSJ
 z0v1VpCUbfM1HkrcEx/FPCapYjWA2JRSBdurHkkmUe57V66zGj9C1JxITgv+k/nBbgqbHpYm5zh
 jZLoD4I6reFQsXvY8h47lh2l2PfdzSC7FJsXKkrODj+IoGUxTl86oqRvev0CAnGWn2dCYmZpOL2
 9Baatinq/5ijgZTdAOyUEVNLp7oNP+GdWUEamOMrSWLvK9SitlKZ7VjrrsUNw7aBciJMCgk7+hn
 nxaJhAn2BJmulNeUgMYcukopt2UhClzh3WBgsV/9sZrX0RDtH5nULlZD6vDxtAHAjNrVh95FEo9
 KKcPjXjh5B+Fnsihpo4fwMIwijyX1AKcOp9VFuF8w6YeZRHWsuxcSWfVZ67UzcyFljwSPbOQ6YN
 fmGo6cLQE8mIHEdFMeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250060

Hi Jarkko,
Thanks for taking a look.

On 9/25/26 4:51 PM, Jarkko Sakkinen wrote:
> On Fri, Sep 18, 2026 at 12:18:25PM +0530, Srish Srinivasan wrote:
>> On 9/18/26 7:40 AM, Jarkko Sakkinen wrote:
>>> On Thu, Sep 10, 2026 at 03:32:22PM +0530, Srish Srinivasan wrote:
>>>> TPM2_Create returns outPrivate, outPublic, creationData, creationHash and
>>>> creationTicket in its response parameter area. However, only outPrivate and
>>>> outPublic are included in the trusted key blob. The size of the blob is
>>>> therefore not determined by the size of the complete response parameter
>>>> area.
>>>>
>>>> tpm2_seal_trusted() currently compares the size of the complete response
>>>> parameter area against MAX_BLOB_SIZE. This can reject a valid response
>>>> when the remaining response outputs cause the entire response parameter
>>>> area to exceed MAX_BLOB_SIZE, even though the outPrivate and outPublic
>>>> TPM2B structures consumed by tpm2_key_encode() remain small enough to be
>>>> encoded in the key blob.
>>>>
>>>> This is observed when creating larger trusted keys using an swtpm TPM 2.0
>>>> emulator backed by libtpms.
>>>>
>>>> For example, requesting a 113-byte key succeeds, 114 fails.
>>>>
>>>> ~$ keyctl add trusted trusted_key1 "new 113 keyhandle=0x81000001" @u
>>>> 520504613
>>>> ~$ keyctl add trusted trusted_key2 "new 114 keyhandle=0x81000001" @u
>>>> add_key: Argument list too long
>>>> ~$
>>>>
>>>> Remove the MAX_BLOB_SIZE check on the complete response parameter area.
>>>> Instead, use the response length passed to tpm2_key_encode() to validate
>>>> that the outPrivate and outPublic TPM2B structures are fully contained
>>>> in the response before accessing them.
>>>>
>>>> Previously, a response parameter area larger than MAX_BLOB_SIZE was
>>>> rejected with -E2BIG before ASN.1 encoding. With this change, if the
>>>> resulting encoded blob does not fit in payload->blob, the error returned by
>>>> asn1_encode_sequence() is propagated instead.
>>>>
>>>> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
>>>> ---
>>>> Changelog:
>>>>
>>>>    v2:
>>>>     - Exclude a comment pointed out by Jarkko
>>>>
>>>>    security/keys/trusted-keys/trusted_tpm2.c | 35 +++++++++++++++++------
>>>>    1 file changed, 27 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>>>> index 01f18bb37047..cbec4f591952 100644
>>>> --- a/security/keys/trusted-keys/trusted_tpm2.c
>>>> +++ b/security/keys/trusted-keys/trusted_tpm2.c
>>>> @@ -24,24 +24,42 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>>>>    			   u8 *src, u32 len)
>>>>    {
>>>>    	const int SCRATCH_SIZE = PAGE_SIZE;
>>>> -	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
>>>> -	u8 *work = scratch, *work1;
>>>> -	u8 *end_work = scratch + SCRATCH_SIZE;
>>>> +	u8 *scratch;
>>>> +	u8 *work, *work1;
>>>> +	u8 *end_work;
>>>>    	u8 *priv, *pub;
>>>> -	u16 priv_len, pub_len;
>>>> +	u32 priv_len, pub_len;
>>>>    	int ret;
>>>> -	priv_len = get_unaligned_be16(src) + 2;
>>>> +	if (len < sizeof(__be16))
>>>> +		return -EFAULT;
>>>> +
>>>> +	priv_len = get_unaligned_be16(src);
>>>> +	if (priv_len > len - sizeof(__be16))
>>>> +		return -EFAULT;
>>>> +
>>>> +	priv_len += sizeof(__be16);
>>>>    	priv = src;
>>>> +	if (len - priv_len < sizeof(__be16))
>>>> +		return -EFAULT;
>>> This caused for me some head scrathing tbh.
>>>
>>> See:
>>>
>>> 1. len >= 2
>>> 2. priv_len <= len - 2
>>> 3. 2 - priv_len + priv_len <= 2 - priv_len + len - 2
>>> 4. 2 <= len - priv_len
>>>
>>> Is this check required?
>>
>> Hi Jarkko,
>> Thanks for taking a look.
>>
>> The preceding check,
>>
>>
>>      if (priv_len > len - sizeof(__be16))
>>          return -EFAULT;
>>
>>
>> ensures that the complete TPM2B_PRIVATE, including its size field,
>> fits within len. After this check, priv_len is incremented by 2 and
>> therefore represents the complete TPM2B_PRIVATE length.
>>
>>
>> The check you pointed out,
>>
>>
>>      if (len - priv_len < sizeof(__be16))
>>          return -EFAULT;
>>
>>
>> then ensures that at least 2 bytes remain for reading the following
>> TPM2B_PUBLIC size field.
> OK, maybe I got something wrong in my deduction but I'm not
> still entirely sure whether this is leanest way to do these
> checks.


Sure, I will simplify this. Would the following be better?


     if (len < 4)
       return -EINVAL;

     priv_len = get_unaligned_be16(src) + 2;
     if (priv_len + 2 > len)
       return -EIO;

     priv = src;
     src += priv_len;

     pub_len = get_unaligned_be16(src) + 2;
     if (priv_len + pub_len > len)
       return -EIO;

     pub = src;


The first check ensures that len can contain both TPM2B size fields.
The second verifies that the complete TPM2B_PRIVATE leaves room for the
TPM2B_PUBLIC size field. The final check ensures that both the complete
TPM2B_PRIVATE and TPM2B_PUBLIC structures fit within len.

>
> I'll iterate some other remarks so that this can move forward.
>
> I was not either entirely sure why this was done:
>
> -	u16 priv_len, pub_len;
> +	u32 priv_len, pub_len;


Yes, so the change from u16 to u32 was because the values stored in 
priv_len and
pub_len include both the 16-bit value read from the response and the 
two-byte TPM2B
size field.


>
> Why wrong len causes -EFAULT and not -EINVAL? EFAULT is for
> memory failures. Probably two that follow should return -EIO.


Agreed, I will fix this.


>
> One more that came to mind:
>
> -	priv_len = get_unaligned_be16(src) + 2;
> +	if (len < sizeof(__be16))
> +		return -EFAULT;
> +
> +	priv_len = get_unaligned_be16(src);
> +	if (priv_len > len - sizeof(__be16))
> +		return -EFAULT;
> +
> +	priv_len += sizeof(__be16);
>
> Removing the line above is not necessary and neither is the last
> the last statement if you just change your check accordingly.


Yes, that's right. And I have made this change in the diff
that I have pasted above.

Please let me know if this looks better now.

And, thanks for the feedback.

>
>
> BR, Jarkko


Thanks,
Srish.

