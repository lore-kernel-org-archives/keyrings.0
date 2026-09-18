Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35064492E3F;
	Fri, 18 Sep 2026 06:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789714129; cv=none; b=qrXLTN0F/IbSmfToBKT8HtYApsKoQWiSgGidfpRmO3ndcGyPpfJ+tcYhrgoeHHFONtKeffale4rqdbrGGjLBIR1zkie9vubzTtCyisEU998CJs/L2L18CMSct1MYgPKd/lXrPp8hubC8IlHf49S28XQxNXEAlANo3RamBWP5nvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789714129; c=relaxed/simple;
	bh=qYEFzIm+N0CfUhVGL28bB4CRxWsTwzRqweegiM+XOQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d1Iw+dNN5HeC9XzNGQ5L1t7vMT1bwWvcgFNRlhJ7e0usU824FEKbl/NG6Alv7OJ4RmmhGuq2jfltWhfhXPySnlkN37Y0fB8uYl8bFn3CHFIY4gknQT4g9sB78BXSlZW5LN6iLdtamHcTF3jyCDEUzkqdnL/kPnjGiHy4U+pWhi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ln5wKdTA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ln5wKdTA"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61c2C2781323;
	Fri, 18 Sep 2026 06:48:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JlJbws
	tGkzlMLSOxQwpy8CnDx+tVF5dvH6CEitAre5g=; b=ln5wKdTAS5s/Nk5VqtAXJ6
	9mW9QnoXPOS6YmMhYIdHSIttd5opYZmLf9MmxTeNA+2CwgtkwU+9K7y9N7niO85e
	1aqiv1cDbabqK6yh7pOrfeY/rVaX6Htoep6dXPw9w+C9elPUvXwNxtu0cR7Cmn9j
	GHgO5dbhRfcuxDYSzX8n+4rWBxRkkwR6yOvZXEJQya+vJ6Ql88kaGw1i25RHNPi0
	Wud0tv1Cu/HlipDlvilKJF/6Mo4BrdpMIN3dDk+Zk1uvhGxA57a7NWoIoCzBrBH+
	3f6eXqOC72oYAhTMOJ2+qSG7wdibTWRSESA6nbcykiJd66F7xOdTEPQLHoyYjWPQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqpn4d-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 06:48:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I6552b196230;
	Fri, 18 Sep 2026 06:48:30 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjp5c0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 06:48:30 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I6mTAe14680646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 06:48:29 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A579E58065;
	Fri, 18 Sep 2026 06:48:29 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 831DD58052;
	Fri, 18 Sep 2026 06:48:26 +0000 (GMT)
Received: from [9.123.14.23] (unknown [9.123.14.23])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 06:48:26 +0000 (GMT)
Message-ID: <e05d8ca7-ac48-47ef-bc47-bef5b22cb723@linux.ibm.com>
Date: Fri, 18 Sep 2026 12:18:25 +0530
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
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <aqydqxpVmp67kTQO@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDA4NyBTYWx0ZWRfX5k5yd4li2M9t
 JsI+7majam6CmqxsdGiN3Mrbigzxi8aH3KV/1rxMLMHczy2YqBmukK/Bk7qUhlMfPeh7xECcjfL
 iF7i+ci9S36LSSG4Z0hBssEf3STxec/PwFTvcFWB/0gzkofy56W4K3PWuxaDP+nXfIf0u+3Ifqf
 25CCpnR9J4c/JFaHbO5xhDusNouakAMjXHfL79BKaBOCoeWC0mn1QA9fHfqMorJTl9Ks6MghLdA
 B+0VJglJ6iQI3WDSGoM0z4N8dFSpgPtmKDL/tfu6N3B0GlAR/jSMX34vKz0Kv8I6tncxep+BGqt
 GLCTtKgR/6QBuGGF+iT8mU19HNGV8gl/CVH7tAXm/7DlarMdEiVrK4boV6oi6kiMk/CxFHLoGOH
 F4lzwgcF/FFcAnU30j+cgYfY5vqmgzu918H0mdBjFBDDa2P44z0obu258IAekV1n2zKTC0qNVp4
 HrissPhr9s/eUWaQcTw==
X-Proofpoint-GUID: M3B6wiPu_x1nxjmVpbQahD3mqB6-0nxd
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aacdebf cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=6fPxEW-5Y_PwP9TQzHIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: M3B6wiPu_x1nxjmVpbQahD3mqB6-0nxd
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDA4NyBTYWx0ZWRfXzJcxTnCKncGt
 ku5UXDI3rC2R1HRmjgp9K/2AowyZkBTsgAZSjMy3o875udla0FMFtwhMowNpJcML7D7asIIIHSk
 3jpihV0kNiO6f/p7b9Jjh8WVwNyYV2g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180087


On 9/18/26 7:40 AM, Jarkko Sakkinen wrote:
> On Thu, Sep 10, 2026 at 03:32:22PM +0530, Srish Srinivasan wrote:
>> TPM2_Create returns outPrivate, outPublic, creationData, creationHash and
>> creationTicket in its response parameter area. However, only outPrivate and
>> outPublic are included in the trusted key blob. The size of the blob is
>> therefore not determined by the size of the complete response parameter
>> area.
>>
>> tpm2_seal_trusted() currently compares the size of the complete response
>> parameter area against MAX_BLOB_SIZE. This can reject a valid response
>> when the remaining response outputs cause the entire response parameter
>> area to exceed MAX_BLOB_SIZE, even though the outPrivate and outPublic
>> TPM2B structures consumed by tpm2_key_encode() remain small enough to be
>> encoded in the key blob.
>>
>> This is observed when creating larger trusted keys using an swtpm TPM 2.0
>> emulator backed by libtpms.
>>
>> For example, requesting a 113-byte key succeeds, 114 fails.
>>
>> ~$ keyctl add trusted trusted_key1 "new 113 keyhandle=0x81000001" @u
>> 520504613
>> ~$ keyctl add trusted trusted_key2 "new 114 keyhandle=0x81000001" @u
>> add_key: Argument list too long
>> ~$
>>
>> Remove the MAX_BLOB_SIZE check on the complete response parameter area.
>> Instead, use the response length passed to tpm2_key_encode() to validate
>> that the outPrivate and outPublic TPM2B structures are fully contained
>> in the response before accessing them.
>>
>> Previously, a response parameter area larger than MAX_BLOB_SIZE was
>> rejected with -E2BIG before ASN.1 encoding. With this change, if the
>> resulting encoded blob does not fit in payload->blob, the error returned by
>> asn1_encode_sequence() is propagated instead.
>>
>> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
>> ---
>> Changelog:
>>
>>   v2:
>>    - Exclude a comment pointed out by Jarkko
>>
>>   security/keys/trusted-keys/trusted_tpm2.c | 35 +++++++++++++++++------
>>   1 file changed, 27 insertions(+), 8 deletions(-)
>>
>> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>> index 01f18bb37047..cbec4f591952 100644
>> --- a/security/keys/trusted-keys/trusted_tpm2.c
>> +++ b/security/keys/trusted-keys/trusted_tpm2.c
>> @@ -24,24 +24,42 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>>   			   u8 *src, u32 len)
>>   {
>>   	const int SCRATCH_SIZE = PAGE_SIZE;
>> -	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
>> -	u8 *work = scratch, *work1;
>> -	u8 *end_work = scratch + SCRATCH_SIZE;
>> +	u8 *scratch;
>> +	u8 *work, *work1;
>> +	u8 *end_work;
>>   	u8 *priv, *pub;
>> -	u16 priv_len, pub_len;
>> +	u32 priv_len, pub_len;
>>   	int ret;
>>   
>> -	priv_len = get_unaligned_be16(src) + 2;
>> +	if (len < sizeof(__be16))
>> +		return -EFAULT;
>> +
>> +	priv_len = get_unaligned_be16(src);
>> +	if (priv_len > len - sizeof(__be16))
>> +		return -EFAULT;
>> +
>> +	priv_len += sizeof(__be16);
>>   	priv = src;
>>   
>> +	if (len - priv_len < sizeof(__be16))
>> +		return -EFAULT;
> This caused for me some head scrathing tbh.
>
> See:
>
> 1. len >= 2
> 2. priv_len <= len - 2
> 3. 2 - priv_len + priv_len <= 2 - priv_len + len - 2
> 4. 2 <= len - priv_len
>
> Is this check required?


Hi Jarkko,
Thanks for taking a look.

The preceding check,


     if (priv_len > len - sizeof(__be16))
         return -EFAULT;


ensures that the complete TPM2B_PRIVATE, including its size field,
fits within len. After this check, priv_len is incremented by 2 and
therefore represents the complete TPM2B_PRIVATE length.


The check you pointed out,


     if (len - priv_len < sizeof(__be16))
         return -EFAULT;


then ensures that at least 2 bytes remain for reading the following
TPM2B_PUBLIC size field.


>
>> +
>>   	src += priv_len;
>>   
>> -	pub_len = get_unaligned_be16(src) + 2;
>> +	pub_len = get_unaligned_be16(src);
>> +	if (pub_len > len - priv_len - sizeof(__be16))
>> +		return -EFAULT;
>> +
>> +	pub_len += sizeof(__be16);
>>   	pub = src;
>>   
>> +	scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
>>   	if (!scratch)
>>   		return -ENOMEM;
>>   
>> +	work = scratch;
>> +	end_work = scratch + SCRATCH_SIZE;
>> +
>>   	work = asn1_encode_oid(work, end_work, tpm2key_oid,
>>   			       asn1_oid_len(tpm2key_oid));
>>   
>> @@ -336,10 +354,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>>   		goto out;
>>   
>>   	blob_len = tpm_buf_read_u32(buf, &offset);
>> -	if (blob_len > MAX_BLOB_SIZE || buf->flags & TPM_BUF_INVALID) {
>> -		rc = -E2BIG;
>> +	if (buf->flags & TPM_BUF_INVALID) {
>> +		rc = -EFAULT;
>>   		goto out;
>>   	}
>> +
>>   	if (buf->length - offset < blob_len) {
>>   		rc = -EFAULT;
>>   		goto out;
>> -- 
>> 2.53.0
>>
> BR, Jarkko

Thanks,
Srish.
