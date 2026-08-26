Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2507346D090;
	Wed, 26 Aug 2026 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787762746; cv=none; b=c6wVgaTl0MNkNCF0JLjB0QPswae7n4P/jR7K93eP1XzEb5cMG87rs0xE2Uz5LffohJbijKnKJUytalPWMbwAF9VD+iHDL0iXdRoqsWYNB8SzZ28nkYv0qqc/lmViXBXmhUPsFCEORqM2w/2PpbHa8Su96oCA0icGG1L1A/AdEyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787762746; c=relaxed/simple;
	bh=FKwdZ0kNj6TKNMz6cRANqkd4+E8cghbWEbTNvONfBgk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=LfzSsaFxCKg+x4axaQuuEBRQDpiHbGFVpxyjdiqskz9JlIQaseABoyaTalqMOU8vg8XEHc+ZZ9z+SZEd8c2EQ19JzJH+QAGAXR6QoSJiAziKE/PRNpZDBuqi5BYJ1jPFff3oJ5zM6Cl97FozrqE7xolhaAfTvvh9EoHdsrMaUeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PSpurddJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PSpurddJ"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QE1dFk070358;
	Wed, 26 Aug 2026 16:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FKwdZ0
	kNj6TKNMz6cRANqkd4+E8cghbWEbTNvONfBgk=; b=PSpurddJxZD7bjMvdy3hBK
	65NbDdFR9d8U2S+TWRGIkAtTbJ5KVlisA3ay3tZRYNY7oFm+YS8v6Yd0OblJw4VP
	/0UvvH/wW8zRrK4arMSicb9Bj5/my8ET6ygxqpKPYjUC5cT+UVmLF10Ird8DQ1Ri
	pWrYe6sRBUH/D4yy22MMysWjKXRMR1dXM4q1SLOdfUEBH6s/RovgruAfvPyou1eU
	rQlqQJyI8Ai4qQrQZKTelBjZQqw/AU/uP/7Tx7AyYaskEvAQVwVsFrBUTnWmDt3C
	Ln8gsn/6yV6lRBLIVf+Lbxaeji4uB4DtOkgx9OrNguNXEqrIs8vA8YJANRHQNfGQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxfmr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 16:45:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QGfEDm022800;
	Wed, 26 Aug 2026 16:45:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7p3qb7qd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Aug 2026 16:45:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QGj1ge36372960
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 16:45:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8DE820043;
	Wed, 26 Aug 2026 16:45:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C63DF20040;
	Wed, 26 Aug 2026 16:44:58 +0000 (GMT)
Received: from smtpclient.apple (unknown [9.124.213.3])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Aug 2026 16:44:58 +0000 (GMT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH v2 1/2] keys: trusted: tpm1: add bounds check in
 tpm_seal() before memcpy
From: Sudhakar Kuppusamy <sudhakar@linux.ibm.com>
In-Reply-To: <20260826080405.255083-1-sanketsharmacsec@gmail.com>
Date: Wed, 26 Aug 2026 22:14:46 +0530
Cc: jarkko@kernel.org, gregkh@linuxfoundation.org,
        "James.Bottomley@hansenpartnership.com" <James.Bottomley@HansenPartnership.com>,
        zohar@linux.ibm.com, dhowells@redhat.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org, security@kernel.org, w@1wt.eu
Content-Transfer-Encoding: quoted-printable
Message-Id: <284F8B1D-F60A-4BBB-80B3-D2814A165DC1@linux.ibm.com>
References: <20260825182919.15943-1-sanketsharmacsec@gmail.com>
 <20260826080405.255083-1-sanketsharmacsec@gmail.com>
To: Sanket Sharma <sanketsharmacsec@gmail.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEzOCBTYWx0ZWRfX9Rp50emSERgN
 AHLYL9hbvYxRs31CJ99rs1NXBcl/2vTz67iaTzDSvl1xcKA9JFnRZGhovc1BBMhaYCSUHo1nIcK
 vU4FgwXaOqgy9uXoDllVOQ/39qEfXzw=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8f1811 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=VnNF1IyMAAAA:8 a=Qxsn6e9zUWdzkDgwqbgA:9 a=QEXdDO2ut3YA:10 a=KSyJCaK48GcA:10
X-Proofpoint-ORIG-GUID: 3K8IBhSYKotbUWi57o4QzPLHEiMZX5Hn
X-Proofpoint-GUID: Kebi_T0TQU_Y4_fB7XJj5Y3JXcaeVrtd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEzOCBTYWx0ZWRfX9EFuzPyxXAd2
 08J1/rAtOE/vkIyc69D2MSm7rZse3vnFiyqCpNPZvtw4e5fMl1fIrQB9xzEtntfGQrd08IakGdS
 UaCIl5jyMIdxFr7kP/YddFr7LJJmD/VitYbtnn9q4Y2I5wPJgFffUZVaW/3rJeAnP0z19UpjjSM
 IBuB3746A55d+bBhhgIzxUk0dTzRXraPCVjrVLOpClaHaTd7mToHa0IttB9iNipJKIazPtwTXAj
 TxdN4LxrkOFyuYSoQseJPomATZ1Lk4NQN+VNur6ge6/Ys96QxJR4cDgzKxFvGJXKW+sy7U+VgG8
 eW0CzWYSMNyd1b8Kjs4HleZIT8MnoTOSlsdqhal15emEZOSKSLV/v6KmX6z679ufdbwrFnS2HoS
 6P21Nzcms27g7vKC88rhxrjf4aVgaZeZvP7DYLzq5NwIbdyc1YMZjfmhlG7Xa+qpJByMuRH820P
 /3YnU4eOTZztKsrv9kQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1011 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260138



> On 26 Aug 2026, at 1:34=E2=80=AFPM, Sanket Sharma =
<sanketsharmacsec@gmail.com> wrote:
>=20
> tpm_seal() computes storedsize from TPM response fields and passes
> it directly to memcpy() into a MAX_BLOB_SIZE buffer without bounds
> validation. A forged TPM response can set storedsize to 4086,
> overflowing the 512-byte blob by 3574 bytes into adjacent slab
> objects.
>=20
> Add a check that storedsize does not exceed MAX_BLOB_SIZE before
> the memcpy, returning -EINVAL on oversized responses.
>=20
> Signed-off-by: Sanket Sharma <sanketsharmacsec@gmail.com>

Reviewed-by: Sudhakar Kuppusamy <sudhakar@linux.ibm.com>


Thanks,
Sudhakar

> ---
> security/keys/trusted-keys/trusted_tpm1.c | 4 ++++
> 1 file changed, 4 insertions(+)
>=20
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c =
b/security/keys/trusted-keys/trusted_tpm1.c
> index 8f57c6111..d47cb7108 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -531,6 +531,10 @@ static int tpm_seal(struct tpm_buf *tb, uint16_t =
keytype,
>=20
> /* copy the returned blob to caller */
> if (!ret) {
> + if (storedsize > MAX_BLOB_SIZE) {
> + ret =3D -EINVAL;
> + goto out;
> + }
> memcpy(blob, tb->data + TPM_DATA_OFFSET, storedsize);
> *bloblen =3D storedsize;
> }
> --=20
> 2.53.0
>=20
>=20

