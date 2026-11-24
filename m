Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795563500;
	b=3THerpewfRnblsVVP92zQX4zjZNxAfkQhw8y11/5Q4IuUP5vVgyOGyF7hP2BZfWbDFrb
	 9AMfUTxWK4Gl7BQHVQ/HsEy9+WjvlsPfef0dt5wWH/RA1CQ3AmdoDYXmcOa2wGUEs48oX
	 ZPVFPbKZGRx6O5piCPuRoW+A+ZppUb9XIlU3BimAYCZ2vRe5mBtUBafwwIw4tunJ7ZipY
	 vjpEGA46VMaqLFvut/vH/IBdnwVWf2U5DojPWbvgaupp1mlyTuCn8u7XsOPgnlLGZvpYq
	 9ZrT/CEJxXQoMz3+18ixHdnoTlQ2+XqZHkJz0qx1A8KkikBSjixrkcchLCmRPPnOAmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795563500;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mCjuELGPbtop55uOSySBfQQgI7D0AQe8nbyG+v53Igw=;
	b=oHq3WWvHWWYYoZRCJ+hO7JGkYtx53ATaLvmwZo+Bz0oLa1xvmnJZ7VmVlObxLTOi8Ptj
	 bHOBq8TRrLiFDrkx20Hev9zyhdwyK+q0d29Po1C+CPnC4uApn97wdI5TaeUI7jAbvTxjE
	 onSNC+bUrGX/+mJUtATrwv5jG3hmOKW4NoTbdpAIRUokzShbseoro/ALSjUL7TNa3jDNQ
	 gDC2BJRZFiPFNA+KCbdX0HXt3d4MjvSLsFlpWYymb7QJZDpHrRKpx9pOl47ElaRE8E5Tf
	 UTqOX+bdEAHvlUxD13xxHg99c2epzrSptfiUzrYB/F+S/s/sJEkxVy5xwM/3DhvUXqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQrSL760;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D3AF7606A334;
	Tue, 24 Nov 2026 23:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EQrSL760
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E60F61F000CF;
	Tue, 24 Nov 2026 23:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795563500;
	bh=mCjuELGPbtop55uOSySBfQQgI7D0AQe8nbyG+v53Igw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EQrSL760s7fgQe0h/rjjFEvpuCz77AcI3AyRSc9H+yM6I+L/r3CiOhtXj23DUxpAO
	 o7QLpK+hxeP/ofUJMU6MEho+Rt8Qs4D+6n2iw54ZJghcGmSYtkiIFtRaDzmwqfyAPW
	 OWyNQpX3StGC4M8orT7QRxX0QRHzj4Qlr9mXlpJuzIBM9b3pBQGBnVser5ssKTcs9k
	 UnF29Vl5e4CaZKQf+LvL9vvzS8nfKsMabtAmj+ElsQf4I129sU8h9rHsjuTAOcIgAb
	 PHA9GjWfCc7kBrOzifj1ztGkbp3d4XXZnUf93vu/3oiqH5ty1kBy0ODyevRdEymz4H
	 2+phr4L/q+1hQ==
Date: Wed, 25 Nov 2026 01:38:16 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guicai Ma <maguicai@kylinos.cn>
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	James Morris <jmorris@namei.org>, Paul Moore <paul@paul-moore.com>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] KEYS: Prevent key type removal during
 key_instantiate_and_link()
Message-ID: <awYf6EKzMMvQ3525@kernel.org>
References: <20261124174035.1614480-1-jarkko@kernel.org>
 <20261124230016.1211738-1-maguicai@kylinos.cn>
 <awYcnWU4I8vYGBaQ@kernel.org>
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
In-Reply-To: <awYcnWU4I8vYGBaQ@kernel.org>

On Wed, Nov 25, 2026 at 01:24:17AM +0200, Jarkko Sakkinen wrote:
> On Tue, Nov 24, 2026 at 06:00:16PM -0500, Guicai Ma wrote:
> > On Tue, 24 Nov 2026 19:40:35 +0200, Jarkko Sakkinen wrote:
> > > @@ -610,11 +628,12 @@ int key_reject_and_link(struct key *key,
> > >  		}
> > >  	}
> > >
> > > -	mutex_lock(&key_construction_mutex);
> > >  	down_write_nested(&key->sem, 2);
> > >
> > >  	/* can't instantiate twice */
> > >  	if (key->state == KEY_IS_UNINSTANTIATED) {
> > > +		mutex_lock(&key_construction_mutex);
> > 
> > Here __key_link_begin() still runs before key->sem is taken and there is
> > no KEY_FLAG_DEAD check, so the link path is still taken: on 7.4-rc3 with
> > KASAN and PROVE_LOCKING, KEYCTL_REJECT with a target keyring on a dead
> > key returns 0 instead of -EKEYREVOKED. If pass 3 retypes the key before
> > key->sem is taken, __key_link() inserts it with an edit built from the
> > old type.
> > 
> > Taking key->sem before __key_link_begin() and skipping the link with
> > link_ret = -EKEYREVOKED when KEY_FLAG_DEAD is set avoids that, and still
> > lets the negative instantiation finish so request_key() waiters wake up.
> > 
> > In key_instantiate_and_link():
> > > +	down_write_nested(&key->sem, 2);
> > > +
> > > +	if (test_bit(KEY_FLAG_DEAD, &key->flags)) {
> > > +		ret = -EKEYREVOKED;
> > > +		goto out_unlock;
> > > +	}
> > 
> > After a modular type is unloaded, key->sem still carries the module's
> > lock_class_key, which lockdep_free_key_range() dropped. In the post-rmmod
> > instantiate test up_write() here warns "trying to release lock
> > (&type->lock_class) ... no more locks to release". Module pinning would
> > remove this; it still matters for stable backports.
> > 
> > The 200-round instantiate/reject race and encrypted-key instantiation
> > pass.
> 
> I'm with you on backports part of course, and apparently you are right
> what you're saying. Thanks for pointing this out.
> 
> Addin SCRU just feels a bit heavy measure but the concurrency case is
> also somewhat nasty. But in the end of the day it's only +10 LOC and
> I understand why it works, and I also under why this does not :-)
> 
> It was not that much more complicated. Can you put the commit message
> more brief and exactly put emphasis on SCRU part?

Take your time, as I won't be sending PRs before next week.

Br, Jarkko
