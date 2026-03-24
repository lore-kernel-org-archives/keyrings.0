Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059E243147;
	Tue, 24 Mar 2026 23:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774395978; cv=none; b=UH5wUYkWYabwYRP6kWbXZDXWzDD8Mxh5ri5TVpb2RTnWOononlkBwpbioA84bOajLWD8Lw/Z94lZEXM8eu0ONMm1S02qdqlrKeTKmL5awoia7DgG2gHRCeiv72CIvHjBlIpHA3UvbKaEINnRoHBmZPac5OPQFXSunIrpvQESHdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774395978; c=relaxed/simple;
	bh=j8hD2jNKXip7jtFuNWO1v8j7LSTjLZn6igxu8mGv80U=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=ieOJfWI/CNnjGkoXgkQV07OZKfmlEmohL0OAWU7m2TuUGDTxHw1bM1mw941Z/bZ1jnVcgoOyAVSDUc5a4pMcPfqDrTHdNi3D3WlmOdwZEFqDNd8zl6/rHjDDNhpqCQWJaMVqPVgm/VA0NX3oERtjHPPl1xzvg2m5ZZye4eawd1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NJP56Qj9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NJP56Qj9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OJWb1H510743;
	Tue, 24 Mar 2026 23:46:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=5Jpm4x
	gm2JFYRw1TeWhchI3irWfxAOBBfGCxwZnJBeI=; b=NJP56Qj9BQhVvTc3lybNEa
	E8X89P1rHi21TSzA/n3TTRzQVbjTiaRAFHn74rY/apEOS8xmm/TDEE3WRmfKXVxF
	xbi5mXE9+KGMVK7tSThV/M4of3prKJGKlAxXGh9Vuj7mYRA9ObLukxJq1uSpvcoh
	22MrWaKdlK/vAQBwf6eHyI44eF+brybUyaUVk/QAVlIHru8T5XUv3UKNIldr1846
	qSRsCEFxTxVIzTOth25D1wXZ/m9lla/U90yPu/u1iWNe7dVqVlDveaXVecCqY2wT
	SX2751CJ+fef8n7AXSDvnZdMAnYIpriutDECiA0aYrGzAE1de2CR+81v8SD4pfuA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9x51e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 23:46:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OK8NMH012213;
	Tue, 24 Mar 2026 23:46:12 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk442c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 23:46:12 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62ONkBcX26149456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 23:46:11 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62E3F58053;
	Tue, 24 Mar 2026 23:46:11 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C07A758059;
	Tue, 24 Mar 2026 23:46:10 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.129.207])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 23:46:10 +0000 (GMT)
Message-ID: <e77dc41b88d60377b81a0cdff4e3823d8aafe98a.camel@linux.ibm.com>
Subject: Re: [PATCH] KEYS: encrypted: Remove unnecessary selection of
 CRYPTO_RNG
From: Mimi Zohar <zohar@linux.ibm.com>
To: Eric Biggers <ebiggers@kernel.org>, keyrings@vger.kernel.org,
        Jarkko
 Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20260321224218.60418-1-ebiggers@kernel.org>
References: <20260321224218.60418-1-ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Mar 2026 19:46:10 -0400
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: knc0qg_kx-Yq0sWwVwQSqZt1JJzlBJkG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE4MCBTYWx0ZWRfX783gJMEp4Q58
 hPSOwHnl5gMSe+zBLjFxrpRkas/hb8GIHIyUthAjQ3e2kxgaflY7vQXpLyNQJQnn3huMwvFY67M
 irooaxQihgs5YrX6ZnfLHZVAI7wE6jexidP2SzmiaWUA2x8SG25l7Ah6qWolwT8fs4ySUGY7y5k
 DQzE8XRl/86EFb0ghG30tFUTcq/djApX5zlF7b69iBzbzlRbwZLWBrd9V+Zna4DKlqRwCwLAZFl
 3G9D8wF5xEL5w+1+/CUIefteMjdoqW2XX0e6RemfX5MTZOMWHiLgRBsE9R51y35m51E3dXzRAoS
 Y1QcjSVb+C3YtKOWl6+M4Rws9KWFA/4wH1P+kgO0ltCY4jeILfIvFNvUcVxrJiMsjG1KmedmvMl
 rvCv6xrb+Rjuxj8WQxbuhpk9lHfxr1samNfYhE0nGlwa8oatsM0YTBHtl4xmpJ7fynHdRjosJgE
 54tSSF56b6T9C4UJLcA==
X-Proofpoint-GUID: knc0qg_kx-Yq0sWwVwQSqZt1JJzlBJkG
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c32245 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=FyE-LDBX9pdfyYag65MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240180

Hi Eric,

On Sat, 2026-03-21 at 15:42 -0700, Eric Biggers wrote:
> encrypted-keys uses the regular Linux RNG (get_random_bytes()), not the
> duplicative crypto_rng one.  So it does not need to select CRYPTO_RNG.
>=20
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>=20
> This patch is targeting the keyrings tree

Not sure what you mean by targeting the keyrings tree. I can definitely que=
ue
it.

>=20
>  security/keys/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/security/keys/Kconfig b/security/keys/Kconfig
> index 84f39e50ca36..f4510d8cb485 100644
> --- a/security/keys/Kconfig
> +++ b/security/keys/Kconfig
> @@ -85,11 +85,10 @@ config ENCRYPTED_KEYS
>  	tristate "ENCRYPTED KEYS"
>  	select CRYPTO
>  	select CRYPTO_AES
>  	select CRYPTO_CBC
>  	select CRYPTO_LIB_SHA256
> -	select CRYPTO_RNG
>  	help
>  	  This option provides support for create/encrypting/decrypting keys
>  	  in the kernel.  Encrypted keys are instantiated using kernel
>  	  generated random numbers or provided decrypted data, and are
>  	  encrypted/decrypted with a 'master' symmetric key. The 'master'
>=20
> base-commit: 113ae7b4decc6c2d95bdbbe52e615a0137ef7f9f
