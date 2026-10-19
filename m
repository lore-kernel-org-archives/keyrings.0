Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792446638;
	b=c5srcP3HP/JspdgbQjbyFQqR80omoNAgCV9gu3okrKMOP8TLAkWefctMWKXYRyY0/9py
	 UdH+lp6CoAHCkya3RBZhRb0spUmyBjN3NzME9ItVitGjqe9C+wgP6OLEa397+7AMBO3sf
	 KEZp+o4y/KrOwZ8AHWzngUhz1tBDSvkisnLC8Kl3k4FAA2xWnshmH9GDFuV2X0gEFAS1c
	 KvjaOCtFuh70dKg4RlF1YA8+5RNIUTYDyCJlz7alzeqMAlD7etYAFV9mtpEOm84F9ZHxJ
	 mebZ09r2cPSXiyOfNAD6C/VBSik7hddw6Qib7HwSlP97fxZMSkils06kem0e/sI5dOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792446638;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=9wRdjv0wMNosrnlf6MW1BRBfYfgIR3bLc7ooPSPmATg=;
	b=qMpZAmSpZiU+Fk8y3eKZf7QJT6p0u06zC+GZAArkTFc18bPm0FjpKRiqFV3YUJraP0vY
	 xC9D7C+DRSe2lQRlLMhK3wdZFrLCi+2iy5YATzQGqq0Zzn8hVCqSA1O5zgXZLeR+C0J0h
	 KiH57ObcncClPyGM4N3qW7f45/clWBpzQBqt/mDwvDXpJuDsiCZfZRh5PpCWswOsAuZVA
	 DnfQjwB46vJ9wxEFId+7Iv3Ts7eZdRQYxJCyFYmciIHFAtUroAlNff8fWUFz66L95/d+P
	 W+PoBFJ4xHgewnSO+SuQv1Sd6+N77m5OxVolSKMuyFgeVnpPlTjdddsCld0VyFTJ2Ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lbd+6kjk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id DA353606A319;
	Mon, 19 Oct 2026 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lbd+6kjk
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E77301F000C5;
	Mon, 19 Oct 2026 21:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792446637;
	bh=9wRdjv0wMNosrnlf6MW1BRBfYfgIR3bLc7ooPSPmATg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lbd+6kjk5noL/yNPdTnfxPBFTi1dI0e5vL0bOfPHwcx9/Yjt+ouzTg8zSFz1BbdN0
	 wm/6mTcBLj2gDpuTP8PEoMEJdvrzQWuXkQfODIbY0YAxA1jIhFN9/r7/C3mr1Y+Mrc
	 O3+LfiuY+dgmgiVlr7vw/MEUpB54buc6brWdqF7NAUYjMX1t10tdx11Psf6KdU/dIj
	 rYdkainDbQHW5RAupyqzVXfdJcnp/G7BGe1FCDmxUgw6G1ddglgvoFzouRthNURPTg
	 yuKQLi6dqslKrRB/Gj6VCzhqy34XxTJquK7NChKeSWf5uFmB3AdaaEKYQrdb1lS6bW
	 BwM0gtQI+/qZw==
Date: Tue, 20 Oct 2026 00:50:33 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Jani Nikula <jani.nikula@intel.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH 6/6] lib: Remove unused assoc_array
Message-ID: <ataQqa4f9XAJQoYO@kernel.org>
References: <20261016215326.4110064-7-jarkko@kernel.org>
 <20261016215326.4110064-1-jarkko@kernel.org>
 <2630215.1792446401@warthog.procyon.org.uk>
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
In-Reply-To: <2630215.1792446401@warthog.procyon.org.uk>

On Mon, Oct 19, 2026 at 10:46:41PM +0100, David Howells wrote:
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > Drop the obsolete leaf-count reference from a dm-verity test comment.
> 
> This might need reworking as a commit message...

Agreed.

> 
> David
> 

Br, Jarkko
