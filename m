Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D6241A4E4;
	Wed, 26 Aug 2026 16:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787762938; cv=none; b=tcB8bYahBqlnBILDzkRyATlpmaCo4PyUIUIUTBfzQ6XzSLZqBoz+dB07PP70CjZ1Zn0HWa1vNE1gT1GVUL3Ut+IvBTnr5lLXuSHqeb1byHmB2qG1bidRgQvaE6VUn9B2P3oSTFIqgBHhLpICiij3mdgmm2to4kkti6SR12MoHjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787762938; c=relaxed/simple;
	bh=obc+IRsBRKyKcqGaGQ0d48PPiKl+8gfBIBrd9w4+4QU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=QLEyN/fhXuQkwtQfGXmu3HcqgFCAEL2CzUwGqRw8MbCsbKEI+OOuJXn2XzL+px3KNV/jrkjpxx5gq28y8w/r3pmxBEmDlaeutbZTpJwOyoI2ZnovmqSePvRdYidiC1ho2RCXNbZ/nH2buK3mFE+o348VXfYIg80Yq4vNdxLrdfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aDCm8Gqg; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aDCm8Gqg"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1X9b015968;
	Wed, 26 Aug 2026 16:48:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=obc+IR
	sBRKyKcqGaGQ0d48PPiKl+8gfBIBrd9w4+4QU=; b=aDCm8GqgRFpUzUVwLgXN8r
	j/wfAFfjdmlb6TwExN3cT6CY/NI+oADQGZFvrvqPFqQkH0WcGxNPYm9SqtUZ7Ivw
	WhQ08gvkheTpFhJh5GrIiU5YWylrAgsK3Big+xtb66+r5/WSb1RyH06zAro8eUwe
	wSEEBsDMIqSGSMH0468F75/Etw940t/Xz0EsujrUNT7X21SfkDq+jW1DqkLLw31q
	1CHgQRbhIjc29sbf2j4u46ZqUTyGuvAuIKKJUS2mXxfCPHRzld1yAbG36r0IksNi
	vrJpMmrecr6cKp2QntldmtIqQJiqVhvUgZXfsOyQPGde3OveYzAcFjmf8Fqh2ICA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g50064-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 16:48:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QGfKPT023110;
	Wed, 26 Aug 2026 16:48:09 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k315b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 16:48:09 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QGm6Rv44761472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 16:48:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E127720043;
	Wed, 26 Aug 2026 16:48:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F323120040;
	Wed, 26 Aug 2026 16:48:03 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.213.3])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Aug 2026 16:48:03 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH v2 2/2] keys: trusted: tpm1: reject unauthenticated
 response tag in TSS_checkhmac1/2
From: Sudhakar Kuppusamy <sudhakar@linux.ibm.com>
In-Reply-To: <20260826080405.255083-2-sanketsharmacsec@gmail.com>
Date: Wed, 26 Aug 2026 22:17:51 +0530
Cc: jarkko@kernel.org, gregkh@linuxfoundation.org,
        "James.Bottomley@hansenpartnership.com" <James.Bottomley@HansenPartnership.com>,
        zohar@linux.ibm.com, dhowells@redhat.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, security@kernel.org, w@1wt.eu
Content-Transfer-Encoding: quoted-printable
Message-Id: <A16F8908-4440-43FE-814C-2129C2B30478@linux.ibm.com>
References: <20260825182919.15943-1-sanketsharmacsec@gmail.com>
 <20260826080405.255083-1-sanketsharmacsec@gmail.com>
 <20260826080405.255083-2-sanketsharmacsec@gmail.com>
To: Sanket Sharma <sanketsharmacsec@gmail.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: wmWzGIHluAZXJb3idDoRZO9sixnTeQx5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEzOCBTYWx0ZWRfX6fEsw9DyckDf
 xpPPMmxcUtHOYjwKDPhQiXUqRCvvoo3eEtZlpOyrtOJr3XKX2CeIyMhJdMedc+5Xpn3blQTmXCH
 6pdt2TYrLPfkdcRikuLWt1OyWP9eoVQ=
X-Proofpoint-GUID: BM2COZajFAbUGG38GdJR3Uzj-vDUP2oN
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8f18ca cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=pGLkceISAAAA:8
 a=NrVHMxhdPDTnOdUCm4oA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEzOCBTYWx0ZWRfXwZDTbjQ3YzDu
 4UPOlWuO1Zj4KJsUkXGpE0tFDfhqEK0YYsYzGjRRpBx4xImi0RQx2hT/FSBPxe1/7vSbmFAjfBd
 rZFRtutCsiT4m5ArKaTYYXLYDoQq9oEzfxTjqSuSj17uPMVkYFRXD3a64pJIQpYcLACvSSFgKsR
 MomantNl3tB8SOZkgboj9FQ6caQ9fK7uAieokvGJfveGB1Z53drPMJwxbT0VE6KjPhr17I7XlMa
 +HZaf5X3lO8b6Xkc9cBRrWmtETD/FCxy0hF9RLQ3UL7MHyE0uFHFJksF0Y4+UlY6xwNbMuhJ4qf
 XY40mQg+rC2ickmiDl0Gh3o2/A2cTg77tALtvXkR4QmjPXUq7SvcF49/Ykx//zluV8lu8CnFQZQ
 z1+Sp5L2ktLjJw0O7V+Eec0fsmRL34QaCT9BUHCNbhu4n7McPTUXycfQq8Rx5zyNu+2QDhNd/r/
 U27zhU5Z1Xc/zhL8z1A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260138



> On 26 Aug 2026, at 1:34=E2=80=AFPM, Sanket Sharma =
<sanketsharmacsec@gmail.com> wrote:
>=20
> TSS_checkhmac1() and TSS_checkhmac2() silently return success when the
> response tag is TPM_TAG_RSP_COMMAND (0x00c4), bypassing HMAC
> verification entirely. A forged TPM response with this unauthenticated
> tag allows an attacker to skip integrity checks on TPM responses.
>=20
> Reject TPM_TAG_RSP_COMMAND with -EINVAL in both functions, requiring
> all responses to carry a proper authenticated tag.
>=20
> Signed-off-by: Sanket Sharma <sanketsharmacsec@gmail.com>
> ---
> security/keys/trusted-keys/trusted_tpm1.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c =
b/security/keys/trusted-keys/trusted_tpm1.c
> index d47cb7108..c89fc6cfe 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -202,7 +202,7 @@ static int TSS_checkhmac1(unsigned char *buffer,
> ordinal =3D command;
> result =3D LOAD32N(buffer, TPM_RETURN_OFFSET);
> if (tag =3D=3D TPM_TAG_RSP_COMMAND)
> - return 0;
> + return -EINVAL;

Hi Sanket Sharma,

Instead of changing the return value to -EINVAL inside the =
TPM_TAG_RSP_COMMAND check,
we can simplify the control flow by removing that block entirely.Since =
TPM_TAG_RSP_COMMAND is
inherently not equal to TPM_TAG_RSP_AUTH1_COMMAND, the subsequent =
mismatch check will naturally
catch it and return -EINVAL.=20

Thanks,
Sudhakar

> if (tag !=3D TPM_TAG_RSP_AUTH1_COMMAND)
> return -EINVAL;
> authdata =3D buffer + bufsize - SHA1_DIGEST_SIZE;
> @@ -270,7 +270,7 @@ static int TSS_checkhmac2(unsigned char *buffer,
> result =3D LOAD32N(buffer, TPM_RETURN_OFFSET);
>=20
> if (tag =3D=3D TPM_TAG_RSP_COMMAND)
> - return 0;
> + return -EINVAL;
> if (tag !=3D TPM_TAG_RSP_AUTH2_COMMAND)
> return -EINVAL;
> authdata1 =3D buffer + bufsize - (SHA1_DIGEST_SIZE + 1
> --=20
> 2.53.0
>=20
>=20

