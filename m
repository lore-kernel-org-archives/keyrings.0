Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792820633;
	b=HHij1tEf1Eciq9Sfk/aT+qeRvaF4HNlYXf07jjnSmsQ3MykAjY4luztwtn1X36Lgf5pk
	 R0Y5kyZhGHwb4Zoup1BobYe6TFb8BETRgzqvYBmB6fnIMowROqAv7h7TMWK9Du3sjEiP7
	 w61qXgJDcDbasvdaGASL/pZylc44JqlAr/DGnT6J3ZfWzi2KQ5+IJtVGweJibsSPsb28O
	 rq3lq1aM5L/krlhFjlflagbyu7phv9P9JpLIWwS1PfWpt8i+5hcx3aO5rukZhWVisTicX
	 YVEqVG/KMmWxKpZ+w//OEOKUZMKggJSqz+zVnC8QwERYDHaYmVR9p2NezHgx534z4ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792820633;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Wiy7ZrHhw15Iry1Hperv5vWO08e018Xa7ESlKnGxgP4=;
	b=p3YNHMdxpC8fh89vtBv0SSsIqsRlYo+FVFbc82i+ZpsdGoYGhGg0vLOFVLjKx7obLxGi
	 0TdpBEJXCUkqHT8ptMzj7uIrEF/C/xe7pTsl7dVampFgxDTaasJabi0YGChwBE2J7o+Qt
	 BseBcAaDgJqapdz+E78K+eADlVuX5pcpbZeVNg5RDqPm3ydFsUfqYorP8ETV+UpG+Yw/R
	 1GbYkl+urTMIbDtUhzlo8b5nZnHGdtxWYwqgSVrffpb2FCG6VPoo/YJHwNb3Og3BIbuqy
	 N1OdaE2yGY/dT7Xil3lUhngQH4m7hCZP7C5yaouduVCngmpv9A+JToJbuiUfukBupuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkYUYPuX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 21CDD606A31A;
	Sat, 24 Oct 2026 05:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZkYUYPuX
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 62E8D1F01825;
	Sat, 24 Oct 2026 05:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792820632;
	bh=Wiy7ZrHhw15Iry1Hperv5vWO08e018Xa7ESlKnGxgP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZkYUYPuXAaZTTqsqd1uu/NLftykv0x7JOgv5e7M5ckkrPOc4TPMTJ7NtCQO7QxmQC
	 gTFMHD+hAtNI40XPWn2N+bnx4Y16EVdXAx5aSb6TC/arDxXko5XsHI+CQm4dFb/IKO
	 TKFLv+mRF4l2rBh/ecrtoAEOETHZUl9FJhSdw97LUOw+9oBcgi4B/HmlXlYGQ/WCmy
	 35PTyxmDtadaHZkEUY1QwBFpT0tAF4IYnhwMx74lP6tAa5YlcZ0k8xHukau9BbXT1o
	 awttVwY7dkmwm09cKUycBSFF5lc++UnLuOyiHcTf2xB1OIJ/9Kx9gf1i9WXfHRmUrX
	 3tszC9aDWsxeQ==
Date: Sat, 24 Oct 2026 08:43:49 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eduard Zateev <hackerowskiy@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] keys: use long workqueue for garbage collection
Message-ID: <atxFldwBDvSALp46@kernel.org>
References: <20261024042944.52493-1-hackerowskiy@gmail.com>
 <atxAM9JW6oi2MEeT@kernel.org>
 <atxEIlD8yeW30Nwr@kernel.org>
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
In-Reply-To: <atxEIlD8yeW30Nwr@kernel.org>

On Sat, Oct 24, 2026 at 08:37:42AM +0300, Jarkko Sakkinen wrote:
> On Sat, Oct 24, 2026 at 08:20:55AM +0300, Jarkko Sakkinen wrote:
> > On Sat, Oct 24, 2026 at 06:29:44AM +0200, Eduard Zateev wrote:
> > > The key garbage collector can wait for RCU grace periods. This can occupy a
> > > normal events worker for a long time and contribute to workqueue lockups.
> > > 
> > > Queue key GC on system_long_wq because its work may wait for long periods.
> > > 
> > > Reported-by: syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com
> > > Link: https://syzkaller.appspot.com/bug?extid=c15de43f1e7fffbb7b9b
> > > Signed-off-by: Eduard Zateev <hackerowskiy@gmail.com>
> > 
> > This commit message is not huge selling point for any possible argument.
> 
> You ignored key_gc_timed_out(), which leaves code to a broken state and
> switching workqueue is not solving any possible root cause of anything.
> The long queue exists mostly for the sake of flush_workqueue().
> 
> Please stop sending patches like this in the future.

Makes me wonder was this even tried a single time TBH given the obvious
glitch.  I would bet for no.

Br, Jarkko
