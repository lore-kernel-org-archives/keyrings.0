Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793761383;
	b=FoDfnrXhKJJE36gOH7xEQcYqM2q7HCu3bBsv/IkMKirpD4pqxk/AfNx153JEuX0F4Ws4
	 5E5tg0Me5P0x0W2Svzd/cxdnoV9/kWt1mChSTjXddx5+H8Xp9hTYUZUk8FyR5UMrmqOp0
	 iJ5QkNZFS0SD9OfIgrEVrum9MVHsoY/CHrmvxHuugyV3WLABqSaKg0I7GCyB8zzW7BS+n
	 MoH+GBlwDU0s/RhV3uHDXeeH1lfv6DIR5a5VZunZ23sfPtEAwLyGJ4iquqkCkx5UUa8DE
	 nqiGKtGXm6acXp/SNlicF6MLSjCSMvrxBggM7p5YGtR+0jsbec3ZBoCcJ/1F58GYXlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793761383;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=wzYU+r3uXDCSd9JLoGVlj0wSnW9MxzPziNGy8n9n1BQ=;
	b=IupXmJjsLBoQYYfDBwF7zYNR5Lve4lGjdGtnN0yZlBZKHHyaRV4vZl9oWR2Kp/rAD2Sv
	 EpKJyXdspopu0wWZG8/4MgqlOQClx+w0zgQ47TWgwNCz8ueyC6F1C/UxQjwkwVuM3OrvR
	 dvP7fIBUja4Hu44Su8DIndyiqnFNVazvrX04TKoYwPn1jju8BDy+Impw6PQWScC4a9WFD
	 9O9U0F51SJ3ooi3nBbKuIYGuRvo70eJso0nffe5mNT2jjrjcdq6yBq7uRNMuRBvVVN+LM
	 c1DhQ8pfDwKhlh7wfX1WMHbHrCLL/zH1S0cHT+8PwUmC96YXI+MBFseDxgQUObNu/zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPCMRMb9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11347606A31B;
	Wed,  4 Nov 2026 03:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPCMRMb9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5856B1F000C1;
	Wed,  4 Nov 2026 03:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793761382;
	bh=wzYU+r3uXDCSd9JLoGVlj0wSnW9MxzPziNGy8n9n1BQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HPCMRMb94lkZhlGSSEtXKpBe6iujZuU5Zmp3Rwm3Wj5K1EWMK4JSFTs4tXJdngkgL
	 QYP1vAd+IHROie1Dx+GqDhWxSuaG8B2KwnqgC0hR4C9Nxmp++VwtRRRHo1+euB7oiv
	 uJtotO1cpNZVsFqrzHweCoQTjAYNAKhLHShFRdtBz/29LJ5V6cYsTp/neqxEimYoeH
	 CNq4kC9XGZpTTPMh1d4fwqa6TB3gDeje2uzrE/kg5wyJU9jE9RTusEJR1r5xuwHtIv
	 pS9rE9THX3HNdRmW2zq9yI3if4RFm+LQ1p0jIbWRHRmHPvJP8DUv7kN3+kvoTTeYU3
	 RkImXJs+U36dA==
Message-ID: <sashiko-outbox-196565@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v2 01/11] KEYS: Add key_gc_flush() for draining RCU
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "David Howells" <dhowells@redhat.com>
Cc: "Eric Biggers" <ebiggers@kernel.org>, "Mimi Zohar" <zohar@linux.ibm.com>, keyrings@vger.kernel.org, "Roberto
 Sassu" <roberto.sassu@huawei.com>, "Dmitry Kasatkin" <dmitry.kasatkin@gmail.com>, "Eric
 Snowberg" <eric.snowberg@oracle.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 =?utf-8?b?b3BlbiBsaXN0OlNFQ1VSSVRZIFNVQlNZU1RFTQ==?= <linux-security-module@vger.kernel.org>
In-Reply-To: <20261103030226.2685251-2-jarkko@kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-2-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 03:03:01 +0000
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
- [Medium] KEYS: premature return in key_gc_flush() when key_gc_work queues=
 RCU
--

commit e02fb1ccece5874817985c8b64ba41bf90bc5796
Author: Jarkko Sakkinen <jarkko@kernel.org>

KEYS: Add key_gc_flush() for draining RCU callbacks

This commit introduces key_gc_flush() to drain RCU callbacks and flush
key_gc_work until no further garbage collection passes remain queued. This
provides callers clearing an internal key cache before module unload with a
synchronous barrier for key destruction.

> diff --git a/security/keys/gc.c b/security/keys/gc.c
> index eda445f815d47..3cfbf00085b3d 100644
> --- a/security/keys/gc.c
> +++ b/security/keys/gc.c
> @@ -21,6 +21,20 @@ unsigned key_gc_delay =3D 5 * 60;
>  static void key_garbage_collector(struct work_struct *work);
>  DECLARE_WORK(key_gc_work, key_garbage_collector);
> =20
> +/**
> + * key_gc_flush - Wait for pending key unlinks and garbage collection.
> + *
> + * Drain RCU callbacks from keyring edits and wait for the key garbage
> + * collector work item to finish reaping unreferenced keys.
> + */
> +void key_gc_flush(void)
> +{
> +	do {
> +		rcu_barrier();
> +	} while (flush_work(&key_gc_work));
> +}
> +EXPORT_SYMBOL_GPL(key_gc_flush);

[Severity: Medium]
Can key_gc_flush() return prematurely before keys invalidated by
key_invalidate() or key_remove_domain() are unlinked and reaped?

Unlike keyring_clear(), which queues assoc_array_rcu_cleanup() via call_rcu=
()
synchronously before returning, key_invalidate() schedules key_gc_work to
reap links first:

security/keys/key.c:key_invalidate() {
	if (!test_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
		down_write_nested(&key->sem, 1);
		if (!test_and_set_bit(KEY_FLAG_INVALIDATED, &key->flags)) {
			notify_key(key, NOTIFY_KEY_INVALIDATED, 0);
			key_schedule_gc_links();
		}
		up_write(&key->sem);
	}
}

When key_garbage_collector() runs the link-reaping pass at found_keyring, it
calls keyring_gc() -> assoc_array_gc() -> assoc_array_apply_edit(), which
queues assoc_array_rcu_cleanup() via call_rcu() without setting
KEY_GC_REAP_AGAIN:

security/keys/gc.c:key_garbage_collector() {
	/* We found a keyring and we need to check the payload for links to
	 * dead or expired keys.  We don't flag another reap immediately as we
	 * have to wait for the old payload to be destroyed by RCU before we
	 * can reap the keys to which it refers.
	 */
found_keyring:
	spin_unlock(&key_serial_lock);
	keyring_gc(key, limit);
	goto maybe_resched;
}

Because key_gc_flush() calls rcu_barrier() before flush_work(&key_gc_work),
if key_invalidate() is followed by key_gc_flush(), the RCU callback is not
queued yet when the first rcu_barrier() starts. If key_gc_work runs
keyring_gc(), queues edit->rcu via call_rcu() after rcu_barrier() has alrea=
dy
passed that CPU (or returned), and finishes before flush_work(&key_gc_work)
is reached, flush_work(&key_gc_work) sees the work item is already idle and
returns false.

At that point the loop exits while assoc_array_rcu_cleanup() is still pendi=
ng
in RCU, key_put() has not been called on the unlinked key, and
key_gc_unused_keys() has not reaped it.

Should flush_work(&key_gc_work) be called before rcu_barrier() in the loop
so that any pending link-reaping pass queues its RCU callbacks before
rcu_barrier() waits for them?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103030226.2685=
251-1-jarkko@kernel.org?part=3D1
