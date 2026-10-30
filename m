Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793395264;
	b=VvAyZofesoiBpZtN71iLQo1DESNKu+qvz41u5adWAUPVzgJiT0PWpqpNZ0OyNhh6zRWk
	 s0zZDghfxkvo2Y3vhI/oL+kf2iJ34jJrJf5luXIAR2AYKTARC4LtZS6J5be3OjSI73AvT
	 Hb7p+pWdFbfJFvkegmFFROxuBd3i70exDyVkPhyJ/qpLWqcNq5APTjKmnhBOEoMowR24U
	 z9wTsLgXIENLVOUY70TEuxjoIdJ+W7FM8gJtNnd+QF5UxD5tbmRK6QXkGms8jRR9sWCmX
	 h609vQb4YGgS10GByesKL6Lr+bnqnkMMzqERbo8lShPB7SCEr8Os59USyfzXhgZcYBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395264;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=mhaMz0y2lVo6uQVjZqe2v/nDHi9BfqrR/10spk7R40U=;
	b=UAuy1JUqnKaIppL/Ve6tTHhOraNpPu6QQ9F+7zihHzx+0KKtSCfGbTkQ12RENw9MSr42
	 H+kdtEUnqZrxZTWbDpiw6rj4F0Xw3Xzq/gFQm8hcaFnnUp4QLu4rztDORLAj3LaBY+x5n
	 fl01WuKZKc/6560ww+L66tZc5Co2twWeCTjFdl/ldeHTLMb89IDdg0dRcTRHDCtseH/E7
	 Kb5N55NgtltluFBg2/nAb+Xfa6DmJBCPDw1ZjnMgAoPysXUZABDbnMLZTvIrH9VbC3UKP
	 +nZ4wgXEXAxAcaTcE2wtGge40Hl5UEJwVOyHveuErH/fgKw5LWaKYne/6QVMZ92LAbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMhUMRo1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 4094E606A31C;
	Fri, 30 Oct 2026 21:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AMhUMRo1
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 39D231F000C1;
	Fri, 30 Oct 2026 21:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793395263;
	bh=mhaMz0y2lVo6uQVjZqe2v/nDHi9BfqrR/10spk7R40U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AMhUMRo1ieVn+nWKa1WA2rjOXwwfisGTA9Q+r8wiUTAdE10Z+0KukKypKYiPrejlD
	 A2NuHcIPRpsAhqtwaasnBsZuoKsC7e2ivmrEWy9TibT5kl1Oivp2o2HkKG1eeBj0hF
	 GmYyRzKpshRBNnzHlGGMrdP5YYYXTcMVWqEpO+hVh5F5OPEpKmXMVQ2DQzpeC2gY8R
	 8oCnQUdBNJLzpP8lIj/ZwN6IdskHIiImUc3lkJG0S/wRgzzN8r7pcVM9kEuUqP7WAc
	 O6TiUfYB36IUOGJioQ8FydCO9zatAcuVl+VORxowbIU98UR/JZVHgLClm25qf84rYx
	 lc1EekkbVUlMA==
Date: Fri, 30 Oct 2026 23:21:00 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>
Subject: Re: [PATCH v8] KEYS: key_garbage_collector(): process in chunks
Message-ID: <auUKPAAbye64m-mG@kernel.org>
References: <20261030205412.3138975-1-jarkko@kernel.org>
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
In-Reply-To: <20261030205412.3138975-1-jarkko@kernel.org>

On Fri, Oct 30, 2026 at 10:54:08PM +0200, Jarkko Sakkinen wrote:
> key_garbage_collector() has a design that is not resistant enough for
> workqueue lockups. The duration scales up relative to the number of items
> in the serial tree, which causes a reoccuring theme of being guilty of
> causing workqueue lockups.
> 
> Resolve the problem by processing in chunks:
> 
> 1. Declare a static variable key_gc_work, which owns the garbage collection
>    in-flight state, and key_schedule_gc_work() for re-scheduling the work.
> 2. Define KEY_GC_CHUNK_SIZE, set to 64 keys, as the bound for the number
>    of items scanned and destroyed.
> 3. Define KEY_GC_DESTROYING to mark resume to destruction without repeating
>    the RCU grace period. Drain the graveyard before advancing key-type
>    reaping.
> 4. Define KEY_GC_REAP_REQUESTED for preserving full-pass requests across
>    the continuations.
> 
> keygcbench results without the patch:
> 
> unused:   min=798.785 avg=4181.989 max=7565.193 var=11446068.927
> expired:  min=0.003 avg=2404.971 max=4111.065 var=3061018.501
> combined: min=0.003 avg=3115.778 max=7565.193 var=7172908.943
> 
> keygcbench results with the patch:
> 
> unused:   min=0.005 avg=0.125 max=79.590 var=1.088
> expired:  min=0.002 avg=0.196 max=236.207 var=8.121
> combined: min=0.002 avg=0.154 max=236.207 var=3.912
> 
> These results translate to:
> 
> - 93% drop in the combined variance.
> - 2.2% increase in the total task time.
> 
> The value 64 for KEY_GC_CHUNK_SIZE was cherry-picked from the set {1, 2,
> ..., 1024} by running the benchmark for each chunk size three times.
> 
> At the far left variance is 97% lower but at the same time total time
> grows by 133%, when compared to the selected chunk size. The size was
> picked based on getting a reasonable variance with a minimal throughput
> decline.
> 
> Fixes: 0c061b5707ab ("KEYS: Correctly destroy key payloads when their keytype is removed")
> Reported-by: syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=c15de43f1e7fffbb7b9b

These re-appeared because last time I fixed up them in the patch and
forgot to remove them from the commit. Not submitting a new version
for this but it can be done :-)

It's just so irrelevant detail in the end of the day so I had my
eyes more on the code than the tag; thus slipped.

> Link: https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd-test.git/tree/package/keygcbench
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

No new Sashiko issues reported. Weird that they came so late.

Br, Jarkko
