Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282288;
	b=eb7VFs2tlTgkY9XRshddMoclzSiAGJ4wqJTMZvUGSzcUeuVhIylIpbs194MwVk5TG5Bg
	 iQdE2vKZsJGbeDjOSMrlAtw1J4PGPj0GuATNTaW3lHHt5hPu6wgnJfbuPbnSBiCnVkY4J
	 lA5imIQczpZjE1gQv6gGsHJmlJGi58SATBloUhelCo6jYIL1e0nOtvFhZhU16OqU7pkOv
	 UxagiaI6BSsvswwPf50J+zmWgs1QsjPjOcN5h7fJxJuJjwTbX9iUR19Mu6qNv/i4kDqkm
	 Gfr7cYGP7pFDNCfvSj0pspXlqn2ySXZAsgck1MlvWv0vXnuaFR07Y7VdThiGKscOzWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282288;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=uhwaCPa5JRqgUjXCODgcbcqwFsDag4JYrxFt3GwiJ78=;
	b=mDBy9TFK8LyPH+eQnMJoomLqfGci0A6iAytfu3VfVKWQAIJgs1XsyOCzlpVczB/gqaAQ
	 hutEWQtKnIWh6P+Ls0Enzk7H5p992m2yrCpfsJFd/crelXOfAYPX39BgAKkaKgqh5Chg0
	 FwP1AGCujvJPD6LEzG9uADfJKHZwCK2mK0qw8uRTODKKybrUx+JFHiZ4ph7U+oImiLaaT
	 q9d7L1Ysj/SnV3MuY+YFZN/46A/hV8NKfcUssDSEU/1goRB0Ea6nWE+IFTOg2kkCKVnLl
	 xR2snwpjP7WJpDr0QWRel40VAQ+dBeyLUdPGwa+2xgtaAxJWqmaToIic37vXOXkk+SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OM8uwNaZ;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD40606A31C;
	Tue, 10 Nov 2026 03:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAD40606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OM8uwNaZ
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA0i9K93480173;
	Tue, 10 Nov 2026 03:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uhwaCP
	a5JRqgUjXCODgcbcqwFsDag4JYrxFt3GwiJ78=; b=OM8uwNaZkSKKkVsZu25oM/
	eUncYj+TeGLvWGTnJKh/tzMvs6CYAnP8kt99eDfjKnsk7PowxuX1+3g8OkztNHTu
	Z/VBFYFs18kvEdeHyxhVdpPLuDnXVblZosyyvLTghLQ/Dz3Puxta+yo+oXZvJpt0
	5/1n0PTeYulZ6+BvSFqUVy9OkX/knsLsKl59//vTcE1xVRZUYnTFfALWDeqdC+7r
	uRRB7L1Rvwu72Z89YnUobRj1Fn8zgyw5TlRDOIx1W75p3hqPir873EPP7N+oSZxU
	WnZjVKBxq2iRD/qNaovFGGrozr6EmerKu+Nzh+v+2ndMbDC1JPmC8pXC0G7Uw9cA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsunt303y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 03:44:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA0o1eb954794;
	Tue, 10 Nov 2026 03:44:35 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfak4xvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 03:44:35 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AA3iYW832047646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 03:44:34 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FE4E58056;
	Tue, 10 Nov 2026 03:44:34 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A82CD5803F;
	Tue, 10 Nov 2026 03:44:29 +0000 (GMT)
Received: from [9.123.14.23] (unknown [9.123.14.23])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 03:44:29 +0000 (GMT)
Message-ID: <d0b84ceb-8926-4e7b-bca6-9cc8b837658e@linux.ibm.com>
Date: Tue, 10 Nov 2026 09:14:28 +0530
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
Subject: Re: [PATCH v6 9/9] pseries/plpks/wrapkey: expose PKWM wrapping key
 management to userspace via sysfs
To: sashiko-reviews@lists.linux.dev, keyrings@vger.kernel.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        nayna@linux.ibm.com, rnsastry@linux.ibm.com
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
 <20261105144320.357260-10-ssrish@linux.ibm.com>
 <sashiko-outbox-199284@kernel.org>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <sashiko-outbox-199284@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxNCBTYWx0ZWRfX3kCLRQv9uUri
 fA9YGBxVaer3SELKqfF2fsZCPJNQ/xBWn904QVmcZ0FNx5ucSIBQghUzrDV+L9Xa01JSGf1QeqC
 1dxlwFgYPW0XHf9/w3jkYowuVHHPqosPYN7TUb490GZ5Y0Wk77GLyUjHjfrybDQpIJVyFX8fwgf
 wSHzJw6VdUbkM8rGHsYu/LKVyG3qI0DvZpCbUHAqUKINDNKruH42TVJR6a5WPxqjZb8vDkZAH7T
 3U7lypyQDWN9zxs6MXFAuytkH/FhFetqI48evMeLnrJzggmtZGbqeJtQ3h/A7tJM9hckUOc8yKd
 HndhG3NJtN7XDTUY93oRr2Ox7jamG5vqVf2FrweJu5+IkSMz2VRB/b7c/YZQ/zV4LcHn80kGGt5
 ENk51EJJ4i/XcJObI+wrBC47V8IkVrSQqXGZkMyihZhPnm62tWEgIh+ZMmwlcLv9QFUz9cyTiu2
 frwtjnLIHfmRIATKMBQ==
X-Proofpoint-ORIG-GUID: ZR7XViUcabHuWNbR42r2QoUvpE7ypHwj
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxNCBTYWx0ZWRfX6tM6yJPfifuv
 u0X7b9csavYrKt9811kXZEvSnGvZbrbj2IjqN7470afwgC63jQHAnKTyCRExBOMp+IrJO3+yETj
 C9satVS39ioyW1Bnb89BHKxllOdRxtY=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af29324 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QUUJxjL6Vp10tb9qvx0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nKMORCa3UUQg_mvwF9PdaoBSQ5FFdkHj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1011 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100014

Hi

On 11/5/26 8:32 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [Medium] pseries/plpks: label truncation and undocumented format in list_key_labels()
> - [Medium] pseries/plpks: TOCTOU race between delete_store() and unrevoke_store()
> - [Low] pseries/plpks: duplicated sysfs store/show logic in plpks-wrapkey-sysfs.c
> --


Yes, these are valid findings and I will fix these in my next version.

Thanks,
Srish


>
> commit 58203a02dbc210e21378df2545831a7ea49bbca4
> Author: Srish Srinivasan <ssrish@linux.ibm.com>
>
> pseries/plpks/wrapkey: expose PKWM wrapping key management to userspace via sysfs
>
> This commit adds a sysfs interface under /sys/firmware/plpks/wrapkey to allow
> userspace to create, revoke, unrevoke, delete, and list PKWM wrapping keys.
>
>> diff --git a/arch/powerpc/platforms/pseries/plpks-wrapkey-sysfs.c b/arch/powerpc/platforms/pseries/plpks-wrapkey-sysfs.c
>> new file mode 100644
>> index 0000000000000..c293196cc9adf
>> --- /dev/null
>> +++ b/arch/powerpc/platforms/pseries/plpks-wrapkey-sysfs.c
> [ ... ]
>> +static ssize_t list_key_labels(char *buf, u8 *obj_labels_buf,
>> +			       u64 obj_labels_count, int revoked)
>> +{
>> +	struct plpks_var var = { 0 };
>> +	u8 *obj_labels_buf_ptr, *comp_prefix;
>> +	u8 *key_label_ptr;
>> +	u16 obj_label_len;
>> +	int len = 0;
>> +	int is_revoked;
>> +	u64 i;
>> +
>> +	var.os = PLPKS_VAR_LINUX;
>> +	var.component = PLPKS_WRAPKEY_COMPONENT;
>> +	obj_labels_buf_ptr = obj_labels_buf;
>> +
>> +	for (i = 0; i < obj_labels_count; ++i) {
>> +		obj_label_len = get_unaligned_be16(obj_labels_buf_ptr);
>> +		comp_prefix = obj_labels_buf_ptr +
>> +			      PLPKS_OBJLABEL_LEN_FIELD_SIZE;
>> +
>> +		var.namelen = obj_label_len - PLPKS_MAX_LABEL_ATTR_SIZE;
>> +		var.name = kzalloc(var.namelen + 1, GFP_KERNEL);
>> +
>> +		if (!var.name)
>> +			return -ENOMEM;
>> +
>> +		key_label_ptr = comp_prefix + PLPKS_MAX_LABEL_ATTR_SIZE;
>> +		memcpy(var.name, key_label_ptr, var.namelen);
>> +
>> +		is_revoked = plpks_is_wrapping_key_revoked(&var);
>> +		if (is_revoked == revoked)
>> +			len += sysfs_emit_at(buf, len, "<%s>\n",
>> +					     (char *)var.name);
> [Severity: Medium]
> Can list_key_labels() silently truncate wrapping key labels when reading
> /sys/firmware/plpks/wrapkey/list_active or list_revoked?
>
> plpks_get_object_labels() can retrieve labels across multiple 4KB buffers via
> H_CONTINUE, and each label can be up to PLPKS_MAX_NAME_SIZE (239) bytes.
> However, a standard kobj_attribute show buffer is limited to PAGE_SIZE - 1
> bytes. Once len reaches PAGE_SIZE - 1, sysfs_emit_at() returns 0 and any
> remaining wrapping key labels are silently omitted without any error or
> indication to userspace.
>
> Also, list_key_labels() formats each label wrapped in angle brackets
> ("<%s>\n"), whereas Documentation/ABI/testing/sysfs-firmware-plpks does not
> mention the angle-bracket format for list_active and list_revoked. Should the
> output format and buffer limit be addressed or documented?
>
>> +		else if (is_revoked < 0)
>> +			pr_warn("Failed to get revocation status for <%s>\n",
>> +				(char *)var.name);
>> +
>> +		kfree(var.name);
>> +		obj_labels_buf_ptr = key_label_ptr + var.namelen;
>> +	}
>> +
>> +	return len;
>> +}
>> +
>> +static ssize_t list_active_show(struct kobject *kobj,
>> +				struct kobj_attribute *attr, char *buf)
>> +{
>> +	u8 *obj_labels_buf = NULL;
>> +	u64 obj_labels_count = 0;
>> +	int rc;
>> +
>> +	rc = plpks_get_object_labels(&obj_labels_buf, &obj_labels_count,
>> +				     PLPKS_WRAPKEY_COMPONENT);
>> +	if (rc) {
>> +		pr_err("Retrieving object labels failed. rc=%d\n", rc);
>> +		goto out;
>> +	}
>> +
>> +	rc = list_key_labels(buf, obj_labels_buf, obj_labels_count,
>> +			     PLPKS_WRAPKEY_UNREVOKED);
>> +
>> +out:
>> +	kfree(obj_labels_buf);
>> +	return rc;
>> +}
>> +
>> +static ssize_t list_revoked_show(struct kobject *kobj,
>> +				 struct kobj_attribute *attr, char *buf)
>> +{
>> +	u8 *obj_labels_buf = NULL;
>> +	u64 obj_labels_count = 0;
>> +	int rc;
>> +
>> +	rc = plpks_get_object_labels(&obj_labels_buf, &obj_labels_count,
>> +				     PLPKS_WRAPKEY_COMPONENT);
>> +	if (rc) {
>> +		pr_err("Retrieving object labels failed. rc=%d\n", rc);
>> +		goto out;
>> +	}
>> +
>> +	rc = list_key_labels(buf, obj_labels_buf, obj_labels_count,
>> +			     PLPKS_WRAPKEY_REVOKED);
>> +
>> +out:
>> +	kfree(obj_labels_buf);
>> +	return rc;
>> +}
>> +
>> +static ssize_t create_store(struct kobject *kobj, struct kobj_attribute *attr,
>> +			    const char *buf, size_t count)
>> +{
> [ ... ]
>> +static ssize_t unrevoke_store(struct kobject *kobj, struct kobj_attribute *attr,
>> +			      const char *buf, size_t count)
>> +{
>> +	struct plpks_var var = { 0 };
>> +	int rc;
>> +
>> +	if (!capable(CAP_SYS_ADMIN)) {
>> +		rc = -EPERM;
>> +		goto out;
>> +	}
>> +
>> +	if (!count) {
>> +		rc = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	if (count > PLPKS_MAX_NAME_SIZE) {
>> +		rc = -ENAMETOOLONG;
>> +		goto out;
>> +	}
>> +
>> +	if (!strcmp(buf, PLPKS_DEFAULT_WRAPKEY_LABEL)) {
>> +		rc = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	if (!is_wrapkey_label_alnum(buf, count)) {
>> +		rc = -EINVAL;
>> +		goto out;
>> +	}
>> +
>> +	var.name = kstrndup(buf, count, GFP_KERNEL);
>> +	if (!var.name) {
>> +		rc = -ENOMEM;
>> +		goto out;
>> +	}
>> +
>> +	var.namelen = count;
>> +	var.os = PLPKS_VAR_LINUX;
>> +	var.component = PLPKS_WRAPKEY_COMPONENT;
>> +
>> +	rc = plpks_unrevoke_wrapping_key(&var);
>> +
>> +	if (rc) {
>> +		pr_err("un-revocation of wrapping key <%s> failed. rc = %d\n",
>> +		       (char *)var.name, rc);
>> +		goto out;
>> +	}
>> +
>> +	rc = count;
>> +out:
>> +	kfree(var.name);
>> +	return rc;
>> +}
> [Severity: Low]
> This isn't a bug, but create_store(), revoke_store(), unrevoke_store(), and
> delete_store() all duplicate the same CAP_SYS_ADMIN check, count validation,
> PLPKS_DEFAULT_WRAPKEY_LABEL check, is_wrapkey_label_alnum() validation,
> kstrndup() allocation, and struct plpks_var initialization (with
> unrevoke_store() returning -EINVAL instead of -EPERM for
> PLPKS_DEFAULT_WRAPKEY_LABEL).
>
> Similarly, list_active_show() and list_revoked_show() duplicate the
> plpks_get_object_labels() call and cleanup, differing only in passing
> PLPKS_WRAPKEY_UNREVOKED vs PLPKS_WRAPKEY_REVOKED to list_key_labels().
>
> Could the shared store validation/setup and show label retrieval logic be
> factored into common helpers?
>
>> +
>> +static ssize_t delete_store(struct kobject *kobj, struct kobj_attribute *attr,
>> +			    const char *buf, size_t count)
>> +{
> [ ... ]
>> +	rc = plpks_del_wrapping_key(&var);
> [Severity: Medium]
> What prevents a TOCTOU race if delete_store() and unrevoke_store() are called
> concurrently on the same revoked wrapping key?
>
> In arch/powerpc/platforms/pseries/plpks.c, plpks_del_wrapping_key() enforces
> that a key is revoked before deletion across two separate hypercalls without
> any lock:
>
> plpks_del_wrapping_key()
>      rc = plpks_is_wrapping_key_revoked(var);
>      if (rc == 1) {
>          ...
>          rc = plpks_remove_var(PLPKS_WRAPKEY_COMPONENT, var->os, vname);
>
> Because delete and unrevoke are separate sysfs attributes, kernfs only holds
> its per-open-file mutex separately for each attribute. If CPU 0 enters
> delete_store() -> plpks_del_wrapping_key() and sees
> plpks_is_wrapping_key_revoked() == 1, and CPU 1 concurrently runs
> unrevoke_store() -> plpks_unrevoke_wrapping_key() (H_PKS_UNREVOKE_OBJECT)
> before CPU 0 calls plpks_remove_var() (H_PKS_REMOVE_OBJECT), won't CPU 0
> delete the now-active wrapping key?
>
