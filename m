Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD4D286425;
	Fri, 25 Sep 2026 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790346091; cv=none; b=eARtfe41+ZebuqQxfLXGhw1sKU2MjKlrRv4zstvlq4fCZT684szsCE0hSCZeedCqL4oa2cT1h1b634XitaE+KICV6Q7wZBYYNfqYY3FEjEN/AHfHAIGplQ8kvKeN983CSUNvsToIicHcSvEQPXQm2oYcgB116/SPriZqXE0+Vdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790346091; c=relaxed/simple;
	bh=KMTJ11ykdnFGIB5IBKpgsNqnRmMbRb/OBM5OhUJ/bKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUXOWV2Y8+GtYLNRr4RJTLX97YfcXNzU4uAsNoqJTuTYPCzGIkJzNBHUVk2Ls8JyjZfh8tZV+fdvI++z3LBvWl3NDcNa3DZP4f6bk0L9ZiBdHtixVpG0r7msZJivh90XpHuYRRFPg353v4wIrY6q/HewTdk8nZ5fSVTuaqom4IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbjpMN5X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbjpMN5X"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E393C1F000FF;
	Fri, 25 Sep 2026 14:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790346088;
	bh=lk9ExM5C04rCLZ8OJ128JihICZt0NCkl3prr+DKdW0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WbjpMN5X6Iqa+zPlNs2dmeXG2IWucUCBCTCBdrscichJ9ebaQup2KIpM16uOus/RQ
	 MOMiE+TuiYekYLZhyF5jEY7LZL4dekBcrb9dKXYXlBfSQztRZv0tSLrtBxSbtSHq/2
	 nJp+tylThy1lfXNdCCNhyNSnabwg9dRY/hus9OYsUkUlqj5jufxviXrJ2dO//sVk/t
	 bpCrLnapQbyeQk6NaoYsAoNNuxm/5dFnG2Z+JYpqgumT49N4FWQKGaKK0Nk3kR1mWb
	 X941q2DbYZ7O+CQUaC0eRuAy+xnzeu9lK7+Dyu0qwmgYJcye077Vh3NoB9/NkdHnP1
	 bEXSEOv+X63lg==
Date: Fri, 25 Sep 2026 17:21:24 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Hui Peng <benquike@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: reject descriptions exceeding U16_MAX in
 __key_create_or_update()
Message-ID: <araDZNQvIkDvcmfJ@kernel.org>
References: <20260919203511.2580732-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919203511.2580732-1-benquike@gmail.com>

On Sat, Sep 19, 2026 at 08:35:11PM +0000, Hui Peng wrote:
> struct keyring_index_key stores the key description length in a 16-bit
> field (u16 desc_len), and __key_link_begin() enforces
> BUG_ON(index_key->desc_len == 0).
> 
> While add_key() bounds explicit userspace description strings to
> KEY_MAX_DESC_SIZE (4096), when the userspace description is NULL or
> empty __key_create_or_update() delegates description generation to
> index_key.type->preparse(&prep) on the payload (up to 1 MiB). Key types
> such as "asymmetric" (x509_key_preparse()) construct prep.description
> from the certificate issuer, subject, and hex-encoded serial number,
> which can exceed 65535 bytes.
> 
> __key_create_or_update() then assigns:
> 
>         index_key.desc_len = strlen(index_key.description);
> 
> without checking whether the length fits in u16. When
> strlen(index_key.description) is 65536 (0x10000), index_key.desc_len
> truncates to 0 and immediately triggers BUG_ON(index_key->desc_len == 0)
> in __key_link_begin(). Lengths above 65536 truncate modulo 65536,
> corrupting keyring hash and comparison lengths.
> 
> Reject empty descriptions or descriptions longer than U16_MAX with
> -EINVAL in __key_create_or_update() and key_alloc().
> 
> Fixes: 16feef434017 ("KEYS: Consolidate the concept of an 'index key' for key access")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>

Were you able to construct X.509 certificate that triggers the bug?

I do think range checks should exist and current implementation leaves
staying within appropriate range somewhat open.

> ---
> diff --git a/security/keys/key.c b/security/keys/key.c
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -245,6 +245,8 @@ struct key *key_alloc(struct key_type *type, const char *desc,
>  	}
>  
>  	desclen = strlen(desc);
> +	if (desclen > U16_MAX)
> +		goto error;
>  	quotalen = desclen + 1 + type->def_datalen;
>  
>  	/* get hold of the key tracking for this user */
> @@ -820,6 +822,7 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
>  	const struct cred *cred = current_cred();
>  	struct key *keyring, *key = NULL;
>  	key_ref_t key_ref;
> +	size_t desc_len;
>  	int ret;
>  	struct key_restriction *restrict_link = NULL;
>  
> @@ -865,7 +868,11 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
>  		if (!index_key.description)
>  			goto error_free_prep;
>  	}
> -	index_key.desc_len = strlen(index_key.description);
> +	desc_len = strlen(index_key.description);
> +	key_ref = ERR_PTR(-EINVAL);

Why key_ref is assigned here?

> +	if (!desc_len || desc_len > U16_MAX)
> +		goto error_free_prep;
> +	index_key.desc_len = desc_len;
>  	key_set_index_key(&index_key);
>  
>  	ret = __key_link_lock(keyring, &index_key);
> -- 
> 2.43.0

Br, Jarkko
