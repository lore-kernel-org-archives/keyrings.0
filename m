Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323AF318ED9;
	Thu,  9 Apr 2026 18:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759249; cv=none; b=FB6npi+gSZ107z+DWf9vc7zDSIwP5EQvJIAIkz0IwmbIy3sQgy1KAbMTIsuga+aFeT1c2DQlWTyXqP8CW043a78SR4piAI0RFx4sC7oaAwcxQFSSra7I0wcrA4F70W1C+6Sg6mmi+e05NwQW5BC4K+xL94CopuGWNevOP8sQj6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759249; c=relaxed/simple;
	bh=uYF3YifdH7fF48Txes38Lb066U9KkSeGIjb8z9XqBtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1zRxgIMv/JZBG2QvoTasMdCdmublQ+/NEwhC+/zG4rsVQPfpB5Z6/LJbUXRFYir80/LyG/3ec2ohe/Z1FmS6RI+6dGadqNWH9FVBCqsq5BH88eWY3aGjonR632KcIpFpaFTmcrGVMmvBA5yb3FjjV4t0PBGKrOM7DxMxI7oUSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jZWAK1mn; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jZWAK1mn"
Date: Thu, 9 Apr 2026 20:27:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775759236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y7d4Zgt5+EzRgdYUx/FvEzdLdOAz12KOBo8NlzxSr74=;
	b=jZWAK1mnkdkw4pfo7qB5vMClEnnF19Nm8uto5PrwEL8PIWjF4rAzhOaxW19mh9H/3dImDC
	Ir2XkbrxoPrt5UUHbE0kKtoVaS71pIC/VLrwWuQdJi3GqgcX7C0hxP0pWvl06CbvAcmlsr
	LM+cOVMpMHdsJRFzR/1QTnbMoqmkgN0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND net-next 2/2] KEYS: annotate struct
 user_key_payload with __counted_by
Message-ID: <adfvgIOB1MrocMR9@linux.dev>
References: <20260409073711.57020-6-thorsten.blum@linux.dev>
 <20260409073711.57020-4-thorsten.blum@linux.dev>
 <2641132.1775756233@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2641132.1775756233@warthog.procyon.org.uk>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 09, 2026 at 06:37:13PM +0100, David Howells wrote:
> Thorsten Blum <thorsten.blum@linux.dev> wrote:
> 
> > +			__aligned(__alignof__(u64)) __counted_by(datalen);
> 
> Can that be __aligned(8)?

Sure, I can send a v2 with __aligned(8).
