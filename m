Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94301153BE9;
	Mon,  5 Oct 2026 06:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791180127; cv=none; b=R3/acbiI0+TzCyuEGX2iARticeaiM1eQbyQP/hDV3hnWFrs8sl7NOP+jcg9xMKTBq9Jxpu6lH+Q+SdtjkZaZOTWh21Gjx5FsnpDlVPRAJ0r7pFNFX7fLVeW3RqeX3qyQQf62sLAaKsjHw4R79MDTOeWwWs7ltsyCiLy3K8P/jzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791180127; c=relaxed/simple;
	bh=Iif4BsD3oM8i7Qhtg4FWHn/UvLKdOS9KHQ0jen1PReg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DVpzfMmjZHjIkJG3QmZ5f74CmFcpnJ0HkuzlWky9GUuuRkfbr35k96Pg6PagZOHjO8qvIaXGnNfC1tTohPBp6oO+6Czv71FWrCBz4xS5eSiYvfVV7F0ORIYKl+riyQALUAJzkHnpHX/pi2oz4dVt8RoA78PNJ5mcvluMxy7+SC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lmw7qkJz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lmw7qkJz"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69515aWb3290354;
	Mon, 5 Oct 2026 06:01:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cGOfAW
	b4TmR7GT7fC+8Gjm8caUz5HqlGlPUNccNryy0=; b=Lmw7qkJzvxxCFD8/vvZCsG
	lsv345lPFpOZtP+gnqkaAJNbvjocoZXYspdxeSfeCmM4j+nUDTi+92pmspqE+SN5
	XN0I3AmJmEbZXTdP0QM85b9GCIigM2toHp+LvnZxOB3DrTM9u8TjxonCaNf6XAqi
	uHILVBDueyaU0QA/9Gj0utWauR943YQHPok2n35QN8W6YKojzXD0EmEYKJm9/V8w
	Tly7zQ0Xc9ar9HfbYIRdKoRKfsS6/rM5mHPgofMJ9sl/5EhoVWHkkkNGYSPbibxz
	sjCKBA9HOGtddIluvcuEOAxOyaakuga+Rp3W188sofD6+Zt74lzFhe/saGlxcU8A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2sbuyuxe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:01:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69512VOK2165220;
	Mon, 5 Oct 2026 06:01:52 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3c1pmb4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 06:01:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69561pC848627984
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 06:01:51 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEDAD58068;
	Mon,  5 Oct 2026 06:01:50 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BDFD5805D;
	Mon,  5 Oct 2026 06:01:47 +0000 (GMT)
Received: from [9.123.14.23] (unknown [9.123.14.23])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 06:01:47 +0000 (GMT)
Message-ID: <d3574d84-84dd-4aa5-b80f-acc7844c3f12@linux.ibm.com>
Date: Mon, 5 Oct 2026 11:31:46 +0530
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] keys/trusted_keys: reuse TPM version in option
 handling
To: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        James.Bottomley@hansenpartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, stefanb@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        nayna@linux.ibm.com, rnsastry@linux.ibm.com
References: <20261002071050.179879-1-ssrish@linux.ibm.com>
 <asMYa0lD7RNcoszb@iki.fi>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <asMYa0lD7RNcoszb@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: TOdaI29EHbEacqf17SSj5oMEcl4ETfnA
X-Authority-Analysis: v=2.4 cv=KJHPn1Fo c=1 sm=1 tr=0 ts=6ac33d51 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=gJAgfurwMlHemBeE4CoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TOdaI29EHbEacqf17SSj5oMEcl4ETfnA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAyMiBTYWx0ZWRfXxgr1M9uv4QiZ
 6Gdc+g/kiIJt4/MmxZuwJ9Z6ImqybpESa/RGvyEpX18336HQ6DZ8+thecwIBcKN9ANq4V4ulY++
 85bIIOB9PddgiQCkvN+igg3TXsLnXEbIVu/BNlDFdAT8BabJ16a7LSorhS3EhrzLKNt71Be12t3
 b048i7qeBC+zMFHYAIZypKQpQNWK9EPrK711SgH8YRwEgWdSpoQVaF2WDmbRYWNrxKws+3oOSTF
 JKM6JqhX66RwkZ6fC4/87fcRkt+DfH/2aSHB1zXoWlpPhNeIsW+WTUIsnJbA7/iq/SpoJq2E2+B
 Yx5CFE0G5/rL4oITEC0p2vKQ87hYFGqnxm4QOiZz9sBeNthPZk3rXfo6W+Ztd9u54q7f12HNjxH
 QMN0RIYACSkFYFv1fiDSVQDS8T/sPdGTEzTNWD7MPn2PljwTCElWGSaeHzfENJjnPw9m9a9Vqrz
 hy8ARfQuggSJBaDZb6w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAyMiBTYWx0ZWRfX+rCTdEl5+mEj
 ihW5T4mwFGJXXd8h/DqV9ZbzEtMPRqBWvlKWwO6SK2GZreMeibYzP/snR8pa/lQpklM3lYQKKxp
 CxVPFAkZOo1oCUR/SRXLhYpdyCN4qJ4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 clxscore=1011
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610050022

Hi Jarkko,

On 10/5/26 8:54 AM, Jarkko Sakkinen wrote:
> On Fri, Oct 02, 2026 at 12:40:50PM +0530, Srish Srinivasan wrote:
>> Determine the TPM version once in the seal and unseal paths and reuse it
>> when allocating and parsing trusted key options. This avoids redundant TPM
>> version checks.
> So this is a bit nitpicking perhaps but a patch that would just clean
> the code up a bit would not be be worth of applying. Almost anything
> that "does nothing" goes to that bin.
>
> What I'm saying is that the conclusion in the last sentence goes to
> wrong direction but luckily the change has also feasible effects that
> we care about.
>
> By caching tpm_is_tpm2() there are less fallible sites in the key
> creation process, and reduced number of roundtrips with the TPM chip.
>
> Or from blackbox perspective it reduces I/O traffic between kernel
> and the hardware platform.


Yes, that makes sense. Thank you for pointing this out.

I will revise the commit message to highlight the reduced failure
surface and I/O between the kernel and the TPM, and
send v3.


>
>> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
>> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
>> ---
>> Changelog:
>>
>>   v2:
>>    - Use bool to indicate whether the chip is TPM 2.0 in the option helpers
>>
>>   security/keys/trusted-keys/trusted_tpm1.c | 35 +++++++++--------------
>>   1 file changed, 13 insertions(+), 22 deletions(-)
>>
>> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
>> index 3ec078ca3f97..6dbce058368f 100644
>> --- a/security/keys/trusted-keys/trusted_tpm1.c
>> +++ b/security/keys/trusted-keys/trusted_tpm1.c
>> @@ -700,7 +700,7 @@ static const match_table_t key_tokens = {
>>   
>>   /* can have zero or more token= options */
>>   static int getoptions(char *c, struct trusted_key_payload *pay,
>> -		      struct trusted_key_options *opt)
>> +		      struct trusted_key_options *opt, bool is_tpm2)
>>   {
>>   	struct trusted_key_tpm *private = opt->private;
>>   	substring_t args[MAX_OPT_ARGS];
>> @@ -712,13 +712,8 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>>   	unsigned long token_mask = 0;
>>   	unsigned int digest_len;
>>   	int i;
>> -	int tpm2;
>> -
>> -	tpm2 = tpm_is_tpm2(chip);
>> -	if (tpm2 < 0)
>> -		return tpm2;
>>   
>> -	private->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
>> +	private->hash = is_tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
>>   
>>   	if (!c)
>>   		return 0;
>> @@ -773,7 +768,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>>   				break;
>>   			}
>>   
>> -			if (tpm2 &&
>> +			if (is_tpm2 &&
>>   			    private->blobauth_len <=
>>   			    sizeof(private->blobauth)) {
>>   				memcpy(private->blobauth, args[0].from,
>> @@ -808,14 +803,15 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>>   			}
>>   			if (i == HASH_ALGO__LAST)
>>   				return -EINVAL;
>> -			if  (!tpm2 && i != HASH_ALGO_SHA1) {
>> +			if (!is_tpm2 && i != HASH_ALGO_SHA1) {
>>   				pr_info("TPM 1.x only supports SHA-1.\n");
>>   				return -EINVAL;
>>   			}
>>   			break;
>>   		case Opt_policydigest:
>>   			digest_len = hash_digest_size[private->hash];
>> -			if (!tpm2 || strlen(args[0].from) != (2 * digest_len))
>> +			if (!is_tpm2 ||
>> +			    strlen(args[0].from) != (2 * digest_len))
>>   				return -EINVAL;
>>   			res = hex2bin(private->policydigest, args[0].from,
>>   				      digest_len);
>> @@ -824,7 +820,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>>   			private->policydigest_len = digest_len;
>>   			break;
>>   		case Opt_policyhandle:
>> -			if (!tpm2)
>> +			if (!is_tpm2)
>>   				return -EINVAL;
>>   			res = kstrtoul(args[0].from, 16, &handle);
>>   			if (res < 0)
>> @@ -838,15 +834,10 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
>>   	return 0;
>>   }
>>   
>> -static struct trusted_key_options *trusted_options_alloc(void)
>> +static struct trusted_key_options *trusted_options_alloc(bool is_tpm2)
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
>> @@ -858,7 +849,7 @@ static struct trusted_key_options *trusted_options_alloc(void)
>>   			kfree_sensitive(options);
>>   			options = NULL;
>>   		} else {
>> -			if (!tpm2)
>> +			if (!is_tpm2)
>>   				private->keyhandle = SRKHANDLE;
>>   			options->private = private;
>>   		}
>> @@ -877,13 +868,13 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
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
>> @@ -922,12 +913,12 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
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
Srish
