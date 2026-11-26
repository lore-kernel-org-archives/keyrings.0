Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723511;
	b=FXo7r/ebaywUS75mkBxbQLInNIyEH0D+syfing58+bPW++z8StiVhGoRAzTWUkwcImTy
	 A8GYNuPbt1vFMIfqxxJG1qRs6A29Z50u/9DGIfAnuoN3lvia2WaxFXQgsqtO4bFFFpEnx
	 dTfoZIk/FDpGBcQ9KMoXm8AYg5T0i9Il4MJ2DZ772foKVoMgcz8NI5DclC/etn31vtnDc
	 O1J5nfdL37A/PFgUkORiRvHXvONF8y6tim31aL/prirwcWGOvFRpgcTPkrZAppk6xlmjm
	 6B12yzDSRGtWlydXDsa/hKWYFrkov3M/p+5GecbxJGswCBRGiQPXeTJfqM29g2SJBgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723511;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Oorl7fqjFLj3OpbK3nEfgLWWnP8AEK1A5CDMOr6O1VU=;
	b=4r1G39Fv7t0dF4W3KNLHIhErCzC+NBS+o7d5gsa+AyS0CXjV22prBlfkvVAoeUvEatOB
	 Qt9NXsUbJhrQhkqtHwfXwRCYkacy6inad6wYUoGDjVY+x+mZCX0Fm8qlZmMyapqIyg8ST
	 aIFUzTRsBDbedmZ3ajxdLQKB1g/ZW3LPQ+BT1lr6oFD8X+DqnPRuD53b/Ko/Uy+/9V0Pr
	 RMCAT1TIIeH1OMlQvg6ehRxOjK4Ll2x+CfWhjkQr4ohCV6En4zdbZVBDpc5gz+Fl8gvTU
	 vVX3bcvvV2noxNnd16gRf83YaTn6VKLhxevY+uO/1IlQZDXFRSOr80z7eTXsKhQXXRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XBLlqk6L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 5E874606A31C;
	Thu, 26 Nov 2026 20:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XBLlqk6L
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A4BBC1F000E0;
	Thu, 26 Nov 2026 20:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795723511;
	bh=Oorl7fqjFLj3OpbK3nEfgLWWnP8AEK1A5CDMOr6O1VU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XBLlqk6LOgL7fr2UCWFje9t7lw/AB+pS7Ow/x7eNhbU53/xOH4btot9rGLfakWSXh
	 aP5R4qF3A3o+Cr9uu9+H/KGLK25ZApxBrnB+GqWxD+RfPi6scb8i31aoz7mmsmDek/
	 Bhw7ROafh+NXttw9llrRuxfF3HV1C3jTxQRy/Htass5FOKLHhQsVqn480UMxmyipPA
	 p7gewW/isaO6ywdkbQJeydCWOpoTWjFEzce/Qi/+nrcYp6xHYBJ8qXuSU2jrgwpW0+
	 Q40vYx38DjmkA+pn3g0R6vsajJ8W2qKF6yqrWOPJgYVu5Nj1ohTJBqU83zhgNGNAdx
	 FbakBUXdKUlkw==
Date: Thu, 26 Nov 2026 22:05:07 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Zhenwen Liang <zhenwenliang@google.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: KEYS: encrypted: encrypted_rcu_free() callbacks can outlive the
 module
Message-ID: <awiQ80xiFgCZSXfb@kernel.org>
References: <awiDY0d9pRUzkV4Z@kernel.org>
 <20261126200058.2806412-1-zhenwenliang@google.com>
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
In-Reply-To: <20261126200058.2806412-1-zhenwenliang@google.com>

On Thu, Nov 26, 2026 at 08:00:58PM +0000, Zhenwen Liang wrote:
> On Thu, Nov 26, 2026 at 09:07:15PM +0200, Jarkko Sakkinen wrote:
> > This will be ultimately addressed by:
> [...]
> > As then operations will be always drained.
> >
> > It's actually somewhat tedious to address this particular issue
> > without this type of architectural change but I'm open for fixes.
> 
> Thanks. For trees that will not get the series, I think a minimal fix
> is possible here, because unregister_key_type() already guarantees that
> no new ->update() can run once it returns: key_create_or_update() holds
> key_types_sem across __key_update(), key_update() checks
> key->type->update under key->sem, and the dead-type GC pass retypes
> each remaining key to key_type_dead under key->sem before
> unregister_key_type() returns. So every encrypted_rcu_free() has been
> queued by then, and an rcu_barrier() after unregister_key_type() in
> cleanup_encrypted() waits for all of them. trusted.ko has the same
> pattern (trusted_update() uses call_rcu(), and none of the exit paths
> waits for pending callbacks), so cleanup_trusted() needs the same.
> 
> I reproduced it in QEMU with KASAN and CONFIG_RCU_LAZY=y: add an
> encrypted key, update it 20 times, and unload the module right away.
> The rcuop kthread hit int3 at encrypted_rcu_free+0x1 in the freed
> module text in 5 of 5 runs. With the barrier, 5 of 5 runs were clean.
> 
> With your series applied, the barrier is still needed as far as I can
> see: the GC calls synchronize_rcu() before the module_put() in
> key_gc_unused_keys(), and key_gc_flush() is only used by dns_resolver,
> NFS idmap, the SMB client and rxrpc. On top of the series, the barrier
> could become a key_gc_flush() call.
> 
> I will send two small patches (encrypted, trusted) with Fixes: tags and
> Cc: stable; feel free to drop the stable tag if you think it is not
> worth it.
> 
> Thanks,
> Zhenwen Liang

I saw the patches. I'll look at them with time as soon as I have
appropriate bandwidth (might next up til next week not sure).

Br, Jarkko
