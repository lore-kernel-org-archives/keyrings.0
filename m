Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604454;
	b=kt3/pXU8KYRReZ9PArY0Bw6+pIcfUR0HQ/D31bnAyi2UIjZA2Oay4h/9zu7wTM2h1ZZo
	 60C6XWXSxC9Vh8ZNSDCvid6s7oVrN+Rb4LUkuxZkDafI+aRetj1DhYNDeGV29h/OUPEci
	 Fs5tcijIn1c8/TQQ05HXw9A4phCYKe4j5Qh+kx8StweOAsFidQEqe1sgoo+ph8l9jUrle
	 xPZaNuIxEshPFIuuWNPxvCrIQzV/vTP8a8DCrHaiyQlzd6aZ9vAUIuofwZrHwMYw1SN+5
	 cUXC/k86sr7bMiQXhZ3yxp29C9Qotf1mBOuWsrYzaJ7XW6IXppDtsItQHEJYiZK6foA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604454;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=OV7qYi7W/vfkD8MCwFb5WEeCnowUs5B5QyZ5kQjzbiI=;
	b=tcbyEbCi91NZW/3wSun6FejNdBCNnW+zAmtmUoPiLPYVEeKVeJkxTbmpBIdx16crwgG9
	 aHdTVvAS6HtuZIf3lhoIhyGKGcQ5Tohwt/xNlHtSiSN36LShJVfXlLU6HJ3GcinY9DRyp
	 SyOjE4jO7Md+cVDe1TovbzGJMXhKleqnoMkC9Yg9WfCPXMTVgYaKwm6rYK2WmPr3t70py
	 FrEXTORMBP2JAVSWI7OVPCBxdLWjurkDqYHJltLqhJIF67fvlhV9+9acH1InY3wGlc46Z
	 WrE0fDnTf2oeCXPlWK5SEh+aFq6YotCiS+z8mE+fa4WbHK3+hzByqsQAxDWQv+ydy4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F337+Enm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 51B09606A324;
	Mon,  2 Nov 2026 07:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F337+Enm
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 67D0A1F00919;
	Mon,  2 Nov 2026 07:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793604453;
	bh=OV7qYi7W/vfkD8MCwFb5WEeCnowUs5B5QyZ5kQjzbiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F337+EnmUtVqpRcwDVIMM76HdG8LPLxs6tk0pj0bhi3x485ZcTlxX/Evm2x5qsdd+
	 f5oYnPvTJsGq2sgi6sOAq+3pMuTmPi8x99E1tuKKEeAEinSX9kMapI9NndpCsMHLts
	 yiX7GTzjCBe7QmO4NM9gQMJTVWfOVT34dwfCP+RjOjlwBatCjJPEDDkmXpD3Gs2End
	 I8OKY01Mc2lqbu7yHfA6eH6fyZAAmPkrLsm0tP8xUi2SdV39QFIRNN+a+8gWq0cd2b
	 dvox5ouQp19W43K3aRVqZksWHZV69wZwxtdQXVsPprdcsA9OQ96a09JWtXOWUAE3SG
	 CdYYJv7dX36SQ==
Date: Mon, 2 Nov 2026 09:27:30 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Cen Zhang <zzzccc427@gmail.com>, dhowells@redhat.com,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com,
	jjzuming@gmail.com
Subject: Re: [PATCH v3] keys: Protect the update method check against type
 removalg
Message-ID: <aug7YvK_mhbm51JR@kernel.org>
References: <pm-keys-update-type-removal-20261029-v8-a0dbc48c588bf2b6a278@gmail.com>
 <20261101221519.GB2689@quark>
 <aug072sNik47BXxQ@kernel.org>
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
In-Reply-To: <aug072sNik47BXxQ@kernel.org>

On Mon, Nov 02, 2026 at 09:00:03AM +0200, Jarkko Sakkinen wrote:
> On Sun, Nov 01, 2026 at 02:15:19PM -0800, Eric Biggers wrote:
> > On Sat, Oct 31, 2026 at 05:26:36PM +0800, Cen Zhang wrote:
> > > Take key->sem before the first access to key->type and hold it until
> > > the preparsed payload has been freed. Once a key exists, only the GC
> > > changes key->type, and it does so with key->sem held for writing.
> > 
> > Reviewed-by: Eric Biggers <ebiggers@kernel.org>
> > 
> > But it seems broken that a key type can be removed while keys of that
> > type still exist.
> 
> It might sense add ->owner and use try_module_get(). That would lead
> into removal of key_type_dead.
> 
> I'd think that is doable but I would first consider applying
> https://lore.kernel.org/keyrings/20261030205412.3138975-1-jarkko@kernel.org/
> as that is more substantial multi-subsystem change.

I would probably favor this idea but it would also change visible
semantics how key types behave with rmmod.

I.e. -EBUSY instead of immediate success. I'm only worried here
of user space relaying on how it works right now.

Br, Jarkko
