Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F9D400DE8;
	Fri,  4 Sep 2026 06:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502338; cv=none; b=Z/M5HC/+849PSrrL5L91RrwmwMg0ANYUDJ8HcPp4W1CpC5STr9fez0YxfjXxnbdsjnpvk3kC1T3cjOC7i7pDCaMSRurM2Bi+QzULSvBWO9UDpyLzun00xnE7ffsB8y0ScOYZtkwF8um4aoyTsSd9pqCwJQJvmwy2Xibd9vPUIaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502338; c=relaxed/simple;
	bh=gUVCS39F6wtc3ZijAGtWLuS32nVUv8Ulsp65I6txJbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WcYMokxHUx0aiFJiqplLA6XJzzmdtw1IAqK8XVxgfg8ZiKJg0o50tBIek6FdoK95euo2uC6TB96TqFrnNZu8uu4MG7fHskCTKZvlm5OV1k2BPXH59K4bVwewZfNFZlw1nOi/PVrqzVAJ0TRS64BXvvvpZyNJkR3SuYMojMaeDBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RG5GmDgs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RG5GmDgs"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464EJX936677;
	Fri, 4 Sep 2026 06:12:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xyM65X
	Nog/H7fiEDfUT9RhpDHIsu4bagLP0oXnVKw90=; b=RG5GmDgsO9SGrXY2cjvSrd
	sG5X2Z3xCq/PLmAe+0P/o630NDL/B0jUepbQGmL3Hd0Abu2AFqbRivVSuupQdOXw
	zg4gGu4nDzQo+af/9sErSgICwt/EIX5apKmgG28VETs2LkY9qt04pKw9WHb/ucd4
	6tCb+7hA2rUYhQV8rZrP+u2aAdFmypG1/DSY1lWlSTISMic0hcfsh97Uhnb+XHxE
	9a7+hFD1LMUrtbyQ+tvQi7ANuK7GkzDsA6mq7SXKlRT5h2Eb5lS6gefmz5XyrRAf
	qEDYM01yg0bh3uUV5SLttUvaOPzRHRV5ONf9L96rKZzEC/tGZGLZEo5fTYe42X0A
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx611md-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:12:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6846BhtK026541;
	Fri, 4 Sep 2026 06:12:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcceyka8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:12:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6846BwbS31654524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:11:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB6E720043;
	Fri,  4 Sep 2026 06:11:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C81FF20040;
	Fri,  4 Sep 2026 06:11:51 +0000 (GMT)
Received: from [9.61.247.46] (unknown [9.61.247.46])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  4 Sep 2026 06:11:51 +0000 (GMT)
Message-ID: <e98b01dc-6347-438b-9894-4f18335f2c9e@linux.ibm.com>
Date: Fri, 4 Sep 2026 11:41:48 +0530
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/10] pseries/plpks: improve type consistency and
 parameter validation
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com
References: <20260831111738.334857-1-ssrish@linux.ibm.com>
 <20260831111738.334857-4-ssrish@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260831111738.334857-4-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a9a6133 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=k4SqsDxa1PK0FLuH3CsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: VyLghFNv6_HeOB_OwrN7o2q3VOfAuv-F
X-Proofpoint-ORIG-GUID: b3Q4BCg3lHUzaH2KwXGu1DO3sPJbWtVB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfXx6Wx5Ou8ZPLY
 5LxZDxI34fon2j1moOrtBJxnSYHYDIKUfKxmXQmlgFvX52DUvUnjQHCWDOCHZjvzsOIZCVmxtXu
 Gd02RWD42Dtb9D6FgrNbqouQSZacZv0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX97vEHlOQ9dpj
 7Dyi2afMmAg8sv7cDl2ks0mjbGu8EzHuyXcMpH8y3LzwroTGJ6Zxs/xQONt+rXNIA1D5AfH87jq
 1yfRi8XX4/kwqYYuAByQMhaQoKd+r6IHKMLCTkCih2BIiRrAbiPy+eouVLNd9VPAWHGMgvwcnAN
 zzM+f3b3pWTwysZ8yQleR31+wM+nPJyoj/2zkJvKR9hopiu0QxerW+2vNe5knxN2c4wJMQHGxnF
 6CI6T2NQywb3F/AmtpKuFcTUYTs56FOgBh6pTELQEEEVq+oHiLjxEKVjtMlScDTMUds4rkxoYCr
 tMGkAeWjtBIyJllpMfW8tRpeEXSQGOl6u9BPNHu9q16ql+X/IGaRv+aojEEZE4Ked3VhQ34zHCu
 UqnWvxBY0Gj/iUN54e5V3TyZso4PHBp2+Z/9XeRHQZUwy4gChXDd6D6bZIB09bsazDXTeush1vB
 MC65IDKoTsnIkhBpS1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040054


On 31.08.2026 4:47 PM, Srish Srinivasan wrote:
> Update plpks_wrap_object() and plpks_unwrap_object() to use u64 length
> parameters, matching the underlying hcall data types for consistency.
> Update the PKWM consumer, where these interfaces are used, accordingly.
>
> Add explicit casts when copying values from hcall return buffers into
> narrower data types. This makes the intended conversion clear and avoids
> implicit truncation in PLPKS hcall result handling.
>
> Also validate input pointers in plpks_signed_update_var() and
> plpks_read_var() before dereferencing them, addressing missing validation
> when reading and updating PLPKS objects.
>
> Fixes: 133aa79e211d ("pseries/plpks: add HCALLs for PowerVM Key Wrapping Module")
> Fixes: 2454a7af0f2a ("powerpc/pseries: define driver for Platform KeyStore")
> Fixes: 899d9b8fee66 ("powerpc/pseries: Implement signed update for PLPKS objects")
> Fixes: c99fcb0d735b ("keys/trusted_keys: establish PKWM as a trusted source")
> Cc: stable@vger.kernel.org
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

Tested on ppc64le PowerVM LPARs on firmware with wrap/unwrap support,
with and without Secure Boot enabled.

Verified trusted key creation and the seal/unseal round-trip for key sizes
in the range [32-128] bytes. Confirmed that NULL pointer validation in
plpks_signed_update_var() and plpks_read_var() does not break normal
operation.
> ---
>   arch/powerpc/include/asm/plpks.h          |  8 ++++----
>   arch/powerpc/platforms/pseries/plpks.c    | 22 ++++++++++++++--------
>   security/keys/trusted-keys/trusted_pkwm.c |  4 ++--
>   3 files changed, 20 insertions(+), 14 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/plpks.h b/arch/powerpc/include/asm/plpks.h
> index e87f90e40d4e..8b2ffb27db5a 100644
> --- a/arch/powerpc/include/asm/plpks.h
> +++ b/arch/powerpc/include/asm/plpks.h
> @@ -118,11 +118,11 @@ bool plpks_wrapping_is_supported(void);
>   
>   int plpks_gen_wrapping_key(void);
>   
> -int plpks_wrap_object(u8 **input_buf, u32 input_len, u16 wrap_flags,
> -		      u8 **output_buf, u32 *output_len);
> +int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
> +		      u8 **output_buf, u64 *output_len);
>   
> -int plpks_unwrap_object(u8 **input_buf, u32 input_len,
> -			u8 **output_buf, u32 *output_len);
> +int plpks_unwrap_object(u8 **input_buf, u64 input_len,
> +			u8 **output_buf, u64 *output_len);
>   #else // CONFIG_PSERIES_PLPKS
>   static inline bool plpks_is_available(void) { return false; }
>   static inline u16 plpks_get_passwordlen(void) { BUILD_BUG(); }
> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
> index 7bd5c149dd09..45278c5a45c1 100644
> --- a/arch/powerpc/platforms/pseries/plpks.c
> +++ b/arch/powerpc/platforms/pseries/plpks.c
> @@ -576,7 +576,7 @@ static int plpks_confirm_object_flushed(struct label *label,
>   				 virt_to_phys(auth), virt_to_phys(label),
>   				 label->size);
>   
> -		status = retbuf[0];
> +		status = (u8)retbuf[0];
>   		if (rc) {
>   			timed_out = false;
>   			if (rc == H_NOT_FOUND && status == 1)
> @@ -637,6 +637,9 @@ int plpks_signed_update_var(struct plpks_var *var, u64 flags)
>   	u64 continuetoken = 0;
>   	u64 timeout = 0;
>   
> +	if (!var)
> +		return -EINVAL;
> +
>   	if (!var->data || var->datalen <= 0 || var->namelen > PLPKS_MAX_NAME_SIZE)
>   		return -EINVAL;
>   
> @@ -822,6 +825,9 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
>   	u8 *output;
>   	int rc;
>   
> +	if (!var)
> +		return -EINVAL;
> +
>   	if (var->namelen > PLPKS_MAX_NAME_SIZE)
>   		return -EINVAL;
>   
> @@ -863,14 +869,14 @@ static int plpks_read_var(u8 consumer, struct plpks_var *var)
>   		goto out_copy_policy;
>   	}
>   
> -	if (!var->data || var->datalen > retbuf[0])
> -		var->datalen = retbuf[0];
> +	if (!var->data || var->datalen > (u16)retbuf[0])
> +		var->datalen = (u16)retbuf[0];
>   
>   	if (var->data)
>   		memcpy(var->data, output, var->datalen);
>   
>   out_copy_policy:
> -	var->policy = retbuf[1];
> +	var->policy = (u32)retbuf[1];
>   out_free_output:
>   	kfree(output);
>   out_free_label:
> @@ -1015,8 +1021,8 @@ EXPORT_SYMBOL_GPL(plpks_gen_wrapping_key);
>    *
>    * Returns: On success 0 is returned, a negative errno if not.
>    */
> -int plpks_wrap_object(u8 **input_buf, u32 input_len, u16 wrap_flags,
> -		      u8 **output_buf, u32 *output_len)
> +int plpks_wrap_object(u8 **input_buf, u64 input_len, u16 wrap_flags,
> +		      u8 **output_buf, u64 *output_len)
>   {
>   	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = { 0 };
>   	struct plpks_auth *auth;
> @@ -1134,8 +1140,8 @@ EXPORT_SYMBOL_GPL(plpks_wrap_object);
>    *
>    * Returns: On success 0 is returned, a negative errno if not.
>    */
> -int plpks_unwrap_object(u8 **input_buf, u32 input_len, u8 **output_buf,
> -			u32 *output_len)
> +int plpks_unwrap_object(u8 **input_buf, u64 input_len, u8 **output_buf,
> +			u64 *output_len)
>   {
>   	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = { 0 };
>   	struct plpks_auth *auth;
> diff --git a/security/keys/trusted-keys/trusted_pkwm.c b/security/keys/trusted-keys/trusted_pkwm.c
> index bf42c6679245..b6b5697426a8 100644
> --- a/security/keys/trusted-keys/trusted_pkwm.c
> +++ b/security/keys/trusted-keys/trusted_pkwm.c
> @@ -83,7 +83,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
>   	struct trusted_key_options *options = NULL;
>   	struct trusted_pkwm_options *pkwm = NULL;
>   	u8 *input_buf, *output_buf;
> -	u32 output_len, input_len;
> +	u64 output_len, input_len;
>   	int rc;
>   
>   	options = trusted_options_alloc();
> @@ -130,7 +130,7 @@ static int trusted_pkwm_seal(struct trusted_key_payload *p, char *datablob)
>   static int trusted_pkwm_unseal(struct trusted_key_payload *p, char *datablob)
>   {
>   	u8 *input_buf, *output_buf;
> -	u32 input_len, output_len;
> +	u64 input_len, output_len;
>   	int rc;
>   
>   	input_len = p->blob_len;

-- 
Thanks and Regards
R.Nageswara Sastry

