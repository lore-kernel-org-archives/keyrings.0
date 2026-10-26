Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058127;
	b=p4/rx0h3B9/kVCCGwwp4Wo6Cz3cV9ukVNxtCjbk1HKsoYHRxbYfn6oPYeQzJuwzK8uu9
	 1rqpc5dcqQ5Jvtmi0PjQVHN3WgU0ByNIpQ2k4oL/4wyajXdNLYwDPmMYgAqaKqs1INdRi
	 Nb8MydPp7WxABJzOzFkDUb/iK1mSlGUxoF1kFOnfj8OU0/f1fppU2BgNsQBq0IXPpNImt
	 AVyGv+zR5I6/L4uOlDnhbSEwwdOXREjfqJt56XJnWUcwbAXTZ18/z/4qrTvCuVH/L1N6y
	 IVu4oS2CbH3PFa/WyydUJ7YVygJy8t7Ij4t+tyy39vuL/VgTJjLukv192eSFGs0E74Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058127;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0Cref69zut0vAJQTI6AWgS5EX/rrz0wMNXR0pFiATGE=;
	b=phW5KpG+G/lF3x3ReP6rw2rXa4FGoKuutgjp6qrEmKFW93svVjpaj0p9KhpFhpy70fRE
	 zeb4v/Ywvdx2sjI3WWLuScZJGZ/u0zp9JT+GToJustuj4rcbnt7BewXsVkiQQL3ZOD58R
	 w93CyXJdhpx2hl/J88/nk5W5oGfh4/k7dBGPiUYdCSi6ePRrZUXVZ9XM3/tdP5ez7/C6U
	 j34YTH2rXB6vdF1zPhPInNcD11xCVYnDcJrXWXxF8qhLT3/WrbMj1PndnxupkSMyGuwy7
	 lZwVVWwPw4CI1PUiMrJ4+/3nxcW1YQrCl60PVkYVJcuv82nRkQ2XK6tIIkpRRfEZIoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSAuadB4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id F159C606A31A;
	Mon, 26 Oct 2026 23:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SSAuadB4
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 00CC51F031E0;
	Mon, 26 Oct 2026 23:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793058126;
	bh=0Cref69zut0vAJQTI6AWgS5EX/rrz0wMNXR0pFiATGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SSAuadB4/9et8dEpA6/NAMYUtFypD4j9oXg7GK8MupjPL30ISwdusmm2o8IcOlCTr
	 nPx5Sk/asToergzCU3p/g0Ed/g3Tt1h9PZmqq8fM8qJ7lSr13bDzdZZczYTy6bcpPa
	 4BYvXN8Ouih5Xbqsmt8EN0sW5/nqw0xQvgyFQOn/YfLe7jPHKnFmYwwazHE3a1bg2R
	 fzNe3isTIZGVKJLk0XeTSftCsjNv9VlC4Cv/zoRU2fwKqBZcXa2l/pKOwwnHRaqTMu
	 Za6aJw9j5maLhsW/Fw4uwDW3sMG9ttOAw/K/h+wr9mOOjCTzyJj4fQchcx92fOFS6n
	 ogr0AIJ2TSJXg==
Date: Tue, 27 Oct 2026 01:42:02 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>,
	syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH] KEYS: dispatch key_gc_work to system_wq.
Message-ID: <at_lSoqp4-2Var4S@kernel.org>
References: <at-LgXM3BjyfF21u@kernel.org>
 <20261026222207.1237-1-hdanton@sina.com>
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
In-Reply-To: <20261026222207.1237-1-hdanton@sina.com>

On Tue, Oct 27, 2026 at 06:21:52AM +0800, Hillf Danton wrote:
> On Mon, 26 Oct 2026 19:18:57 +0200 Jarkko Sakkinen wrote:
> >On Mon, Oct 26, 2026 at 06:57:22PM +0200, Jarkko Sakkinen wrote:
> >> > --- x/security/keys/gc.c
> >> > +++ y/security/keys/gc.c
> >> > @@ -270,9 +270,8 @@ contended:
> >> >  
> >> >  maybe_resched:
> >> >  	if (cursor) {
> >> > -		cond_resched();
> >> > -		spin_lock(&key_serial_lock);
> >> > -		goto continue_scanning;
> >> > +		schedule_work(&key_gc_work);
> >> > +		return;
> >> >  	}
> >
> >I guess I'll to elaborate my fix and this proposal as you gave feedback
> >of neither.
> >
> >What you wanted to respond to my patch other than nitpicking is probably
> >this sequence:
> >
> Nope because synchronize_rcu() has nothing to do with workqueue lockup.
> 
> >  key_garbage_collector()
> >    synchronize_rcu()
> >      synchronize_rcu_normal()
> >        wait_for_completion()
> >          schedule_timeout()
> >            schedule()
> >
> >I should have put this to the commit message, and missed also this
> >detail.
> >
> >So the way I saw this, which could be wrong, is that the workqueue
> >lockup would could happen less often as also other threads are scheduled
> >preemptively in unbounded queue outside critical sections.
> >
> The unbound queue could also suffer lockup.
> 
> >What you are doing with early return is at least not right as it 
> >corrupts the state. So you should supplement that with something
> 
> How?
>
> >that carries it.
> >
> Feel free to post a diff?

Actually I choose not to answer to your questions as your only
argument is "show the diff" or providing a diff without making
your case. I'm sorry but I don't get anything from this.

If you want to help, be helpful.

Br, Jarkko
