Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793392718;
	b=NmrQybLwZsugX9ZhLTCZGYa8Ygr6+JfCvfazCyiXPRzQOJUg/HDCH1dO5zwu0D9xmtg6
	 LwgkqJlGztZ49vEEFWLVI4PKB/z6wg2YtYfxBKL1BTBjmdtXBkkdCfulSprCWIzLu/bVI
	 OS9lBVhm/qy12MxmPaf6/u/nNW/hATg86YdClmLWqMRevNV/DsUri0QlFmMgd5cVk1XEX
	 53X/EDzA99wxzxuaAu2UT+d8HEoOhHD9ngcbY2wOw2QJNA42Rg0UBUIAMigfswAxlw1Hw
	 +wiSYAcs/BD3mccn/lUR0UilBGmFDYoSul+pNPqabJYZFehQzEQG8qB3ZMlmWioQwlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793392718;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GZR0h/BTjOwFw8LgvVYwSLPWD4t8y2xKJKB3R84NrM0=;
	b=zu5T1afQDcIl0irtd5EChW/2DM1uJV31YRoaWR2o0j5GTDirtwkPLvilTwiod75NMzvh
	 XtMHWrgahxpQafTHZ51afZ0SmsIBByy6z8RVCZGDg/xsdWugurii4AMUiyq0BANjjsD/i
	 Xoxg9l9gUuN33AyxC3ssCq+7cBoO9FXqvqCE+1hq1x2JbiTZ7HqmfnFtRkxKkjy/VWLvP
	 zAMSSYSEkadFCaOCF+L3jIRFbKueweJEk7aAssZU16SaA73AR4F3dfmwtez/tzvNqIJtC
	 d0t5osuzRkTQgqiW48tn4mpvcEUqJoByYhAXtjDKuQXqmoTmXpROLBZW/xa7JE1/alQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRs9ZLwE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111F8606A31A;
	Fri, 30 Oct 2026 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NRs9ZLwE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB1A1F000C1;
	Fri, 30 Oct 2026 20:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793392717;
	bh=GZR0h/BTjOwFw8LgvVYwSLPWD4t8y2xKJKB3R84NrM0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NRs9ZLwEti45Gy3d4H3gxcsFe5VGt2eI0susj9sQ/FljKxYtJTAw7aZQWKulF/sYb
	 /bNY/d9Kc3r8cyg2S2zJJD6SPUCWrgNlrDhUZRQ03Gvi88UmK3k+E3+/n6Ng/89ko5
	 fv1lyvHX3WpAYl5kP1Hw+KRC9B2bXeA3NTQIV+SDwdMyOFHUbPGPYw5KTxUK4yieLf
	 b8uNNNHuCOAF8BObYU8pPkytVMoPlOdaICPzyO31ywA5+zPT772sVS5xa9S058eAp3
	 lVtBbboiwPgJm3rnKGKWE4uCOTQsAyQn0TjuV+THudk93h9MLzKDzXaZClJ7KCztJn
	 X0ZeY7fZm1xHQ==
Message-ID: <sashiko-outbox-191485@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7] KEYS: key_garbage_collector(): process in chunks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "David Howells" <dhowells@redhat.com>
Cc: "Eric Biggers" <ebiggers@kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>, "Eric
 Snowberg" <eric.snowberg@oracle.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>,
 =?utf-8?b?b3BlbiBsaXN0OktFWVMvS0VZUklOR1M=?= <keyrings@vger.kernel.org>
In-Reply-To: <20261030202457.3058665-1-jarkko@kernel.org>
References: <20261030202457.3058665-1-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 20:38:36 +0000
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
- [Medium] KEYS: key_put() sets KEY_GC_KEY_EXPIRED via key_schedule_gc(0)
--

commit 46ff4f9d21b46f71b2432aa577bc3594d1df5791
Author: Jarkko Sakkinen <jarkko@kernel.org>

KEYS: key_garbage_collector(): process in chunks

This commit updates key_garbage_collector() and key_gc_unused_keys() to scan
the key serial tree and destroy unused keys in bounded chunks of 64 keys. It
also introduces key_schedule_gc_work() and KEY_GC_REAP_REQUESTED to preserve
garbage collection requests across chunked workqueue continuations.

Link: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd-te=
st.git/tree/package/keygcbench

> diff --git a/security/keys/gc.c b/security/keys/gc.c
> index eda445f815d47..ea2efde5f33fd 100644
> --- a/security/keys/gc.c
> +++ b/security/keys/gc.c

[ ... ]

> @@ -44,6 +56,21 @@ struct key_type key_type_dead =3D {
>  	.name =3D ".dead",
>  };
> =20
> +/*
> + * Schedule a new GC pass or re-schedule an ongoing GC pass.
> + */
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
> +
>  /*
>   * Schedule a garbage collection run.
>   * - time precision isn't particularly important
> @@ -57,7 +84,8 @@ void key_schedule_gc(time64_t gc_at)
> =20
>  	if (gc_at <=3D now || test_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags)) {
>  		kdebug("IMMEDIATE");
> -		schedule_work(&key_gc_work);
> +		/* Catch expirations that became due during the scan. */
> +		key_schedule_gc_work(true);
>  	} else if (gc_at < key_gc_next_run) {

[ ... ]

> diff --git a/security/keys/key.c b/security/keys/key.c
> index a438c4508595d..ab3d3a70705af 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -661,7 +661,7 @@ void key_put(struct key *key)
>  			}
>  			/* Mark key as safe for GC after key->user done. */
>  			clear_bit_unlock(KEY_FLAG_USER_ALIVE, &key->flags);
> -			schedule_work(&key_gc_work);
> +			key_schedule_gc(0);
>  		}
>  	}
>  }

[Severity: Medium]
When key_put() drops the final reference on a key
(refcount_dec_and_test(&key->usage)), calling key_schedule_gc(0) causes
gc_at <=3D now to evaluate as true and calls key_schedule_gc_work(true), wh=
ich
sets KEY_GC_KEY_EXPIRED in key_gc_flags:

key_put()
  key_schedule_gc(0)
    key_schedule_gc_work(true)
      set_mask_bits(&key_gc_flags, 0,
                    BIT(KEY_GC_REAP_REQUESTED) | BIT(KEY_GC_KEY_EXPIRED))

In key_garbage_collector(), KEY_GC_KEY_EXPIRED sets KEY_GC_REAPING_LINKS in
gc->state:

	if (test_and_clear_bit(KEY_GC_KEY_EXPIRED, &key_gc_flags))
		gc->state |=3D KEY_GC_REAPING_LINKS;
	...
		if ((gc->state & KEY_GC_REAPING_LINKS) ||
		    unlikely(gc->state & KEY_GC_REAPING_DEAD_2)) {
			if (key->type =3D=3D &key_type_keyring)
				goto found_keyring;
		}

Because every keyring link holds a reference on key->usage, a key reaching a
usage count of zero has no remaining links in any keyring and only needs to=
 be
removed from key_serial_tree and freed via the graveyard list. With
KEY_GC_KEY_EXPIRED set on every final key_put(), key_garbage_collector() wi=
ll
instead drop key_serial_lock on every keyring in key_serial_tree and run
keyring_gc() across all keyrings in the system whenever any unreferenced key
is freed. In addition, if key_gc_unused_keys() frees a keyring that held li=
nks
to other keys, keyring_destroy() will call key_put() and set
KEY_GC_KEY_EXPIRED again for the next pass.

Similarly, in key_schedule_gc(), if gc_at > now while KEY_GC_REAP_KEYTYPE is
set, key_schedule_gc_work(true) will set KEY_GC_KEY_EXPIRED even though the
expiration time has not been reached.

Should key_put() call key_schedule_gc_work(false) directly instead of
key_schedule_gc(0), and should key_schedule_gc() pass gc_at <=3D now to
key_schedule_gc_work()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030202457.3058=
665-1-jarkko@kernel.org?part=3D1
