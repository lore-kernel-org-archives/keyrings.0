Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F250175A95;
	Wed,  9 Sep 2026 21:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987772; cv=none; b=lxK+YR+n72rXReWhZqge9pbYhpx8Wt3RuWrnxByo/4aK/D9zg2af8mO+vx7clYnbPccF0vKYvJpnxF13vW/n0HM3zRuMKDA4NtEZgIXJG36YHp9mQEaxVqv1sBnynlWJzWtC2tqyTJ1QJPKiO7BlO+sK+rRqSMH/NdCoWma/Zqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987772; c=relaxed/simple;
	bh=R59x8R7psJDZbM9OhsEn3f4kfpzmK0S5REH9S1Cb9iU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUBSl5kADY8t0dQJxa+BNGa2fkRce7FmuniIgMSNS7x416oVmtTpTBLwdt5lz1KvHcc7Khc3Ol9IjZbdbYPk2NXLlEq9rtWcfhhg7ivd2N/OGnnDIQoxA6PT/mU3paKBQfXf2jlKYLfTJxr5J+oGoYBpBB9XJwaj3Aba7/tnowQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BT9KHTvJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BT9KHTvJ"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3EAD31F000FF;
	Wed,  9 Sep 2026 21:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788987770;
	bh=lCvveR41iG6mS89E8edgr/x11J5hy1mj5OqLbwKrgbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BT9KHTvJ1TyIbQzlDdCnMxBJOyCC+3dQ/jVDultByePki8yE6FJM3QMAW1OfusR4H
	 qq72oRVoQo1mv5sxhQqthsHsfDATAUBsi+4unXabcgb2Z7Sc+LGbZqGPBEs1sNXBc/
	 Sxk8RKhieNKn6T+P6qlJMgP7BxoYjrEYv0TpoVxq04B3c3FxiHIcU/x4+nSJRJe7xc
	 6nxY3kKAiyTroCqeGSJ8ydk52EREO6rJciwbelvFOK4ifyPGUVxIz4lipqrUsq8b5W
	 EyY4pKo71FlmGczm8Ps7B6wahXFG8LleSAOXQpVf0RvP31e6Xib+bkliovjCAGxyHa
	 Rc/st+OhxzgGQ==
Date: Thu, 10 Sep 2026 00:02:46 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	nayna@linux.ibm.com, rnsastry@linux.ibm.com
Subject: Re: [PATCH 1/2] keys/trusted_keys: return immediately after TPM
 unseal failure
Message-ID: <aqHJdr-S7s-YMduB@kernel.org>
References: <20260902103120.222326-1-ssrish@linux.ibm.com>
 <20260902103120.222326-2-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902103120.222326-2-ssrish@linux.ibm.com>

On Wed, Sep 02, 2026 at 04:01:19PM +0530, Srish Srinivasan wrote:
> trusted_tpm_unseal() proceeds to pcrlock() when the TPM unseal operation
> fails. If pcrlock() succeeds, its return value overwrites the unseal error,
> causing key instantiation to succeed.
> 
> Return immediately when unseal fails to preserve the original error.
> 
> Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> Cc: stable@vger.kernel.org
> Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
> ---
>  security/keys/trusted-keys/trusted_tpm1.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
> index bf0bf7f36970..1168ca235205 100644
> --- a/security/keys/trusted-keys/trusted_tpm1.c
> +++ b/security/keys/trusted-keys/trusted_tpm1.c
> @@ -923,8 +923,10 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
>  		ret = tpm2_unseal_trusted(chip, p, options);
>  	else
>  		ret = key_unseal(p, options);
> -	if (ret < 0)
> +	if (ret < 0) {
>  		pr_info("key_unseal failed (%d)\n", ret);
> +		return ret;
> +	}
>  
>  	if (options->pcrlock) {
>  		ret = pcrlock(options->pcrlock);
> -- 
> 2.53.0
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
