Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792819255;
	b=RrZ3uBpdXZxD7AmZteQg79rv1n6T6mOzb/fqX4QVFB8CHGLkyRaaYFdEB/OmSwIH7FhH
	 rvmHL0WN6VR3IPbFCm1OuFkX5xasoEvofD+P2KSwMlA2anYGFjiSbl+62pqiSXUhuFap1
	 Mq4UDN8DUSk0+sEpF+udO1FGYCuAP3iS3gd14y3Wg9G9tFkbpqBR4jaGwvvLoBRoOAuLU
	 UKXwNVcnjFAI8TMOGz8eqcQQEQZl4PHE0Sjy3slOQDdKlDesm9g11q56iQ+KoeUV2Ydme
	 ATyAGmduJ/LM74jDOCTlxOaZJR3CfajDFpiW5KpA/CE7W8Sv2rqFeSV30c6Q1L6z5Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792819255;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xYHh2t4gmp4t/9L9LEjBajU/Uf/iAUb9KqQnGwg7gN4=;
	b=zhrjrsR/vdGG4CUAtzM9ACJDeaUGwTaLclXOgNYZB83ulnj4ZXepQ/X+eZheCDrq8t0L
	 Oyv3u1jUTcvnpmPNHdxMUd4xpgmKMssUa29xMbJ3NARoeWHsylfslz6Vb2uDIhhfHOhMO
	 ruk7wapJAElRDjBUzpZAcldN/nOnGc9Y+o5F3nZSUQTEZrQKSzkiutFJckWrLrZn3zc4s
	 WFuvAyLzo9O22lFfvq4JbSb0SRq3dAhv0+z01o+mz7uPfiaomaRRxiv4v5friY8VDhHfw
	 yWJu8TobAY6BjOm6aNMglm/Flh5HPNRKYwVEwfLpLLvkajl4FQRUJx4rt/ft+zwtNfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I94jBxwW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id EB595606A31A;
	Sat, 24 Oct 2026 05:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I94jBxwW
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 417001F01825;
	Sat, 24 Oct 2026 05:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792819254;
	bh=xYHh2t4gmp4t/9L9LEjBajU/Uf/iAUb9KqQnGwg7gN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I94jBxwWaulFurt//1CDuYBXQGofSkrns9upf5ezh7ntuhY4GUZKtwyndfTSJXbCT
	 QC49t6deoWqAYzRR7ilWZqKQsOmbRvIPc13yyEKDOE9I/4zZrIroAq6cNaPkXvKqYO
	 Ft/YlTQ5WWjzltKiudnPhUN3CCYVEFII6P+u+1sTG8nDTdkboF2rm4k1ICOIONGKk1
	 B0KdWFoXLgVywy9wGYJxjIPUyG+zMknRxHluYYiX31EbFxuX7geONEUL0tMNRUw8+5
	 3TSqDHidMlnlx5UFzUwGIlSSSm9sQqlWrEa19aDy71DnhqlVYkA5wgBiVMKSAxsE3X
	 K8mOgkksYbw5A==
Date: Sat, 24 Oct 2026 08:20:51 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eduard Zateev <hackerowskiy@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] keys: use long workqueue for garbage collection
Message-ID: <atxAM9JW6oi2MEeT@kernel.org>
References: <20261024042944.52493-1-hackerowskiy@gmail.com>
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
In-Reply-To: <20261024042944.52493-1-hackerowskiy@gmail.com>

On Sat, Oct 24, 2026 at 06:29:44AM +0200, Eduard Zateev wrote:
> The key garbage collector can wait for RCU grace periods. This can occupy a
> normal events worker for a long time and contribute to workqueue lockups.
> 
> Queue key GC on system_long_wq because its work may wait for long periods.
> 
> Reported-by: syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com
> Link: https://syzkaller.appspot.com/bug?extid=c15de43f1e7fffbb7b9b
> Signed-off-by: Eduard Zateev <hackerowskiy@gmail.com>

This commit message is not huge selling point for any possible argument.

> ---
>  security/keys/gc.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/security/keys/gc.c b/security/keys/gc.c
> index eda445f815d..b174b8c511b 100644
> --- a/security/keys/gc.c
> +++ b/security/keys/gc.c
> @@ -19,6 +19,7 @@ unsigned key_gc_delay = 5 * 60;
>   * Reaper for unused keys.
>   */
>  static void key_garbage_collector(struct work_struct *work);
> +/* Key GC may wait for RCU grace periods, so queue it on system_long_wq. */
>  DECLARE_WORK(key_gc_work, key_garbage_collector);
>  
>  /*
> @@ -57,7 +58,7 @@ void key_schedule_gc(time64_t gc_at)
>  
>  	if (gc_at <= now || test_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags)) {
>  		kdebug("IMMEDIATE");
> -		schedule_work(&key_gc_work);
> +		queue_work(system_long_wq, &key_gc_work);
>  	} else if (gc_at < key_gc_next_run) {
>  		kdebug("DEFERRED");
>  		key_gc_next_run = gc_at;
> @@ -85,7 +86,7 @@ void key_set_expiry(struct key *key, time64_t expiry)
>  void key_schedule_gc_links(void)
>  {
>  	set_bit(KEY_GC_KEY_EXPIRED, &key_gc_flags);
> -	schedule_work(&key_gc_work);
> +	queue_work(system_long_wq, &key_gc_work);
>  }
>  
>  /*
> @@ -119,7 +120,7 @@ void key_gc_keytype(struct key_type *ktype)
>  	set_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags);
>  
>  	kdebug("schedule");
> -	schedule_work(&key_gc_work);
> +	queue_work(system_long_wq, &key_gc_work);
>  
>  	kdebug("sleep");
>  	wait_on_bit(&key_gc_flags, KEY_GC_REAPING_KEYTYPE,
> @@ -322,7 +323,7 @@ static void key_garbage_collector(struct work_struct *work)
>  	}
>  
>  	if (gc_state & KEY_GC_REAP_AGAIN)
> -		schedule_work(&key_gc_work);
> +		queue_work(system_long_wq, &key_gc_work);
>  	kleave(" [end %x]", gc_state);
>  	return;
>  
> -- 
> 2.55.0
> 

Br, Jarkko
