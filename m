Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516789;
	b=U3mzkraH36xmKdbRHP9U1kqI7CdNLr+TVYHZ+FFUlpPrblScgwY0UoOm/vJs0fQ+oOp6
	 pvN6pcEoW/yxvzxdqbADZumqF28Cg60Eqm9R018/tC8wDU6ZX0ZvPgBf4O6YWWoUtDAba
	 NP9I04DUKb+MwgliKOHOIt5KFGVtS+z8itPuNrj0HSOQ8ls62WfCnwldMhcrUm+OPiTt7
	 mNMj/p3RQamgesxbYk5MbLIIDZpMshxbx5kUBJOKSIaePpXO6Y1Bhu/8udyFeLNQ/14ih
	 1REoHlF/QbehBsKimH3mwFbO1tuiiqx6NruYjuvnB3ssVlZbZM2q4qmEmx1jK3xADYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516789;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=XaIoBa6eQ++jknaYes2r4zpKhd074VPU4OvOZ99nt48=;
	b=D234xGMgzqc/JnwmsEOko0eTT7IsfvknbGG7uiA0HsgDLp8cQzeDvSY+bskBGmCO6t/K
	 dlcOr9o8sPlxu4Kdu8pSycCWWoAQSKyshR97tjCZio7zd4RUN0ouDN7OqQ/KAxcEBWzQt
	 rtevhXcX3hg2ax3cUIb/g2zE6f2C+hyiDNbUmFyuAqIhdBYGQ+asOnamky6HyhxjZ9vli
	 faDkpM1sqliqgdSbgpBoERHZhU/6cnatRC8luhDQYwzVGDt85MuLlszxCSqpnYGjPvRB0
	 rGTWghytZks5yc79Xl3IAPH8+r37JjH8bNRJj6BvI4si+qHVRNpQHu9jVCNFb5/qOew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3AFAC606A322;
	Tue, 20 Oct 2026 17:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A7A431F000CC;
	Tue, 20 Oct 2026 17:19:48 +0000 (UTC)
Date: Tue, 20 Oct 2026 20:19:15 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>,
	Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: trusted: Reject short TPM2 public areas
Message-ID: <ateik-fTiwltXgFJ@kernel.org>
References: <ateELTsfmHsdCEGL@kernel.org>
 <20261020161954.3956212-1-4ncienth@gmail.com>
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
In-Reply-To: <20261020161954.3956212-1-4ncienth@gmail.com>

On Wed, Oct 21, 2026 at 01:19:54AM +0900, Daehyeon Ko wrote:
> tpm2_load_cmd() reads TPMA_OBJECT with get_unaligned_be32(pub + 4), but
> does not require public_len to cover that field.
> 
> A TPM 2.0 ASN.1 key blob with public_len zero makes the read begin at the
> end of the B + 4-byte decoded allocation, causing a four-byte heap
> out-of-bounds read before the TPM command is transmitted. This is reachable
> from an unprivileged add_key() call when TPM trusted keys and a TPM2 device
> are available.
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
> rejected it with -EINVAL and no KASAN report in 3/3 boots; valid TPM 2.0
> ASN.1 and legacy trusted-key loads continued to succeed.
> 
> The issue was found with an LLM-assisted source audit and validated with an
> end-to-end QEMU and swtpm reproducer.

I did not get any response from you so I'll put one more nit here.

I think it would be better swap these two paragraphs with description
how you address the issue, and why -EINVAL is the right return value
here.

> 
> Fixes: e5fb5d2c5a03 ("security: keys: trusted: Make sealed key properly interoperable")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
> Changes in v2:
> - Describe the wrapper as the TPM 2.0 ASN.1 key format.
> - Explain the eight-byte minimum next to the check.
> - Return -EINVAL for a malformed TPMT_PUBLIC instead of -E2BIG.
> - Replace the obsolete Assisted-by trailer with changelog disclosure.
> 
> v1: https://lore.kernel.org/r/20260925095308.3248297-1-4ncienth@gmail.com
> 
>  security/keys/trusted-keys/trusted_tpm2.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 30188a0ec6766..fb45795b53327 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -425,6 +425,13 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
>  	if (private_len + 2 + public_len + 2 > blob_len)
>  		return -E2BIG;
>  
> +	/*
> +	 * TPMT_PUBLIC starts with type (2), nameAlg (2), and
> +	 * objectAttributes (4), which is read below.
> +	 */
> +	if (public_len < 8)
> +		return -EINVAL;
> +

I don't think that this nails it as well what this protects against as
what I proposed and it does not wrap at 80 chacters.

However, I think what is better here are the sizes in parentheses so
take my comment and add sizes to it (and wrap to 80 characters).

>  	pub = blob + 2 + private_len + 2;
>  	/* key attributes are always at offset 4 */
>  	attrs = get_unaligned_be32(pub + 4);
> 
> base-commit: 722658cac48a6ba49f5506fd74d010ad9dbb2f05
> -- 
> 2.55.0
> 

Br, Jarkko
