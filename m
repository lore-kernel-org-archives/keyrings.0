Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F1B1DDC1B;
	Tue, 11 Aug 2026 13:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786455844; cv=none; b=JTVori7lWsCwbD2tUcWur4vgBk3ZiSUT/p68WRXneZAP8/x3SihavVvNiWVigfLknTvlQjN+P/MkT6IheTOFtDA6RglhFdtWGQlgdju1nusK62spz3B0AcV/fdiSiNnqMoMJEfx1Nxp5yM4d+E6NT3SDr0sqIgQf9VjJH12TQZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786455844; c=relaxed/simple;
	bh=v+1M0ooAJbFWSfm9UKtKrb0tMJFoerTyCfJVprGm6HQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvK6p5mqvk22Q8cZ36WkZcNXAJGN5VGd/1vJp1D3P4yk9XqPqyUunwAUiTuO8krhuJC7kc7cLJNHrgJsL+jWKk79+bCCrhZmrUsjLzG2E1Jp3tPBZ1FDQkiXHUReJaeSF5fsbIENYf8A5W0C+hwv/EFZVGNMk/bh/z+xDWaTIpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3RiJeIY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3RiJeIY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21F21F000E9;
	Tue, 11 Aug 2026 13:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786455833;
	bh=Gz0q4Bj/jbKLsxjzDjzW6S4zyUlfaGH8U1N9wJqf3Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y3RiJeIYaWN4UnbzDTXg4ul0AsSy6cgnOcwgiqOsY9P1fZUaTPg4F3Wa3okQup8eb
	 pWRp7XGcWRCz4oCSZ8Fy1UUTZ1tYsaUJ3tt4a7UsJrlqJcjJbzoj4EHnW12V3F+ljx
	 M3Ogs68K4RA92eE897opZbff48XNAYuEAKJOY1D43SaGopLzR6R6yNV3+iZQX4uUQF
	 kKNIc1Sq1FqDfzd7Y6eMzVsNS6yeT7hNsLP8rfcuXyQxUXbcSys1w2pKYrjZIDxQA6
	 cJO9Schn6EhfR55koqs93qaKSc9h1hfto6sAdlorjc3T9WBVYOXZ9sc/GhLpQoAMsF
	 QQDjkEJQn3+lA==
Date: Tue, 11 Aug 2026 08:43:52 -0500
From: Rob Herring <robh@kernel.org>
To: Jan Sebastian =?iso-8859-1?Q?G=F6tte?= <linux@jaseg.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, keyrings@vger.kernel.org,
	linux-mm@kvack.org, linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org
Subject: Re: [PATCH 1/4] of/kexec: fix typo in comment (usable-memory-range)
Message-ID: <20260811134352.GA2054339-robh@kernel.org>
References: <20260731162739.158320-1-linux@jaseg.de>
 <20260731162739.158320-2-linux@jaseg.de>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731162739.158320-2-linux@jaseg.de>

On Fri, Jul 31, 2026 at 06:27:36PM +0200, Jan Sebastian Götte wrote:
> Signed-off-by: Jan Sebastian Götte <linux@jaseg.de>
> ---
>  drivers/of/kexec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/of/kexec.c b/drivers/of/kexec.c
> index 029903b986cb..36635f6cb900 100644
> --- a/drivers/of/kexec.c
> +++ b/drivers/of/kexec.c
> @@ -24,7 +24,7 @@
>  
>  /*
>   * Additional space needed for the FDT buffer so that we can add initrd,
> - * bootargs, kaslr-seed, rng-seed, useable-memory-range and elfcorehdr.
> + * bootargs, kaslr-seed, rng-seed, usable-memory-range and elfcorehdr.

If we're going to fix it, really it is "linux,usable-memory-range" and 
"linux,elfcorehdr".

Rob
