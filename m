Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795861701;
	b=rAjSjlsEtq20iIvnLqzpTvI2uJYXto4LrTbcLdKJH5bFe6y745uUBjI8c3aOfoKiGd7u
	 1SKpiyV7EQE8/lip5xsgE1D+5FaWrYUJ/+Lp8B3v+3hlmjxEhUs78o1VP3vUs90yW8XDI
	 rzdMvtXBXnm9agKCq+0CuuH295UTwmdisLE5stv6fRcULnqtWLZbpfuFmvlJXo2V2TVcI
	 Wq/6XlxCWWd6sOEJp2YQlBImgXeT+kzPkLtO1agGQdekkyUIPv48Lork76DE/dOIrIdFd
	 ZWAIZV8SzX2jZzAjbnQ5pSCm6GjsuYJ992tEx3SpZu8zbo6SgmcBGSCGyQsj1E6AahA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861701;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=O9VK4etYNiBsDB79WMihHGteRv1FPxivaQCYnVGg0D0=;
	b=Lizdcu2SeoWgl14p0w7uV8H9aE0NRYW8Ab3Eh7Bc0Ru5gXSgn+FZT9R68cyCokeXmcaa
	 4HBi8GOmgdAryhZZcbONjkipNBfhBAJCkZbTtoIF/s2Hfd+yXCtj0r+ryLb9B7AC6RkoY
	 nDrCrNVNiwYTTruj7VdA4WiqP60NaTIibKA6C6QjWAUzMX96l5z/ySmDft/nebjJGab1r
	 FgrT+brjQRkcoZRV6Of1i0ilG7J4XD0f520s4zpQzmNVmSRUJZb6SMwY6PKMf2qXdmWms
	 kVafDdzW9+mfNaFVR/FiFWaJmDb5ot2z7kIOZJY32uXZVLJNUQrTznObzAKa6oo328g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MEhHub/U";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id F0A33606A31C;
	Sat, 28 Nov 2026 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MEhHub/U
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1C9DE1F00899;
	Sat, 28 Nov 2026 10:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795861700;
	bh=O9VK4etYNiBsDB79WMihHGteRv1FPxivaQCYnVGg0D0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MEhHub/UKtJKfeuRAAevq3+yJKPP2gp94KL6lU+CCYC/uYsFRrfvSIMUFYReoONG1
	 HnAIJXiW7N7vAASI1CPwvmGA5FCmLUiM8AkKHhFxPALKZhuSDAwNsDdH+5Hk7bor9U
	 Odlz4k4wBBcv018u+YBSysY6WWBXerA+17kfz06SxSS9nO3ZEjiGYAkba8im+h0UM/
	 zs+aIfhQMaPJfxGvWY+kU8snPWQEPI5RxPqyKpXYijn7a4TKdjUYmMXst4ZmkZSy5l
	 MBxw/T7FGow4BooXjgKL39M9oxig/jOKhGLulV08k83lf7MEVVJNAMFeWczt+yFfAl
	 w/DG+WHVQkR8A==
Date: Sat, 28 Nov 2026 12:28:17 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guicai Ma <maguicai@kylinos.cn>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] KEYS: Protect key instantiation and rejection against
 type removal
Message-ID: <awqswXcxSseHA1wZ@kernel.org>
References: <20261125032605.1327954-1-maguicai@kylinos.cn>
 <20261126023920.1981107-1-maguicai@kylinos.cn>
 <awhb3uC83WDzQup3@kernel.org>
 <awmE8ykDdfSqPxgw@kernel.org>
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
In-Reply-To: <awmE8ykDdfSqPxgw@kernel.org>

On Fri, Nov 27, 2026 at 03:26:11PM +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 26, 2026 at 06:18:38PM +0200, Jarkko Sakkinen wrote:
> > On Wed, Nov 25, 2026 at 09:39:20PM -0500, Guicai Ma wrote:
> > > key_instantiate_and_link() and key_reject_and_link() access key->type
> > > and link keys without synchronizing against unregister_key_type(). If
> > > the type is removed during construction, key_instantiate_and_link() can
> > > call key_type_dead.instantiate, which is NULL, and either function can
> > > link a dead key into the keyring before GC pass 3 retypes it.
> > > 
> > > key->sem cannot be used here because it inverts lock order with
> > > encrypted_instantiate() and uses a freed lockdep class after a modular
> > > type unloads, while key_types_sem may be held and methods may sleep.
> > > Guard both paths with key_type_srcu and a KEY_FLAG_DEAD check, waiting
> > > with synchronize_srcu(&key_type_srcu) after GC pass 1; for a dead key in
> > > key_reject_and_link(), just wake waiters and invalidate @authkey under
> > > key_construction_mutex, leaving the key uninstantiated.
> > > 
> > > Fixes: 0c061b5707ab ("KEYS: Correctly destroy key payloads when their keytype is removed")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Guicai Ma <maguicai@kylinos.cn>
> > > ---
> > > v4:
> > > - Rebase onto jarkko/master.
> > > - In key_reject_and_link(), handle KEY_FLAG_DEAD under
> > >   key_construction_mutex alone without taking key->sem or changing
> > >   key->state, and document the result in the kerneldoc.
> > > 
> > > v3:
> > > - Shorten the commit message and focus on why SRCU is used.
> > > - Change Fixes tag to 0c061b5707ab.
> > > 
> > > v2:
> > > - Switch from key->sem to key_type_srcu and check KEY_FLAG_DEAD in
> > >   key_instantiate_and_link() and key_reject_and_link().
> > > 
> > >  security/keys/gc.c       |  13 ++++
> > >  security/keys/internal.h |   2 +
> > >  security/keys/key.c      | 160 ++++++++++++++++++++++++++++-----------
> > >  3 files changed, 129 insertions(+), 46 deletions(-)
> > 
> > It's unfortunate that the fix needs to be this complicated but as we've
> > looked this through, also with failed alternatives, I still think this
> > is a feasible fix.
> > 
> > And it's good to now before I even consider moving forward with my
> > keyring GC overhaul, which ties keys to their key type's LKM, and
> > removes racy key types altogether.
> > 
> > Linus, I'll give a forewarning on this fix because is not every day
> > thing to introduce SRCU in stable fixes.
> > 
> > 
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> I rebased my series on top of this and yeah, it will be erased by the
> last commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?h=keyring_gc&id=5028b0336d35f14981116926d9ee5e131ff7c7ed
> 
> That does not make the fix less important. On contrary, it is good to
> have it in place for stable kernels.

It's better not to have these changes in v7.5 yet so that there is
more window for fixes.

I.e., only rhashtable changes will land to that release and keyring_gc
with current ETA to  v7.6.

Br, Jarkko
