Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10122E7F0A
	for <keyrings@vger.kernel.org>; Sun, 10 May 2026 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778410056; cv=none; b=jqBeJYw8URVnv171ZBJzvFkriu/ECoaRcImelcd7JrDSXIDro+XPCGoIdHY6189hZ+4PQi+c2JWvWItoSuziFZHzRnuBCLTiDgkkYKWq4qCNea9W8UChM4nyGUXpH6DQK0skzlnWWv+OCLDR77GasfBcZGgZrmBQeG5iCkvUyag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778410056; c=relaxed/simple;
	bh=TItSsgo6xk+A+nS+xKDE670mrpC2vv49TvVJ4oJCwlM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F/1HwpfUhqjxW8GEiok16MWq0xUxyxoRjD9KBml7pOmN02l/4rzGK3Y29BE9v0FawutU/Evgnz7RJ1PNzFd1ZJigQsDkAb+nkV9TdFsbX2mDBKxDgtgnv7JGcV42aKerkPeJ3db4ikjw/lpvipUbWufMYCUvolGxN3UtnvgI6jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J9BzUyLY; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J9BzUyLY"
Date: Sun, 10 May 2026 12:47:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778410049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=u4Pzr0iNwGtAMfR8p6Nf/I699yHeqKq0hYur9yHLEUg=;
	b=J9BzUyLYpergVOZqFXjwm3zUjZBK1n4RkTHIQtTJoBEt2yYnGmOF+X9WsJALlZhOYRzeb/
	IQHhnD3UMa3mS2xFW83AIbwz9+x7+rw54cOVwn7nLRmzcSrUAgKG76NhSlmO67KC9GrrlT
	52/8c3djOd6TftdBYjgB6YKQorpzPFk=
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
Subject: Re: [PATCH net-next v3 2/2] KEYS: annotate struct user_key_payload
 with __counted_by
Message-ID: <agBiPEJZhWHydwuz@linux.dev>
References: <20260427114422.313356-3-thorsten.blum@linux.dev>
 <20260427114422.313356-4-thorsten.blum@linux.dev>
 <af8ZUXn4uStU_vs5@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af8ZUXn4uStU_vs5@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Sat, May 09, 2026 at 02:24:01PM +0300, Jarkko Sakkinen wrote:
> On Mon, Apr 27, 2026 at 01:44:24PM +0200, Thorsten Blum wrote:
> > Add the __counted_by() compiler attribute to the flexible array member
> > 'data' to improve bounds checking via CONFIG_UBSAN_BOUNDS and
> > CONFIG_FORTIFY_SOURCE.
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> This is again a crippled commit message.
> 
> I.e. this requires either knowing, remembering and/or cross-referencing
> "bunch of" unrelated to keyring.

I kept the commit message short because it follows the same pattern as
many other __counted_by() patches that have been accepted across several
subsystems.

I'm not sure which part of the message you want expanded. Could you be
more specific?

Thanks,
Thorsten
