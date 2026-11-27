Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785975;
	b=b3KaC5h8bjhdHbd6KNtJA94cuecqKbt0R3yOvK0eQ9DjhjT6czdpN//ckzSb5xYQ+dKw
	 UFgt7az747dKTgWW2miYtFwEx65vgK1DLmFcadazMqvtOfqPavjMAdADahq8PziJtiKqJ
	 CBhJJf/GU+Z/K+HWcI6qfIJgBbBBLN/kQLn5uCMVMvd3xLPjoGnOri+cVlb9mICXQBMAT
	 tZhnCUiz2rNtL9oPBiyYPTDYAutp5yerJHpye4DLdhvYkcVAa5CND1KTVSiVYfHXp/HvI
	 zwX2Ks6hogPuX/xhDq4AGvNBVS2QJ4JSTnwqDEBQOin/VH3+8Yod5CC0n6A0pPSM+Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785975;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+GC/+u0KPD+4/whVqI0q7ymfNcD13KUJ/8A03NmmIeQ=;
	b=vgsVi36dLa/0SBbX2qv7Nk6iyzEVe+LmnkUTsQn7mzlu3wE8HH/Ent+ebpTHpV2Z6KsZ
	 YrJB+B3AgGfIo8aXmExUxdaL2S/c3DflZvHsY5rYcbLJG9ahMpGy0sytrtF29PjMfwDPb
	 TiJCg5wVadClsau7YA3voziYkxTMHwQR4I7kgRvzOhwnRXfWp0TWZJQOFqngz9+uUaJRG
	 YPC6pFhSRWsJ3h3EWuxv7CxHEuIZmxymTFGi/CHRi+pRA2LvuZnBc7/L48uoK6KzBzHhd
	 oDuc6kvF2hNecnKxptHWoMJKoNTLNP9uKjzypjIRJgvRXttaZFE3LUGt0gxLgkXS1hQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F86eSM27;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 79E63606A31E;
	Fri, 27 Nov 2026 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F86eSM27
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 77F9A1F00893;
	Fri, 27 Nov 2026 13:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795785975;
	bh=+GC/+u0KPD+4/whVqI0q7ymfNcD13KUJ/8A03NmmIeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F86eSM27/gLh9DeCYeu9AM8s8s90gP7Oy1GWXCRF/JfDZEGmgAXZov9XdCZhHjJWb
	 LbLUs3/e6GtTW5hecoj/u8IC5glAj5Ye9c/upnwIfEN/jiNjQ2kp30SmRWKurb82zD
	 Ry12xhWxKuWeg6EPUcRDvRBbyRScOyT5Ky8SokRkqINQbH7x4IRMr6nGjn8jpNQRPM
	 Uqdq82bXneqfeENvvnR7kOweEFK8sVDhq55DvazIiD7SGFaq2cvdAkNMOKLoATb5Zw
	 X0sZqJGtrDk/JEsmBeAruczdlwiSaR1wHT9q+HZl/8svzocCvBFptqvCkzgrkgHG6O
	 NHIrjRJCIQujA==
Date: Fri, 27 Nov 2026 15:26:11 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guicai Ma <maguicai@kylinos.cn>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] KEYS: Protect key instantiation and rejection against
 type removal
Message-ID: <awmE8ykDdfSqPxgw@kernel.org>
References: <20261125032605.1327954-1-maguicai@kylinos.cn>
 <20261126023920.1981107-1-maguicai@kylinos.cn>
 <awhb3uC83WDzQup3@kernel.org>
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
In-Reply-To: <awhb3uC83WDzQup3@kernel.org>

On Thu, Nov 26, 2026 at 06:18:38PM +0200, Jarkko Sakkinen wrote:
> On Wed, Nov 25, 2026 at 09:39:20PM -0500, Guicai Ma wrote:
> > key_instantiate_and_link() and key_reject_and_link() access key->type
> > and link keys without synchronizing against unregister_key_type(). If
> > the type is removed during construction, key_instantiate_and_link() can
> > call key_type_dead.instantiate, which is NULL, and either function can
> > link a dead key into the keyring before GC pass 3 retypes it.
> > 
> > key->sem cannot be used here because it inverts lock order with
> > encrypted_instantiate() and uses a freed lockdep class after a modular
> > type unloads, while key_types_sem may be held and methods may sleep.
> > Guard both paths with key_type_srcu and a KEY_FLAG_DEAD check, waiting
> > with synchronize_srcu(&key_type_srcu) after GC pass 1; for a dead key in
> > key_reject_and_link(), just wake waiters and invalidate @authkey under
> > key_construction_mutex, leaving the key uninstantiated.
> > 
> > Fixes: 0c061b5707ab ("KEYS: Correctly destroy key payloads when their keytype is removed")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guicai Ma <maguicai@kylinos.cn>
> > ---
> > v4:
> > - Rebase onto jarkko/master.
> > - In key_reject_and_link(), handle KEY_FLAG_DEAD under
> >   key_construction_mutex alone without taking key->sem or changing
> >   key->state, and document the result in the kerneldoc.
> > 
> > v3:
> > - Shorten the commit message and focus on why SRCU is used.
> > - Change Fixes tag to 0c061b5707ab.
> > 
> > v2:
> > - Switch from key->sem to key_type_srcu and check KEY_FLAG_DEAD in
> >   key_instantiate_and_link() and key_reject_and_link().
> > 
> >  security/keys/gc.c       |  13 ++++
> >  security/keys/internal.h |   2 +
> >  security/keys/key.c      | 160 ++++++++++++++++++++++++++++-----------
> >  3 files changed, 129 insertions(+), 46 deletions(-)
> 
> It's unfortunate that the fix needs to be this complicated but as we've
> looked this through, also with failed alternatives, I still think this
> is a feasible fix.
> 
> And it's good to now before I even consider moving forward with my
> keyring GC overhaul, which ties keys to their key type's LKM, and
> removes racy key types altogether.
> 
> Linus, I'll give a forewarning on this fix because is not every day
> thing to introduce SRCU in stable fixes.
> 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I rebased my series on top of this and yeah, it will be erased by the
last commit:

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?h=keyring_gc&id=5028b0336d35f14981116926d9ee5e131ff7c7ed

That does not make the fix less important. On contrary, it is good to
have it in place for stable kernels.

Br, JArkko
