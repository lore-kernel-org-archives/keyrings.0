Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E796832F757;
	Mon, 22 Jun 2026 15:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782141856; cv=none; b=JZQnmoKhynL5JZOoLuz2XYzPD6cMaGhWz1zF6WrOO+nbRR+sWtjctd88hZcWtJzsmpJJAnIhIpX8xgFbvSzMDDvAONPDXJ1S8Ffz6xYA6bQFgnRTNQkmX36nM02VpBmFsc6JjRkRVWVuzkjuFe/6q5nFc+rRHgoxofWGKVSelII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782141856; c=relaxed/simple;
	bh=hu4TQQQ2kLY6TbupZJ5UTBdHViF2xsQDWC075aCoRvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pdn3JUOV97pQEKCvMk4vc/B+TJVVYfswZz5g04Os8SfDnUZLMMfDKH3DhSv+IoPBhdKubwFXQeKhIn4lA86rtXEhpfHJynU65FsQo0oaivxsp1hF3e3sV5/u1OsDxM58Gd9wkIUM3tEGJjS5ugaXSpSfavmzQYpG9om8E0KmuzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FSqJJySf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FSqJJySf"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1321D1F00A3A;
	Mon, 22 Jun 2026 15:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782141855;
	bh=biMhVOMPH5LjI+s0O7L7liAdmt3BubRONcx2Lql16Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FSqJJySfoHfmMKS8iGU1nmAFVW1O/eGfi/dBXXQKSFmP8wzktIpivvTbdGoTXUfq8
	 rcqL3VFOn8K6mc75TQmLUK0snL7a6tPY/ujVeBIOTFTiU6nSUK/gSHv+eq60wnE2ri
	 rXgPd2vWRkz5liZ7gLgK53DZiF7l+552SYJRl1ZXWpUCguXYW2RlWwetm0wSokrxC7
	 h9eyqC2jD7sXj1Xeq7dvFJPVsventHRlvu5KUZjT7CCUCjQbECP26aCQit4UQo1TYz
	 teSsSXCh4V2XdHg3z6y1dwbYfYG3AmBHrAoY74Rj2KCuIcWnf8C0WNPgXZ4tqf9MRv
	 FrgYA9uzkKT4g==
Date: Mon, 22 Jun 2026 18:24:11 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Berkay =?iso-8859-1?Q?Y=FCrekli?= <ps1296@owsa.nl>
Cc: david@sigma-star.at, upstream+dcp@sigma-star.at,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH] keys: trusted: dcp: Make dcp_trusted_key_ops const
Message-ID: <ajlTmzEigwaLxadN@kernel.org>
References: <CAMyZDTsA-m0R1Ziy74Ck0EPj8UFJhUw-vE0_ACrQ3hiLLaNaKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMyZDTsA-m0R1Ziy74Ck0EPj8UFJhUw-vE0_ACrQ3hiLLaNaKQ@mail.gmail.com>

On Sun, Jun 21, 2026 at 09:05:40PM -0400, Berkay Yürekli wrote:
> Mark the dcp_trusted_key_ops structure as const to improve kernel
> self-protection. This structure contains function pointers that are
> initialized once during module initialization and never modified.
> 
> Making function pointers read-only protects against memory corruption
> attacks where an attacker might overwrite these pointers to redirect
> execution flow, as recommended in Documentation/security/self-protection.rst.
> 
> Signed-off-by: mcss <ps1296@owsa.nl>

full name please

> 
> ---
>  include/keys/trusted_dcp.h          | 2 +-
>  security/keys/trusted-keys/trusted_dcp.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/keys/trusted_dcp.h b/include/keys/trusted_dcp.h
> index 9aaa42075b40..8ee24f2d21ff 100644
> --- a/include/keys/trusted_dcp.h
> +++ b/include/keys/trusted_dcp.h
> @@ -6,6 +6,6 @@
>  #ifndef TRUSTED_DCP_H
>  #define TRUSTED_DCP_H
>  
> -extern struct trusted_key_ops dcp_trusted_key_ops;
> +extern const struct trusted_key_ops dcp_trusted_key_ops;
>  
>  #endif
> diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/
> trusted-keys/trusted_dcp.c
> index 7b6eb655df0c..f638078640f9 100644
> --- a/security/keys/trusted-keys/trusted_dcp.c
> +++ b/security/keys/trusted-keys/trusted_dcp.c
> @@ -347,7 +347,7 @@ static void trusted_dcp_exit(void)
>   unregister_key_type(&key_type_trusted);
>  }
>  
> -struct trusted_key_ops dcp_trusted_key_ops = {
> +const struct trusted_key_ops dcp_trusted_key_ops = {
>   .exit = trusted_dcp_exit,
>   .init = trusted_dcp_init,
>   .seal = trusted_dcp_seal,
> --
> 2.54.0
> 

BR, Jarkko
