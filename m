Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD70E3BD638
	for <keyrings@vger.kernel.org>; Wed,  8 Apr 2026 12:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650896; cv=none; b=Cug0sDFGiQvsohptGloOAuLVGkLY6xRhEfTTXJ0XpI0EwJutgB+t23V5GmLQYJ5a5dv9HmZ1gX1BRIgEheLxsOx+KMuyUdYl6NOJDLC4FB/epAtWWh/y85tCjnIWHTgeRplRArKfqv7/8yJ7A8z79MO6fdGoyvtK7gAfgSCX/mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650896; c=relaxed/simple;
	bh=To1t6onb6iRbQ4NI9iTporpAVWGW80BE37Sq12ywklU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1qW7IhaPm8fAJMLU3gpfHfYrw8SWhdxU4chIABKxa5vtVnU51nqq+jQf4k2RCEQPgICQjS+H3XDKSNE0MPkY55oRqIrK9jmReDfRgz5jwwt/NbBkX+llQOvGwEEyD/pqyi9WJWif4ThOV8LSI0LnftZ4VycJMMMNGInb5+UQ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wsQz5oi7; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wsQz5oi7"
Date: Wed, 8 Apr 2026 14:21:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775650882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OV1C/PCBzbDZKqr7KrHh/nB0c1sre56nEKvZgPQ9aaA=;
	b=wsQz5oi7bs0U2vAjNNVb4rupFIvMQmqt4Cn/lYAyNgEV8sQNNYdmXcZv7hiHp9ZOzv4f0Q
	9hdKcEG57WyYt+lHdjqqmFkV88St4iVkObqCpd7RyLWuEivAdM3cRLIKXlqaOK5Pi76OUS
	zhK8QCRF+v35BIdw1x78HP4IPgjlR70=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] KEYS: annotate struct user_key_payload with
 __counted_by
Message-ID: <adZIP8w0IttbIZa2@linux.dev>
References: <20260406175810.1018681-3-thorsten.blum@linux.dev>
 <20260406175810.1018681-4-thorsten.blum@linux.dev>
 <adYZoWK_CTv2-RA_@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adYZoWK_CTv2-RA_@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 08, 2026 at 12:02:25PM +0300, Jarkko Sakkinen wrote:
> On Mon, Apr 06, 2026 at 07:58:10PM +0200, Thorsten Blum wrote:
> > Add the __counted_by() compiler attribute to the flexible array member
> > 'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> > CONFIG_FORTIFY_SOURCE.
> > 
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  include/keys/user-type.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/keys/user-type.h b/include/keys/user-type.h
> > index 386c31432789..2305991f4fcd 100644
> > --- a/include/keys/user-type.h
> > +++ b/include/keys/user-type.h
> > @@ -27,7 +27,8 @@
> >  struct user_key_payload {
> >  	struct rcu_head	rcu;		/* RCU destructor */
> >  	unsigned short	datalen;	/* length of this data */
> > -	char		data[] __aligned(__alignof__(u64)); /* actual data */
> > +	char		data[]		/* actual data */
> > +			__aligned(__alignof__(u64)) __counted_by(datalen);
> >  };
> >  
> >  extern struct key_type key_type_user;
> 
> You don't provide any evidence of any improvement.

It's a proactive hardening change to help avoid future mistakes.

The __counted_by() annotation makes the bounds visible to the compiler
and at runtime so that future ->data accesses can be checked against
->datalen.

The current code is correct regarding ->data accesses and doesn't
require any changes.
