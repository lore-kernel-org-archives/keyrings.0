Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFAC3BBA1D;
	Fri, 18 Sep 2026 02:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789697474; cv=none; b=j7+txDAPVDYTVJAw9TvtYieFeDWfq6DG9NNcLsYF9tmRoOBlWY+foVvS2zEli24uQvEbsfii6rhh3ufF6V8p8zTHdbSnnuqW+odYLrwCGolpN75V1ZpmaAreXf59ji11BLYioPODZ+lN2n5gL0+VCAjJf3Icd2woiTS2PEFneeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789697474; c=relaxed/simple;
	bh=xbiuMgJRxS3Joty81s86GEbj8KsBkj8yZdH5VKGvbXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/j6o/XhKwGwnhzqfId57FSUSZBfYj2NpbSG1Mmkf5D1ofHziyP+YsnB1XCwNzWHKoVZtpRQ8JYFTWDDT3RTP6nLuXO2arI8FQ9sRrrXuigdZ86sRLmYHqv1kc1c8/xXObHViOQE5krb3JcBeM9qp6SKvXm85SAe8rLwSX+Rk3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gv6JPFnu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gv6JPFnu"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 40E871F000FF;
	Fri, 18 Sep 2026 02:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789697455;
	bh=KddPLoNfzs7OEm8VmRCHbNNf5ZVXDctzT84aZOT3unQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Gv6JPFnurqYQiNm/uWlm5SIR4LG2I+YvdZTB6CHx2LEdJut+BRtdKkHUUGODUADOz
	 7klD1SQQvdd8bPXtBZH8CV/k0zO0MSc4xnjKEyox5eIxDnfkbnjUxCgK2lKuJxUCGe
	 nUVg2/tGBQ8M1RvwoHHS4Q1V+NQwILeQ79xTJrqc3rHLrMqlnovVo7SDOzljfY+x4q
	 gUanXCK2SmzHZGIiQ4fRzJHoFHhLLT7Bpd9dWpeZ2GbK7weta85yu97G+K8ulZELra
	 cf91M3FazVeSNtqFZRuacFuO/bl4Da6mErQwynfy3Gnz4NL6mkqh3bdul0l/r5jrXz
	 SJsCYkHSxtaUw==
Date: Fri, 18 Sep 2026 05:10:51 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	stefanb@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
	rnsastry@linux.ibm.com
Subject: Re: [PATCH v2] keys/trusted/tpm2: Validate TPM2_Create object sizes
 separately
Message-ID: <aqydqxpVmp67kTQO@kernel.org>
References: <20260910100222.247529-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910100222.247529-1-ssrish@linux.ibm.com>

On Thu, Sep 10, 2026 at 03:32:22PM +0530, Srish Srinivasan wrote:
> TPM2_Create returns outPrivate, outPublic, creationData, creationHash and
> creationTicket in its response parameter area. However, only outPrivate and
> outPublic are included in the trusted key blob. The size of the blob is
> therefore not determined by the size of the complete response parameter
> area.
> 
> tpm2_seal_trusted() currently compares the size of the complete response
> parameter area against MAX_BLOB_SIZE. This can reject a valid response
> when the remaining response outputs cause the entire response parameter
> area to exceed MAX_BLOB_SIZE, even though the outPrivate and outPublic
> TPM2B structures consumed by tpm2_key_encode() remain small enough to be
> encoded in the key blob.
> 
> This is observed when creating larger trusted keys using an swtpm TPM 2.0
> emulator backed by libtpms.
> 
> For example, requesting a 113-byte key succeeds, 114 fails.
> 
> ~$ keyctl add trusted trusted_key1 "new 113 keyhandle=0x81000001" @u
> 520504613
> ~$ keyctl add trusted trusted_key2 "new 114 keyhandle=0x81000001" @u
> add_key: Argument list too long
> ~$
> 
> Remove the MAX_BLOB_SIZE check on the complete response parameter area.
> Instead, use the response length passed to tpm2_key_encode() to validate
> that the outPrivate and outPublic TPM2B structures are fully contained
> in the response before accessing them.
> 
> Previously, a response parameter area larger than MAX_BLOB_SIZE was
> rejected with -E2BIG before ASN.1 encoding. With this change, if the
> resulting encoded blob does not fit in payload->blob, the error returned by
> asn1_encode_sequence() is propagated instead.
> 
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> ---
> Changelog:
> 
>  v2:
>   - Exclude a comment pointed out by Jarkko
> 
>  security/keys/trusted-keys/trusted_tpm2.c | 35 +++++++++++++++++------
>  1 file changed, 27 insertions(+), 8 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 01f18bb37047..cbec4f591952 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -24,24 +24,42 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
>  			   u8 *src, u32 len)
>  {
>  	const int SCRATCH_SIZE = PAGE_SIZE;
> -	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
> -	u8 *work = scratch, *work1;
> -	u8 *end_work = scratch + SCRATCH_SIZE;
> +	u8 *scratch;
> +	u8 *work, *work1;
> +	u8 *end_work;
>  	u8 *priv, *pub;
> -	u16 priv_len, pub_len;
> +	u32 priv_len, pub_len;
>  	int ret;
>  
> -	priv_len = get_unaligned_be16(src) + 2;
> +	if (len < sizeof(__be16))
> +		return -EFAULT;
> +
> +	priv_len = get_unaligned_be16(src);
> +	if (priv_len > len - sizeof(__be16))
> +		return -EFAULT;
> +
> +	priv_len += sizeof(__be16);
>  	priv = src;
>  
> +	if (len - priv_len < sizeof(__be16))
> +		return -EFAULT;

This caused for me some head scrathing tbh.

See:

1. len >= 2
2. priv_len <= len - 2
3. 2 - priv_len + priv_len <= 2 - priv_len + len - 2 
4. 2 <= len - priv_len

Is this check required?

> +
>  	src += priv_len;
>  
> -	pub_len = get_unaligned_be16(src) + 2;
> +	pub_len = get_unaligned_be16(src);
> +	if (pub_len > len - priv_len - sizeof(__be16))
> +		return -EFAULT;
> +
> +	pub_len += sizeof(__be16);
>  	pub = src;
>  
> +	scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
>  	if (!scratch)
>  		return -ENOMEM;
>  
> +	work = scratch;
> +	end_work = scratch + SCRATCH_SIZE;
> +
>  	work = asn1_encode_oid(work, end_work, tpm2key_oid,
>  			       asn1_oid_len(tpm2key_oid));
>  
> @@ -336,10 +354,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
>  		goto out;
>  
>  	blob_len = tpm_buf_read_u32(buf, &offset);
> -	if (blob_len > MAX_BLOB_SIZE || buf->flags & TPM_BUF_INVALID) {
> -		rc = -E2BIG;
> +	if (buf->flags & TPM_BUF_INVALID) {
> +		rc = -EFAULT;
>  		goto out;
>  	}
> +
>  	if (buf->length - offset < blob_len) {
>  		rc = -EFAULT;
>  		goto out;
> -- 
> 2.53.0
> 

BR, Jarkko
