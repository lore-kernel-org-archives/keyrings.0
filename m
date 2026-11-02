Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622779;
	b=Lymj/TNZnoCaa0LcFC8imKiYoAgLqMvANZUsTpOXump6tT0z5J4VX0Xz5qWKtRkSJIHX
	 tBfjrFMtw1WGA1PxMU95IeaIVVrAmWsSmAM+Tsl3OxXVSnR8zqMrJEWPnuWpv83rg6gZ/
	 9LSPjs0FDwXDNkPrvhCHrnr8uQREDu1uM7/9EOpPalDJh8obpmfEhsR88OBn0gXyxWwka
	 hoQiAQwU8jB9r7184pmCwIt0xDNrRhNvJeTZkGsnW4Jzd+rVbLuqapPY98eNn2nAwyNHW
	 miyHFsgnsuveZzlcYUWWCeR4E3zGlIX8mh9x8zwaBj2kwh4fzBP9XQkKeb1dMPTAKLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622779;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5cK176MvYbDRYoWTIM0ndVdF1rozXQ8JRU80zMKEZ+c=;
	b=H1pAB6OuJBgSnMWBdO0HfDirdxEklYbPANQThbnAfL6HO6iJCSzuDkAZuf7pOVNHTZaG
	 T6194mqgqw54oV/Ag1zjqfbpLYYTD8MrFwf57/XV95iywdMmt1KG+hCIVs2q0FoLxV3n3
	 yf2bP7D3m+LL4WgOMz7QpAQffNleReYNv5U0nCKf4seYgjca04zYg6jVglceLcSYihvz8
	 WwMKLZ/Q9/LPU8GQZSnPavZKoG+ctBipsF7eGmmrRw0veQMpkX0DqHwnlV0xI3NykLLka
	 J+8BV8b0M1zYET5f69VqWnMfXddesXq5/ddR0vfAirYVPKCZ0OT/m+xicyt1jvwB1yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jNCN7vhl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2B606A32F;
	Mon,  2 Nov 2026 12:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jNCN7vhl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F5F1F00A17;
	Mon,  2 Nov 2026 12:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622778;
	bh=5cK176MvYbDRYoWTIM0ndVdF1rozXQ8JRU80zMKEZ+c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jNCN7vhlG6flwRSh+y7+3Ry4Ey5en6SFHsj0yNbk71GxaJLfqA4xbn8TNKur66Kfm
	 Q6WnqeMzS+EzMw+GdKG6Oe7Vf2YflfFsTh/R6z1ANRDAe2ZoY7zj6/8cRQgJBZ4npV
	 g7TUGJe6GDXteanXTGSsrHBWxJ3N+AD8XPFmIKDAnckwSaa84QJ3pJA1CPey92yOi9
	 uVHoXNI86OSYclt0o+nEaOXO+Iwttj1gGpydpuK4sLzrHi4lsWePUd+j6mQVk4DN4Q
	 YvzgWPVK0bhkf2Va0isj5DC8/twLfmjpaN5HyXabLeqcZtfsDX27uG0i4FgjL5R8XS
	 LxDh3eXAwkFAw==
Message-ID: <sashiko-outbox-193421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 4/4] KEYS: key_garbage_collector(): process in
 chunks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "David Howells" <dhowells@redhat.com>
Cc: "Eric Biggers" <ebiggers@kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>, "Eric
 Snowberg" <eric.snowberg@oracle.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OktFWVMvS0VZUklOR1M=?= <keyrings@vger.kernel.org>
In-Reply-To: <20261102121518.1197453-5-jarkko@kernel.org>
References: <20261102121518.1197453-1-jarkko@kernel.org>
 <20261102121518.1197453-5-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 12:32:57 +0000
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
- [Medium] keys: non-atomic flag clearing in key_garbage_collector() drops =
link reaping
--

commit 9857f1d86bdced127ae471468f5b25b61aa04d0f
Author: Jarkko Sakkinen <jarkko@kernel.org>

KEYS: key_garbage_collector(): process in chunks

This commit updates key_garbage_collector() to scan the serial tree and
destroy unused keys in chunks of 64 items, tracking in-flight state across
workqueue continuations to prevent workqueue lockups.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd-te=
st.git/tree/package/keygcbench

> diff --git a/security/keys/gc.c b/security/keys/gc.c
> index 876c30c019ad4..fc1e5e39b828c 100644
> --- a/security/keys/gc.c
> +++ b/security/keys/gc.c

[ ... ]

> @@ -31,6 +42,23 @@ static DEFINE_TIMER(key_gc_timer, key_gc_timer_func);
>  static time64_t key_gc_next_run =3D TIME64_MAX;
>  static unsigned long key_gc_flags;
>  #define KEY_GC_KEY_EXPIRED	0	/* A key expired and needs unlinking */
> +#define KEY_GC_REAP_REQUESTED	1	/* Another complete pass was requested */
> +
> +/*
> + * Schedule a new GC pass or re-schedule an ongoing GC pass.
> +*/
> +void key_schedule_gc_work(bool expired)
> +{
> +	unsigned long flags =3D BIT(KEY_GC_REAP_REQUESTED);
> +
> +	if (expired)
> +		flags |=3D BIT(KEY_GC_KEY_EXPIRED);
> +
> +	/* Publish all request flags together, after the caller's updates. */
> +	set_mask_bits(&key_gc_flags, 0, flags);
> +	schedule_work(&key_gc_work.work);
> +}

[ ... ]

> @@ -137,35 +159,45 @@ static noinline void key_gc_unused_keys(struct list=
_head *keys)
>  static void key_garbage_collector(struct work_struct *work)
>  {
>  	static LIST_HEAD(graveyard);
> -	u8 gc_state =3D 0;
> +	typeof(key_gc_work) *gc =3D &key_gc_work;
>  #define KEY_GC_REAP_AGAIN	0x01	/* - Need another cycle */
>  #define KEY_GC_REAPING_LINKS	0x02	/* - We need to reap links */
> +#define KEY_GC_DESTROYING	0x04	/* - We need to destroy keys */
> =20
> -	struct rb_node *cursor;
> +	unsigned int chunk =3D KEY_GC_CHUNK_SIZE;
>  	struct key *key;
> -	time64_t new_timer, limit, expiry;
> +	time64_t expiry;
> =20
> -	kenter("[%lx]", key_gc_flags);
> +	kenter("[%lx,%x]", key_gc_flags, gc->state);
> =20
> -	limit =3D ktime_get_real_seconds();
> +	if (gc->state & KEY_GC_DESTROYING)
> +		goto destroy_keys;
> +	if (gc->cursor) {
> +		spin_lock(&key_serial_lock);
> +		goto continue_scanning;
> +	}
> =20
> +	test_and_clear_bit(KEY_GC_REAP_REQUESTED, &key_gc_flags);
> +	gc->start =3D ktime_get_real_seconds();
> +	gc->state =3D 0;
>  	if (test_and_clear_bit(KEY_GC_KEY_EXPIRED, &key_gc_flags))
> -		gc_state |=3D KEY_GC_REAPING_LINKS;
> -	kdebug("new pass %x", gc_state);
> +		gc->state |=3D KEY_GC_REAPING_LINKS;

[Severity: Medium]
Can clearing KEY_GC_REAP_REQUESTED and KEY_GC_KEY_EXPIRED in two separate
operations on opposite sides of ktime_get_real_seconds() cause a link-reapi=
ng
request to be dropped?

In key_schedule_gc_work(true), called from key_gc_timer_func(),
key_schedule_gc(), key_invalidate(), and key_remove_domain(), both
KEY_GC_REAP_REQUESTED and KEY_GC_KEY_EXPIRED are published together via
set_mask_bits().

However, if another CPU calls key_schedule_gc_work(true) after
key_garbage_collector() executes:

    test_and_clear_bit(KEY_GC_REAP_REQUESTED, &key_gc_flags);
    gc->start =3D ktime_get_real_seconds();

(for example, right after the clock ticks to a new second, or after a new k=
ey
is invalidated or a domain is removed) and before:

    if (test_and_clear_bit(KEY_GC_KEY_EXPIRED, &key_gc_flags))

then the current pass consumes KEY_GC_KEY_EXPIRED while leaving
KEY_GC_REAP_REQUESTED set.

The current pass will run keyring_gc(key, gc->start) with the older gc->sta=
rt
timestamp (or after already having scanned past a keyring if this were not
the start of the pass, or before the new expiry second is reached in
key_is_dead()), and when the follow-up pass triggered by
KEY_GC_REAP_REQUESTED runs, KEY_GC_KEY_EXPIRED is already clear so
KEY_GC_REAPING_LINKS will not be set.

Should key_gc_flags be consumed atomically with xchg(&key_gc_flags, 0) befo=
re
sampling gc->start =3D ktime_get_real_seconds()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102121518.1197=
453-1-jarkko@kernel.org?part=3D4
