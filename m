Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7423921F6;
	Fri,  8 May 2026 22:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278949; cv=none; b=oMpUQCy3TSwd2IZ/XI8g2kWLGnjIrFUe0AFhkZDnIFkalG/OGBxB4PA07DGbuaW0gUXpeQdRWH6M74PV6U9EiB1q9W8lkmG1Pn74mdHqi2PjbtqrU3KCl4D2/x+V2/qkNHqGjy9NL5gPf4Xpi63AiKkjodaZhgTm39FkMBRAICc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278949; c=relaxed/simple;
	bh=v+YrmPN98rmOPgqI8qzMEYAYy7v6oa9s+yEkKSjHflQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aS2lQEUFWM7HS87xi+SZYSJX/rItmvU35QwD7GDv9RLuX76QYo+OQ5edADP+CCsq7pflttbrGkh/SxcnbO2BmqOfIMcAGmko3VKoNcNVOMBX2EIWDLeZykhHNHQyIIdB+XmGZT6z/cz7LfD6rvn1Kg1Oyppw8KjCqKgKCsgEsLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ilibAvyS; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ilibAvyS"
Date: Sat, 9 May 2026 00:22:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778278942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AX0C4a1+ZGYkQkuyscavIIXsbJ2Zce7Z7oYzxtQbRF4=;
	b=ilibAvySx0V8cMRJ0cnH443wtv+acaEQ50SCRWFOyAI37FJuiobGfKVrjAot549HFeIA5V
	t/wcBj2sHfHp3trvv74dVAyqR1H6UDuc6qj06wuMkCNzR4oyH5nElWr+xzRCRr2YStEBXr
	SypEpiFYW0fltkLQLP/KNJBi8fFsrT0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Tim Bird <tim.bird@sony.com>, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/2] keys, dns: drop unused upayload->data
 NUL terminator
Message-ID: <af5iFwm9Nckoz4Jt@linux.dev>
References: <20260427114422.313356-3-thorsten.blum@linux.dev>
 <af5TvSZHwBH0N8Jq@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af5TvSZHwBH0N8Jq@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Sat, May 09, 2026 at 12:21:01AM +0300, Jarkko Sakkinen wrote:
> On Mon, Apr 27, 2026 at 01:44:23PM +0200, Thorsten Blum wrote:
> > ->data includes an extra NUL terminator despite never being used as a C
> > string and only accessing ->datalen bytes. Remove the redundant NUL
> > terminator and allocate one byte less in dns_resolver_preparse().
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> Never being used where?

Does this conversation [1] with Jakub answer your question?

[1] https://lore.kernel.org/lkml/adw5cvtPfx1SWQq9@linux.dev/

> Let me go this through.
> 
> I read this from the documentation:
> 
>   /*
>    * Preparse instantiation data for a dns_resolver key.
>    *
>    * For normal hostname lookups, the data must be a NUL-terminated string, with
>    * the NUL char accounted in datalen.

This documents prep->data and prep->datalen, which must be
NUL-terminated and is checked here in dns_resolver_preparse():

	if (!data || data[datalen - 1] != '\0')
		return -EINVAL;

According to this, datalen (prep->datalen really) must include the NUL
terminator, otherwise -EINVAL is returned.

However, my patch is about upayload->data and upayload->datalen, and
upayload->data currently has a trailing '\0', which upayload->datalen
doesn't account for (a mismatch that prevents adding __counted_by).

> So what is confusing here for me is that should upayload, which is
> original data with options and '\0'.
> 
> So my question is which is the regression here:
> 
> 1. Incorrect length. Then the fix would be simply setting length as
>    'result_len + 1', which aligns also with the snippet of documentation
>    I pasted.

This would be an option, but there is currently no consumer of
upayload->data in the kernel that uses the trailing '\0'.

> 2. Unnecessary '\0'.

Yes, '\0' is an unnecessary extra byte that no consumer of
upayload->data uses, and my patch removes it.

> If there is an issue, your commit is lacking fixes tag and cc tag to the
> author of potentially failing commit.

It's just an unused extra byte that prevents adding __counted_by(),
which is otherwise harmless, hence no fixes tag.

Thanks,
Thorsten
