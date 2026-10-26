Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793033843;
	b=MP5kLmHXIQk4Zyv0HzFbsu9jyWxZHdInYLHkb0Owt7vF3rYiDytNycLgpGr0SyH1ExAW
	 ZMrolLQ/dSHt0VV4jbnSAybt3gev7jp2w/KQJ8ZwRY3SXlO3pvasZngPljjFzf8QuGucs
	 8+Cg0ODCUEwkRabYxaYgstIey9F4I1Dp56Mp5FaLknk3SrTBEY8uq2IvWnURu45yh4Rj3
	 2tyyseyJkHcQMdWEcxWer5Nzj9S95G6zz25asE/UOTrCRi3osWijrMXmD/og7jI9VN97I
	 DR2xJa1Dgy9HT1H+AgDG6f2YC/r9vfVTUiwcRbvsfHow0lrHEJDgpAUpbYZu2f4wr7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033843;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8NTcwjopRIiIx3KdeE685AzKks9pIh9xK6s8dhG06Ns=;
	b=ZLF69vGk8MbdlQu0E93zzx8yt3oIdFybtBEWmijDoEn5Hy3Po+fHOHSSJdaXCgtwh0eV
	 mky69amckBfZTM63X7hxym5OabFrB6f+573sorqxY3GY8jhARcYweA7ekMyN253owL0tw
	 6tuISCq020U3wrmffPoJqY35xpqoEAGSdc8bmPkMg+vM8jrFrtgF7cLFDKKetU7tKZqZZ
	 06KXi6n0Z7nBc2zW3OJseH+aOt88zFcg67pjQEELqXdEzLoEnr1jc8CEvq1Mf9aTcVp2Q
	 81IoSpdYb/VYzoGBRh7pLA66pORA6u2SE9gZbXsIn0jF18btfXvQlVaeFsKB/xbPExg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIoPvtJQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D18F6606A31A;
	Mon, 26 Oct 2026 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIoPvtJQ
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E17501F01828;
	Mon, 26 Oct 2026 16:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793033842;
	bh=8NTcwjopRIiIx3KdeE685AzKks9pIh9xK6s8dhG06Ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gIoPvtJQNuwf4v28TSvml4zKtBw2EYNKVaaJz2VXQ+GdyRhpv5F+RAqVJjzcYhNOy
	 91ivGoxJM3yfEL03JAmOtcihU7M62JL24q0R+eRQ64eUgGy4+JbOPIV8CPInxsboXo
	 IjIrxNdkS/RLlIgrXJGu1I02eEIQD5bxkSFDs5usBPUYQ6smvLKVfw0YmwTZkd+S9T
	 iCmSJvjl96jc9BCqg9jCS38qJczEjuCXSwz2xL4lX4BMPGYOTH4tRQdQbEaoyCzeM8
	 9OVWYhGGHuUQufJvbYN713L9Z+B8vS6jnDLF8AOCslTiiuMcwNk6aO0cogGlqJYMSU
	 3p2QLGhPO5iwg==
Date: Mon, 26 Oct 2026 18:57:18 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] KEYS: dispatch key_gc_work to system_wq.
Message-ID: <at-Gbux2IWwF8aqp@kernel.org>
References: <20261026031219.2627968-1-jarkko@kernel.org>
 <20261026095609.1220-1-hdanton@sina.com>
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
In-Reply-To: <20261026095609.1220-1-hdanton@sina.com>

On Mon, Oct 26, 2026 at 05:56:05PM +0800, Hillf Danton wrote:
> On Mon, 26 Oct 2026 05:12:18 +0200 Jarkko Sakkinen wrote:
> > schedule_work() dispatches key_gc_work on the per-CPU system_wq, which can
> > choke the queue:
> > 
> > BUG: workqueue lockup - pool cpus=0 node=0 flags=0x2 nice=0 stuck for 30s!
> > 
> > Queue the work on system_dfl_long_wq instead, which is an unbounded wq for
> > long-running tasks i.e., it has the WQ_BOUND flag set and thus cannot hog
> > the CPU core.
> >
> Nope there is no cpu hog at all given cond_resched().

I used wrong term, and it is good that you nitpicked that.

What about workqueue lockup, which I pointed out from transcript?

This does not help.

> Take a break instead then the workqueue has a chance for housekeeping.
> 
> --- x/security/keys/gc.c
> +++ y/security/keys/gc.c
> @@ -270,9 +270,8 @@ contended:
>  
>  maybe_resched:
>  	if (cursor) {
> -		cond_resched();
> -		spin_lock(&key_serial_lock);
> -		goto continue_scanning;
> +		schedule_work(&key_gc_work);
> +		return;
>  	}
>  
>  	/* We've completed the pass.  Set the timer if we need to and queue a
> --

Br, Jarkko
