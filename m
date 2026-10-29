Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292319;
	b=dqPA7dnAOTa3Bb6mwJ9gIe0Y3WZl+/izEUpdtFKqPMCzWG4ZX2Kxg2gM/JCYB3hUdvQz
	 C7vMTxW6dTKn4MXATkOLI4IKt4o4I+OSBsdnf4vC5S5qTnpkrLcmxuaaU2sl26+3v+XzE
	 847o2iIYQhzL6wKrGo7/1/o2kvOpLq40AlJgHqmgQJ49mMTb+EMlOKPn0xohYmwC7nSHp
	 d8B5VG+l4NXcIkwyHQ5TUf//5QFbqrPz3xdbV6UVDOYOncT9KKif86r7v3w2umJR7+6WS
	 P2okF690ErNpj6RCWQLwGYHxWal8v5c5+xp4xCvgQqHRw6fxHzyAL2ry0pYM4VjlEXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292319;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TwhsF8heRL/FPi+JPE2Ch6ttIpQ7f/8UVa4zHjgf4PQ=;
	b=YWu8Kd0cI6Ssm3/uRPH9Y+2/1VAeIP5ySIOHZkVmiqJJhveOk+UQzefVcn5IBgFt9srV
	 EVmAb4WDNJ5uOZpF84oLINOMf3TrmRhPD8Ct3yV+dnmwztygUiuQDpqSg8GxKzJBR04kD
	 MeyDghOkJmOjMrowrNMc0jiwKCckaKHR5/BiRG3E8epTjkZND5NZk80/mGfs7ZGJjxfGM
	 T/5twTh2n06vW68yKfXyVpc6Hz4OJCAGM8VSdAxhavH1SQTO5UYYd/Cero2yKokH9/IJ2
	 vjwmL1mnRvYVCEwf1/I/5vhMVYdiwq5BVdJWR+xfX9TSwuz+OtGVqJN+7SwH5QlTL+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8Z77AYC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 8FB11606A322;
	Thu, 29 Oct 2026 16:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f8Z77AYC
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 930B11F031E1;
	Thu, 29 Oct 2026 16:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292319;
	bh=TwhsF8heRL/FPi+JPE2Ch6ttIpQ7f/8UVa4zHjgf4PQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f8Z77AYC4GOGpdqb5zuJ7v3xiEJl6d2RJE1EZsme0Ajz14w/zz2gx745j/mNahvqm
	 83HGTnnnYgWQ7mayeooSAS8dss8w9PipTw2YvoXv9Z92puGhOIb55xj16f76nv/fpm
	 pGHs0UVknnIsGCAHXQL+WIoCPKoWgtL3v99mY4NxkoDLR/+ygMkz6ciKaGqnPAxYXg
	 ZgnfP8qcuSHhpHYwQYjzORvYhkprWxe/UxvfH3UNcdK2jAff1KehleBcTrHdR6j/7e
	 vJLlgM6b3lJiNM+aZme8f3HCv5dCUrH9FE8+kW81QKrlnQx+glgy+Q73byn985p2g4
	 X6UrgpUHCBAWA==
Date: Thu, 29 Oct 2026 18:45:15 +0200
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
Subject: Re: [PATCH v4] KEYS: key_garbage_collector(): process in chunks
Message-ID: <auN4G05kSzZepLE3@kernel.org>
References: <20261029140707.2010100-1-jarkko@kernel.org>
 <auNZIm0meBH7zHQX@kernel.org>
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
In-Reply-To: <auNZIm0meBH7zHQX@kernel.org>

On Thu, Oct 29, 2026 at 04:33:10PM +0200, Jarkko Sakkinen wrote:
> On Thu, Oct 29, 2026 at 04:07:05PM +0200, Jarkko Sakkinen wrote:
> > keygcbench results without the patch:
> > 
> > unused:   min=3016.754 avg=11859.097 max=28667.645 var=141391574.712
> > expired:  min=0.015 avg=12758.165 max=21516.237 var=85158284.646
> > combined: min=0.015 avg=12308.631 max=28667.645 var=113477010.596
> > 
> > keygcbench results with the patch:
> > 
> > unused:   min=0.225 avg=13.991 max=853.100 var=858.700
> > expired:  min=0.016 avg=30.442 max=2791.695 var=14187.539
> > combined: min=0.016 avg=19.249 max=2791.695 var=5177.436
> 
> I personally would optimize all-in for variance because:
> 
> 1. It is insignificant drawback for any practical keyring workload
>    if the total time increases slightly.
> 2. Latency peaks are a signifiant drawback for any possible latency
>    sensitive workload running in the system.
> 
> What I'm doing now is to find sweet spot chunk size below 1024 where
> variances reaches its lowest value.
> 
> The latency part makes this change more valuable than focusing on
> only on the regression itself.

The best block size 1 and this was actually my guess. Just in case I ran
the benchmark three times for each 11 block sizes.

It is simple refactor to do. I simply substitute KEY_GC_BLOCK_SIZE with
1 and carefully refactor the constant out.

I think that converging to the correct solution through this route was
worth of the additional trouble because at least now properly sanity
checked.

Br, Jarkko
