Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793319730;
	b=ZCGwJQq+JsDfUv/ISmbJSyA6vAc1V8vtRcp8spGWiaup7oRMF6IJQrIUga8iLgcVqi8S
	 06CoYB6QtI5p69HcpcvJrj1uQXQ/qCvOLcY+B33REBrKTG2h8x32BSkoPeDKiOvRF4Kyk
	 62QKQ3V2lgNN3JmWjisCF687adNLJdnx80xbu7dKca06LhK/RLzzvLFqJUDbERKlbRtfx
	 G3I6iD+bNtzLSJzhRduLisc8ysXWKfKwDshFUjynYpbBmU55E3Q57U4NVvI4TU7jvYRJh
	 /Q4FFbaJ/tgDAo+6xuF3onlnBeL1p5wPssAEmhSKXPDUd53sRHVVwOUYTkUoL1fXYFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793319730;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kc1RKoWOX8N1DPFnmzPmZhXrh6On0Y0EpjyH5JLZxn8=;
	b=XI8/wL18ndmwASIVtuqh/ymiUgcUUcGQhj75PGocYZshZ2iJVvy13jTKwfanCT4+cm2J
	 dbbaYHan28KeVUr63aBo0MCKGFFTeOUfgYVF3ZcuvxZqVJaD2/B0MsmcC2BQKAt0SHh4g
	 ZctURCFbtHUPPZKfToV4hN92N32V5q0C0Yz4ICvDu/A0Qys4GawfhoLotj8qIwIl5AvMk
	 8GQphDyjBQh8YI2pTZY2ZwGKTn1TYxVWQWZjIIvjzDtbm3SePOUqIKgnz/4utB0agRo7+
	 N+fojBvDKZM4BuA2cybQMhoxBJAy9Z5qmRLP9FCgt6JGTeW9FbDorAi3HOX69u0bMDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuetkeBv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8AB64606A31A;
	Fri, 30 Oct 2026 00:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuetkeBv
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D354D1F000C1;
	Fri, 30 Oct 2026 00:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793319730;
	bh=kc1RKoWOX8N1DPFnmzPmZhXrh6On0Y0EpjyH5JLZxn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BuetkeBvrg19tvg726YaAAzROO993O2IkiV8oNMer6r+jswRue2aPFh9nAZJl4avr
	 1NtekoriCJi/QSS/5/Szb8YUovwa3T/zmWQ0LkAw5EfHYv+3lwGlVpj6xeShnAcz6o
	 ORrgcAkBuSvH7voLgC1Q/nnUL5dSlfzLEJ0hZqK/w31TO+2V+Q4ZpV1r+yebWXvMLb
	 qxYd5XFywkB+VQ/chy7w0jOeHmzpBXfkUz7GJDJfcCJtcxfVP26noKvA8IyhsE0ofH
	 r3NeUUzL/1Ud6ivz3tvheGNw913DF5mW7iKNIxexx4vCqldwR/3+3DLd8cEDhBqjzm
	 SfKk5CTTBwAMg==
Date: Fri, 30 Oct 2026 02:22:06 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: David Howells <dhowells@redhat.com>, Eric Biggers <ebiggers@kernel.org>,
	James Morris <jmorris@namei.org>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	keyrings@vger.kernel.org
Subject: Re: [PATCH v5] KEYS: key_garbage_collector(): process in chunks
Message-ID: <auPjLi6xocFw7r-k@kernel.org>
References: <20261029172918.2118600-1-jarkko@kernel.org>
 <20261029234149.218-1-hdanton@sina.com>
 <auPiF49J5QkIlnP1@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <auPiF49J5QkIlnP1@kernel.org>

On Fri, Oct 30, 2026 at 02:17:31AM +0200, Jarkko Sakkinen wrote:
> On Fri, Oct 30, 2026 at 07:41:48AM +0800, Hillf Danton wrote:
> > On Thu, 29 Oct 2026 19:29:17 +0200 Jarkko Sakkinen wrote:
> > > key_garbage_collector() has a design that is not resistant enough for
> > > workqueue lockups. The duration scales up relative to the number of items
> > > in the serial tree, which causes a reoccuring theme of being guilty of
> > > causing workqueue lockups.
> > >
> > Given cond_resched() the gc work is not a cpu hog, and given concurrency
> > workqueue can get individual cpu highly overloaded in short time, so what
> > you delivered is a half backed croissant, HBC, as you failed to make it
> > clear why lockup occurs when the number of gc items rockets up.
> 
> Please, read:
> 
> 1. Documentation/process/code-of-conduct-interpretation.rst
> 2. Documentation/process/code-of-conduct.rst

And: I'd suggest to do some self-reflection and not use LKML for
trolling. There's 4chan, Reddit and other more appriate forums for
doing that.

Br, Jarkko
