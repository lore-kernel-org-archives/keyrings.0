Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FC12CCC5;
	Wed, 30 Sep 2026 05:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790747535; cv=none; b=dOXhzLA+coSB6hh0eZes8tvB2Is+1RDX84goKBuAcFt3Wu4Weq6ojTLeVW1Fv/H6gOPeSqPK6nV8nKgRjaoanj928jJC8uuKUFpH2yJCRG6ZctOlS+piw189Yyk7R5VFD/PK3Skua0Ef6ED5Jk0qZx7JRj9CFrbsHv47FH5Sr3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790747535; c=relaxed/simple;
	bh=IggA075lpKBvqFkqul8Glhx0cPLiFA4k2iwalES6fQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q5VCy9MgA0l4gqyx5TD+toFz4AiwnUM9A8NqgTpmw5kVVW/VSy1TUmZ7B9MJSxRnJfCIUuNWVy5Bvj5gixNEiCLGLvIIqQozKxpk8iCJVqkZNoeFFE+TxfF0w95vdRyNEu0j3SjV0DGJlYal9Uj1X1vpV2xA9sshbzk+LqNnCYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cvyx/iSK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cvyx/iSK"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TNZT0S1171258;
	Wed, 30 Sep 2026 05:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hQY8BM
	nBJklWk2mbjFQaJuJ2lh+1RdgoYRVU/lkUbRA=; b=cvyx/iSK6HivfFc0nZbV1E
	4zccFMZeB/r6Lp48tVm99Se9VWjlaksZatVfBVCiDyOectUpm/Bg1kXH6nR0c6hR
	tSENjLhJK5K3p/DN5d/nYZziz7+H7JFCkpAyTVhaikoDbTTyXS6QndZ7JNFY57pS
	Zte3ohwZDizdo+bqPhwGOxHb9ZejYUhwnYO0xTzJGBvAJsaT7wtu7bm9EcacWcHu
	rJDWY/ps7zAl9bXuFDOoBGBIVnI2x4Fzv09zSJyqWhlcqp5hHI6RbWYbHlNsurIY
	a6on8c6Q5TjkwRopLMjtgrznR2O5NuPwm8E+5IM1nBb2RMz556+Uk7qGrVMn1qMQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkakue-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 05:52:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68U4hHCo1289114;
	Wed, 30 Sep 2026 05:52:10 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4p92jg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 05:52:10 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68U5q8DC2032466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 30 Sep 2026 05:52:08 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DCEE5805E;
	Wed, 30 Sep 2026 05:52:08 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 782595805D;
	Wed, 30 Sep 2026 05:52:04 +0000 (GMT)
Received: from [9.67.100.83] (unknown [9.67.100.83])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 30 Sep 2026 05:52:04 +0000 (GMT)
Message-ID: <d0079240-f97f-4cfe-b26d-2ad2b88ab3b7@linux.ibm.com>
Date: Wed, 30 Sep 2026 11:22:02 +0530
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] keys/trusted/tpm2: Validate TPM2_Create object sizes
 separately
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
        stefanb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com
References: <20260926184203.479203-1-ssrish@linux.ibm.com>
 <arwqiNal3ElcgfON@kernel.org>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <arwqiNal3ElcgfON@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YUMNASIhfsx7r4qtr_c2kjx_ybblRNGe
X-Proofpoint-GUID: YUMNASIhfsx7r4qtr_c2kjx_ybblRNGe
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAyMiBTYWx0ZWRfX2tMNTp6w4MGL
 4pcd5mcAy73uZnx4qCDfCgys0t4jEUn69JYK4AkoPvNeud7480a/PjRhGbHpiUVkonydDKmjdRu
 qkQQlZMPcn67FX038X/7xsyXVmEMrwc=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abca38a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=Su7yy7IH-EJ2G0VEJOIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAyMiBTYWx0ZWRfX5rdiRM2oII2a
 XHbEv6EOdRAsN2JWCrQN5GAYybz4y0mODqAlMKf7dTJIlHcCdy/PjpqagDc7k0Bpef4SusphkGR
 39mj4a5bdvBvk42Q8NQpk+9DqWmQNWERQM8FnVeQV6NYPKj3k1nZ5uP0wEu6fOmqetBPWz95SW5
 TnxJvJ1tO6MinZWYtIDPlgdtwvbJN1T6K9auPHmm95LSmbaIiMzvQzfzjTDM888F9BnZp2kklL1
 +j2ddRvl7N5ogcjQ8TOqfMkj2MTl9ld84vIJ3or+WiBFH6BRCNZQpPyS+koeQi8+aM+5rGwZ3po
 RQCLSP7Hl88fWqonvY7VGFnqFdxGWn/LiF4eQt83fEmmvnB4Mn8PwTT450gmh94KKWsit6kVAiP
 Gf8IB95xglN4H6L0xVaG+PHVtvaCUROFxSqYQtUnjH83JeXHWVXzaVErSJcliHx7rSQCUHGUO03
 qOZNfDQYHaWmJ8K7l6g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300022


On 9/30/26 2:45 AM, Jarkko Sakkinen wrote:
> On Sun, Sep 27, 2026 at 12:12:03AM +0530, Srish Srinivasan wrote:
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
>> This is observed when creating larger trusted keys using the swtpm TPM 2.0
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
>> Also, use scope-based cleanup to simplify resource management.
>>
>> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
>> ---
>> Changelog:
>>
>>   v3:
>>    - Simplify the TPM2B_PRIVATE and TPM2B_PUBLIC bounds checks
>>    - Use appropriate error codes for failure returns
>>    - Use scope-based cleanup to simplify resource management
>>
>>   v2:
>>    - Exclude a comment pointed out by Jarkko
>>
>>   security/keys/trusted-keys/trusted_tpm2.c | 42 +++++++++++++----------
>>   1 file changed, 24 insertions(+), 18 deletions(-)
>>
>> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
>> index 906700c3d7f0..920f45c7864b 100644
>> --- a/security/keys/trusted-keys/trusted_tpm2.c
>> +++ b/security/keys/trusted-keys/trusted_tpm2.c
>> @@ -25,24 +25,36 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>>   {
>>   	struct trusted_key_tpm *private = options->private;
>>   	const int SCRATCH_SIZE = PAGE_SIZE;
>> -	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
>> -	u8 *work = scratch, *work1;
>> -	u8 *end_work = scratch + SCRATCH_SIZE;
>> +	u8 *scratch __free(kfree) = NULL;
>> +	u8 *work, *work1;
>> +	u8 *end_work;
>>   	u8 *priv, *pub;
>> -	u16 priv_len, pub_len;
>> +	u32 priv_len, pub_len;
>>   	int ret;
>>   
>> +	if (len < 4)
>> +		return -EINVAL;
>> +
>>   	priv_len = get_unaligned_be16(src) + 2;
>> -	priv = src;
>> +	if (priv_len + 2 > len)
>> +		return -EIO;
>>   
>> +	priv = src;
>>   	src += priv_len;
>>   
>>   	pub_len = get_unaligned_be16(src) + 2;
>> +	if (pub_len + priv_len > len)
>> +		return -EIO;
>> +
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
>> @@ -50,10 +62,9 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>>   		unsigned char bool[3], *w = bool;
>>   		/* tag 0 is emptyAuth */
>>   		w = asn1_encode_boolean(w, w + sizeof(bool), true);
>> -		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode")) {
>> -			ret = PTR_ERR(w);
>> -			goto err;
>> -		}
>> +		if (WARN(IS_ERR(w), "BUG: Boolean failed to encode"))
>> +			return PTR_ERR(w);
>> +
>>   		work = asn1_encode_tag(work, end_work, 0, bool, w - bool);
>>   	}
>>   
>> @@ -65,8 +76,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>>   	 */
>>   	if (WARN(work - scratch + pub_len + priv_len + 14 > SCRATCH_SIZE,
>>   		 "BUG: scratch buffer is too small")) {
>> -		ret = -EINVAL;
>> -		goto err;
>> +		return -EINVAL;
>>   	}
>>   
>>   	work = asn1_encode_integer(work, end_work, private->keyhandle);
>> @@ -79,15 +89,10 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>>   	if (IS_ERR(work1)) {
>>   		ret = PTR_ERR(work1);
>>   		pr_err("BUG: ASN.1 encoder failed with %d\n", ret);
>> -		goto err;
>> +		return ret;
>>   	}
>>   
>> -	kfree(scratch);
>>   	return work1 - payload->blob;
>> -
>> -err:
>> -	kfree(scratch);
>> -	return ret;
>>   }
>>   
>>   struct tpm2_key_context {
>> @@ -340,10 +345,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>>   		goto out;
>>   
>>   	blob_len = tpm_buf_read_u32(buf, &offset);
>> -	if (blob_len > MAX_BLOB_SIZE || buf->flags & TPM_BUF_INVALID) {
>> +	if (buf->flags & TPM_BUF_INVALID) {
>>   		rc = -E2BIG;
>>   		goto out;
>>   	}
>> +
>>   	if (buf->length - offset < blob_len) {
>>   		rc = -EFAULT;
>>   		goto out;
>> -- 
>> 2.53.0
>>
> Now we can say that it leaves the tree to cleaner state than it was
> before applying this patch. The first version, despite doing the right
> thing was simply too convoluted.
>
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>


Thanks for the review and for helping improve the patch, Jarkko.


> Br, Jarkko

Thanks,
Srish.
