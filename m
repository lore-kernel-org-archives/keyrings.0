Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795562658;
	b=FzpgRk7PkUMYE4+Nrkz2ge6ftnVkKvmY1xaEMmoZMbPuCFPsjp0Lg37TPok3QJ5CXpP0
	 Rhbfh5z7HpjM6cha0f6Ft2gNNyC1oQ+xWHWMjxAzSdJRxUU/HlBmdHq/Wkuc+eE2JOoz5
	 W7E8IZeUaz84QuGc5ZBj+TorEVDQbzCE3QXJDzke4rrn17sUSDnbYz4Z6a10lRaDlIV4H
	 dSgX+PmfYtZeOZlxkPFfFSkxyjSQALYCbqIvKNyEcREeR1es9Psnj4iBEzuvM4ugtqpbf
	 lCekVlSyQaRhMnP5POuC8LVzzayHK5Gl/avt/PFpI7zONfxnYL+S3g2/NfMhUuta60Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795562658;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VWOa+OHeYg0bo45k/IVN3s6CMsaFwwZbA3v5LIT0KL0=;
	b=PHGdyRKRpQR8a2GCVO8WVe7kWMla0XMg7NG0RbsJhZQ8Hd5VWQNCKI6ry7mB2VUeMpGh
	 LZGOcUEmgee1ffCVqqmkjYPhnqE5D+nNmm6P/cdtwBfK+sffxvC+eFz70Rp34zEaP0yuz
	 jljYBbfjUYBOO7W55LHbjVEo2fHGniBUzVZ27eXPN7AGsvfPgv3/twdtSuWxCjTl4tu7x
	 0t0GReiU1MR5s9WeWFjW8c13x3B13LtsQ8gDa6cZzcC5/GOBGUFpnGPtPd37mFCQUV1EY
	 gwr8nmVxUTnIUugQLWFtLdJjNnOXGPib0gMG8A+Nn0y0rkBEUmaF+9o6TAIGcuDkK/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oZYdkNBq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0D42F606A6A1;
	Tue, 24 Nov 2026 23:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oZYdkNBq
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E51BF1F000D0;
	Tue, 24 Nov 2026 23:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795562657;
	bh=VWOa+OHeYg0bo45k/IVN3s6CMsaFwwZbA3v5LIT0KL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oZYdkNBqVYpM9h5JzH9C4GRkxNQLDtgTH/hJnYyp2rdh7EfDV1jDTRmr7Wgyjjlkc
	 kmfz2RNRgNIQ0t9laDng6gPso7lGSHyy70J5mS1E88RRB8mAlKNC38+Ok9BNaXDwmT
	 EVUdaQOoMSciWSj2ZtxsehZOCJVgkBNdxbfCXdfxjNJmTF4XovlEj5GNfGOB1F4/OM
	 UJdekAUwWXA1HwaWC6b84TUaFe2tDuQgpzRHaORaEiVI+E8bBBB5DIyo1LH+a1XmMC
	 a5hTXm2TOi1d3NHNpK0B10Bu+AMW0woSMrM8GMOearXqG1Ebv4M5dEjjNWeJky0ojq
	 l4UFwnG0eDjFw==
Date: Wed, 25 Nov 2026 01:24:13 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guicai Ma <maguicai@kylinos.cn>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] KEYS: Prevent key type removal during
 key_instantiate_and_link()
Message-ID: <awYcnWU4I8vYGBaQ@kernel.org>
References: <20261124174035.1614480-1-jarkko@kernel.org>
 <20261124230016.1211738-1-maguicai@kylinos.cn>
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
In-Reply-To: <20261124230016.1211738-1-maguicai@kylinos.cn>

On Tue, Nov 24, 2026 at 06:00:16PM -0500, Guicai Ma wrote:
> On Tue, 24 Nov 2026 19:40:35 +0200, Jarkko Sakkinen wrote:
> > @@ -610,11 +628,12 @@ int key_reject_and_link(struct key *key,
> >  		}
> >  	}
> >
> > -	mutex_lock(&key_construction_mutex);
> >  	down_write_nested(&key->sem, 2);
> >
> >  	/* can't instantiate twice */
> >  	if (key->state == KEY_IS_UNINSTANTIATED) {
> > +		mutex_lock(&key_construction_mutex);
> 
> Here __key_link_begin() still runs before key->sem is taken and there is
> no KEY_FLAG_DEAD check, so the link path is still taken: on 7.4-rc3 with
> KASAN and PROVE_LOCKING, KEYCTL_REJECT with a target keyring on a dead
> key returns 0 instead of -EKEYREVOKED. If pass 3 retypes the key before
> key->sem is taken, __key_link() inserts it with an edit built from the
> old type.
> 
> Taking key->sem before __key_link_begin() and skipping the link with
> link_ret = -EKEYREVOKED when KEY_FLAG_DEAD is set avoids that, and still
> lets the negative instantiation finish so request_key() waiters wake up.
> 
> In key_instantiate_and_link():
> > +	down_write_nested(&key->sem, 2);
> > +
> > +	if (test_bit(KEY_FLAG_DEAD, &key->flags)) {
> > +		ret = -EKEYREVOKED;
> > +		goto out_unlock;
> > +	}
> 
> After a modular type is unloaded, key->sem still carries the module's
> lock_class_key, which lockdep_free_key_range() dropped. In the post-rmmod
> instantiate test up_write() here warns "trying to release lock
> (&type->lock_class) ... no more locks to release". Module pinning would
> remove this; it still matters for stable backports.
> 
> The 200-round instantiate/reject race and encrypted-key instantiation
> pass.

I'm with you on backports part of course, and apparently you are right
what you're saying. Thanks for pointing this out.

Addin SCRU just feels a bit heavy measure but the concurrency case is
also somewhat nasty. But in the end of the day it's only +10 LOC and
I understand why it works, and I also under why this does not :-)

It was not that much more complicated. Can you put the commit message
more brief and exactly put emphasis on SCRU part?

> 
> Thanks,
> Guicai

Br, Jarkko
