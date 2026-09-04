Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBBC414A2A;
	Fri,  4 Sep 2026 06:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502240; cv=none; b=Gd1YEgNrXMDHNeH3POZ9W53qG0GxmOb2tpZNBNSjy11YsvMXvsoUQx0vzQ+KhoqhPMDAueCUi0UVS+vdrJJkVuqPcGMVmz1hTH+ym+mewYYb0IiH2/NZugtHPQP+q3EruOvhkQ4EY4A9rxUMP+CeHtxV/nuZ1T3/uT2rOzD0A6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502240; c=relaxed/simple;
	bh=3l2fgcyVrJxrS90+tLbAHnESPYxrvgoxhahRmryoN/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1ujes3gZGBLW4ydBmHP3kzXtuHT0Ezxa26csFRsiANyLUsBy2e5m7vjnvgR/e/ltvRjGiB9MJFenPczc/eRkzkBEEQeKdtDvj0niwEdExcMUzcThknxBYq1u5SSVUSngsuTOlG9II+HmrDHY7jqQLIy3ww821+UPWTpjrEOekI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NkTV4xoJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NkTV4xoJ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68464WhQ3993728;
	Fri, 4 Sep 2026 06:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OQbECm
	C/onJiPTMMl9RCUTY5J26b9sb7ubS5BtR54vc=; b=NkTV4xoJsPs5PYMTsQ6EEN
	8cqUG/TWMjQNLRvVbibM9bXppxU34UwNXMXRV7/x8OD6m9MzIvcgq8gBUewgPGMM
	WwOnvOb9Ii2s4s1OjtcHAWGcqkAjeoRzmq2lV13GaMZCdniazJ99hA1hzWcheyxx
	pWiTRvciH8OEHiK0msXp9WawYjNQlTJfkiOSsoAbI/Z2eFFshFNQALaVaK7N3HAG
	jwtL0ZqNangLYMvkhQTYDL0tA+PQbHr+2Ch5g4W7DjetuGAfFLiI5JV/vFXFJVdJ
	HFF5P3FLGZ4IL62csoPYQRJqEexbWhKsbYhxRgFWLkZpFFIDW3u7E5Q/2huv7ViA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbnue8jav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:10:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6845uOAX002158;
	Fri, 4 Sep 2026 06:10:15 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gcb8huebc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 06:10:15 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6846ABQn42074590
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 4 Sep 2026 06:10:11 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C675F20043;
	Fri,  4 Sep 2026 06:10:11 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EF4D20040;
	Fri,  4 Sep 2026 06:10:05 +0000 (GMT)
Received: from [9.61.247.46] (unknown [9.61.247.46])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  4 Sep 2026 06:10:05 +0000 (GMT)
Message-ID: <6fed0a01-964e-4945-b598-a890cbcb6da5@linux.ibm.com>
Date: Fri, 4 Sep 2026 11:40:01 +0530
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/10] pseries/plpks: update PKS documentation and
 maintainer entry
To: Srish Srinivasan <ssrish@linux.ibm.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com,
        jarkko@kernel.org, zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com
References: <20260831111738.334857-1-ssrish@linux.ibm.com>
 <20260831111738.334857-2-ssrish@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <20260831111738.334857-2-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: SnJZsrsJ53N_81H6YNQvYFe8I2YXR0KK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfX/Q5NI5kGfru8
 WGnzI21tKyNN9+YqRdl/SAteiF4ileL3wjedwIm2YQekekdOHxeC8xRkvkjrt4UkT+3r/vEGB5y
 qX/7DfSYlLeb/f4atnJQ9dHAZ2WSmEvDDQnvyrL6RS5CqeHjdxQBcYrqVTrFuigSRWrNstcDRIy
 qS4R5PdtYsF404MI6msg9dKOBY1uxvl4mPFWQXO0LqSUOL2BJnjb0ch45ZOwvL71mBZzBEBjJSU
 YRrDvOHgvVnNou0L4XQxYDTqoBurCK+ulT5CnsNNq0FBdVvSMDcITlJPd9nRhnM3uBoeQnxcMW7
 h3WtpaTnQLuwLuEMC5IPHTL90DmIcvhFd1DIJaqL2MlCCaWg/Xy2gIjc7LZIueeKL7EVocdZeYq
 e5pU5fUbHsICioIs4eEHsLudMDDIVbcC11d1SQ1hgwqvoUeorge/qdk3sBgn6AOWHULhTNS1S1M
 tmJxS2xIzOrNHSGSkOw==
X-Proofpoint-ORIG-GUID: RCcuBRQqUr2h0Dc9lQNS9_Jgpx1r7q7L
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDA1NCBTYWx0ZWRfXwBOAL4RDPkHc
 2Mpxczjv0TQiu6N3ZibewWmIoyMbiCLYY6x6zrEUdHMAI8Lr0qixraDHpuDWJfc4PJMEqjzfNtQ
 YACuknmXRfMLaPdG4k+94Pgqz2Khvlk=
X-Authority-Analysis: v=2.4 cv=B92JFutM c=1 sm=1 tr=0 ts=6a9a60c8 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=ZSwnYTGPAMvaW41niKkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609040054


On 31.08.2026 4:47 PM, Srish Srinivasan wrote:
> Wrap long PKS hcall return-value lines consistently and fix a typo in the
> H_PKS_UNWRAP_OBJECT description.
>
> Also update the MAINTAINERS entry from KEYS-TRUSTED-PLPKS to
> KEYS-TRUSTED-PKWM to reflect the PowerVM Key Wrapping Module naming.
>
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>

Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

Documentation-only change. Gone through documentation.
Used this data in test cases creation.

> ---
>   Documentation/arch/powerpc/papr_hcalls.rst | 16 ++++++++--------
>   MAINTAINERS                                |  2 +-
>   2 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/arch/powerpc/papr_hcalls.rst b/Documentation/arch/powerpc/papr_hcalls.rst
> index 14e39f095a1c..44c9c8b32ae3 100644
> --- a/Documentation/arch/powerpc/papr_hcalls.rst
> +++ b/Documentation/arch/powerpc/papr_hcalls.rst
> @@ -305,8 +305,8 @@ like core instruction, core LLAT and nest.
>   | Input: authorization, objectlabel, objectlabellen, policy, out, outlen
>   | Out: *Hypervisor Generated Key, or None when the wrapping key policy is set*
>   | Return Value: *H_SUCCESS, H_Function, H_State, H_R_State, H_Parameter, H_P2,
> -                H_P3, H_P4, H_P5, H_P6, H_Authority, H_Nomem, H_Busy, H_Resource,
> -                H_Aborted*
> +                H_P3, H_P4, H_P5, H_P6, H_Authority, H_Nomem, H_Busy,
> +                H_Resource, H_Aborted*
>   
>   H_PKS_GEN_KEY is used to have the hypervisor generate a new random key.
>   This key is stored as an object in the Power LPAR Platform KeyStore with
> @@ -321,8 +321,8 @@ the user. Generation of wrapping keys is supported only for a key size of
>   |        inlen, out, outlen, continue-token
>   | Out: *continue-token, byte size of wrapped object, wrapped object*
>   | Return Value: *H_SUCCESS, H_Function, H_State, H_R_State, H_Parameter, H_P2,
> -                H_P3, H_P4, H_P5, H_P6, H_P7, H_P8, H_P9, H_Authority, H_Invalid_Key,
> -                H_NOT_FOUND, H_Busy, H_LongBusy, H_Aborted*
> +                H_P3, H_P4, H_P5, H_P6, H_P7, H_P8, H_P9, H_Authority,
> +                H_Invalid_Key, H_NOT_FOUND, H_Busy, H_LongBusy, H_Aborted*
>   
>   H_PKS_WRAP_OBJECT is used to wrap an object using a wrapping key stored in the
>   Power LPAR Platform KeyStore and return the wrapped object to the caller. The
> @@ -331,16 +331,16 @@ which must have been previously created with H_PKS_GEN_KEY. The provided object
>   is then encrypted with the wrapping key and additional metadata and the result
>   is returned to the caller.
>   
> -
>   **H_PKS_UNWRAP_OBJECT**
>   
>   | Input: authorization, objectwrapflags, in, inlen, out, outlen, continue-token
>   | Out: *continue-token, byte size of unwrapped object, unwrapped object*
>   | Return Value: *H_SUCCESS, H_Function, H_State, H_R_State, H_Parameter, H_P2,
> -                H_P3, H_P4, H_P5, H_P6, H_P7, H_Authority, H_Unsupported, H_Bad_Data,
> -                H_NOT_FOUND, H_Invalid_Key, H_Busy, H_LongBusy, H_Aborted*
> +                H_P3, H_P4, H_P5, H_P6, H_P7, H_Authority, H_Unsupported,
> +                H_Bad_Data, H_NOT_FOUND, H_Invalid_Key, H_Busy, H_LongBusy,
> +                H_Aborted*
>   
> -H_PKS_UNWRAP_OBJECT is used to unwrap an object that was previously warapped with
> +H_PKS_UNWRAP_OBJECT is used to unwrap an object that was previously wrapped with
>   H_PKS_WRAP_OBJECT.
>   
>   References
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3a19da74d00c..6b91d7f081c4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14491,7 +14491,7 @@ S:	Supported
>   F:	include/keys/trusted_dcp.h
>   F:	security/keys/trusted-keys/trusted_dcp.c
>   
> -KEYS-TRUSTED-PLPKS
> +KEYS-TRUSTED-PKWM
>   M:	Srish Srinivasan <ssrish@linux.ibm.com>
>   M:	Nayna Jain <nayna@linux.ibm.com>
>   L:	linux-integrity@vger.kernel.org

-- 
Thanks and Regards
R.Nageswara Sastry

