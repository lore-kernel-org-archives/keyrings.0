Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB27B4EE844;
	Fri, 25 Sep 2026 22:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377040; cv=none; b=tmyiXGs/qpVs+kwh8+sXIrYsyC1J+galK4wK1QB3jsdlHX/qPYQDF+2x1z05NGG0apR1+6bxrmhEjS1ZMGrdvSnEaUZtkRzwXIE3GczsK9suH7LZPas59WpVQ3xfK7NWKsNgfadsCcaX682v/G4TyCd8CN1p/RJFX8nmacdHzs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377040; c=relaxed/simple;
	bh=J1TPWHHnfoUo2nYN3xrPs5nZiLeeK2BR1CVQDLQBzPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sd8nv0yRUqfJCaOoGsZH2/RvnNMihJgM7sQZbU2hlJFM+iTmTKOtFKHjfOAYpFbtOwa2l1OeDW3o2WC4r2+QbyyW7pVi4fR0KD/FD7eZweC+C1o8Hh/kdXJFFUtduPDvvaRGIMsAT1C62baaSd4FTP1xbtQKaq/kXPRPdeBpXkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMoZuTW+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMoZuTW+"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B982E1F000FF;
	Fri, 25 Sep 2026 22:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790377039;
	bh=YjXDn+XCSuMiREjh9cg06zpaUOVtfg1ul5tnYcpaZAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZMoZuTW+l3cRejGlnzs3iIz1Mb0pp66Ykly3tiijrPG7J48FLbhEpR51MVJvsjK9H
	 kI30YvjqC29dryBF4Ak38ziASSsxFQw3sjCmCF15pd9+zwpSlMETU+jVwLekPMpKxy
	 msBla9QQXYamYxCr8FnPvAfK2Oo854GGjm/QAr6XtMe4vqjVYwNeCmIP+66zIn6TTc
	 7fYQUNKoAo3/bpedb8InrBfPwZrrsPf9zan1Xwdz8xT9NlK6WkHgcPuExulbQfO7Sz
	 vNQoXcclNsmZ8x4Ug1ec6SX8CjDGXW0KgpjBIqIntpS819PGbaliFz+K+01ovH39Ba
	 ZFhO9+kyh0P7w==
Date: Sat, 26 Sep 2026 01:57:15 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: trusted: Reject short TPM2 public areas
Message-ID: <arb8S05PULLMYfD8@kernel.org>
References: <20260925095308.3248297-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925095308.3248297-1-4ncienth@gmail.com>

On Fri, Sep 25, 2026 at 06:53:08PM +0900, Daehyeon Ko wrote:
> tpm2_load_cmd() reads TPMA_OBJECT with get_unaligned_be32(pub + 4), but
> does not require public_len to cover that field.
> 
> A new-format blob with public_len zero makes the read begin at the end of
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
> +	if (public_len < 8)
> +		return -E2BIG;
>  
>  	pub = blob + 2 + private_len + 2;
>  	/* key attributes are always at offset 4 */
> 
> base-commit: 27d14d3b15d5691bcbf0683883a2ea12469edbea

Yeah, makes sense as those eight bytes is what covers the data needed
to identify the key.


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks.

Br, Jarkko
