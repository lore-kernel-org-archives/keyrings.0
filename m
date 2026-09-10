Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF59B355048;
	Thu, 10 Sep 2026 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027109; cv=none; b=Czal5kaNv2VNavWNb4TV8oHdtyU1LiThsLXQ/r4uKpOzLSroxooUrT3bYA1rmzphaD0E60z9H+IFBJ4jPw2aKvJbh7RnhjtYWSrDAQ+jS6TJM/ZKQW7yqpcg4nGegDwkmvKN24tXfYmuvGaMdzxONadOdmmlDAXKlwoi040KIiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027109; c=relaxed/simple;
	bh=zQij38x8Gr6PSfKZrv2646dDAIeMPC1xF2jZHUrQF40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DjrGdL8KtJd2d3gqh09icuMJMl8rFtSmYQnmdLscdBi5LwLIi80Y0STKtxWpTKCR7Xkc+/lPIdSG2cQ0MgWeK1aE4Zxnj+qN8E/eNd0RKkXQ24GUZcbszWwPsLge9ACxBdn0hbBoqnKIX1g9Sj8t+qVs2Dhb8Lfod42vY6SduCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hf86JdSL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hf86JdSL"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5VRC21996969;
	Thu, 10 Sep 2026 07:58:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4wU3kk
	0+swCWLpvgHo+/2f07jyIZvoPRKiL/lPRPhqg=; b=hf86JdSLtkMJrJqVYpUOHq
	jmkw9Va5iBaCzf2OjmXWo13uR8XRK3xwUt3hpEDRxzym8+/iFdZHYQ7OzGcgmw6q
	612cdEQAuwNdDkOWBHxXhJePtQ5TvzuNALyqQpsGp6jHrFYrIAht0tTBs6pbLS5R
	e6wCy0YfpyM/gk3LAeHnvGx3e4kej9XNy3XxJ69kiCdzVANBTNcHol7Ypfz+hll2
	b2vJaPNpLUHXVRXb6gR+6WpxMDIfplXBaRFVEd7R6fU3GO2jLT6j+d/5B67Yk53i
	h06T6j/DVBQPXct+gm/vh7krdudlD0MUIU48PNdb3dpo6GSyqIe5xHHmizNuEGjg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8qk5ss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 07:58:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 68A7uFb0032035;
	Thu, 10 Sep 2026 07:58:24 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkcr3b721-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 07:58:23 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68A7wLEc26083844
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Sep 2026 07:58:21 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BE4658051;
	Thu, 10 Sep 2026 07:58:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6B8B5805C;
	Thu, 10 Sep 2026 07:58:18 +0000 (GMT)
Received: from [9.123.14.23] (unknown [9.123.14.23])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Sep 2026 07:58:18 +0000 (GMT)
Message-ID: <46f1c7c2-0bde-447d-a92c-c30b623a5a4e@linux.ibm.com>
Date: Thu, 10 Sep 2026 13:28:17 +0530
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] keys/trusted/tpm2: Validate TPM2_Create object sizes
 separately
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        nayna@linux.ibm.com, rnsastry@linux.ibm.com
References: <20260902114340.268698-1-ssrish@linux.ibm.com>
 <aqHLkyUewMrTr1wB@kernel.org>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <aqHLkyUewMrTr1wB@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SpUFe/O0 c=1 sm=1 tr=0 ts=6aa26320 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=mDX-_44H_j9oIHSpGQEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: M-6sk-3_lXk8LU-0sLmzIsxVpwMEWv-U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4MSBTYWx0ZWRfX/iCe73HFRnTC
 UDIZ7l0F/9ZYOubVEKrONB3W5bMjiy1EqmvZLArNwlQqWU8arS3rw+xSZN6QsblXTTvq/3lFrHu
 CsCwx4ODOMpTURtS4pjNa8apQ5XAMlZDZYqcU8OOPsTHp7qA+i4dkAEYiFHiJY/Ffijg2uPgxjy
 +iK5B2reEm560RYoTvWtJ4yEhwLDAIF8q8Q4dBj6larw51jcIeSu+h0TjfpOtS0SaXDcpmLYPhT
 F5TJu42tH9a5RDoAyT23dkfLlDVPp5IJVU5W15FiRXrANA0yR1KvAyiSIdLYo8g6OjhCcbaqWNI
 0B5KXRSTIqi2oBqVwIM1zErhLK2FlsxCcvM0DoZbwOVnSrL09nU+VoAJhbQpEhlZx2vaEhER2ND
 jMAi83hQqpeklPgJXP+BubH+JSLOrnGnbnbp3aOMwshOPZ3VbNiXLRiq5d5Siu0LcIC/sh0CMvV
 EYuSwUEtqIunNV6VBRw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4MSBTYWx0ZWRfX4JHQm3e+g7ZA
 c7XfNAQojjIUzTRWNHeoWGbqR0ME5kRrHjGYo2IMFQJqym6x7yCjL3d9I5WF11oV+Dfub57e1Y6
 rR+Sy5UPNbAsrKaKLeJdmfrVSYXmOk4=
X-Proofpoint-GUID: M-6sk-3_lXk8LU-0sLmzIsxVpwMEWv-U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100081

Hi Jarkko,

On 9/10/26 2:41 AM, Jarkko Sakkinen wrote:
> On Wed, Sep 02, 2026 at 05:13:40PM +0530, Srish Srinivasan wrote:
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
>>   security/keys/trusted-keys/trusted_tpm2.c | 47 +++++++++++++++++++----
>>   1 file changed, 39 insertions(+), 8 deletions(-)
>>
>> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>> index 67225dd562a9..efb016a6d4b8 100644
>> --- a/security/keys/trusted-keys/trusted_tpm2.c
>> +++ b/security/keys/trusted-keys/trusted_tpm2.c
>> @@ -24,24 +24,54 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
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
>> +	/*
>> +	 * TPM2_Create Response Parameters:
>> +	 *
>> +	 * outPrivate
>> +	 * outPublic
>> +	 * creationData
>> +	 * creationHash
>> +	 * creationTicket
>> +	 *
>> +	 * Validate outPrivate and outPublic against the response parameter
>> +	 * length before accessing them.
>> +	 */
> Please remove this comment. It is only an annoyance.


Sure, will get rid of it and post v2.

Thanks,
Srish.


>
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
>> @@ -335,10 +365,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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
