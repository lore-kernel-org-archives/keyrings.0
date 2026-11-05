Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793880776;
	b=QjlJRe16lN5dMqudfNHkunjLJWvH5nVqDhL4KxaKB46y+22nEAgr6d9SzhMYiJRFHvTs
	 l6uc8Tt+IrgRMJhBnHG7gqNak2xVTQVOSQ2zN6r3KoA0I+Ey04Q7IqVAyBgNxR8qetPSH
	 fuaf+6fO56E6GD51WHOrZ8OAxdPcf6JvP8IFYeNHXDmtlO+mIsQjb5xFI9XjFjrcyh6aE
	 7Wm0lvVLDJ9pmAkI5PQQ1gDac4+lcOpoah/7j3w9aAf0KdF7e3wbUoWiKCrq51BzRmr9v
	 H3+X41qQJdxaEiZMZKSbfhnbRx2j/b/KO2ZXD+1llry9+Tw2nzph9Vc3h5uNLPX8Xng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793880776;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=00ek9Ej6DuVogu5zP3exew52MggQez4Mp5KV7aYfsRA=;
	b=ZBPbRzIGGmW0fl4/BzVataZ41fnrGJvZYWaf3btb3MHWPlsQ+c12HE8MYiJCiuDjudQN
	 iyrJAhCqzvpvfYp4pI/J5lI1xF9e+3p1EANFF0B07qPReh5W7LWRzb4p69NxaenG1b/Ar
	 5wc4sGfG90+T7cbxxy9DQ3apEOnlMZim3de5DjHlkFMJ2RxO6qnzSkYVCY1q7rUZrgiVY
	 o2h/+EXG4EsnxltY40zInkjEKZ+f8CUT4OtDwLiITgH1WZgi87d95XpThbpdrrjIi62z4
	 bwUJ0X2Kl0w9EdwcvvrEr8NwSExeXeBsS3YCaOMPxewXeHFmfyC2jg/9JB2j+ChiwAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TLbQXrsD;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F7C606A329;
	Thu,  5 Nov 2026 12:12:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3F7C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TLbQXrsD
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5AEC4h3166406;
	Thu, 5 Nov 2026 12:12:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=00ek9Ej6DuVogu5zP3exew52MggQez4Mp5KV7aYfs
	RA=; b=TLbQXrsDiyeNbiRPCdSoJxZ6OoqKMRQQR2ZbqlpF0QXLqUfcD8SA5XMXO
	VFcjzCwCfGkYNVklzObqXZ5qYfofVE7MuoC9EEa12K3U1yPwIShYUBZ6D7EbcX67
	tkj6c7Y+Y6klRanum3l6HuVRPCdizlhkyNiO0fBNVQHdbWCS9O6phl8x7UMeyzHG
	VdUKAw9H5tb0e9BkgIIX5pjfquGnnzOJ91opKU0zmCGjzo7Pf/Qn0NY8QcyRkbAd
	Eoy64unI1X17NYDXge1Uus8vCyPnZpM3vNN8q8RMFtESQBiKKCXrljM7JxiWDZUd
	6HQx47y7k0HkedlJIGy7UJdA+KYnw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rj1rmb-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 12:12:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5A4s071476854;
	Thu, 5 Nov 2026 12:12:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka6spc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 12:12:34 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5CCXq041615820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 12:12:33 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E44C52004B;
	Thu,  5 Nov 2026 12:12:32 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 079CA2004E;
	Thu,  5 Nov 2026 12:12:31 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com.com (unknown [9.61.54.214])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 12:12:30 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Roberto Sassu <roberto.sassu@huawei.com>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] ima: use the system blacklist in lieu of the IMA blacklist keyring
Date: Thu,  5 Nov 2026 07:12:24 -0500
Message-ID: <20261105121227.4089147-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: STcF29WCR2h3a8WENpf03rNAyg0AfHVO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0NiBTYWx0ZWRfX3eVu9aUaO4Mt
 pkUW9hUksmLRFTTy9icns1Ju6FXVpduyFdJl+0ScgveYyCHYKz71N8K194figW3kFb5+aPpqFl8
 LVKSIORZdBzbL78CIjnDDXy3HND65VY=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6aec72b3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=E4YdAB1t0zyyqKEc0TgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0NiBTYWx0ZWRfX8aHZjtEpKhCM
 wP36jYEQ+MIfoSCkTJbg3X22quBFWLHNvgPiZdPnziTFTkeYTRflrdDoMPw+tnvanNn/vOGCKpo
 Oa3Me3PYZqZcXY+ZHvQZpxadwECA/2dDDANezUhPros0TJFvkPh5QbnyPbngSWzxBhaY8HmY7yE
 7lo8/QyQx72wRhBDvw+V3iKcqUtMlWVpuCKZhxjJp0l3Qzmk2sOiIfN1F4E5ls0NuVFGiD2JLOQ
 gzYGL0QMWNc1d+qSzE0jkOnQChbULhWADFrxTl8UicDrDZBP9FHtxH4ctyAsuvsbNZrfh27Jf2p
 EAFTv3pCz1FT142EtRDLofI1dZHznAKvtsXYXCEi/CX3iqFm7utq6GgxlpALVskYhGvm7bpMj/s
 zlLTFmxdGpoEezXUUg0wWIv9W3xAxw7c5Y8kybZgTaMDhIbhrbZVXl0SvasmopU5YaSMFN5HczM
 ao3sRF2F1j3t6JmFwgg==
X-Proofpoint-GUID: STcF29WCR2h3a8WENpf03rNAyg0AfHVO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050046

The experimental IMA blacklist keyring accepts any certificate signed by
a key on the builtin trusted keyring.  The certificate being revoked was
created by such a key, so root can add it to the blacklist.  Nothing
differentiates the authority to sign from the authority to revoke.

The system blacklist already supports signed updates
(CONFIG_SYSTEM_BLACKLIST_AUTH_UPDATE), but cannot revoke a key that is
already loaded on a keyring.

This series defines "skid:<hex>" entries and adds is_key_blacklisted()
to the system blacklist, has IMA's asymmetric_verify() call it on the
key it finds, and removes the IMA blacklist keyring.

 1/3 certs: blacklist: define skid: entries and add is_key_blacklisted()
 2/3 integrity: use is_key_blacklisted() in asymmetric_verify()
 3/3 ima: remove the experimental IMA blacklist keyring

Revocations for keys on the IMA keyring are now "skid:<hex>" entries in
the system blacklist.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Mimi Zohar (3):
  certs: blacklist: define skid: entries and add is_key_blacklisted()
  integrity: use is_key_blacklisted() in asymmetric_verify()
  ima: remove the experimental IMA blacklist keyring

 certs/Kconfig                          |  7 ++-
 certs/blacklist.c                      | 81 ++++++++++++++++++--------
 include/keys/system_keyring.h          | 22 +++----
 security/integrity/digsig_asymmetric.c | 25 ++++----
 security/integrity/ima/Kconfig         | 13 +----
 security/integrity/ima/Makefile        |  1 -
 security/integrity/ima/ima_mok.c       | 49 ----------------
 7 files changed, 82 insertions(+), 116 deletions(-)
 delete mode 100644 security/integrity/ima/ima_mok.c

--
2.56.0

