Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793377466;
	b=3E2mNBMuEx+HWT646AXBmWv0f6gVDttj/glZ7mn4l6hBgiRgXZ00wzBhAWCu7JXG535k
	 hTkzmybRHct4PcTaf5ZL2s/j0DSlc0Erh235FFR8iEfCFftIibDeaZwjLVrFOSjuNzVEo
	 +56dY6XFkUBj255D3uXzzIu1kOtREyLM0jiI8hOT9gR6bou5VU2lIBIYF6w9BFIVcE0Yt
	 WJSx1vigEoOyKoZ8e51JAy5z7v9u5SmCMmLqjx1DUfBMdz5j0ZX1YimiBkuBcFbp02liL
	 85trTlq1XL5aU8HSw/OqfJe/ZGFhoAA7lhvqxCR/wb53mYE4BRO0H4GjnDHY/QomARQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377466;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aAuhwlLFQt+BaDbJCnvu8zPNZu86drhVBdYAts6y/sI=;
	b=AUUhLbOdzbzKhm8eBa+iGEuJoC/0EX0yyHIwnHFxkarSPgLCwrj8X4sbD7556e88jHWu
	 zwz9hGIu2pWPCJtWmxAyinEGqkuwMsFZtbIZ5JOXfh3oPjL/+WeI061FcCQY2sE1yQAFu
	 LaQ9l07NGgIgau0fsdokghyZcdo63KE9BvaQLCRqww7UU0M7479BytCJZfUoAaYlUXia5
	 RhGkY2G++5v2YImfSCly7tczEt0/oJow4e0lPpCoQp3CWrSkxGDzGw7lRqXPY5a5Ny8sF
	 WqwJEAxWqP1ztTo12ZnflBXvAIRY6kimSsaUSs8JOQVu3198vqUo65eTBAD/6trXaww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NefYfwMx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9550606A31A;
	Fri, 30 Oct 2026 16:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NefYfwMx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380631F000C1;
	Fri, 30 Oct 2026 16:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793377465;
	bh=aAuhwlLFQt+BaDbJCnvu8zPNZu86drhVBdYAts6y/sI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NefYfwMxDPcbDVPsSWHgdSJkNt7REl9Gxmngmi4oerGPr5ga0+oiUenaUcix1zdf5
	 OPW3VmzkiUFN1KD+oxPpaYPTV9lsTTAR/kI7LPjGurFTQfMbKMBWASegcpRPg/Sr0Y
	 UNOHKw9VzuJFSKIY6mmMGF237Z2xLIr5BlYLlOAxf0YzVl2krVHnJbpMhrSfzmKf4g
	 aZ+cPQSi8Rqf2456tGonIdWDX2U715kmO4TfqY/9fHr+D6M5Dh4e9Nw5Gb3QwiwdEt
	 wtMbNr8Y+yCkf9kAgQuMqDyKg9hdg9txhyRmBC7XfqOnOQjy7XcB8fu0AlXK2XWuUF
	 q438daR8oa1zg==
Message-ID: <sashiko-outbox-191260@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] KEYS: key_garbage_collector(): process in chunks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "David Howells" <dhowells@redhat.com>
Cc: "Eric Biggers" <ebiggers@kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>, "Eric
 Snowberg" <eric.snowberg@oracle.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OktFWVMvS0VZUklOR1M=?= <keyrings@vger.kernel.org>
In-Reply-To: <20261030160924.2919363-1-jarkko@kernel.org>
References: <20261030160924.2919363-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 16:24:24 +0000
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
- [Medium] keys: missed KEY_GC_KEY_EXPIRED for keys expiring during chunked=
 GC scan
--

commit 8a5b903eb11c1b0cb7aae033aae44253bd9ca4d8
Author: Jarkko Sakkinen <jarkko@kernel.org>

KEYS: key_garbage_collector(): process in chunks

This commit updates key_garbage_collector() to scan the serial tree and
destroy unused keys in chunks of 64 to prevent workqueue lockups when
there are a large number of keys.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd-te=
st.git/tree/package/keygcbench

> diff --git a/security/keys/gc.c b/security/keys/gc.c
> index eda445f815d47..171977e56a784 100644
> --- a/security/keys/gc.c
> +++ b/security/keys/gc.c

[ ... ]

> @@ -44,6 +56,20 @@ struct key_type key_type_dead =3D {
>  	.name =3D ".dead",
>  };
> =20
> +/*
> + * Schedule a new GC pass or re-schedule an ongoing GC pass.
> + */
> +static void key_schedule_gc_work(void)
> +{
> +	/*
> +	 * Order caller updates before setting KEY_GC_REAP_REQUESTED, given that
> +	 * set_bit() is unordered.
> +	 */
> +	smp_mb__before_atomic();
> +	set_bit(KEY_GC_REAP_REQUESTED, &key_gc_flags);
> +	schedule_work(&key_gc_work.work);
> +}
> +
>  /*
>   * Schedule a garbage collection run.
>   * - time precision isn't particularly important
> @@ -57,7 +83,7 @@ void key_schedule_gc(time64_t gc_at)
> =20
>  	if (gc_at <=3D now || test_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags)) {
>  		kdebug("IMMEDIATE");
> -		schedule_work(&key_gc_work);
> +		key_schedule_gc_work();
>  	} else if (gc_at < key_gc_next_run) {
>  		kdebug("DEFERRED");
>  		key_gc_next_run =3D gc_at;

[ ... ]

> @@ -178,54 +206,64 @@ static noinline void key_gc_unused_keys(struct list=
_head *keys)
>  static void key_garbage_collector(struct work_struct *work)
>  {
>  	static LIST_HEAD(graveyard);
> -	static u8 gc_state;		/* Internal persistent state */
> +	typeof(key_gc_work) *gc =3D &key_gc_work;
>  #define KEY_GC_REAP_AGAIN	0x01	/* - Need another cycle */
>  #define KEY_GC_REAPING_LINKS	0x02	/* - We need to reap links */
> +#define KEY_GC_DESTROYING	0x04	/* - We need to destroy keys */
>  #define KEY_GC_REAPING_DEAD_1	0x10	/* - We need to mark dead keys */
>  #define KEY_GC_REAPING_DEAD_2	0x20	/* - We need to reap dead key links */
>  #define KEY_GC_REAPING_DEAD_3	0x40	/* - We need to reap dead keys */
>  #define KEY_GC_FOUND_DEAD_KEY	0x80	/* - We found at least one dead key */
> =20
> -	struct rb_node *cursor;
> +	unsigned int chunk =3D KEY_GC_CHUNK_SIZE;
>  	struct key *key;
> -	time64_t new_timer, limit, expiry;
> +	time64_t expiry;
> =20
> -	kenter("[%lx,%x]", key_gc_flags, gc_state);
> +	kenter("[%lx,%x]", key_gc_flags, gc->state);
> =20
> -	limit =3D ktime_get_real_seconds();
> +	if (gc->state & KEY_GC_DESTROYING)
> +		goto destroy_keys;
> +	if (gc->cursor) {
> +		spin_lock(&key_serial_lock);
> +		goto continue_scanning;
> +	}
> +
> +	test_and_clear_bit(KEY_GC_REAP_REQUESTED, &key_gc_flags);
> +	gc->start =3D ktime_get_real_seconds();
> =20
>  	/* Work out what we're going to be doing in this pass */
> -	gc_state &=3D KEY_GC_REAPING_DEAD_1 | KEY_GC_REAPING_DEAD_2;
> -	gc_state <<=3D 1;
> +	gc->state &=3D KEY_GC_REAPING_DEAD_1 | KEY_GC_REAPING_DEAD_2;
> +	gc->state <<=3D 1;
>  	if (test_and_clear_bit(KEY_GC_KEY_EXPIRED, &key_gc_flags))
> -		gc_state |=3D KEY_GC_REAPING_LINKS;
> +		gc->state |=3D KEY_GC_REAPING_LINKS;

[ ... ]

> @@ -239,24 +277,24 @@ static void key_garbage_collector(struct work_struc=
t *work)
>  		if (expiry !=3D TIME64_MAX) {
>  			if (!(key->type->flags & KEY_TYPE_INSTANT_REAP))
>  				expiry +=3D key_gc_delay;
> -			if (expiry > limit && expiry < new_timer) {
> +			if (expiry > gc->start && expiry < gc->end) {
>  				kdebug("will expire %x in %lld",
> -				       key_serial(key), key->expiry - limit);
> -				new_timer =3D key->expiry;
> +				       key_serial(key), key->expiry - gc->start);
> +				gc->end =3D key->expiry;
>  			}
>  		}

[ ... ]

> @@ -269,7 +307,11 @@ static void key_garbage_collector(struct work_struct=
 *work)
>  	spin_unlock(&key_serial_lock);
> =20
>  maybe_resched:
> -	if (cursor) {
> +	if (gc->cursor) {
> +		if (!chunk) {
> +			schedule_work(&key_gc_work.work);
> +			return;
> +		}
>  		cond_resched();
>  		spin_lock(&key_serial_lock);
>  		goto continue_scanning;
> @@ -281,12 +323,12 @@ static void key_garbage_collector(struct work_struc=
t *work)
>  	 */
>  	kdebug("pass complete");
> =20
> -	if (new_timer !=3D TIME64_MAX) {
> -		new_timer +=3D key_gc_delay;
> -		key_schedule_gc(new_timer);
> +	if (gc->end !=3D TIME64_MAX) {
> +		gc->end +=3D key_gc_delay;
> +		key_schedule_gc(gc->end);
>  	}

[Severity: Medium]
Can an expired key be left linked in its keyring if wall-clock time
reaches or passes gc->end while a multi-chunk scan is in flight?

At the start of a pass in key_garbage_collector(), gc->start is sampled
once via ktime_get_real_seconds() and persisted across all chunk
continuations. When scanning a key whose effective reap time (expiry) is
greater than gc->start, keyring_gc(key, gc->start) does not unlink the key
during the current pass, and its expiration is recorded in gc->end so that
key_schedule_gc(gc->end) can arm the timer once the scan completes.

Because scanning is now split into chunks of KEY_GC_CHUNK_SIZE across
multiple schedule_work(&key_gc_work.work) continuations, wall-clock time
can advance to or past gc->end before the final chunk finishes and calls
key_schedule_gc(gc->end).

When key_schedule_gc() sees gc_at <=3D now (or KEY_GC_REAP_KEYTYPE is set),
it takes the immediate branch:

    key_garbage_collector()
      key_schedule_gc(gc->end)
        key_schedule_gc_work()
          set_bit(KEY_GC_REAP_REQUESTED, &key_gc_flags);
          schedule_work(&key_gc_work.work);

Unlike the deferred branch (which arms key_gc_timer -> key_gc_timer_func()
-> key_schedule_gc_links() and sets KEY_GC_KEY_EXPIRED),
key_schedule_gc_work() only sets KEY_GC_REAP_REQUESTED without setting
KEY_GC_KEY_EXPIRED.

When the next pass starts, gc->start is updated to the new wall-clock time
(now >=3D expiry) and KEY_GC_REAPING_LINKS is not set in gc->state. In that
pass, keyring_gc() is not called because KEY_GC_REAPING_LINKS is clear, and
expiry > gc->start is now false for the expired key, so the key is neither
unlinked from its keyring nor scheduled for timer reaping until an
unrelated event sets KEY_GC_KEY_EXPIRED.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030160924.2919=
363-1-jarkko@kernel.org?part=3D1
