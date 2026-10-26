Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984830;
	b=LC57PP2DTfqStAnByiODBXpXAQn8NOL9g9yShUuHKw0NFOp+C3DoBXjsQBG14/13KTG3
	 5QRK38Q18jx/ymdm53d7ZI1sch3Vo/8LswbcSnLnN6Wu3qFZHxY3Y8nNcpgyV3gWmymjx
	 P4HPC/X7EdGqjrH4ueM9qfWzFAYpquutJy8rAjbJuILcTKNZgMXwqeKELncWVDvEF8HtJ
	 0DZ+WYIAex1oNGrdEWs387w21zJ+viF/fWFZa2Umvi1kD7swp+MhZtN9h0CxMDXOgpB5a
	 X8AJTcwpYvlTL8og1ZEMblYf7qArhI0Wdyu3kvTZ9BgUftNEEZYnRTWDP8KdTn3Y5FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984830;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=2m1HlrAMX1k+0En8UXUb5+7RGqWl4A1YMYeD0fcDZJs=;
	b=45+Z6kZ0wSxxKgf7eLJjFYNyK35XKD/FSshqWNHrfzq28lV1VIkCetPbMVT98x6GExQd
	 85wJ/snM4WyR8985YhIg+9w52d9DCwCeyOZsKy4RK8FHbYEHc9MTL3gEVcadwEDeVJH7G
	 cG+lWYZxirNNt6lzFI07tK/gsli7pOop7FobquMWCAjgWstMtjRfbcv3jT9W+1N6WvC68
	 ZzuVRPHM5QXVGWURmyjuyhT3epDpPqxuSzFqsC8vuPyV7QsPyL4/jWU7meXCc51eJt5ab
	 5C4xsmH5EoYlp6KwC1/NZiNdNZkwmC6b9mlMenlz5sVxhWY4N5hn5NXGskLNoGW0FGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VgGC6Bah;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 08ACC606A31A;
	Mon, 26 Oct 2026 03:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VgGC6Bah
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0AF241F01825;
	Mon, 26 Oct 2026 03:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792984829;
	bh=2m1HlrAMX1k+0En8UXUb5+7RGqWl4A1YMYeD0fcDZJs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VgGC6BahiS/v5DPUFqNFVNGWpycU0gJUcyjIBh6RIzl1Dx4VrDTJPRFrz2McXu38a
	 d5PEVICgfbzGkypO9VCtUQiA6FbCW9AQH2i8vWazkHbbfMdsMqmgKuNGx4jcJtHmsS
	 qUEtSD9UcjtsQc1TKJGGuIe2yRylknuelEcTBBODx4CU3EvM48aiePYTSZqi5H2YJu
	 Z3hVsPkLyb0iRGp732m7krEOUdHEmKEh737fwps2jZfSNAix91EOTmTfB7+cXHPxns
	 1Oy+PHTBKqI0tTyMsIHMV79HYQDS0T1kOQoN06IULPARFSNZLtGO7hyoJDBFKCuDsO
	 ZGBAoEG3PKhEA==
Date: Mon, 26 Oct 2026 05:20:26 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:LIBRARY CODE" <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH] KEYS: dispatch key_gc_work to system_wq.
Message-ID: <at7G-sfZmmqJfv2E@kernel.org>
References: <20261026031219.2627968-1-jarkko@kernel.org>
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
In-Reply-To: <20261026031219.2627968-1-jarkko@kernel.org>

short summary: /system_wq/system_dfl_long_wq/, /\.//

On Mon, Oct 26, 2026 at 05:12:18AM +0200, Jarkko Sakkinen wrote:
> schedule_work() dispatches key_gc_work on the per-CPU system_wq, which can
> choke the queue:
> 
> BUG: workqueue lockup - pool cpus=0 node=0 flags=0x2 nice=0 stuck for 30s!
> 
> Queue the work on system_dfl_long_wq instead, which is an unbounded wq for
> long-running tasks i.e., it has the WQ_BOUND flag set and thus cannot hog
> the CPU core.
> 
> Link: https://lore.kernel.org/keyrings/20261024042944.52493-1-hackerowskiy@gmail.com/
> Reported-by: syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/6ad35b60.7952420f.283480.0360.GAE@google.com/T/
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
> I sanity checked with perf that scheduler latency improved clearly as it
> should, and used large keyrings that I expired, as the test payload.
> 
> It was ad-hoc testing but I can scrape from transcripts a test script
> if wanted.
>  security/keys/gc.c  | 8 ++++----
>  security/keys/key.c | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/security/keys/gc.c b/security/keys/gc.c
> index eda445f815d4..2337d39722e4 100644
> --- a/security/keys/gc.c
> +++ b/security/keys/gc.c
> @@ -57,7 +57,7 @@ void key_schedule_gc(time64_t gc_at)
>  
>  	if (gc_at <= now || test_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags)) {
>  		kdebug("IMMEDIATE");
> -		schedule_work(&key_gc_work);
> +		queue_work(system_dfl_long_wq, &key_gc_work);
>  	} else if (gc_at < key_gc_next_run) {
>  		kdebug("DEFERRED");
>  		key_gc_next_run = gc_at;
> @@ -85,7 +85,7 @@ void key_set_expiry(struct key *key, time64_t expiry)
>  void key_schedule_gc_links(void)
>  {
>  	set_bit(KEY_GC_KEY_EXPIRED, &key_gc_flags);
> -	schedule_work(&key_gc_work);
> +	queue_work(system_dfl_long_wq, &key_gc_work);
>  }
>  
>  /*
> @@ -119,7 +119,7 @@ void key_gc_keytype(struct key_type *ktype)
>  	set_bit(KEY_GC_REAP_KEYTYPE, &key_gc_flags);
>  
>  	kdebug("schedule");
> -	schedule_work(&key_gc_work);
> +	queue_work(system_dfl_long_wq, &key_gc_work);
>  
>  	kdebug("sleep");
>  	wait_on_bit(&key_gc_flags, KEY_GC_REAPING_KEYTYPE,
> @@ -322,7 +322,7 @@ static void key_garbage_collector(struct work_struct *work)
>  	}
>  
>  	if (gc_state & KEY_GC_REAP_AGAIN)
> -		schedule_work(&key_gc_work);
> +		queue_work(system_dfl_long_wq, &key_gc_work);
>  	kleave(" [end %x]", gc_state);
>  	return;
>  
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 6ebb8691551f..599626c897b2 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -668,7 +668,7 @@ void key_put(struct key *key)
>  			}
>  			/* Mark key as safe for GC after key->user done. */
>  			clear_bit_unlock(KEY_FLAG_USER_ALIVE, &key->flags);
> -			schedule_work(&key_gc_work);
> +			queue_work(system_dfl_long_wq, &key_gc_work);
>  		}
>  	}
>  }
> -- 
> 2.47.3
> 

Br, Jarkko
