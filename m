Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793707412;
	b=a6Z3/IfJ4tFEDSPaBOiJtLdldze+p8P+3alB8DnOYMy1r/hEyDW0jaW49cNgLhpON4Ed
	 tHkmZb02XjrrgIAo2MlCX8QJpAdUgOgqRUdCVWE/Xvv7tndsR3RjmrjblyiLjoo3jMBcc
	 OjaZoBY4MnUdWhBvvzrQB9oBCCKEPldH7+Ef373/e7p+PyuexH8a9XMmhJ2QSHtp+EJpI
	 3CWOIU/w82EmWf80Bam3C7KcIRL0rQsU324u60f08xh7QLbz0I2+k0eGa8mSwODDxOtB3
	 s7P+T4qbLU6VOBc5axtX3OCvuzql5dt93l0GN/RYoyyNEUlaOLLYKzUbEqirPvs6oag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793707412;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ErhxaLG8zQV6ewXSts/ImtHsAfSHl+3ak5JxlwrZSXQ=;
	b=TpAGhy2wOTsdN6PNYe2Fj62zFs5P1SXc4GRGGMxCkqlfFTJAVRVDmjFTtdmyyrsp5kEr
	 8+0pK1HmLIpPmgFWIWdfyXOKXL3fG70XxdDwwZ7KDGBLdR1Tlmz6yPdiZK/hp1caDVYMk
	 ech4qqss3z5Jw2togfanvq9VMx4UOkaCh+6UoaGlTLVoHSYd4o6vfsTLR63Tq9cohBfBO
	 MuJYhjAroCzj4PgUlTWhz71glqAHlBIaSOTYkQdB1qae5FZNWY1vMw4sxCLPfxvxZL1r/
	 ValNTiciQqR87PHnHtBQuihhcCxvaw9WQ/B8cIAdJo6oH2hoxn9StHoByhOLaWhm/pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQ2JLtR9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D12B1606D802;
	Tue,  3 Nov 2026 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PQ2JLtR9
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D8DEF1F00A21;
	Tue,  3 Nov 2026 12:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793707411;
	bh=ErhxaLG8zQV6ewXSts/ImtHsAfSHl+3ak5JxlwrZSXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PQ2JLtR9BtWxM/oVsy4zD2llXD3UFUxTnPGmo3o7yFcLPDfaSCQO53zYnRX3ANtyq
	 SEPsryn4DFTh0pcV9CPFRyNGTenxjzdi/EzMEDhBX574UNXyhttQunDHFe5gEpx1Z8
	 FvHy6J+et2nK2JPUgBYfLuODHNqCw87R20Lgm4AXJB7zn4xenrYQPu7N851wAx8HEi
	 pfCaFusNfdCAMpEoXhZZcw0zHP/aEytX+eQlzIQgw8kWUgnE5wfk/pkCPKTAi/+PWG
	 0KIqH3AE67fb+TYnnRQbZ1T9gX3uGtxGGP4IIybM6WFeFK3wrvKtPv1cFqHH6CA4mK
	 2/DvggfSPQUhA==
Date: Tue, 3 Nov 2026 14:03:27 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 00/11] KEYS: Sanitize the garbage collector
Message-ID: <aunNj35KmcAC4ByH@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <641294.1793700187@dhowells-thinkpadp1gen8.rmtgb.csb>
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
In-Reply-To: <641294.1793700187@dhowells-thinkpadp1gen8.rmtgb.csb>

On Tue, Nov 03, 2026 at 10:03:07AM +0000, David Howells wrote:
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > The first change has user space visible effect: rmmod semantics will change
> > from always succeeding into returning -EBUSY when keys or restrictions have
> > the LKM pinned.
> 
> Please don't do that.  That will cause the AF_RXRPC module to get pinned in
> place by outstanding connections that haven't timed out yet.

Despite the changes I think it hits wall also with DNS resolver.

This spinned up from [1]. I'll figure out some other angle or have
some ideas but please tell if you have suggestion.

The chunk based processing is available as an independent patch [2]
without prepending changes and is pretty much done, or waiting for
feedback.

> 
> David
> 

[1 https://lore.kernel.org/keyrings/20261101221519.GB2689@quark/
[2 https://lore.kernel.org/keyrings/20261030205412.3138975-1-jarkko@kernel.org/

Br, Jarkko
