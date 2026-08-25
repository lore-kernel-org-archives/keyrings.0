Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070C0472536;
	Tue, 25 Aug 2026 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666884; cv=none; b=rkh1hours6/KC8Ht1ONAmydso7lr+hdPR6gZexFhJGOne4DvGjQjaYkR+YLXTNbwZ8z1ROZgF2nxrq8wMLWRwfUW5R/F5NT/U7vz32W8KU5TYtnhxra7ovbDTHIWsrRzC1nCTGLyQvT46pHqrgCbou+pGu3GA6ancHST0BRqFg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666884; c=relaxed/simple;
	bh=zr/2C23VYBg5LbqW/G/01rHh0mXnCBWp6k0PGS1h7+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orDHAFmBUtleXHYhuczjQPdd61kwI36NjXJBU6cB5bXlYgBjMPe7FWuEtjG6H5qE8SbfI6ow4LzGmBobipehWqVavQ68jLvpFB5IO2W4ZIdYpqgVCq21mNXQnxP2Fz7GrLh9Mqz1YaB8bXhFav9nFqx6zsW2tXYJ6jALQiF8uCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q/LZny4O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q/LZny4O"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2C2E81F000E9;
	Tue, 25 Aug 2026 14:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787666882;
	bh=nCk4v5O3nDcRRnnmp6QTELNqk3gp2nLuclpCFNq7UUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q/LZny4OTFoeuWOk3l4kVakPHd8hLUctFNBXG30vhwROASo+XqGLMK6kHMr2UqRKC
	 DtubvvSpPoCw1+51kWNtz5aPvDO0K7x/jxD6fOIrMNKKPYrB5X0LH4Q8k0vnkIynne
	 C6GnC4r33fvtph53TlvRh4oB9pKD4WCn2dA57Xw+cRdEv+uxp2fvWvqoW7Mtt09+M3
	 EH96qK4n/xXZ90atfUhFIJGYyGkJ5PzoHCgo7wtYp5LP6PIgMpN2MxCHcuaBKT3Cnk
	 Ca3F5qzDpwFFWNgpAuGly4tbAe6Wo6qfN1IaLUFTfNTD5p2q8wkjg5VH8FmLsBs9b3
	 ppPq6aOqwzyfQ==
Date: Tue, 25 Aug 2026 17:07:59 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] keys: fix lost wakeup when reaping a dead key type
Message-ID: <ao2hv-9TVbMe2bbm@kernel.org>
References: <20260821025327.61488-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821025327.61488-1-kmehltretter@gmail.com>

On Fri, Aug 21, 2026 at 04:53:27AM +0200, Karl Mehltretter wrote:
> clear_bit() is atomic with respect to the word it modifies, but it is
> an unordered operation: it implies no memory barrier on either side
> (Documentation/atomic_bitops.txt).
> 
> key_garbage_collector() clears KEY_GC_REAPING_KEYTYPE with clear_bit()
> and calls wake_up_bit() after reaping a dead key type. wake_up_bit()
> uses a lockless waitqueue check and requires a full barrier after the
> clear.
> 
> The existing smp_mb() is before clear_bit(), so nothing orders the clear
> against that check. The GC can see an empty waitqueue while
> unregister_key_type() still sees the bit set. The final wakeup is then
> lost, leaving module unload stuck in wait_on_bit().
> 
> Use clear_and_wake_up_bit(). Its clear_bit_unlock() has RELEASE
> semantics, so the completed GC work stays ordered before the clear, and
> its smp_mb__after_atomic() orders the clear before the waitqueue check.
> 
> Fixes: 0c061b5707ab ("KEYS: Correctly destroy key payloads when their keytype is removed")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> v2: open with the ordering semantics of clear_bit(), as suggested by
>     Jarkko. No code change.
> v1: https://lore.kernel.org/r/20260811173753.67616-1-kmehltretter@gmail.com/
> 
> LKMM (herdtools7 7.58). LKMM has no clear_bit*() primitives, so these
> tests abstract the bit clear as a store while preserving the ordering
> relevant to this race. The fixed test models clear_bit_unlock() with
> smp_store_release() and smp_mb__after_atomic() with smp_mb().
> 
>   C keys-gc-buggy
>   { flag=1; }
>   P0(int *flag, int *wq)
>   {
>   	int r0;
>   	smp_mb();
>   	WRITE_ONCE(*flag, 0);
>   	r0 = READ_ONCE(*wq);
>   }
>   P1(int *flag, int *wq)
>   {
>   	int r1;
>   	WRITE_ONCE(*wq, 1);
>   	smp_mb();
>   	r1 = READ_ONCE(*flag);
>   }
>   exists (0:r0=0 /\ 1:r1=1)
> 
>   C keys-gc-fixed
>   { flag=1; }
>   P0(int *flag, int *wq)
>   {
>   	int r0;
>   	smp_store_release(flag, 0);
>   	smp_mb();
>   	r0 = READ_ONCE(*wq);
>   }
>   P1(int *flag, int *wq)
>   {
>   	int r1;
>   	WRITE_ONCE(*wq, 1);
>   	smp_mb();
>   	r1 = READ_ONCE(*flag);
>   }
>   exists (0:r0=0 /\ 1:r1=1)
> 
>   herd7 -conf linux-kernel.cfg keys-gc-buggy.litmus
>   herd7 -conf linux-kernel.cfg keys-gc-fixed.litmus
> 
>   pre-fix: Sometimes
>   fixed:   Never
> 
>  security/keys/gc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/security/keys/gc.c b/security/keys/gc.c
> index 748e83818a760..eda445f815d47 100644
> --- a/security/keys/gc.c
> +++ b/security/keys/gc.c
> @@ -318,9 +318,7 @@ static void key_garbage_collector(struct work_struct *work)
> 
>  	if (unlikely(gc_state & KEY_GC_REAPING_DEAD_3)) {
>  		kdebug("dead wake");
> -		smp_mb();
> -		clear_bit(KEY_GC_REAPING_KEYTYPE, &key_gc_flags);
> -		wake_up_bit(&key_gc_flags, KEY_GC_REAPING_KEYTYPE);
> +		clear_and_wake_up_bit(KEY_GC_REAPING_KEYTYPE, &key_gc_flags);
>  	}
> 
>  	if (gc_state & KEY_GC_REAP_AGAIN)
> --
> 2.53.0

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I send this to -rc2 as I already sent keys PR and I have quite heavy
TPM PR to prepare.

BR, Jarkko
