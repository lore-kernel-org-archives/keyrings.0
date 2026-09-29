Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1B9486422;
	Tue, 29 Sep 2026 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790716998; cv=none; b=OoAQbup0hKCZjkgcW+pWnFA84muop9HuVEorGM+TO6Xk6yY9IuqcQ5u9/1ey3MkDUSlH0kfCJPgsA3Y6WaSJb6fnppqChf2H5g1h7hp8KuFj/NUbCvu4cK5ovaR+rJxpIpM/4xlqFvtDr3yDKfDOV2o266SsamcxFkAEKujiIkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790716998; c=relaxed/simple;
	bh=hBgWk7s9sOGyCLG6QGBjlo2nUmD20+2o+qn7bG8zquA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPFJkJyR2UZ0FDowLuM1E2XrxB4EQixe0PSg8HnqINX2joVgbZjUwFMHDVRH2OXDfcdum2+mEACTBJ+MniGjp3DOAlLLCwFNilZC4INpXvqaRP5PbmiMv/T2Vw/w5tTXLHqp4nvNITbXiJ9QxUEhYU1LPj4hY5aFNmnymLdP8Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrJ3kpON; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrJ3kpON"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 059DC1F000FF;
	Tue, 29 Sep 2026 21:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790716996;
	bh=DADWbIck7Nsu1Ql42hdABk8Jq9CXub8OD3BxstumOaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DrJ3kpONHFRYmgVAk2AG+WGXduV34t7WDBFxEN5Z9EpvdQOTHuBm29wSlDFH3skym
	 2fKEPZVg4wO9fKxa/TRHKD7zJJYmN9hrdZ/EurYOioLopWXPEZjLvnfh0PF/T3t8MD
	 +tuIF0jsk4doOETSnbwP3SjEySu8VqdI562LJjr8sQbS0taBNF3efxJ58YUCds9Gjy
	 v+ubryYyysGmTzEhQSlg+jBjj2sqMSAwHQNcfx8OXwOXmQzAarlakZdJ7b1GzOs0cn
	 ewv7ASD2iDVJL23ZEonKHrOCCLQmebu6vBolNxmW0EnRSdSB0ihIXPigh35vCHaYoz
	 bXjIuB6o9WprQ==
Date: Wed, 30 Sep 2026 00:23:13 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] security: keys: Fix comment of
 search_process_keyrings_rcu()
Message-ID: <arwsQdH8JqgjeRnA@kernel.org>
References: <20260928072024.91664-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928072024.91664-1-thuth@redhat.com>

On Mon, Sep 28, 2026 at 09:20:23AM +0200, Thomas Huth wrote:
> search_my_process_keyrings() has been renamed to search_cred_keyrings_rcu()
> in commit e59428f721ee ("keys: Move the RCU locks outwards from the keyring
> search functions"), but one spot has been missed in a comment.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  security/keys/process_keys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
> index a63c46bb2d148..570c131d90d5c 100644
> --- a/security/keys/process_keys.c
> +++ b/security/keys/process_keys.c
> @@ -528,7 +528,7 @@ key_ref_t search_cred_keyrings_rcu(struct keyring_search_context *ctx)
>  
>  /*
>   * Search the process keyrings attached to the supplied cred for the first
> - * matching key in the manner of search_my_process_keyrings(), but also search
> + * matching key in the manner of search_cred_keyrings_rcu(), but also search
>   * the keys attached to the assumed authorisation key using its credentials if
>   * one is available.
>   *
> -- 
> 2.55.0
> 

Thanks.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
