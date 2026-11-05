Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890588;
	b=gdf8ggcBehJfOCz71mdrVjF/dgloq+QmMkaj/0zMwDMqe/PMjzhhDD0fPskZLKPxG2iW
	 rej8oobtwWAMdTD60OKVLa9SXTV1xgnb1BZgiEE6YZb8ulJavoJ0Zm5QGHZyem3f3ggpT
	 Y0ba8EP538g3q+dbptPhV29C0WnXy3yuQ4t8MGRjgWIcv/1efcdR1gXQy4Rwhn9cXElbh
	 97vdBWiG25S7SylfR2LiJjVg3+fyZ5M5SdLiyPbkdBPI/PN9dhW1t/CCfOUhuz9oXTilT
	 nMcWhIT/r8QH01Z9oIwm0ZQnxz0Dre8bNl5011DrfPJrchExpTtKKsmX2ZpMvnHxjbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890588;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aiuSAbASG4forzRExt2HK5A5gO/fgfmnmE3dC5sNQWw=;
	b=3sR/36fvR5+fZTS55eQz+LqNa7tUV0/+Asjrto8kqurnRPkLJzHavYnZrq3QT6syJvyq
	 2YTUJ538J+qYAQj9NTN6gBE6iwVmzzX8QPLRZSyAlGvQH0k+qyg3tf85y1iR/bfx1mxuz
	 bwm2ju0MSWMdQ135XIhtlfaW6Y4e9r6P6Vhd1DOm5P9QHG2W6Hk3mrLiM66uPz3tU/PiA
	 E4cN2AgBOrSWQxtwNndnoRHkQG3kTceJCSIsxIU5iRFmIwxgrqeSoYkbvFLoRRpXS+jnA
	 p96hYX+0S9cVEOJSK37FnLOn+MCWN6tqXycLP/h8Du52kE5dscOm+zJWw7Quvt5PbvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQEAb1+v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E35A606A31B;
	Thu,  5 Nov 2026 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQEAb1+v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD851F000C1;
	Thu,  5 Nov 2026 14:56:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890587;
	bh=aiuSAbASG4forzRExt2HK5A5gO/fgfmnmE3dC5sNQWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QQEAb1+v874Lp8j55M+h2VaolUqm0Q/LYaYwV8hhmChKAZa28jMZf4S9JPEra8Za+
	 +ISHk+3LsKdwhsPfMFf37i2ZLUtTC90MTgrZ8ZZBLzB1nUmu06sGBv36uf2M6YRDui
	 80A6KY2YAuJ0nALH9OO7aJMStFl20GWfkmOWtcAuUhljNiLcVJcGxbbQ1d0w7uVpy4
	 T/7DFvWRoD4pdJoWtjRbsizS3i4GPyyOc3DN2rY/We6iP52U7RKYuXFwOPyz6qG55U
	 ovdE9E4I8CKqLonyOiZg81AmoY06sctpzfM/ICazbEcKlvhloZnWn3LZ51efrtwnkI
	 Zt8UF5AjuNlXw==
Message-ID: <sashiko-outbox-199277@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/9] pseries/plpks: add HCALLs for PKWM wrapping key
 life cycle management
Reply-To: sashiko-reviews@lists.linux.dev
To: "Srish Srinivasan" <ssrish@linux.ibm.com>, keyrings@vger.kernel.org
Cc: maddy@linux.ibm.com, ritesh.list@gmail.com, sshegde@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, James.Bottomley@HansenPartnership.com, jarkko@kernel.org, zohar@linux.ibm.com, linux-security-module@vger.kernel.org, nayna@linux.ibm.com, rnsastry@linux.ibm.com
In-Reply-To: <20261105144320.357260-8-ssrish@linux.ibm.com>
References: <20261105144320.357260-1-ssrish@linux.ibm.com>
 <20261105144320.357260-8-ssrish@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 14:56:26 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pseries/plpks: output_buf leak and -EAGAIN return in plpks_get_o=
bject_labels()
--

commit 41ef08b282e00765eba284dad461f1985057d371
Author: Srish Srinivasan <ssrish@linux.ibm.com>

pseries/plpks: add HCALLs for PKWM wrapping key life cycle management

This commit adds support for the H_PKS_REVOKE_OBJECT, H_PKS_UNREVOKE_OBJECT,
and H_PKS_GET_OBJECTLABELS hypercalls to manage the life cycle of PKWM
wrapping keys and retrieve wrapping key labels in the Platform Keystore.

> diff --git a/arch/powerpc/platforms/pseries/plpks.c b/arch/powerpc/platfo=
rms/pseries/plpks.c
> index d5adc563f71f0..6e10bd6a9a481 100644
> --- a/arch/powerpc/platforms/pseries/plpks.c
> +++ b/arch/powerpc/platforms/pseries/plpks.c
[ ... ]
> @@ -1205,6 +1237,457 @@ int plpks_unwrap_object(u8 **input_buf, u64 input=
_len, u8 **output_buf,
[ ... ]
> +int plpks_get_object_labels(u8 **output_buf, u64 *output_len,
> +			    char *comp_prefix)
> +{
> +	unsigned long retbuf[PLPAR_HCALL_BUFSIZE] =3D { 0 };
> +	u8 *labels_buf =3D NULL;
> +	u8 *tmp_buf =3D NULL;
> +	struct plpks_auth *auth;
> +	struct label_attr *metadata =3D NULL;
> +	u8 prefix[PLPKS_OBJLABEL_PREFIX_LEN];
> +	u16 label_len;
> +	u64 labels_count;
> +	u64 continuetoken =3D 0, output_buf_len =3D 0;
> +	int rc, pseries_status;
> +	size_t labels_buf_offset =3D 0, output_buf_offset =3D 0;
> +	size_t obj_label_entry_size, i;
> +
> +	if (!output_buf || !output_len || !comp_prefix)
> +		return -EINVAL;
> +
> +	*output_buf =3D NULL;
> +	*output_len =3D 0;
> +
> +	memset(prefix, 0, sizeof(prefix));
> +	memcpy(prefix, comp_prefix, strnlen(comp_prefix, sizeof(prefix)));
> +
> +	auth =3D construct_auth(PLPKS_OS_OWNER);
> +	if (IS_ERR(auth))
> +		return PTR_ERR(auth);
> +
> +	do {
> +		labels_buf =3D
> +			kzalloc(PLPKS_OBJLABEL_BUF_SIZE, GFP_KERNEL);
> +
> +		if (!labels_buf) {
> +			rc =3D -ENOMEM;
> +			goto out_free_output_buf;
> +		}
> +
> +		rc =3D plpar_hcall(H_PKS_GET_OBJECTLABELS, retbuf,
> +				 virt_to_phys(auth), continuetoken,
> +				 virt_to_phys(labels_buf),
> +				 PLPKS_OBJLABEL_BUF_SIZE);
> +
> +		pseries_status =3D rc;
> +		rc =3D pseries_status_to_err(rc);
> +
> +		if (rc && rc !=3D -EAGAIN) {
> +			pr_err("H_PKS_GET_OBJECTLABELS failed. pseries_status=3D%d rc=3D%d\n",
> +			       pseries_status, rc);
> +			goto out_free_labels_buf;
> +		} else {
> +			/*
> +			 * Setting an incorrect countinuetoken upon
> +			 * receiving H_CONTINUE would result in H_P2. Since
> +			 * the continuetoken is being set to the expected
> +			 * value from the previous call, H_P2 must not be
> +			 * returned.
> +			 */
> +			continuetoken =3D retbuf[1];
> +
> +			labels_count =3D retbuf[0];
> +			if (!labels_count) {
> +				kfree(labels_buf);
> +				labels_buf =3D NULL;
> +				goto out;
> +			}
> +
> +			/*
> +			 * Filter out object labels that don't have the provided
> +			 * component prefix.
> +			 */
> +
> +			output_buf_len +=3D PLPKS_OBJLABEL_BUF_SIZE;
> +
> +			tmp_buf =3D krealloc(*output_buf, output_buf_len,
> +					   GFP_KERNEL);
> +
> +			if (!tmp_buf) {
> +				rc =3D -ENOMEM;
> +				goto out_free_labels_buf;
> +			}
> +
> +			*output_buf =3D tmp_buf;
> +
> +			for (i =3D 0; i < labels_count; ++i) {
> +				if (labels_buf_offset +
> +				    PLPKS_OBJLABEL_LEN_FIELD_SIZE >
> +				    PLPKS_OBJLABEL_BUF_SIZE) {
> +					rc =3D -EIO;
> +					goto out_free_labels_buf;
> +				}
> +
> +				label_len =3D
> +					get_unaligned_be16(labels_buf +
> +							   labels_buf_offset);
> +
> +				obj_label_entry_size =3D
> +					PLPKS_OBJLABEL_LEN_FIELD_SIZE +
> +					label_len;
> +
> +				if (label_len < sizeof(struct label_attr) ||
> +				    labels_buf_offset + obj_label_entry_size >
> +				    PLPKS_OBJLABEL_BUF_SIZE) {
> +					rc =3D -EIO;
> +					goto out_free_labels_buf;
> +				}
> +
> +				metadata =3D
> +					(struct label_attr *)(labels_buf +
> +					labels_buf_offset +
> +					PLPKS_OBJLABEL_LEN_FIELD_SIZE);
> +
> +				if (!memcmp(metadata->prefix, prefix,
> +					    PLPKS_OBJLABEL_PREFIX_LEN)) {
> +					memcpy(*output_buf + output_buf_offset,
> +					       labels_buf + labels_buf_offset,
> +					       obj_label_entry_size);
> +
> +					output_buf_offset +=3D
> +						obj_label_entry_size;
> +					(*output_len) +=3D 1;
> +				}
> +				labels_buf_offset +=3D obj_label_entry_size;
> +			}
> +			kfree(labels_buf);
> +			labels_buf =3D NULL;
> +			labels_buf_offset =3D 0;
> +		}
> +	} while (rc =3D=3D -EAGAIN);
> +
> +	goto out;
> +
> +out_free_labels_buf:
> +	kfree(labels_buf);
> +	labels_buf =3D NULL;
> +out_free_output_buf:
> +	kfree(*output_buf);
> +	*output_buf =3D NULL;
> +	*output_len =3D 0;
> +out:
> +	kfree_sensitive(auth);
> +	return rc;
> +}

[Severity: Medium]
Can plpks_get_object_labels() leak *output_buf or return -EAGAIN to the
caller?

First, inside the do-while loop, when labels_count > 0, *output_buf is
allocated or grown via krealloc() before checking whether any of the return=
ed
labels match comp_prefix. If PLPKS contains objects for other components so
labels_count > 0, but none of those labels match comp_prefix, the loop
completes with rc =3D=3D 0 and *output_len =3D=3D 0 and jumps to out withou=
t freeing
*output_buf. Unlike the case where PLPKS has 0 total objects on the first
call (which returns 0 with *output_len =3D=3D 0 and *output_buf =3D=3D NULL=
), this
returns 0 with *output_len =3D=3D 0 while *output_buf points to an allocated
buffer of uninitialized heap memory. Callers checking *output_len =3D=3D 0 =
will
leak *output_buf, while callers checking *output_buf !=3D NULL will read
uninitialized memory.

Second, if !labels_count (retbuf[0] =3D=3D 0) is encountered when
H_PKS_GET_OBJECTLABELS returns H_CONTINUE (converted by
pseries_status_to_err() to rc =3D -EAGAIN) or on a subsequent continuation
iteration after *output_buf was already allocated, jumping directly to out
bypasses the loop condition and out_free_output_buf. Could that return the
internal continuation code -EAGAIN to the caller and leak any *output_buf
allocated in prior iterations?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105144320.3572=
60-1-ssrish@linux.ibm.com?part=3D7
