Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036372;
	b=VH6dGI630GjB2RQdZvM6oHqBRCTiwgWN6P6aVM7uFBVobxGcXV4r1495VkK5A3zWVedu
	 7Cb/pPIXKFMlj0V2AkH9IhzHlafBapVaPXeAfUq0MW0m1hI1k11xtb2Q48mmekFHoAGJC
	 T9XiJTfzrwHCcU8Cl9HiZULNG/D2/R+lxrSdI2kTS3yeGEpZP/v3ZMeO3m0JqoFSD69e1
	 +1q6lGFzDCmQ/xtkUin9GElwzYQvnnf2b/TIZEj6CP3XLXkTLFeMcJJJygflBsgmGBuNL
	 HCYi5y3elww5mvm/FDwMcDiUZAePIWOpmtvEiNldclZ30digtRUje4TXfDGFju6nzGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036372;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/OaIQJ55C35QtmqZCOLPnT2R5/UQeB22wSAn3zHiMMg=;
	b=x8C0wo8KYjQNYP//Wbnx3aUPipDQL87P92vpeuWYkO3Hb9WzKsQaK8jgvD0dSJFR8AEJ
	 gj0t7SdrTOXL+uxdLOCeh8i/Og/6fNhqoq6wyXcSAGJWWekd3SDttUCLiM1x+0PQ3+ZNE
	 QNF2CeuOnMHkHZN6lJWJl5VWmrRItVn/KbO3y7XWyiQZuPPj9zArYl1ArI8WRHKE7r2SB
	 N7DIDWL6ZXPX6U5dynwtJbO85CAlo0PJG3KPG8VFMyRXgApPtGzdFzbZJbxPufb7IOpw/
	 Id/KZJMJ2kTtg50CDECyERB8OhZsGz6TW2ztvUAMoym0AtYj6qQpwzwDY7kxqIChv/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyBmfnMT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 98FE4606A31A;
	Mon, 26 Oct 2026 17:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cyBmfnMT
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id A7F231F01825;
	Mon, 26 Oct 2026 17:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793036372;
	bh=/OaIQJ55C35QtmqZCOLPnT2R5/UQeB22wSAn3zHiMMg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cyBmfnMT/VOS2892+vuXtl0mWe4zx49lqgeZJwqPIoj1yZOuN+EhEAvKn6NX3I+Ms
	 DV/GgmEinunXnHRcm2vyAPrRowjZgknur+Db284QLpJ1DQSYTnZZ0xRjsLIraiHn39
	 GE8BHh0I1oq9v7yjg4zv49fzGjkwl5Q+nuo9EY2/EQacPkoJI6UwmbQaet31pEbmTi
	 saifs2hT2JKqjwAlhplfJGEkQ6qsYXN8Gr3o4MFFByNA+QPsOG0jjqBgTyPQSOXY5K
	 MGpKSRNrf5pl81BigmUdhKL3Oi2kIyGNFeylC1mAiaybQUhTkNDrWlxe72yR6ZDXu0
	 768ycXUNj0+tQ==
Date: Mon, 26 Oct 2026 19:39:28 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] KEYS: dispatch key_gc_work to system_wq.
Message-ID: <at-QUKgt9Aw6-0Yl@kernel.org>
References: <20261026031219.2627968-1-jarkko@kernel.org>
 <20261026095609.1220-1-hdanton@sina.com>
 <at-Gbux2IWwF8aqp@kernel.org>
 <at-LgXM3BjyfF21u@kernel.org>
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
In-Reply-To: <at-LgXM3BjyfF21u@kernel.org>

On Mon, Oct 26, 2026 at 07:19:01PM +0200, Jarkko Sakkinen wrote:
> On Mon, Oct 26, 2026 at 06:57:22PM +0200, Jarkko Sakkinen wrote:
> > > --- x/security/keys/gc.c
> > > +++ y/security/keys/gc.c
> > > @@ -270,9 +270,8 @@ contended:
> > >  
> > >  maybe_resched:
> > >  	if (cursor) {
> > > -		cond_resched();
> > > -		spin_lock(&key_serial_lock);
> > > -		goto continue_scanning;
> > > +		schedule_work(&key_gc_work);
> > > +		return;
> > >  	}
> 
> I guess I'll to elaborate my fix and this proposal as you gave feedback
> of neither.
> 
> What you wanted to respond to my patch other than nitpicking is probably
> this sequence:
> 
>   key_garbage_collector()
>     synchronize_rcu()
>       synchronize_rcu_normal()
>         wait_for_completion()
>           schedule_timeout()
>             schedule()
> 
> I should have put this to the commit message, and missed also this
> detail.
> 
> So the way I saw this, which could be wrong, is that the workqueue
> lockup would could happen less often as also other threads are scheduled
> preemptively in unbounded queue outside critical sections.

I did test this with fairly large keyrings. I think I'll scrape that
script. That does not mean by any means that the fix is correct at all
but. Please in future also provide context for your alternative
proposals because otherwise they pay no contribution to anything.

I'm not really interested whether I'm right or wrong here but
instead of finding the "truth" aka the correcting reasoning
that leads to a proper fix.

A random diff won't do it.

> 
> What you are doing with early return is at least not right as it 
> corrupts the state. So you should supplement that with something
> that carries it.


Br, Jarkko
