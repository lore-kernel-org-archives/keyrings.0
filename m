Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B0B246778;
	Sun,  4 Oct 2026 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136453; cv=none; b=oePsOQ8ohnp0dt7aJc80ju5g7JDs7rdqLPCr2ZnB59JoIq8owLXt/SsilD8XWqbjntcIOY8G03JS/jBbvWBzEz3+rif/Ivbk93WP6vVQOSZxf4sS/Jr/b4oh7yqrigg0V+UseWABloOiLInLCR5xFT1IJjAWy3KtBoJ4Vt1Ylag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136453; c=relaxed/simple;
	bh=bIpBpwSDMTaU8BXN8CxrzjQJkRxgkHLzToHm5hjgwr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMi2v6gftCMqXvh77ixnf34Wj+DtcBDl/mGmBzStHYUdIdqUH/uBM36iRd1/fnAX+YrHSan/3AXw1GOlAOorT7va2rX+Uq5YTB2iqotF0WU7r4i7FMVY9/jjttCf95M28JP5lHBB1x+lcHEsjue0w1AGhfVuaCF2+J0TUhp+QVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLwf4tyy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLwf4tyy"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9FEA41F000FF;
	Sun,  4 Oct 2026 17:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791136450;
	bh=s1bBFTOMd9m2tkNcN4VP+RVchshr8UAmNsEx4KkZNLw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eLwf4tyyd5mGT72nG216gHgHkhDJTrhCEqosXbfVBHKoq6I6LlE+HnqZuL7B+8hVo
	 KQYFklWS7GJOzqGqiHU1gtS1dYMkG6m5G9MC0Ghwl8SDqPPnspr8F9cbOmEEgkpdZk
	 5tVRxk6zlPlmg6x8tLGLqT9g9yo0pSRBSjMctzT830MNAreqE5qIdp9J7Ydm+Ncl/5
	 8BmqwrvE/I56whU7mbMDyZ78a9RuqBtKC9fqi7EzmQSfenwBhk+Bzl9sBQq0SsxE9/
	 YyET9k4u+cpvWDqTE6N8kvjEjWKRyTNdG8bDVx31cfkMdUvK/Dd8mcgyp0bq0M+mxU
	 G7X3tvobYE6uQ==
Date: Sun, 4 Oct 2026 20:54:06 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: keyrings@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [RFC PATCH 0/2] keys: Address lookup_user_key() mutability
Message-ID: <asKSvjz2YLZhFI4t@kernel.org>
References: <20260924055521.1981957-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924055521.1981957-1-jarkko@kernel.org>

On Thu, Sep 24, 2026 at 08:55:16AM +0300, Jarkko Sakkinen wrote:
> The main objective in these patches is to remove to unneeded mutability
> from key look ups. It does harm and brings no value so it is pretty obvious
> to me that addressing this harmful behaviour is what we should do.
> 
> I based the first patch on what Jann suggested in [1]. Nothing too clever here
> and I'm ofc open for further suggestions.
> 
> [1] https://lore.kernel.org/keyrings/CAG48ez0XjVSR=M--UBauTm8sJuc+ZbhKzaPa3a6wrSVHyoKevw@mail.gmail.com/
> 
> Jarkko Sakkinen (2):
>   keys: Return user session keyring on lookup
>   keys: Reject keyring creation with overridden credentials
> 
>  Documentation/security/keys/core.rst |  7 ++-
>  security/keys/process_keys.c         | 65 +++++++++++++++-------------
>  2 files changed, 40 insertions(+), 32 deletions(-)
> 
> --
> 2.47.3
> 

So.. should I move forward to with non-RFC v2?

Note that some tags (e.g., Fixes) are missing simply because this is RFC.

Br, Jarkko
