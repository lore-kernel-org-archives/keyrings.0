Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794282016;
	b=fH5f3nB6sekkZtsgT1x+jeqNvhLWXSi/7TEoOBW3n8qzc9PtC6FvpJd8Oi+4RfO56db/
	 mVAmCGirBvU8anbMc0O7PUW9Dlck2jEL1g045+W5BaMsaxT6/DuFBYsg56KXAEoEP0x17
	 ikLMAms/2NP013GbN4BilY8W1wnRjDn13od8wl+J1jfNGTqkaQ6uNGP0gZgWiMQv+mBFx
	 ZfL98jk/VqNJ/WywI0SJ78A9abwOheXwgF0d5XrJ7QqM0fCxj/J9Cisa8Nab1mD9ku+DS
	 LJ7wgz9CDbvl9JS5l6yUfRaI9QsnacKTdEAVBz+GAJ3Zrj7/EZA8FGoZV0lO0+JqZRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794282016;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=yQHJV/ve8eAEgSivz91f5kWHgn+LmGnJAbhGiLAmTrw=;
	b=xHSWS0lT6mCFaff4bAhO0sRjxJXijyZduCotjXWVsBNR9GQUXIW8C/IOqR+PBw4Bm060
	 BpmPh8CO+4oCqrf3KNiEht6YneaS4ASeNNdyc7NZjKxegdBNrSXDVlNhaFA/mQUfG/ZUU
	 fb9WTutGKYW/83SyPeBbt2nVmdhi3Dgwcpz2mEAINQW5HiPC/zGxo2Rk2+Fdpr59pMTWl
	 iAIYNpG/+d1gUGEkrFGRnrrE5kCJsKS8iUALa694IrrpYGO/mk60AyC27AuPw9fbH7x6U
	 TOIZ3Al4a0Au3aSVBW1nFBeDGeNDhqy6XpE3H6uL4K6i8bQzsKBkTfQe/mFop4tomFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="Rm/5sirq";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB20606A31C;
	Tue, 10 Nov 2026 03:40:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFB20606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Rm/5sirq
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA0jx8G3910804;
	Tue, 10 Nov 2026 03:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yQHJV/
	ve8eAEgSivz91f5kWHgn+LmGnJAbhGiLAmTrw=; b=Rm/5sirqhz/FRX2FOkg/Qr
	zBoaK+TaVXX0Ra3jUZtJkpA4gLWU++C+uOxBw3SBfryNjltUw3ujW0RSU601aRJo
	Mu/U81/Y0ze1xnfI2b1KH6lYDSeJ63sXavOjP5kFXI95/1PkklphgrMNQUTqugvp
	qwj2kllwXK8LK8x914USC4PcauJ7bMA0YbTi9nIVT8xu1MttPgCbZ4ZdyFpcnDXy
	niHBPia+ryAMrS+b6NNHdn2xDU7sWjwJEZmh2BT+6qoAXxMTrw79yeVotukVRKD0
	+S6snzsHI/EtLTnsjcwhqp3zCq8zA4cTz+qqToGYfdKYIlaSfeVCGnuA7wRXg+cw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdg2k6q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 03:40:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA0nt2H954688;
	Tue, 10 Nov 2026 03:40:03 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfak4xnb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Nov 2026 03:40:03 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AA3e1JU17695448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Nov 2026 03:40:02 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE71758056;
	Tue, 10 Nov 2026 03:40:01 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C78D58061;
	Tue, 10 Nov 2026 03:39:57 +0000 (GMT)
Received: from [9.123.14.23] (unknown [9.123.14.23])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Nov 2026 03:39:57 +0000 (GMT)
Message-ID: <93b91092-b7e2-436d-9e8e-ebc59f18ab57@linux.ibm.com>
Date: Tue, 10 Nov 2026 09:09:56 +0530
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
Subject: Re: [PATCH v6 7/9] pseries/plpks: add HCALLs for PKWM wrapping key
 life cycle management
To: sashiko-reviews@lists.linux.dev, keyrings@vger.kernel.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, linux-security-module@vger.kernel.org,
        nayna@linux.ibm.com, rnsastry@linux.ibm.com
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
 <20261105144320.357260-8-ssrish@linux.ibm.com>
 <sashiko-outbox-199277@kernel.org>
Content-Language: en-US
From: Srish Srinivasan <ssrish@linux.ibm.com>
In-Reply-To: <sashiko-outbox-199277@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af29214 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=lSR6CTt58exauEyhIgcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxMiBTYWx0ZWRfXz68sEZqTjKtw
 aMp3UALFU9YmsJWcAUGqsfWSOdma6ClFaZ/maBemzZD5ntizHomhnLm7VWj2aFa+r6kHsNbZMEN
 IHC4QzWIeClyNiRDo7OwRq3TNqU7bqrhH1jpJrpqxEHXHJwpGC4yFdhiwmiAykWivPdw5OCI1Qd
 hdLWzmCKzxqRZgBKt+BjoUY8TFIDAo5MAfv+tfPK2ADMqoboSiyyEf4S1gCDfDC55Yd1si2MJMJ
 9IKjrv3v1yrvTQGqyf70cIaJvPG5D6BSt/pwNJSF1sEBLwYBBe1LubxHIccwM1MMV5MT+D9bWdT
 iYAQJi9tVXjdfJwi1JuwBVYhvuzX2k7C8SHyzPFSkdV9tIkmaly3FaJfPlt1dpEgqXpJ8K0/Aaz
 wgkjNF612kEypzryY6Z6sMQWvjKPMCo4510Rxt38z+lWOLyl6wsJ2VBt6JoxCBR1/FlQli+q6vs
 00VxfKo88gu7f2B3oCw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxMiBTYWx0ZWRfX8T1nbkEXwkj3
 NndiN9Z3TT5NRWFaF1MRWYfPfsqd0LdR/k2n5Wgw/roP4FlFk4+CwTdTsVSjMT0VE3yZ/lR0tFW
 wmBFyYlj98pQitO0t3PQlGzx4YcVRUA=
X-Proofpoint-GUID: sgJxV4c-SXNwQSrylox01WZJsBX3QAXT
X-Proofpoint-ORIG-GUID: qR6g1Ez7zwzV5bZ0Fy24r_BDDvJVCdPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100012

Hi

On 11/5/26 8:26 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] pseries/plpks: output_buf leak and -EAGAIN return in plpks_get_object_labels()
> --


Yes, these are valid findings and I will fix these in my next version.

Thanks,
Srish.


>
> commit 41ef08b282e00765eba284dad461f1985057d371
> Author: Srish Srinivasan <ssrish@linux.ibm.com>
>
> pseries/plpks: add HCALLs for PKWM wrapping key life cycle management
>
> This commit adds support for the H_PKS_REVOKE_OBJECT, H_PKS_UNREVOKE_OBJECT,
> and H_PKS_GET_OBJECTLABELS hypercalls to manage the life cycle of PKWM
> wrapping keys and retrieve wrapping key labels in the Platform Keystore.
>
>> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platforms/pseries/plpks.c
>> index d5adc563f71f0..6e10bd6a9a481 100644
>> --- a/arch/powerpc/platforms/pseries/plpks.c
>> +++ b/arch/powerpc/platforms/pseries/plpks.c
> [ ... ]
>> @@ -1205,6 +1237,457 @@ int plpks_unwrap_object(u8 **input_buf, u64 input_len, u8 **output_buf,
> [ ... ]
>> +int plpks_get_object_labels(u8 **output_buf, u64 *output_len,
>> +			    char *comp_prefix)
>> +{
>> +	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] = { 0 };
>> +	u8 *labels_buf = NULL;
>> +	u8 *tmp_buf = NULL;
>> +	struct plpks_auth *auth;
>> +	struct label_attr *metadata = NULL;
>> +	u8 prefix[PLPKS_OBJLABEL_PREFIX_LEN];
>> +	u16 label_len;
>> +	u64 labels_count;
>> +	u64 continuetoken = 0, output_buf_len = 0;
>> +	int rc, pseries_status;
>> +	size_t labels_buf_offset = 0, output_buf_offset = 0;
>> +	size_t obj_label_entry_size, i;
>> +
>> +	if (!output_buf || !output_len || !comp_prefix)
>> +		return -EINVAL;
>> +
>> +	*output_buf = NULL;
>> +	*output_len = 0;
>> +
>> +	memset(prefix, 0, sizeof(prefix));
>> +	memcpy(prefix, comp_prefix, strnlen(comp_prefix, sizeof(prefix)));
>> +
>> +	auth = construct_auth(PLPKS_OS_OWNER);
>> +	if (IS_ERR(auth))
>> +		return PTR_ERR(auth);
>> +
>> +	do {
>> +		labels_buf =
>> +			kzalloc(PLPKS_OBJLABEL_BUF_SIZE, GFP_KERNEL);
>> +
>> +		if (!labels_buf) {
>> +			rc = -ENOMEM;
>> +			goto out_free_output_buf;
>> +		}
>> +
>> +		rc = plpar_hcall(H_PKS_GET_OBJECTLABELS, retbuf,
>> +				 virt_to_phys(auth), continuetoken,
>> +				 virt_to_phys(labels_buf),
>> +				 PLPKS_OBJLABEL_BUF_SIZE);
>> +
>> +		pseries_status = rc;
>> +		rc = pseries_status_to_err(rc);
>> +
>> +		if (rc && rc != -EAGAIN) {
>> +			pr_err("H_PKS_GET_OBJECTLABELS failed. pseries_status=%d rc=%d\n",
>> +			       pseries_status, rc);
>> +			goto out_free_labels_buf;
>> +		} else {
>> +			/*
>> +			 * Setting an incorrect countinuetoken upon
>> +			 * receiving H_CONTINUE would result in H_P2. Since
>> +			 * the continuetoken is being set to the expected
>> +			 * value from the previous call, H_P2 must not be
>> +			 * returned.
>> +			 */
>> +			continuetoken = retbuf[1];
>> +
>> +			labels_count = retbuf[0];
>> +			if (!labels_count) {
>> +				kfree(labels_buf);
>> +				labels_buf = NULL;
>> +				goto out;
>> +			}
>> +
>> +			/*
>> +			 * Filter out object labels that don't have the provided
>> +			 * component prefix.
>> +			 */
>> +
>> +			output_buf_len += PLPKS_OBJLABEL_BUF_SIZE;
>> +
>> +			tmp_buf = krealloc(*output_buf, output_buf_len,
>> +					   GFP_KERNEL);
>> +
>> +			if (!tmp_buf) {
>> +				rc = -ENOMEM;
>> +				goto out_free_labels_buf;
>> +			}
>> +
>> +			*output_buf = tmp_buf;
>> +
>> +			for (i = 0; i < labels_count; ++i) {
>> +				if (labels_buf_offset +
>> +				    PLPKS_OBJLABEL_LEN_FIELD_SIZE >
>> +				    PLPKS_OBJLABEL_BUF_SIZE) {
>> +					rc = -EIO;
>> +					goto out_free_labels_buf;
>> +				}
>> +
>> +				label_len =
>> +					get_unaligned_be16(labels_buf +
>> +							   labels_buf_offset);
>> +
>> +				obj_label_entry_size =
>> +					PLPKS_OBJLABEL_LEN_FIELD_SIZE +
>> +					label_len;
>> +
>> +				if (label_len < sizeof(struct label_attr) ||
>> +				    labels_buf_offset + obj_label_entry_size >
>> +				    PLPKS_OBJLABEL_BUF_SIZE) {
>> +					rc = -EIO;
>> +					goto out_free_labels_buf;
>> +				}
>> +
>> +				metadata =
>> +					(struct label_attr *)(labels_buf +
>> +					labels_buf_offset +
>> +					PLPKS_OBJLABEL_LEN_FIELD_SIZE);
>> +
>> +				if (!memcmp(metadata->prefix, prefix,
>> +					    PLPKS_OBJLABEL_PREFIX_LEN)) {
>> +					memcpy(*output_buf + output_buf_offset,
>> +					       labels_buf + labels_buf_offset,
>> +					       obj_label_entry_size);
>> +
>> +					output_buf_offset +=
>> +						obj_label_entry_size;
>> +					(*output_len) += 1;
>> +				}
>> +				labels_buf_offset += obj_label_entry_size;
>> +			}
>> +			kfree(labels_buf);
>> +			labels_buf = NULL;
>> +			labels_buf_offset = 0;
>> +		}
>> +	} while (rc == -EAGAIN);
>> +
>> +	goto out;
>> +
>> +out_free_labels_buf:
>> +	kfree(labels_buf);
>> +	labels_buf = NULL;
>> +out_free_output_buf:
>> +	kfree(*output_buf);
>> +	*output_buf = NULL;
>> +	*output_len = 0;
>> +out:
>> +	kfree_sensitive(auth);
>> +	return rc;
>> +}
> [Severity: Medium]
> Can plpks_get_object_labels() leak *output_buf or return -EAGAIN to the
> caller?
>
> First, inside the do-while loop, when labels_count > 0, *output_buf is
> allocated or grown via krealloc() before checking whether any of the returned
> labels match comp_prefix. If PLPKS contains objects for other components so
> labels_count > 0, but none of those labels match comp_prefix, the loop
> completes with rc == 0 and *output_len == 0 and jumps to out without freeing
> *output_buf. Unlike the case where PLPKS has 0 total objects on the first
> call (which returns 0 with *output_len == 0 and *output_buf == NULL), this
> returns 0 with *output_len == 0 while *output_buf points to an allocated
> buffer of uninitialized heap memory. Callers checking *output_len == 0 will
> leak *output_buf, while callers checking *output_buf != NULL will read
> uninitialized memory.
>
> Second, if !labels_count (retbuf[0] == 0) is encountered when
> H_PKS_GET_OBJECTLABELS returns H_CONTINUE (converted by
> pseries_status_to_err() to rc = -EAGAIN) or on a subsequent continuation
> iteration after *output_buf was already allocated, jumping directly to out
> bypasses the loop condition and out_free_output_buf. Could that return the
> internal continuation code -EAGAIN to the caller and leak any *output_buf
> allocated in prior iterations?
>
