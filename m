Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4E35908C4;
	Wed,  9 Sep 2026 21:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788988312; cv=none; b=PwVDR8ZTgTTLXfvpHiAo5h5/vD9UnlXM8Fg5uqoOndvoDEqlm05Bg0BQXFMgBSCFzIQ2ErZCRuci6FOrI8/F2zJWMfoXwFg+OzdaSA2aPw3iBbZe3CaFYPDGCsGBhsMmc1C8kD5s+q/fWPBMX7T1AAbcxKH1y1EdqIxiVqgTa8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788988312; c=relaxed/simple;
	bh=wUsyydvqlSxhrWWkZG6+z9QLnSiaZppJEC2Pfwa8GIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMcxH9Dhcg1PRvUrkCUUiDH4mhRt7m5NzFfkX1HP5SR/borILdYojlQ106jTAzvfswX707uzjtC4IFFzZMzxuxecyXAmGJZcwT6Qom0wiivs3ZrLxjoyO1QujBCcc/LmHBSk04HbgtFwrlpnW2p1OWDcf3t/IQq2n07ZTYLnLVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fn5+C6TH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fn5+C6TH"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 88E8C1F000FF;
	Wed,  9 Sep 2026 21:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788988311;
	bh=ww0GWOMaIDMkIstrfwnKekmdrrjKu4hZ61lEZfdiCV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fn5+C6THd11og+szfJWQG3Jp6lmwJzwtK7q0fN26A7ZPqdial8FPzMbTXmgBsGuMA
	 bsOX56MForiodh4ga6LRVyvG818flwJS1eBXp+zs9WFWBBKniVOA7soC6/n1FY1vmY
	 sUWE7XJghC+KOrfQXJ1NrTQT2FFf9LoG2k2cvl4sH731xHZEicr0/+FgvYPXLMYQs8
	 /fETUZyyv2GZgyWPRGmo8d8B6J3/pkKn7GnaPeTlQTy7XZHnAsN5zmXufWi95bawf4
	 QQFOxJYwWsyWfFbo9FfPprAg7PYsrwbb629GVFGt5s6N/h7x7Y41LNj0f//Ur0FKFI
	 DSRwhQlKie8ow==
Date: Thu, 10 Sep 2026 00:11:47 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	nayna@linux.ibm.com, rnsastry@linux.ibm.com
Subject: Re: [PATCH] keys/trusted/tpm2: Validate TPM2_Create object sizes
 separately
Message-ID: <aqHLkyUewMrTr1wB@kernel.org>
References: <20260902114340.268698-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902114340.268698-1-ssrish@linux.ibm.com>

On Wed, Sep 02, 2026 at 05:13:40PM +0530, Srish Srinivasan wrote:
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
>  security/keys/trusted-keys/trusted_tpm2.c | 47 +++++++++++++++++++----
>  1 file changed, 39 insertions(+), 8 deletions(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 67225dd562a9..efb016a6d4b8 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -24,24 +24,54 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
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
> +	/*
> +	 * TPM2_Create Response Parameters:
> +	 *
> +	 * outPrivate
> +	 * outPublic
> +	 * creationData
> +	 * creationHash
> +	 * creationTicket
> +	 *
> +	 * Validate outPrivate and outPublic against the response parameter
> +	 * length before accessing them.
> +	 */

Please remove this comment. It is only an annoyance.

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
> @@ -335,10 +365,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
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
