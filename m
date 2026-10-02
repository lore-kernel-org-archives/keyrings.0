Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC71411FBF;
	Fri,  2 Oct 2026 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790924401; cv=none; b=UA38Y2zs5yf9BpnQsv6JXB89LqrI07MclaaunX2bFdCvW5Nt21pl+gQyQ8yykfZMBWaHul0MSNE9ibz/kak2E/iWEWzuHkHtBs4hGyNs86JehA8v//x6weHpQGgAzDTwMqzeuM/kJRg+nchXwv2QWGAzx9krWgpZYGbfh0lUubY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790924401; c=relaxed/simple;
	bh=gvZIJpj+r10yTiOxPqeLJOz8iC5YZQzvCTsqV5HrXg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m/9dalHYXkorgyp8QzhBZfulwSgMbLG/siv/klrlp2XGQ4ADKV1TbaZ1EGvhK54jSeEdvxYT9w8rlpXpKXl0gaQphxb2zm/4XLqgroFXlB3Dnht7X9qhU2y6t4LXMGWzUbx8YxR0d+Dl4oLzYkraHJPB+OjjmzvMlLvoi6Iv5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cFglvN4s; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cFglvN4s"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69265mgg2089302;
	Fri, 2 Oct 2026 06:59:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UWKFDJ
	o1BSddba+GbBwzzSwgjGvOfUClbp3SCxtsRSs=; b=cFglvN4s1EvQRJNEfifmYS
	GG73NgY6rJg4vwAYX3XHcA29HevVhYTL9voIaD8KjtuflGPZQ8Z5kZK+jl+SCkcw
	2+W9jh7oZ9C5VBKiXKVVFpH0UGeLMqPyt8oecc6Gor+3zmyWCSegdTdGs+NBeg0h
	Ku9nSsXu5XL6G3d7pTaIYGi1kDF7jq515VpJLa2yVb9z6yDHb1+ZbLptyVni20Nw
	pxr5dRczW4dQD+JFlq+pKTnEWNonfjJ0gm3Fkh4LjJjgoEPgHoNDpbLijh8ibNlX
	CSWo11wbZknQmlW2hGg0p//cSVMTDKjv+X3VpLdsOJl7uOH4UvBAwMucmYJYERMQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5qrqvjv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 06:59:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6925lhm3807631;
	Fri, 2 Oct 2026 06:59:50 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pk71f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 06:59:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6926xnmD31851224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 06:59:49 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39F4358056;
	Fri,  2 Oct 2026 06:59:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F16858060;
	Fri,  2 Oct 2026 06:59:43 +0000 (GMT)
Received: from [9.67.94.93] (unknown [9.67.94.93])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  2 Oct 2026 06:59:42 +0000 (GMT)
Message-ID: <2c71655a-53c7-4e63-9e38-7372fae74a0e@linux.ibm.com>
Date: Fri, 2 Oct 2026 12:29:41 +0530
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] keys/trusted_keys: reuse TPM version in option handling
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
        stefanb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com
References: <20260930060217.112471-1-ssrish@linux.ibm.com>
 <ar8ln4Au8rDe_Ssm@kernel.org>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <ar8ln4Au8rDe_Ssm@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAyNiBTYWx0ZWRfX2IKGGdUO5KF5
 sh1ycy3APsQPGygdflgFlZEtu+PGaiirOjuC1TP0YyjtHlZmZ+e2so7oeJ3mzvUYRFk7uaBsXI0
 a9VRC12Ocu4JQfDWv4Mw//5VFI+0vuA/333JK+VqKK7J20V2ueRwPPjzeTJDQlNLm5WSgAzRgw7
 mqGZBAprfTUcgU1L2NY+eG8YtqFcZj6RogxhkcK1ECIC9luF+Q3PTJciPQTQaJ7wsTw4qNBPJQw
 Q5mA4FES897QRWzybZYMpuZfbATfUK64lJ9PdYbCnpchkup8d8E4xSbgVGip4MyqzgKvCsDiz6L
 6bL0f47fC9NEsYUa/GnxIAG5O/6OV6bxQ1NXrOwP0sQ+7oeAU+ZdnEa1BRAadPXI3c+KqrphZFD
 UiCpXj3Dh4Ph7/UFXTuH5XfanJmKTL1JhlOskgl1mJrGDliNh1VoBrz+YB6TPQllDz+IXg7D8HE
 Y67SEdAMnyrpTzqhYbg==
X-Authority-Analysis: v=2.4 cv=SPbXx+vH c=1 sm=1 tr=0 ts=6abf5666 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=nqzg7_J6T3GHwYJh-FoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: fwrJTO13pm-924E_RkkK7HPt9EGK_PRy
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAyNiBTYWx0ZWRfX8KVPfaokJg1E
 nqW7vf7a31acAD1n/7dxAb7UsMTnH+TEnYtTLsgrX9jhFPpGQRjaK0A6lswZgTYyCnfilbb0QRh
 oshCQrwzhSvKhiMdrWuGB/Qy2pUqEyk=
X-Proofpoint-GUID: fwrJTO13pm-924E_RkkK7HPt9EGK_PRy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610020026

Hi Jarkko,
Thanks for taking a look.

On 10/2/26 9:01 AM, Jarkko Sakkinen wrote:
> On Wed, Sep 30, 2026 at 11:32:17AM +0530, Srish Srinivasan wrote:
>> Determine the TPM version once in the seal and unseal paths and reuse it
>> when allocating and parsing trusted key options. This avoids redundant TPM
>> version checks.
>>
>> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>>   security/keys/trusted-keys/trusted_tpm1.c | 22 ++++++----------------
>>   1 file changed, 6 insertions(+), 16 deletions(-)
>>
>> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
>> index 3ec078ca3f97..70de4101923f 100644
>> --- a/security/keys/trusted-keys/trusted_tpm1.c
>> +++ b/security/keys/trusted-keys/trusted_tpm1.c
>> @@ -700,7 +700,7 @@ static const match_table_t key_tokens = {
>>   
>>   /* can have zero or more token= options */
>>   static int getoptions(char *c, struct trusted_key_payload *pay,
>> -		      struct trusted_key_options *opt)
>> +		      struct trusted_key_options *opt, int tpm2)
>>   {
>>   	struct trusted_key_tpm *private = opt->private;
>>   	substring_t args[MAX_OPT_ARGS];
>> @@ -712,11 +712,6 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>>   	unsigned long token_mask = 0;
>>   	unsigned int digest_len;
>>   	int i;
>> -	int tpm2;
>> -
>> -	tpm2 = tpm_is_tpm2(chip);
>> -	if (tpm2 < 0)
>> -		return tpm2;
>>   
>>   	private->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
>>   
>> @@ -838,15 +833,10 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>>   	return 0;
>>   }
>>   
>> -static struct trusted_key_options *trusted_options_alloc(void)
>> +static struct trusted_key_options *trusted_options_alloc(int tpm2)
> Probably "bool is_tpm2" would be better here. It does not need to be
> tightly coupled with the tristate acquired from tpm_is_tpm2.


Makes sense.
Sure, I will make this change and send out v2.


>
>>   {
>>   	struct trusted_key_tpm *private;
>>   	struct trusted_key_options *options;
>> -	int tpm2;
>> -
>> -	tpm2 = tpm_is_tpm2(chip);
>> -	if (tpm2 < 0)
>> -		return NULL;
>>   
>>   	options = kzalloc_obj(*options);
>>   	if (options) {
>> @@ -877,13 +867,13 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
>>   	if (tpm2 < 0)
>>   		return tpm2;
>>   
>> -	options = trusted_options_alloc();
>> +	options = trusted_options_alloc(tpm2);
>>   	if (!options)
>>   		return -ENOMEM;
>>   
>>   	private = options->private;
>>   
>> -	ret = getoptions(datablob, p, options);
>> +	ret = getoptions(datablob, p, options, tpm2);
>>   	if (ret < 0)
>>   		return ret;
>>   	dump_options(options);
>> @@ -922,12 +912,12 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
>>   	if (tpm2 < 0)
>>   		return tpm2;
>>   
>> -	options = trusted_options_alloc();
>> +	options = trusted_options_alloc(tpm2);
>>   	if (!options)
>>   		return -ENOMEM;
>>   	private = options->private;
>>   
>> -	ret = getoptions(datablob, p, options);
>> +	ret = getoptions(datablob, p, options, tpm2);
>>   	if (ret < 0)
>>   		return ret;
>>   	dump_options(options);
>> -- 
>> 2.53.0
>>
> Br, Jarkko

Thanks,
Srish.
