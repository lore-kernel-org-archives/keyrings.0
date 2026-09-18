Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D2C3B9DA2;
	Fri, 18 Sep 2026 02:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789697567; cv=none; b=M8OF2/ppEx4LHBbeJLV4/OqRuHtDebgSrPRA2m4iZ1qmbjwhrKn1NBSNKO8vfgmwoNstrp3+PyyCfFFvGS70BicI6GNcDXmrud5sXwKafV/cj5P269iSPQhyVl2YNhVADZiozJjabraA7Y7Uwpu/thO/FyzO0ceXxGmxuXdFA9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789697567; c=relaxed/simple;
	bh=jtX7FZ7RJ06CBiGmk1kPgZKWraP9AuswhIhdfky8550=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RsEy3tHfG1Y8qCjef/WxAxNxOKtr+KCVOMrPVvw8KFr7kTjhkr6i1w4/m1qOBIrYFGxBCadiuPCednUeCwnNw/VrRXnHlrZiy6llukv7jnjirrMhZpOTojmNzCaCY+5QDD43O4tHuaITMlpcOl+4kvSZzoP3LLzK9x5InznAnOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHVfs6Th; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHVfs6Th"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9B29C1F000FF;
	Fri, 18 Sep 2026 02:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789697565;
	bh=d4vVwkbXz45ooOzl44gRG1JuQT888xvFhnus8MsVAGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IHVfs6ThfgU+r2I3cM3beKDx9sEqHdgRB9fXzRTfCy8PvP47dFuIPJxWflHVVG0pU
	 t555heaSPScodDZAPqMe5+4XIimtnefdGyegd4TA9Ot/nVyoyBchg9TjX9AasJ5CHJ
	 yPjFqopmEzqHsOxOKw8l56mswVA55bMRJjBHq74ijeO5bzYGOn9UvcLzTx+7nFYPyW
	 xpvwCQdQR9HeyH4hfNNpVsYWpYRykZXxf/GIxeZY68Y9vp320PEZhU+ak7FCJiHafy
	 mritK0b/WZu9rpq09VB/CiiqWZJAvUwBWMorPZbCDlSbzCSRp+Lf+kxIkPoQJyby4O
	 msDiRupmV63NQ==
Date: Fri, 18 Sep 2026 05:12:41 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	stefanb@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
	rnsastry@linux.ibm.com
Subject: Re: [PATCH v9 0/2] Move TPM-specific fields out of
 trusted_key_options
Message-ID: <aqyeGbZKvLxaDwju@kernel.org>
References: <20260912062950.279104-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912062950.279104-1-ssrish@linux.ibm.com>

On Sat, Sep 12, 2026 at 11:59:48AM +0530, Srish Srinivasan wrote:
> struct trusted_key_options contains fields that are specific to the TPM
> trusted source, resulting in the accumulation backend-specific fields in
> the generic options structure.
> 
> Move the TPM-specific fields into a new struct trusted_key_tpm and store a
> pointer to it in the private member of struct trusted_key_options.
> 
> As a preparatory change, return immediately after a TPM unseal failure to
> prevent pcrlock() from overwriting the unseal error.
> 
> Changelog:
> 
>  v9:
>   - Resent the full patch set with consistent v9 subject prefix
>   - Corrected patch 1/2, which was sent as v3 in v8, which caused b4 to
>     flag the series as incomplete
> 
>  v8:
>   - Rebase onto commit
>     adc6a9f6d997 ("KEYS: trusted: Fix tpm2_load_cmd() boundary check")
>     to resolve the merge conflicts
>   - Include Jarkko's Reviewed-by tag
> 
>  v7:
>   - Fix a memory leak in the preparatory fix
> 
>  v6:
>   - Add a preparatory fix to return immediately after a TPM unseal failure
>   - Replace explicit cleanup with __free(kfree_sensitive) in the TPM seal
>     and unseal paths, as suggested by Jarkko
> 
>  v5:
>   - Rename struct trusted_tpm_options to struct trusted_key_tpm, as
>     suggestedby Jarkko.
> 
>  v4:
>   - Rebased onto mainline after tpm-buf memory-safe allocation changes were
>     merged
>   - Resolved the resulting merge conflicts
> 
>  v3:
>   - Exclude the preparatory clean up patch as the problem has been
>     addressed in commit
>     9ec4175a30eb ("KEYS: trusted: Debugging as a feature")
> 
>  v2:
>   - Exclude the bug-fix patch as it has already been applied to 6.19-rc7
>   - Rename instances of trusted_tpm_options from tpm_opts to private
>   - Use pr_debug and KERN_DEBUG for logging debug messages (preparatory
>     clean up patch)
>   - Address other minor comments from Jarkko
> 
> Srish Srinivasan (2):
>   keys/trusted_keys: return immediately after TPM unseal failure
>   keys/trusted_keys: move TPM-specific fields into struct
>     trusted_key_tpm
> 
>  include/keys/trusted-type.h               |  11 --
>  include/keys/trusted_tpm.h                |  14 +++
>  security/keys/trusted-keys/trusted_tpm1.c | 125 ++++++++++++----------
>  security/keys/trusted-keys/trusted_tpm2.c |  50 +++++----
>  4 files changed, 113 insertions(+), 87 deletions(-)
> 
> -- 
> 2.53.0
> 

I applied v8 already. Please check from my tree whether this needs
reapplying or not.

BR, Jarkko
