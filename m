Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292611;
	b=d/xX1lp7u4I1BeiJDStguC/ixsLIWlCZ4l4v5izLq3QmJWmHuAeff3aojEaUpLWE5ua+
	 hJFLXTu7cIgVait30RzUfml1UYTQRgMX8ewIK6RlNWFznr8lxHpB/p3pqxPl80+ewjN6M
	 qvaHttP3apeP98WV7U0bsoKp3nBeU2yUYtTL4GW+EGhwsAW4WCq7rHgy+RbUZ9eCqEqDr
	 CzBwS5yyxSFHv2yXgc05Te9atCGN96YLsuhaf8ND5vSOv3Wvzq1wbhBgBcnaDHdYM5LIU
	 E+HYR9s926BB4z1HrUFc92VLmu8JKuZlua1BfXlPoxuVYOuDZX9uNKXMGrC0vZ2oE2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292611;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qVX1t9dKSkLThmzH5jvhgtq92wmevObd0ItO8RxTMIg=;
	b=ZUAcjvTZA9oqA5RYOX682HNUleDTX2RVmcWbk60PpflD/BWO37Wr2jvlNdE0ZEBesOBC
	 akcHMBi8+i4LDVG3o7HkN7E0MXgct7ZgK0DjG463tomCognlgup/KINvcwicI3X/EWfq4
	 7KsMwcUktJ8/ZE3ka0PG4GTPo3CjEUrFy2G+rHGRA5JJ/FvN8k96tXrJ41KygGhHJBZL7
	 krNy2w01DFRs75M5+RQx8mjBmwcUcrqek1dAb8xoSQmO2QRt5UVuyAJjhZs8cWv1ZyiCl
	 cgZH/80XaNIsCq3MXVRY0s0pz49Z3gVAP+Idw47AD7iawywgY7Mh9gQaAfxWvXUkdlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdPh9Ce+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 45172606A31A;
	Thu, 29 Oct 2026 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fdPh9Ce+
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4B7281F01816;
	Thu, 29 Oct 2026 16:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292610;
	bh=qVX1t9dKSkLThmzH5jvhgtq92wmevObd0ItO8RxTMIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fdPh9Ce+0ey1hBlXwFkQGvgEYPA4B0BdxhiuPuiiz4QmluS3KsQ/Tik28WCrFpcd0
	 pDsz4xd/khL54GoXQtGyiprJakmao9c0H/Oo+GSEdIsD4ilOKy9aOGqHLBGj3HikgQ
	 GcLHAExYQDPHsATApj0otMT/v3GqsAiQHWm0x1ZVMxlOeg6rvFkmCxolXvuDCyNkL/
	 RlbFTBpzZjfqLyJqlAQIEbYj8t9WRdEhzlm1kDBS6elmK33tMsOd4e4APbIe4P5srY
	 DIDrARqWAOa4hvzlUstuNb2yWDSmFZMmiBAcVxk3nqvKA4zz30UZCQrV9LWVy/e0z5
	 w8hl58TJcUH1g==
Date: Thu, 29 Oct 2026 18:50:07 +0200
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
Message-ID: <auN5P8fmsply4mr_@kernel.org>
References: <20261029140707.2010100-1-jarkko@kernel.org>
 <auNZIm0meBH7zHQX@kernel.org>
 <auN4G05kSzZepLE3@kernel.org>
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
In-Reply-To: <auN4G05kSzZepLE3@kernel.org>

On Thu, Oct 29, 2026 at 06:45:19PM +0200, Jarkko Sakkinen wrote:
> On Thu, Oct 29, 2026 at 04:33:10PM +0200, Jarkko Sakkinen wrote:
> > On Thu, Oct 29, 2026 at 04:07:05PM +0200, Jarkko Sakkinen wrote:
> > > keygcbench results without the patch:
> > > 
> > > unused:   min=3016.754 avg=11859.097 max=28667.645 var=141391574.712
> > > expired:  min=0.015 avg=12758.165 max=21516.237 var=85158284.646
> > > combined: min=0.015 avg=12308.631 max=28667.645 var=113477010.596
> > > 
> > > keygcbench results with the patch:
> > > 
> > > unused:   min=0.225 avg=13.991 max=853.100 var=858.700
> > > expired:  min=0.016 avg=30.442 max=2791.695 var=14187.539
> > > combined: min=0.016 avg=19.249 max=2791.695 var=5177.436
> > 
> > I personally would optimize all-in for variance because:
> > 
> > 1. It is insignificant drawback for any practical keyring workload
> >    if the total time increases slightly.
> > 2. Latency peaks are a signifiant drawback for any possible latency
> >    sensitive workload running in the system.
> > 
> > What I'm doing now is to find sweet spot chunk size below 1024 where
> > variances reaches its lowest value.
> > 
> > The latency part makes this change more valuable than focusing on
> > only on the regression itself.
> 
> The best block size 1 and this was actually my guess. Just in case I ran
> the benchmark three times for each 11 block sizes.
> 
> It is simple refactor to do. I simply substitute KEY_GC_BLOCK_SIZE with
> 1 and carefully refactor the constant out.
> 
> I think that converging to the correct solution through this route was
> worth of the additional trouble because at least now properly sanity
> checked.

Taking this back! It has 133% total time increase :-) So yeah constant
is required. I have all eleven (x3 each) available so I pick something
more appropriate (more like 13% at most).

Br, Jarkko
