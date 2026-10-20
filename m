Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792509008;
	b=iF+bN95JK5InAD4QzyWczCk5nDQobuCfdgI2oxYzttEi77Zqv/bYsbZi6NwTvqpf5xwM
	 mS3jL2bRy41cqfC9bCMWXoFmrZIUdlwp8z3As9uucO1HLfzzEyc+9Dk1EHDhAp3dPqOJs
	 tHXB8PxnwOAlLPzvovii369UY5SQXZBbJKp4V6mlFe84W9WXsswJbrA2vLrP9qn6ToBG/
	 ZCbcRe6EnzicuhRtQBzWscGOItlzvDjs+WZhQwdO+/Q00888QY0enEsqNY0HCNX+5dHCr
	 Pu69e2M5JkXYdSB7K6gNFy5xonFuonv/MtJ96askh/yXnQtNne6hoQx63yajGw9+crg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792509008;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Laxh79qXwAwsmuV6O1MzM4XcWCJ9HNwhZ1DgdfgCfZw=;
	b=bq+jY4h0zkd9OvIoq8eTjA2bcMNMRAI/qf95OO2/Vj6o2O0oyAhtHp7YrpmZ/t/gg1Lr
	 Ncy82fPQGB9q/mVtdrMnBV4s3GEiFfE6/TBOJwu1BbDMFYt4TLg9o+4rx9YE5+KslzSvn
	 EQivQgFAIFd8gPLobjZO2DEMykWwdKxdULb7AncvJfsPxFCG7GAUex1hSBUk/KJpexrfx
	 phrJEesIhPdPFvF9sNBgMu/vbhK/NpZYmmBmHlHS5A/50jBfV7Q5FmfeGX3/ZxE0tFUwW
	 nGpstLQhyD0P+9mrysTczncXH9/RxjnortyAu3M7BRsRepU7BNyWVnq50B4WCZF1V6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 582CC606A31E;
	Tue, 20 Oct 2026 15:10:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 66F1B1F000C4;
	Tue, 20 Oct 2026 15:10:07 +0000 (UTC)
Date: Tue, 20 Oct 2026 18:09:33 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: trusted: Reject short TPM2 public areas
Message-ID: <ateELTsfmHsdCEGL@kernel.org>
References: <20260925095308.3248297-1-4ncienth@gmail.com>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925095308.3248297-1-4ncienth@gmail.com>

On Fri, Sep 25, 2026 at 06:53:08PM +0900, Daehyeon Ko wrote:
> tpm2_load_cmd() reads TPMA_OBJECT with get_unaligned_be32(pub + 4), but
> does not require public_len to cover that field.
> 
> A new-format blob with public_len zero makes the read begin at the end of

New-format is not anything. TPM2 protocol format might be better here (nit).

> the B + 4-byte decoded allocation, causing a four-byte heap out-of-bounds
> read before the TPM command is transmitted. This is reachable from an
> unprivileged add_key() call when TPM trusted keys and a TPM2 device are
> available.
> 
> This affects v5.13-rc1 and later kernels built with CONFIG_TRUSTED_KEYS=y
> and CONFIG_TRUSTED_KEYS_TPM=y when a TPM2 device is present. A KASAN run
> as UID 1000 with no effective capabilities reported:
> 
> BUG: KASAN: slab-out-of-bounds in tpm2_unseal_trusted
> Read of size 4 at addr ffff888106273b48 by task exploit/160
> CPU: 1 UID: 1000 PID: 160 Comm: exploit
> The buggy address belongs to the object at ffff888106273b40
>  which belongs to the cache kmalloc-8 of size 8
> The buggy address is located 0 bytes to the right of
>  allocated 8-byte region [ffff888106273b40, ffff888106273b48)
> 
> TPMT_PUBLIC starts with the two-byte type, two-byte nameAlg and four-byte
> objectAttributes fields. Require public_len to cover all eight bytes before
> reading the attributes.
> 
> The exact input produced the KASAN read in 3/3 fresh boots. The fixed build
> rejected it with -E2BIG and no KASAN report in 3/3 boots; valid new- and
> old-format trusted-key loads continued to succeed.
> 
> Fixes: e5fb5d2c5a03 ("security: keys: trusted: Make sealed key properly interoperable")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
> Tested with QEMU tpm-tis and swtpm: vulnerable 3/3 KASAN reports,
> fixed 3/3 clean -E2BIG rejections, with public_len 7/8 and new/old-format
> controls passing. Stable 5.15+ requires 114f00d738f1 first; both patches
> apply cleanly in that order.
> 
> The source reproducer and full logs are available privately on request.
> 
>  security/keys/trusted-keys/trusted_tpm2.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index c2a69bcf381d7..b3109e0a924f5 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -418,6 +418,8 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  	public_len = get_unaligned_be16(blob + 2 + private_len);
>  	if (private_len + 2 + public_len + 2 > blob_len)
>  		return -E2BIG;

I was writing summary of the changes for my v7.4-rc1 PR but this
does not look right.


This would really need an explanation like:

/* 
 * Check that TPMT_PUBLIC fields type, nameAlg and objectAttributes are covered
 * in order to avoid out-of-bounds read.
 */

> +	if (public_len < 8)
> +		return -E2BIG;

Why would you pick -E2BIG as I guess here that is not the problem?

Just checking before proposing anything.

>  
>  	pub = blob + 2 + private_len + 2;
>  	/* key attributes are always at offset 4 */
> 
> base-commit: 27d14d3b15d5691bcbf0683883a2ea12469edbea

I'll drop this patch and postpone v7.4-rc1 at least one day so there
is still time.

Br, Jarkko
