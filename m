Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB2F3D4137;
	Fri,  9 Oct 2026 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554005; cv=none; b=DfcwQLsYJE+2JUr5p4kefpEahm97znd+19W4hFQTT7ic6GFcOb8mFfxjuZ8lhniOuhixelEgoHhR+GftBGmwIEUWFbgneUAjfedQPwvI249bkUI3NhgDm0DnMAx65XGikmXdu5w8K94CSkc/bsip6e1tmKxZH3kQFIe8rq3RgPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554005; c=relaxed/simple;
	bh=wwQLBBCDgQtkxwgcEJAIRKX/9FFU8CvbK7rE//19MsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kse8JQdYsJBHhUpWTxBFLils7R91qa5BuStaukX6RMt3xWgWmv7ObbCPxvGNfT00lu+JD4eaXyfw5CnWXVfKco1BJrXC0wnVgHGdehal+k0LBdhc9OedF5hWQpXgXxUvC1x5LoG4Bs5nMxToXqoOysAQ56Y9ZiA9ac517VoacBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fiauu7rA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fiauu7rA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E11D1F000FF;
	Fri,  9 Oct 2026 13:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791554004;
	bh=pKVECIe1GuZeVTptdzU/muxgQ79NyTRV6qLsS00zFt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fiauu7rAz9q0I20ZrTStokCU/Pu0RQLkA7vXjN85/Eo1spYMvZNU60xG8on2Ve8DH
	 pQobrmn88etPrgZ5Dj/++HH2ilM/funC4IyhZJLLsUQW+mj0BmbYAre1QhfZUzx/Ax
	 iNtNM4PhqiDiW5tr42tuoZN9liwRf8CYFx7rQOz+fFms+bb2sMv98ZjnCO+1G23BIU
	 9R/bhP+hO+j9wX8BLsTWRFzLNY5Ufio+1wAcW1tQTDeJnRW+4UChR6KnJHocZpKNEf
	 M47LtOaek208ik+MkLjU0m7k/AR2DDQ/xK5aR+AA2YxXDODjV+foF/LhLJk/+cb7/S
	 jbcyY8Kn0iihg==
Date: Fri, 9 Oct 2026 15:52:28 +0200
From: Eric Biggers <ebiggers@kernel.org>
To: Massimiliano Marretta <massimiliano.marretta@egicon.com>
Cc: David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>, keyrings@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Add bulk signing support for PKCS#11 keys
Message-ID: <20261009135228.GA321175@quark>
References: <20261009101915.495734-1-massimiliano.marretta@egicon.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009101915.495734-1-massimiliano.marretta@egicon.com>

On Fri, Oct 09, 2026 at 12:19:13PM +0200, Massimiliano Marretta wrote:
> Add support for signing kernel modules in bulk when the signing
> key is stored on a PKCS#11 token.
> 
> Currently scripts/sign-file signs one module per invocation. When
> the key lives on a PKCS#11 token (e.g. a Nitrokey HSM or a
> SmartCard-HSM), every invocation pays a fixed initialization cost
> of 25-36 seconds, which dominates the actual signing time. For a
> typical build with hundreds of modules this is impractical.

Can you elaborate on what problem you're trying to solve by using not
only asymmetric signatures, but also an HSM to hold the private key?

Have you considered hash-based integrity checking
(https://lore.kernel.org/linux-modules/20260505-module-hashes-v5-0-e174a5a49fce@weissschuh.net/)?

- Eric
