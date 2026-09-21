Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02703939C8;
	Mon, 21 Sep 2026 19:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790018819; cv=none; b=l/c3JqM0m6/B1U9Xp8Uw1IGVhmtDG0A+s8rjEbat/TW6PBLjQIFFm4go/eDGabtbT+hWmrL4WgBQVfm0oBvaO2mhiY/RwQx6g+mplN2IQw81D4tpZRwWTAcWodsU57Cd4Y/5M+ZxQkjew4e/dvTe2yxqbB3vU20YVnasNAfUoUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790018819; c=relaxed/simple;
	bh=ctwPX9nemqH7LKSpr4W2687hkOMPT3OWSAC22HXosvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXZ75kSMWcf0Z/opPrhtM5HRaFiytYTlIko25i6bfdHxCs0pG8r0CyS+6y4WmKOKMmxpv/sVV7AHDzkzQa3uazht++YZ4S3J7ZV8pws0m3HPqbDAG378/DhXPiPZ67eP976ys5W/lnqklWQXGFOa6wP/H1CoORmIyHnjJeBpx9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZRkeCLwh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZRkeCLwh"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LF8YLw703559;
	Mon, 21 Sep 2026 19:26:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cbHkgC
	fr3twGPLqRav4nUuRjrvrvOvewHchIn5Azz6k=; b=ZRkeCLwh1vpXSMfO4kwFkf
	xoep/7i1SYNmBg1hc0twmw11+YdKuBHj7TP00MFSp86a6TfuXw6lT+rrRPiB6yu8
	dCcCBnfGCFwKmHslskN8ZRJ/6OVy+NKWpZwVWrqIJGj1470Q99fBHrMejcNUrZjU
	Ew99Wsksg8gaZmM5yq0NZ/Lfgk7OdbTJY7xEKrIzTgxwF66QVpz/74ERVEVDGgFp
	Kb0aezFPxlh31CcWK3OxVmzLAdY8lGm/2sSUzPHRDol9a9rrYUOZW2gnp4uLVzT2
	w3qnnlVXJwpMiNHms/Czv8fwfg3QvjXOJsr206jV2Ya9RNWRzRlAftD0oiE2FW4Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgqa4fa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 19:26:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68LJEmeL1431683;
	Mon, 21 Sep 2026 19:26:37 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53veuw6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Sep 2026 19:26:37 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68LJQZpf31457804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Sep 2026 19:26:36 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D259258059;
	Mon, 21 Sep 2026 19:26:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF4755805D;
	Mon, 21 Sep 2026 19:26:30 +0000 (GMT)
Received: from [9.67.77.117] (unknown [9.67.77.117])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 21 Sep 2026 19:26:30 +0000 (GMT)
Message-ID: <bcd5e2e9-5000-44a8-9e7d-ebb4cc3e02d9@linux.ibm.com>
Date: Tue, 22 Sep 2026 00:56:29 +0530
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/10] Extend PKWM to support user-created wrapping
 keys
To: nayna <nayna@imap.linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@hansenpartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com
References: <20260831111738.334857-1-ssrish@linux.ibm.com>
 <b133937fab3f5cd7203d8b48824a6e0e@imap.linux.ibm.com>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <b133937fab3f5cd7203d8b48824a6e0e@imap.linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=G+OJgNk5 c=1 sm=1 tr=0 ts=6ab184ee cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=Xgi9pjjPtvcisj4yZHwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDI3OSBTYWx0ZWRfXxzEg00pP+D7x
 54LNJrh5IpFh2l0uaAJ4Tohcy2b/ROiFKd97LFT3KQSWlbMe2WLMm8vpN0gjQ4T0Kyj+F5aN9ux
 ooMekuK+5Hsm81WE1ewo2S9GMD07RLH0ELUfv/ufa7K/pCYXRRaOkJHae5nFMQJ8CQOZ77twP4U
 XQW3iGy54NaBpUXRBKBAo0Mg+V6GtoYEundsL+7zocFA4VCSHZqapxILrrrKAPlSBOt+nmUCIlX
 8U+YdueeXJobhS2pGSyPLfKnPeB1/P8cr2QT9YcWE6NF77jxePb3XWH1Nkb+Fug2YzR2BT7QR4a
 uaRVWa2UumOAjwkjXRhWVkm6d5/KMdLKbwxO1XgT+FtOX8jNVwKEgob4lVJBQJFi0Kwiwql6trE
 Ezeg8T9WNkZ43xpwDYJN0IcwinAjoxYtYvgXvCgdgsrPrs1q5zJ+FsXDZf+ACzn+oPl4NGv7sAE
 FdTnVJUO7LKtOnNU94g==
X-Proofpoint-ORIG-GUID: a8PxXmDplA7WdE98ZVMAbjuus_uvxCue
X-Proofpoint-GUID: l18ZMeXMEawAD3hhx_qESs7ofoIhuFxq
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDI3OSBTYWx0ZWRfX9bWlZlIGHVUw
 Nr+lU6TdUFAKtT993OVxSA0zCynC71dg6lSzDEEd8vQvAtP8OoX7pdFPuZH7c9dr2G+1X/+iiwa
 2qlhOtgWjaVLDriiMBPNSXAu8Pgj508=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210279

Hi Nayna,

On 9/21/26 7:09 PM, nayna wrote:
> On 2026-08-31 07:17, Srish Srinivasan wrote:
>> The PKWM trusted source currently uses a single default wrapping key per
>> LPAR. This key is created during trusted source initialization, and all
>> trusted keys backed by PKWM are sealed and unsealed using it.
>>
>> Recent versions of PKWM allow users to create and manage their own 
>> wrapping
>> keys through a set of lifecycle operations. This patch series brings 
>> these
>> PKWM capabilities into the kernel, allowing users to create, manage, and
>> select wrapping keys for sealing and unsealing their trusted keys, 
>> rather
>> than requiring all trusted keys to use the default wrapping key.
>>
>> This series adds support for user-created wrapping keys to PLPKS and 
>> PKWM.
>> It begins with seven preparatory cleanup and bug-fix patches that 
>> improve
>> error handling and type consistency, clarify macro naming, prevent
>> unsupported capabilities from being exposed through sysfs, and update 
>> the
>> documentation and MAINTAINERS entry.
>>
>> The final three patches add the required hcalls, enable wrapping key
>> selection by label for PKWM-backed trusted keys, and provide a sysfs
>> interface for managing wrapping keys from userspace.
>
> Thanks Srish for your work.
>
> It would be cleaner to split these into two separate series: one for 
> the cleanups and one for the user-created wrapping keys management 
> feature. This makes each series easier to review and test. Also, this 
> allows cleanup patches to be accepted even if the wrapping key 
> management feature is still under review.


Sure, that makes sense.
Will split them up into two separate series.


>
> Thanks & Regards,
>    - Nayna

Thanks,
Srish.
