Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792820262;
	b=amolFWcPhI0rNN3xt1xvxT8VOIrAnM1Pr5syWy+r09/Zf6sj6zsJkSnUd9UL+5dnIyf5
	 6NTtvnQD9ikmP2fVw41pRE8gSkDjp5zGtntmHTXbmA7pawDSRYgrD/3qaeAyvESTB68zc
	 vOW+jtcE5Nyyvr5o62SxYeJeBMn2qAobu3ZIV65x3Dfv1mwXq0Maqr9ajXKxFS2ybtkXs
	 vjhR9jNlTpHWaDFmQvDGIcc9aOI/oot3hXa3cCYBCf1AT3oLSlKWATyyvIeEIO5oxWjd9
	 j8PnT8+mvgjNMdwmTnExQqazK1DhqbPEVyPhOZownaORBS5T8y7oEeOwzLguxVBy5BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792820262;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=+U0qwNJO/TPKFg6WnxMQirMDZfxpuXdJH0s+8t30zPo=;
	b=OeIYv4Qd0psb6B3aw8uevqOjCcDWEiEPIlnHrWVC6BXveePrYNVAJC+hDwEDqkPB50aJ
	 5Mtlc3v/T8irm128Z14kVfGhavAkgGP5OnJUiC1WfeO9X1wyFkJc/W4vljLm1WDpTJ0bu
	 zxbxbBA5KJEeSzwcV8+q1392ExQKDjDxyF+k/A9q4PAVwHpT94VOcSiNNqAsd4P8px2bZ
	 CAl0WncZpRyEZQuGMZ7tCWuKe4VyLCqi/vduFmmhrkCS8zQY782A4FAQ6ci67tahYg+YX
	 jSxMuS5FhIveRcc/3SZ1LtDADEdtWTfllg5EAJ9+oWMdI38tYAtBzvnJmU47Vol33Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EssRatyK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E0E0D606A31D;
	Sat, 24 Oct 2026 05:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EssRatyK
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 4C5871F01828;
	Sat, 24 Oct 2026 05:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792820261;
	bh=+U0qwNJO/TPKFg6WnxMQirMDZfxpuXdJH0s+8t30zPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EssRatyKoT3GPSbW8NwJcixfEfMV6TtTBlg6cQeH8ehJNCkuJDPtJNIJCa6mmirtk
	 jMjoynqD46LmIWHeH9u4QC+i6DjUDDUF6NDBZkwjVssUeFTl1rxSG9r6c2LpUEwFJG
	 gY7OQE4s/CPCTtUP/SwbF1GyaGQUbnEEcnoRgfK6mPoF5w+Sf3f/8kiq2OcIG3Ot/T
	 6tPb8W5+iacOBS4L9MdlUKiRtkivrx14gcoKD8nVrEp4jeeRxHSuuMV7OPTlcQj4JM
	 23oRbCwFn+4Q8+l8ylQvAjGJPKhZPPebRJNU/vvD1RyZy6Xnf4ZgVyhQAJzDb27cwZ
	 10ZHyBTdXvLnA==
Date: Sat, 24 Oct 2026 08:37:38 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eduard Zateev <hackerowskiy@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] keys: use long workqueue for garbage collection
Message-ID: <atxEIlD8yeW30Nwr@kernel.org>
References: <20261024042944.52493-1-hackerowskiy@gmail.com>
 <atxAM9JW6oi2MEeT@kernel.org>
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
In-Reply-To: <atxAM9JW6oi2MEeT@kernel.org>

On Sat, Oct 24, 2026 at 08:20:55AM +0300, Jarkko Sakkinen wrote:
> On Sat, Oct 24, 2026 at 06:29:44AM +0200, Eduard Zateev wrote:
> > The key garbage collector can wait for RCU grace periods. This can occupy a
> > normal events worker for a long time and contribute to workqueue lockups.
> > 
> > Queue key GC on system_long_wq because its work may wait for long periods.
> > 
> > Reported-by: syzbot+c15de43f1e7fffbb7b9b@syzkaller.appspotmail.com
> > Link: https://syzkaller.appspot.com/bug?extid=c15de43f1e7fffbb7b9b
> > Signed-off-by: Eduard Zateev <hackerowskiy@gmail.com>
> 
> This commit message is not huge selling point for any possible argument.

You ignored key_gc_timed_out(), which leaves code to a broken state and
switching workqueue is not solving any possible root cause of anything.
The long queue exists mostly for the sake of flush_workqueue().

Please stop sending patches like this in the future.

Br, Jarkko
