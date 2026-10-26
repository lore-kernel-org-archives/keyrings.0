Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792984506;
	b=0wC8+qqhbd8CA/9e3fOlxoq6XBUWd4UtXpIQNERka8E5bZfK+MQ9Or7gfdWNyT6Ip5bZ
	 lD/Xq8VEBU+OuPaO+DRHequ6qaxQH8lyYs/J3+F/uzgE8k1+VYfIjxdHJG9oTVBYZ/cPl
	 oLwDc8CSxVK4bxjKDO9gM7Vf//HjqfzHmsppQj3xCeOhTw5naRHSbfcs/QSkfq1B9khYf
	 wsIHCgC9wbC0MAE0HlFPgO8AXdmjVO7k5Ye5ZGqknF0GscHBZ4qLFS+g0OPzwrJI41nLz
	 cxLGUyxVbmCucELgVYFBIPxpd6Ef9O8fzC2EmmCyxlEYtHJc5e7BS25M1MZE62zwszA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792984506;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=DFKNiPZn/yMuwd98rkS5hZfOJKFxSsBCWKv6y1kml4w=;
	b=rT9YibPvpYDKVBfxXmjldfxgT9nIojqsrgochJvZTZl6KWChEtLFie//WzKc657t68DB
	 mtjmolNS6A97PP8GZuSWF0wOLWSpgHiLRjzdCQODBURtgy1TpQN7mjM4CvbStIo625WIa
	 xUDwIGGG7d6nGDwtGZmYfOIm3Nf8qZfqihBipfTpoVidy1Bju2NytsKKHStisNxDoaho4
	 lhst9OxEIf70HIbyUlsVcKLkRCJ0pPfa0V/KPSKuBRGQbdXAYh3Kxt5ostFDQDEgmfiXa
	 fp7DbA8wy3oop9tZW0lFcepnlJFLdFL4qQ0TEyCjrRnmXeY2BybAc2Xh7pbBuX47B2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFzEcfhR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 070F5606A31D;
	Mon, 26 Oct 2026 03:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dFzEcfhR
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0F57F1F01825;
	Mon, 26 Oct 2026 03:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792984505;
	bh=DFKNiPZn/yMuwd98rkS5hZfOJKFxSsBCWKv6y1kml4w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dFzEcfhRtexQRmLmzlaSbg/AVrJTv7HPZMN5/KU6Vv/3CaOqn9eXICUS32jU46UwP
	 0iZbw6YaXs/lPo2m2YE5zXfind8LMDa31sW/HCrIEBxhS9flxqZTyEMSN3WaYuY0gw
	 nDv+sIwIJV5JlqqEuOdu4IHZ4/nSQj/f9Gmy2Mm9nIsx5eYjWnD11DQ6/Jatmvl4Yq
	 pFLPPF9XrFDkDk6dncayi4WArH7xhxRpWTjgIfd+bdYaxTCYFpbxNCHi5wEboMoWkQ
	 LrnrcwrenFiIhdCXoqkj88NNl9daYVuYpixKTKrxa0Xl4nCgbhF6ChRmeq8OLlU850
	 TdHzk5IvGRxVA==
Date: Mon, 26 Oct 2026 05:15:02 +0200
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
Message-ID: <at7FtiVqFz-ECZY4@kernel.org>
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

Because old code has weird assumptions regardless what code it is, if it
has been for a while using one threading model, so I'm mainly concerned
are there "pinned to a CPU" assumptions in the keyring GC?

Br, Jarkko

