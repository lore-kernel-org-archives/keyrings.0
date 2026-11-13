Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581115;
	b=ZZz7nWOZtHONor2Rp9cAXmNIQmWgUVydiBmv8LkKhGh1yP5HRrklF0gLokPHByiVflXy
	 96cXr5u3JHKaSUTNooxvQ+kxYQJ4We+6Qt3OkE96J9/Goc+QQpq8W5BHnDUZXlP+aMdtM
	 DVwH4pM9zVFhc52EhqbuWSa9aM/yJZeYgfpQV60wcnVsJ7ksa9lqrLutU3PausS7Dbm6v
	 i6JENyCFu1Ae+70VLwd63af5mBs67l21HxQ150Y3j3mFJ2OG7rdli6/oJm9t6jiB/XlOZ
	 Z2DUKGkkDl+I6/OHUmG1hM8vc4IyYzN+io3JfXs8sJlj9md8XdttgCqj4ddNOXnPUlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581115;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=ydTUVXDliY8dDnSWxpGXxy/5egBwbdz7n5fMS8Wz8uc=;
	b=uhGZLaIBuQiY1jNOcB+drwBZEQIuc1vG/x9RPKXQFCJPc36vIbKkKSUDEqXggz35iYWU
	 4oK2ahLVW90NGOqZ3ZWDGtJV/VC4GnBtrdTNxxoLIG/5iNCpqcrL9XEpHeqkRzxNY3/hP
	 TUIUcd5SHMVQkn1OPMdBDzJ36qddec5HadqAZkCHNOVI4dbyGVRjiZhDIz6M9o8YNxeUq
	 sCtuTP34iyeHaN8W7vQHm8tqKyAqkEz2hyohs1RpW39W/e0rVErgHZv62PZeBmhP3SphI
	 9fUpsmh+0ePka5rML+4oL8Wsue5NrfDd9iCSESMzD9arepL7N/ygD/zqfpI9vyB23wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kfw9IK+v;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC58606A330;
	Fri, 13 Nov 2026 14:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FC58606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kfw9IK+v
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCENXM1667747;
	Fri, 13 Nov 2026 14:45:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ydTUVX
	DliY8dDnSWxpGXxy/5egBwbdz7n5fMS8Wz8uc=; b=kfw9IK+vw72S8WrPuPOolK
	1haQ6UPc1q9QUycJHCsbhd++9mfQJYWxccNzpDa3OU7ergKOQIB6bNPAXmVLLsYw
	fMXGFiFSjgVMxq7P3BPL3dYe0F1JNFn+V6rxtGuwRFs1jggdKWmc07umMOu4aQ+5
	9jpaeZKl6h33tHlxaHjO9bRKN3q+JQvrnnKZtSCUt5F1O1V8ynLSN8y0+XhJgkMX
	J+iEz/Ps7uvTXHwpNB+aLkVSi539iub1LrbiqrqlspFnc0QN12zCaLeqOEZdlWH5
	kSLJ8HIWehYKiZV+H2SkRZGdJMBVSCLzP1FMJ466fn+TtEROaCU1h1HHRoOKhJ/w
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdgjyh4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 14:45:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC5Ki52352642;
	Fri, 13 Nov 2026 14:45:07 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwc0tcq4n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Nov 2026 14:45:07 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADEj6NE54985132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 14:45:06 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCDD858059;
	Fri, 13 Nov 2026 14:45:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 28AC45805C;
	Fri, 13 Nov 2026 14:45:06 +0000 (GMT)
Received: from [9.47.158.153] (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 14:45:06 +0000 (GMT)
Message-ID: <5c9ba3d6-cf55-4a8d-914d-2c85f7b7f5cf@linux.ibm.com>
Date: Fri, 13 Nov 2026 09:45:05 -0500
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KEYS: Fix signature input size for KEYCTL_PKEY_VERIFY
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        dhowells@redhat.com, Florian Bauckholt <florian.bauckholt@cispa.de>
References: <20261113140311.1375048-1-stefanb@linux.ibm.com>
 <avcaQGqHKnNFNFSG@kernel.org> <avcadBCRBGUXDapR@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <avcadBCRBGUXDapR@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af72273 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=M43pvfWBF3vM85GmxsMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1OCBTYWx0ZWRfX9pOcGW8LTmM1
 Chx4pg9tnUADerOiz/fhtdjKRSpsLKvPY+8uSxMgtT5bce9iL8Qz0wWtWDoalNSRrh5uLB5zIFC
 1qE3n9JIjnEgFqHnKv4UYWcty/XawJhs0dioVn3YQJKkbHX2uAVNTyc9lZ6ntQY+Ig8pITZ7sPR
 wqX8AiNcB13oyMPsndOGDkLxB5T6UDaRAsqGk4VXhsyxkbXQZ4CyLKbHyxB0crMlk1HHw7rsxlq
 O1vEDmzPx8b/VpnAxXjXpGD/uWuqg43aBkoyoEACHmOSp8fPTHAvA+t4aHcDsNA9pvexhcRruZm
 tunxN+D6+ijVER6yWPE/gSudK4TknSCTQ/uCSteXwMlFqJN2Z7J74fkKEAKAYjx5Wi44mnSGn2z
 eJaKiNFlFrR2P0Fdbli8X3dTgHDzWnSb6c1yuNNKx8rX1TxxvOkmbBUgvmHF0BG9A8U52qlPuEe
 4IUBrefCKCV82/IhO9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1OCBTYWx0ZWRfXxBEnpLuiSVN8
 1PWdfwIdwZJe0fnSCIwGUZjUwjItvGe+70DuQy730tfrzk6/8e/jaugnvV0Al44rH9yMkEUDzDu
 pZDVEfKRwGphWQls+tWOCKOchPYbzLw=
X-Proofpoint-GUID: O1akjyiLhMwsdg7_Hqm5Ip3MENWb2Xip
X-Proofpoint-ORIG-GUID: O1akjyiLhMwsdg7_Hqm5Ip3MENWb2Xip
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130058



On 11/13/26 9:11 AM, Jarkko Sakkinen wrote:
> On Fri, Nov 13, 2026 at 04:10:12PM +0200, Jarkko Sakkinen wrote:
>> On Fri, Nov 13, 2026 at 09:03:11AM -0500, Stefan Berger wrote:
>>> Revert the changes made for signature verification in cb481e59ea6c back
>>> to the old behavior where effectively the params->in2_len was set to the
>>> length of the user provided buffer uparams.in2_len (out_len is an alias
>>> for in2_len due to the union). We cannot use the max_sig_size in the
>>> case of signature verification since this is neither the true size of the
>>> input buffer nor would it pass tests of size indicators found in the ASN.1
>>> in the buffer comparing against the input buffer size.
>>>
>>> Fixes: cb481e59ea6c ("KEYS: fix overflow in keyctl_pkey_params_get_2()")
>>> Cc: Jarkko Sakkinen <jarkko@kernel.org>
>>> Cc: Florian Bauckholt <florian.bauckholt@cispa.de>
>>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
>>> ---
>>>   security/keys/keyctl_pkey.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
>>> index 15b6bf6399b5..794fa3d01911 100644
>>> --- a/security/keys/keyctl_pkey.c
>>> +++ b/security/keys/keyctl_pkey.c
>>> @@ -160,7 +160,7 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
>>>   		    uparams.in2_len > info.max_sig_size)
>>>   			return -EINVAL;
>>>   
>>> -		params->out_len = info.max_sig_size;
>>> +		params->in2_len = uparams.in2_len;
>>>   		break;
>>>   	default:
>>>   		return -EOPNOTSUPP;
>>> -- 
>>> 2.56.0
>>>
>>
>>
>> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> Did we have reported-by and closes tags for this?

Let me add this here for v2:

Link: 
https://lore.kernel.org/linux-crypto/473700a3-f5d7-4a7a-b89a-12c51adcc3df@cispa.de/T/#t
Reported-by: Sashiko <sashiko-bot@kernel.org>

Once Florian added his Tested-by: to v1 should I then add this?

Cc: stable@vger.kernel.org

> 
> Br, Jarkko

