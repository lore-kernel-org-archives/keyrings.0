Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E162E762C;
	Sat, 26 Sep 2026 04:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790395476; cv=none; b=g0LssC4Qk2nb3oMIpFNoYXQbWfMNIcVujaJgadLC3hI6SMJ3z+WCdKQOQayTWucPvSB/bMp07SZeJl1h1w9Ex/W0xJundtZOccP2VA6uHLro3rne/M4YVT+9gGbXdHdt33r9KnOP/BqZxIbdFBqe5Lqgn9JHlnQWPuf+waTMlRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790395476; c=relaxed/simple;
	bh=4GYGkVQ1tFRPffJavRRjf0oPhQOylT5XbN92s4E+vR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ESv4FSMZe7NPs6ZYpl34GzrOPt8gMv5JyNTSefOJh+EtA2v5i5cYKOjJkLrYAdUgSrcFEc0IIOpWAatGOXue2lqtFy5Eews0Q/B21xCAbZmtiIsGMua0ePnqiTk+6/fXZ8+HHB+nYJk4NY2cdeQV1fddtov/LFJkZYyeoHjm12Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DWH4AiEI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DWH4AiEI"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68Q3ZZ7g2885730;
	Sat, 26 Sep 2026 04:04:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=abH1CK
	xNqijdXYE2eZz9QEq28Sz1CmmGyIC6Xp2jZes=; b=DWH4AiEI5MXf+Itkr6zDHe
	t+qIN0JCJmk61HMscT3S3gjCwTeqhxUm+QHVP3AUZ2JAQUyb4Pjps2eezPaVH081
	luDZRdNqkAeDk2zfeQz8ywZkueWVK/p2yx7WyUhKr5BGnM2xSlQHkNOziCJFWZuA
	A8JjqsEwurDsk3K7A63PXdi7DUEeODtxGRbTvyUod8q3caAemn9BoY5uGMbQV7Qm
	dYRckgh3uggUIwCNuteQxn/FG/Nf70AIsymkzIRB4oajOTKjzz1vb4M1S+DlQFmj
	21+Yahrq2PDxvNs4CtjPyIL4V2/66iqGiirTjVij9E4EgRC4GQf6zTi6Xw6i/zQw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j4r6b4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 26 Sep 2026 04:04:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68Q3HVWd717099;
	Sat, 26 Sep 2026 04:04:30 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gwy279avc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 26 Sep 2026 04:04:30 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68Q43ieG58196268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Sep 2026 04:03:44 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C3AF5805F;
	Sat, 26 Sep 2026 04:04:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55A485805C;
	Sat, 26 Sep 2026 04:04:25 +0000 (GMT)
Received: from [9.67.86.75] (unknown [9.67.86.75])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 26 Sep 2026 04:04:25 +0000 (GMT)
Message-ID: <1c97a5ff-731b-49aa-83ba-2824ad4b7c75@linux.ibm.com>
Date: Sat, 26 Sep 2026 09:34:24 +0530
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
 <bec84181-565a-478e-a485-7f63819024cc@linux.ibm.com>
 <arb5XnpAHe3SZEfv@kernel.org>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <arb5XnpAHe3SZEfv@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDAxNCBTYWx0ZWRfX8r9Jkl3OpwFX
 N//SeU8f3q0J5Wmx8RDgjbo/lN9hgrmmpC8J9MKyIMwfosQ7nAklwxB4BaGvKnsOucTNyOnvgeD
 crDEW07RNk3np9Bt9Plt0xyISRAANYY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDAxNCBTYWx0ZWRfX4aecbsj6hpqI
 pO1NMC+2pHI5caRKAG5YnisMsOgsxPCbE694Mu89nnuAIuc3qDv3NY4tA4PqvpulzlHaaWT3Vxa
 VNWMmmJ094JPxMpD9UVR3GGx0Ms9bYyg3GnY6n026cklBgnYmSIGhfJZ6VEjXSGMuBCpv62w7WN
 d9d1lE0YzOs+aDtC7hBPIGvXJUgFcAniBjRZOvEqdnkctqrR/Ld5dBgrSfA1yuEV5ekXiIuUMJG
 gp9sr3eKy6/sidtFl45LvrGrq9y0vJ5PdAgRbDrjGaXCX8EtQ4XmnMAmAG4wmz/L+tjiJwoYjsJ
 BQZL5+NBoS4kpGhyjenAq2kShgBLH0buir/z+tT6trQQljF+t9uYSx52eMBb57GomELw+poriq7
 SOYc/5I1A3tIEC9Hgjef5kXMswzvzpwF68bxRTMdVQAJcMwWZ8WKtOn+SUjTtJ1kDSdqqiKTEUG
 kXLWBigXxVilLA0/6ow==
X-Proofpoint-GUID: PEFUvHYGEQ1Kf9nlXuN4uu7IQdGAmVmR
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6ab7444e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=LXdEIwAnBRKBSfTeCqEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PEFUvHYGEQ1Kf9nlXuN4uu7IQdGAmVmR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260014


On 9/26/26 4:14 AM, Jarkko Sakkinen wrote:
> On Fri, Sep 25, 2026 at 08:42:09PM +0530, Srish Srinivasan wrote:
>> Hi Jarkko,
>> Thanks for taking a look.
>>
>> On 9/25/26 4:51 PM, Jarkko Sakkinen wrote:
>>> On Fri, Sep 18, 2026 at 12:18:25PM +0530, Srish Srinivasan wrote:
>>>> On 9/18/26 7:40 AM, Jarkko Sakkinen wrote:
>>>>> On Thu, Sep 10, 2026 at 03:32:22PM +0530, Srish Srinivasan wrote:
>>>>>> TPM2_Create returns outPrivate, outPublic, creationData, creationHash and
>>>>>> creationTicket in its response parameter area. However, only outPrivate and
>>>>>> outPublic are included in the trusted key blob. The size of the blob is
>>>>>> therefore not determined by the size of the complete response parameter
>>>>>> area.
>>>>>>
>>>>>> tpm2_seal_trusted() currently compares the size of the complete response
>>>>>> parameter area against MAX_BLOB_SIZE. This can reject a valid response
>>>>>> when the remaining response outputs cause the entire response parameter
>>>>>> area to exceed MAX_BLOB_SIZE, even though the outPrivate and outPublic
>>>>>> TPM2B structures consumed by tpm2_key_encode() remain small enough to be
>>>>>> encoded in the key blob.
>>>>>>
>>>>>> This is observed when creating larger trusted keys using an swtpm TPM 2.0
>>>>>> emulator backed by libtpms.
>>>>>>
>>>>>> For example, requesting a 113-byte key succeeds, 114 fails.
>>>>>>
>>>>>> ~$ keyctl add trusted trusted_key1 "new 113 keyhandle=0x81000001" @u
>>>>>> 520504613
>>>>>> ~$ keyctl add trusted trusted_key2 "new 114 keyhandle=0x81000001" @u
>>>>>> add_key: Argument list too long
>>>>>> ~$
>>>>>>
>>>>>> Remove the MAX_BLOB_SIZE check on the complete response parameter area.
>>>>>> Instead, use the response length passed to tpm2_key_encode() to validate
>>>>>> that the outPrivate and outPublic TPM2B structures are fully contained
>>>>>> in the response before accessing them.
>>>>>>
>>>>>> Previously, a response parameter area larger than MAX_BLOB_SIZE was
>>>>>> rejected with -E2BIG before ASN.1 encoding. With this change, if the
>>>>>> resulting encoded blob does not fit in payload->blob, the error returned by
>>>>>> asn1_encode_sequence() is propagated instead.
>>>>>>
>>>>>> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
>>>>>> ---
>>>>>> Changelog:
>>>>>>
>>>>>>     v2:
>>>>>>      - Exclude a comment pointed out by Jarkko
>>>>>>
>>>>>>     security/keys/trusted-keys/trusted_tpm2.c | 35 +++++++++++++++++------
>>>>>>     1 file changed, 27 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>>>>>> index 01f18bb37047..cbec4f591952 100644
>>>>>> --- a/security/keys/trusted-keys/trusted_tpm2.c
>>>>>> +++ b/security/keys/trusted-keys/trusted_tpm2.c
>>>>>> @@ -24,24 +24,42 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>>>>>>     			   u8 *src, u32 len)
>>>>>>     {
>>>>>>     	const int SCRATCH_SIZE = PAGE_SIZE;
>>>>>> -	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
>>>>>> -	u8 *work = scratch, *work1;
>>>>>> -	u8 *end_work = scratch + SCRATCH_SIZE;
>>>>>> +	u8 *scratch;
>>>>>> +	u8 *work, *work1;
>>>>>> +	u8 *end_work;
>>>>>>     	u8 *priv, *pub;
>>>>>> -	u16 priv_len, pub_len;
>>>>>> +	u32 priv_len, pub_len;
>>>>>>     	int ret;
>>>>>> -	priv_len = get_unaligned_be16(src) + 2;
>>>>>> +	if (len < sizeof(__be16))
>>>>>> +		return -EFAULT;
>>>>>> +
>>>>>> +	priv_len = get_unaligned_be16(src);
>>>>>> +	if (priv_len > len - sizeof(__be16))
>>>>>> +		return -EFAULT;
>>>>>> +
>>>>>> +	priv_len += sizeof(__be16);
>>>>>>     	priv = src;
>>>>>> +	if (len - priv_len < sizeof(__be16))
>>>>>> +		return -EFAULT;
>>>>> This caused for me some head scrathing tbh.
>>>>>
>>>>> See:
>>>>>
>>>>> 1. len >= 2
>>>>> 2. priv_len <= len - 2
>>>>> 3. 2 - priv_len + priv_len <= 2 - priv_len + len - 2
>>>>> 4. 2 <= len - priv_len
>>>>>
>>>>> Is this check required?
>>>> Hi Jarkko,
>>>> Thanks for taking a look.
>>>>
>>>> The preceding check,
>>>>
>>>>
>>>>       if (priv_len > len - sizeof(__be16))
>>>>           return -EFAULT;
>>>>
>>>>
>>>> ensures that the complete TPM2B_PRIVATE, including its size field,
>>>> fits within len. After this check, priv_len is incremented by 2 and
>>>> therefore represents the complete TPM2B_PRIVATE length.
>>>>
>>>>
>>>> The check you pointed out,
>>>>
>>>>
>>>>       if (len - priv_len < sizeof(__be16))
>>>>           return -EFAULT;
>>>>
>>>>
>>>> then ensures that at least 2 bytes remain for reading the following
>>>> TPM2B_PUBLIC size field.
>>> OK, maybe I got something wrong in my deduction but I'm not
>>> still entirely sure whether this is leanest way to do these
>>> checks.
>>
>> Sure, I will simplify this. Would the following be better?
>>
>>
>>      if (len < 4)
>>        return -EINVAL;
>>
>>      priv_len = get_unaligned_be16(src) + 2;
>>      if (priv_len + 2 > len)
>>        return -EIO;
>>
>>      priv = src;
>>      src += priv_len;
>>
>>      pub_len = get_unaligned_be16(src) + 2;
>>      if (priv_len + pub_len > len)
>>        return -EIO;
>>
>>      pub = src;
>>
>>
>> The first check ensures that len can contain both TPM2B size fields.
>> The second verifies that the complete TPM2B_PRIVATE leaves room for the
>> TPM2B_PUBLIC size field. The final check ensures that both the complete
>> TPM2B_PRIVATE and TPM2B_PUBLIC structures fit within len.
>>
>>> I'll iterate some other remarks so that this can move forward.
>>>
>>> I was not either entirely sure why this was done:
>>>
>>> -	u16 priv_len, pub_len;
>>> +	u32 priv_len, pub_len;
>>
>> Yes, so the change from u16 to u32 was because the values stored in priv_len
>> and
>> pub_len include both the 16-bit value read from the response and the
>> two-byte TPM2B
>> size field.
>>
>>
>>> Why wrong len causes -EFAULT and not -EINVAL? EFAULT is for
>>> memory failures. Probably two that follow should return -EIO.
>>
>> Agreed, I will fix this.
>>
>>
>>> One more that came to mind:
>>>
>>> -	priv_len = get_unaligned_be16(src) + 2;
>>> +	if (len < sizeof(__be16))
>>> +		return -EFAULT;
>>> +
>>> +	priv_len = get_unaligned_be16(src);
>>> +	if (priv_len > len - sizeof(__be16))
>>> +		return -EFAULT;
>>> +
>>> +	priv_len += sizeof(__be16);
>>>
>>> Removing the line above is not necessary and neither is the last
>>> the last statement if you just change your check accordingly.
>>
>> Yes, that's right. And I have made this change in the diff
>> that I have pasted above.
>>
>> Please let me know if this looks better now.
>>
>> And, thanks for the feedback.
> Yeah, so this is a patch that needs a few iterations I'm not against
> the change itself per se :-)
>
> I think it would make sense to declare "u8 *scratch __free(kfree)"
> while at it so that rollback does not complicate this function
> further.

Hi Jarkko,

Sounds good. I will make this change, and incorporate the other changes 
discussed,
and post a v3 for further review.


>
>>>
>>> BR, Jarkko
>>
>> Thanks,
>> Srish.
>>
> Br, Jarkko

Thanks,
Srish.
