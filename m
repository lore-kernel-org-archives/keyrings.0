Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792816573;
	b=tMSDamVbxOVVyCzZsgpgQqr6KFD2Hd8KSp4H5gCopBBHXaRjyAzwBF0EuYdi+p8GH1ku
	 tPPyntNyI74VmGpO/TPK2eaStogHGtM9EXgc0ts7VzpVwWmgA+KsLfW0eJJqogodh4cSK
	 MYMOCTGQFA0vZ1U3/aEdbQaU5HEsQuFONsjnZf4KmCgllvtcuLt9KtoU9Sqe3u+LYU3fj
	 o5xf2Dq+YPkIatqzBTCxAuJfEcH9ZTNJ7H8JByhQrrW/5qMRX1KVz857wihOTunHRP8OC
	 PyVQ25QonfP/1yo6g4ePgV58TecBkzsKm3xhyuY39CSU/zCi8NevQ8BY7qqU2+SzhnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792816573;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+EkNcIEh8tEiAq9oL3kV4mVut8sIXU7O2KYLjszWO1Q=;
	b=d+jRAjXjKXIx/+ytdVAYzy++XRkvymOEEg9zmD8LDBflSmPGXG0C2wsBhuvfNRH2i/iO
	 fLCIq8/4LHkO+K6LxSIwh2lUxVj2FA3qjwK3QH/mBaz5ca95M1EhtoqEz+2nGzKRJ0zWZ
	 cHapkYjOlc3iaMYU7doL+y0bUvmCmCkg6gotl8C8W/55bMr1xV8kne4EJg6QYatcvIdjc
	 ueEI3NP1V949QbJYvCrr4iYzsRtt+Ek6TYrycx/Lw1nc0aVljUr7IZJAex3G/QaeU3kLl
	 Khww3fuPX+NOPosagRNVXHhrgTbtBKscsxf259Nf6kU2VPy8kS1wHEB0mOLFmhyXOBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQFymaJM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A249606A31A;
	Sat, 24 Oct 2026 04:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQFymaJM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CB681F01825;
	Sat, 24 Oct 2026 04:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792816572;
	bh=+EkNcIEh8tEiAq9oL3kV4mVut8sIXU7O2KYLjszWO1Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bQFymaJMdppuSPDfMcgZMn1ceTjHCthTgabL6kOSW4a8p0bxSbxO7NlFqxeQZghJj
	 1aCnva0A/4VoHgdrfxx1nvTEdsg/UwMv0EKDSxRHcuaBuyJrusYeD+CSnSaEcRljMl
	 iMvnAC18lqhb+6olNFe3BJCTV1jjgs+7kDhc4sYtJmbFIkQcRgI/6AVs6mQJlrm75C
	 40GracYMTIFtaFj6h3qTMSek2dSX840ipiKpU3L9Wy1dvEnXhb13ACsUh04UXyDiHm
	 SXUvHby9yo7DOCgcgmt5j1VyawYIgzo2BBsxSeYrKJIUOiP0ngQqUG2PRMip6RB29w
	 t0szA10P8rQWg==
Message-ID: <sashiko-outbox-183546@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] keys: use long workqueue for garbage collection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zateev" <hackerowskiy@gmail.com>, dhowells@redhat.com, jarkko@kernel.org, paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org, syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com, syzkaller-bugs@googlegroups.com
In-Reply-To: <20261024042944.52493-1-hackerowskiy@gmail.com>
References: <20261024042944.52493-1-hackerowskiy@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 24 Oct 2026 04:36:11 +0000
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] keys: concurrent key_garbage_collector() via schedule_work() i=
n key_put()
--

commit 49fec25be24d41f55255824b44e92e9f57128440
Author: Eduard Zateev <hackerowskiy@gmail.com>

keys: use long workqueue for garbage collection

This commit switches the key garbage collector work item (key_gc_work) in
security/keys/gc.c from system_percpu_wq to system_long_wq because key
garbage collection can block waiting for RCU grace periods.

Link: https://syzkaller.appspot.com/bug?extid=3Dc15de43f1e7fffbb7b9b

> diff --git a/security/keys/gc.c b/security/keys/gc.c
> index eda445f815d47..b174b8c511b4b 100644
> --- a/security/keys/gc.c
> +++ b/security/keys/gc.c
> @@ -19,6 +19,7 @@ unsigned key_gc_delay =3D 5 * 60;
>   * Reaper for unused keys.
>   */
>  static void key_garbage_collector(struct work_struct *work);
> +/* Key GC may wait for RCU grace periods, so queue it on system_long_wq.=
 */
>  DECLARE_WORK(key_gc_work, key_garbage_collector);
> =20
>  /*
> @@ -57,7 +58,7 @@ void key_schedule_gc(time64_t gc_at)
> =20
>  	if (gc_at <=3D now || test_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags)) {
>  		kdebug("IMMEDIATE");
> -		schedule_work(&key_gc_work);
> +		queue_work(system_long_wq, &key_gc_work);

[Severity: Critical]
Does this allow key_garbage_collector() to run concurrently with itself acr=
oss
two CPUs because key_put() still queues key_gc_work on system_percpu_wq?

While this patch updates the four schedule_work(&key_gc_work) call sites in
security/keys/gc.c to use system_long_wq, key_put() in security/keys/key.c
still calls schedule_work(&key_gc_work):

security/keys/key.c:key_put() {
	if (key) {
		key_check(key);

		if (refcount_dec_and_test(&key->usage)) {
			/* Mark key as safe for GC after key->user done. */
			clear_bit_unlock(KEY_FLAG_USER_ALIVE, &key->flags);
			schedule_work(&key_gc_work);
		}
	}
}

First, since key_put() is the path that clears KEY_FLAG_USER_ALIVE to trigg=
er
reaping of unreferenced keys and the resulting synchronize_rcu() call, norm=
al
system_percpu_wq workers will still execute key_garbage_collector() and blo=
ck
on RCU grace periods.

Second, in __queue_work(), cross-CPU non-reentrancy for a work_struct that =
is
already executing relies on matching the target workqueue against the runni=
ng
worker's workqueue:

kernel/workqueue.c:__queue_work() {
	...
	last_pool =3D get_work_pool(work);
	if (last_pool && last_pool !=3D pool) {
		worker =3D find_worker_executing_work(last_pool, work);

		if (worker && worker->current_pwq->wq =3D=3D wq) {
			pwq =3D worker->current_pwq;\
			pool =3D pwq->pool;
			WARN_ON_ONCE(pool !=3D last_pool);
		} else {
			/* meh... not running there, queue here */
			raw_spin_unlock(&last_pool->lock);
			raw_spin_lock(&pool->lock);
		}
	}
	...
}

Once process_one_work() clears WORK_STRUCT_PENDING_BIT and begins executing
key_garbage_collector() on one CPU under system_long_wq, a concurrent
key_put() -> schedule_work(&key_gc_work) on another CPU passes wq =3D=3D
system_percpu_wq (or vice versa). Because worker->current_pwq->wq =3D=3D wq=
 is
false, __queue_work() queues key_gc_work on the second CPU's pool and runs a
second instance of key_garbage_collector() in parallel while the first is
sleeping in synchronize_rcu(), cond_resched(), or down_write(&key->sem).

key_garbage_collector() assumes only a single instance can run at a time:

security/keys/gc.c:key_garbage_collector() {
	static LIST_HEAD(graveyard);
	static u8 gc_state;		/* Internal persistent state */
	...
	/* As only this function is permitted to remove things from the key
	 * serial tree, if cursor is non-NULL then it will always point to a
	 * valid node in the tree - even if lock got dropped.
	 */
	spin_lock(&key_serial_lock);
	cursor =3D rb_first(&key_serial_tree);
	...
}

Can concurrent execution of key_garbage_collector() corrupt the static
graveyard list and gc_state, free keys in key_gc_unused_keys() before the
other worker's synchronize_rcu() completes, or rb_erase() and free the key
pointed to by the other worker's cursor while key_serial_lock is dropped?

Should key_put() in security/keys/key.c also be updated to call
queue_work(system_long_wq, &key_gc_work)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261024042944.5249=
3-1-hackerowskiy@gmail.com?part=3D1
