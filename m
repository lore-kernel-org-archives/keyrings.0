Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4334CF496;
	Sun, 18 Oct 2026 02:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792290121; cv=none; b=sXF/aGo94giDbLO11opZBl+KSTkQl0AYGQtfWw3L2MqDijlbGj7GttP6MHxB2UqduhQZWGiT7T/oCeEtFL/8HAVH7sJwuGumaEHe2sv9tyNYqYr8O/5Y6OI/80foY+fQkW0djfIT7w6jrJEFmPGzZerH6rcUZ9UZWXKwZw0YwwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792290121; c=relaxed/simple;
	bh=YigvOe6r5fb0SoNXwtOtI+Uf5J7Z4N3KYja54tlt0W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeK3FYeo22gD8PDeSGkDESSyCNOF23caxBJu0PIzKPwE/PelfKLkZdw5owlYFe3xf5H5Alvnuqha4zCrvBiJGXc1xCi5XT58sssMSFlz7/WvEPC/ATqd/RoqprIG+K/buJdwpc4+TW9LetXzCYcCB3nMru574BlrTFctjBuzz5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaSYBebu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaSYBebu"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5D2311F000C4;
	Sun, 18 Oct 2026 02:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792290119;
	bh=xy2v8N4lc3FWiPThm0d4wC/5Rf0Ef0WoaiQ/i8Bm5KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EaSYBebuHUV0eLF4gszmrNEWD8UmJElmdte1hKKIj0puvOVCRcrTpNqyYRQ+dElxl
	 ot59n9D+sFqp6TTXK1I4l53i0MQmoKAgZldOsrA/o1/ZhBPA1CbQ+FiWTTC/ldBzEc
	 xYsJCv09cdKpl6f2nQQpdf/etA6gJ1O9BNj4wmj3gHi2qoLZ8st1C4Z0tFcYpmfmVY
	 Eypvzb7Z31GNYXZrLsZI2A0owOmvN8BhN2PdbtO661JVFNenkeYlUk4wjR+rUdHB8m
	 J6DkZ4ByGhEOWbtqoaxD1jsOMhL7X17nUBzlRkGNqFcGrPjbP6swANF+YuAjTfaQOS
	 qwBdSuhj1zc/Q==
Date: Sun, 18 Oct 2026 05:21:56 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	ebiggers@kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH] keys: Avoid owner account dereferences in /proc/keys
Message-ID: <atQtRK3wy6g8YdIV@kernel.org>
References: <pm-keys-proc-owner-uid-followup-20261017-v2-8f8f34a41eb1bbb94ef0@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pm-keys-proc-owner-uid-followup-20261017-v2-8f8f34a41eb1bbb94ef0@gmail.com>

On Sat, Oct 17, 2026 at 04:16:22PM +0800, Cen Zhang wrote:
> The namespace filters in find_ge_key() and key_serial_next() read
> key->user->uid while traversing the serial tree under key_serial_lock.
> That lock keeps the key allocated, but it does not protect the separate
> key_user from ownership changes.
> 
> A /proc/keys read reaches find_ge_key() through proc_keys_start(), and
> key_serial_next() through proc_keys_next(). The lock stays held until
> proc_keys_stop().
> 
> A successful privileged KEYCTL_CHOWN on the same key replaces key->user
> under key->sem and drops the old owner's reference after releasing the
> semaphore. If that was the old dynamic key_user's last reference, a
> /proc/keys reader can access freed memory:
> 
>     /proc/keys reader                   KEYCTL_CHOWN
>     proc_keys_start()                    keyctl_chown_key()
>       spin_lock(key_serial_lock)          down_write(key->sem)
>       find_ge_key()
>         old = minkey->user
>                                           zapowner = key->user
>                                           key->user = newowner
>                                           key->uid = uid
>                                           up_write(key->sem)
>                                           key_put(key)
>                                           key_user_put(zapowner)
>                                             kfree(zapowner)
>         read old->uid -> use-after-free
>     proc_keys_stop()
>       spin_unlock(key_serial_lock)
> 
> Use the inline key->uid in both filters, following the approach already
> used by find_keyring_by_name(). The serial-tree lock keeps the containing
> key alive, so filtering no longer depends on the quota owner's lifetime.
> This also uses the same owner UID as proc_keys_show() and the permission
> check.
> 
> For thread keyrings, key_fsuid_changed() can update key->uid without
> changing the quota owner. The filters now follow that current owner UID,
> including when its namespace mapping differs from the quota owner's.
> 
> Fixes: 454804ab0302 ("keys: make procfiles per-user-namespace")
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

These tags could be ordered correctly.

> 
> ---
>  security/keys/proc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/proc.c b/security/keys/proc.c
> index 4f4e2c1824f1..aea06a74d0fe 100644
> --- a/security/keys/proc.c
> +++ b/security/keys/proc.c
> @@ -68,7 +68,7 @@ static struct rb_node *key_serial_next(struct seq_file *p, struct rb_node *n)
>  	n = rb_next(n);
>  	while (n) {
>  		struct key *key = rb_entry(n, struct key, serial_node);
> -		if (kuid_has_mapping(user_ns, key->user->uid))
> +		if (kuid_has_mapping(user_ns, key->uid))
>  			break;
>  		n = rb_next(n);
>  	}
> @@ -100,7 +100,7 @@ static struct key *find_ge_key(struct seq_file *p, key_serial_t id)
>  		return NULL;
>  
>  	for (;;) {
> -		if (kuid_has_mapping(user_ns, minkey->user->uid))
> +		if (kuid_has_mapping(user_ns, minkey->uid))
>  			return minkey;
>  		n = rb_next(&minkey->serial_node);
>  		if (!n)
> 
> base-commit: a626e44fd64c456d373ae8c28b939197b9446a02

I don't want to circulate this further.


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
