Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748603446A7;
	Fri, 18 Sep 2026 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789695155; cv=none; b=e8kmEqFZQzczhu7w4qkD/Y8dL7k1RK9ywbZUQc2k9TVQMbZ20O+Z13BJWZwJ6bWJV1ejmdlxPURKt/ZxRugu3fcdl3RyyU6TZDWl3ju/769UdqQCKwWatOGt28f+VsrViY63cqjdxTtcGmbQn4pQxMOY9e52wUNSpvbeeYUbRlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789695155; c=relaxed/simple;
	bh=4G2+ijy7hs+rAQ3MgyooQgk0n7ZQS5cebcVMSPfGyAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G263+WZnA2mLsNBQFZHTyE2/FdjzJ2GFxbsOcgIAuSpzoqFyrlUX+uAaJ2YO3s0MI557ScMiKbaMxhGFvIctFF1cTttG18uR499ZtnP6SaDnaDCrdjP+xR4juzSGTjBorAHX88LcuFhn475uZOxWyeVAMNW59v14GMl5u+qAhA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmOKJ/TU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmOKJ/TU"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6EF0A1F000FF;
	Fri, 18 Sep 2026 01:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789695142;
	bh=oUdhFaXhjrTU9bXBqPsBeccrOI+/aRGPsJwhCyGATKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bmOKJ/TUbpi+xI4C3tMbN4ZNM3KtVUarK2zscvV6lrvrgFKqqtqHkiDAtNJSDLJ/E
	 IdKTJooF5ucRBuzBuCWb0HqrgSRhddg+2nswEkVXcKMbbS0dK1bJJL3Oip5ntyjEnk
	 FTpLSaTbvhImzj82uo79SQPZFZwKcSltX2xbDjmpZzDHElfW5PUPlZbGpV4gsdcCPH
	 EcGj/Jsn6J+rI5oQoBDqIfJVN6UHH8vS71pc5/5cJeMmhwzWn+R+OM3ziS3HHNQ21A
	 hkusKj6uWMvwQTwpbxCvPaJYEvZlSat5MIywEMW7WwxZmxrLY3CKKBZEs1JyDE6oBV
	 yvrSxiFqqeiVg==
Date: Fri, 18 Sep 2026 04:32:18 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Srish Srinivasan <ssrish@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com, zohar@linux.ibm.com,
	stefanb@linux.ibm.com, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, nayna@linux.ibm.com,
	rnsastry@linux.ibm.com
Subject: Re: [PATCH v8 0/2] Move TPM-specific fields out of
 trusted_key_options
Message-ID: <aqyUoucEdEbc3Ugc@kernel.org>
References: <20260910075232.178855-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910075232.178855-1-ssrish@linux.ibm.com>

On Thu, Sep 10, 2026 at 01:22:30PM +0530, Srish Srinivasan wrote:
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

Thank you. Applied.

BR, Jarkko
