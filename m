Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793151344;
	b=CxuPl1NCHns7ZHZBChj72jXScEoRjQr4LaEA6FLD0yZvD41P2NQROIJLn3VQ1iEyKL0n
	 6gKfEGDfm0jOfmGNcbMLwoGCBf9HXv0mN5qxwPY+RvKpXMPfO/kEpdX2+oHG9LlOJRlf2
	 6DbtK4hUJNpeI3TwZFFP48d53pW5N/EP6rAwZxAesJcShR2Zrqexc0aXvrS8azUMpSj9z
	 ubbNXMA8SlgCsv3pvqkq7kDhhQf1RRdz//mSvUNB28pn1mInIdzt9pn1XwH9AOtIAebW3
	 685dogV/QMx5qHIQcH/H5Z7W1Vv5UcGHp44EqGsEboDSzzo1k2fOV7/9634ghf8Qq1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793151344;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tQBZEHxuD5qcpCA8fr6zvVVPbiVqCdDvWzSVmZ08A/0=;
	b=U1+1s2ffaJEOFI6/dB8TwuN+kvNIHUi1z73j5ar1wQlqW9rhRmtxqywVtYOwiEsK3lm0
	 OTtnPc+Yn5q0uEOdsnI0irvj8czyjtKl7+zR2K4fIeVdRWMakBH0NtVJHQIcIDb1GetWC
	 NC7WqJ1xyUNxIQMOGi7zGAFdvwt98YsVRmC62S9vC3eVycp2zj25XM7w3itWdtgPJokjy
	 M24beM1kn1uync7Y26Fu+dyKlRda5cCD8u8qMnfQLptw2gDHhmdI/u90lXn+bS4/OfWXD
	 yB6NVuKQcWyRbJMH/fUifNDqBX3CFBBHwWXr3W0PePTAphv9g2w/EEyo/b+cmpegcAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F2O/MnQN";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 61499606A31E;
	Wed, 28 Oct 2026 01:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F2O/MnQN
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 256A81F01825;
	Wed, 28 Oct 2026 01:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793151343;
	bh=tQBZEHxuD5qcpCA8fr6zvVVPbiVqCdDvWzSVmZ08A/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=F2O/MnQNWAObumJnuz7lVenqSjM8YqFNGg+T4xZQypdTVALgC7UAa6KnCuXMKSbOU
	 AIt2xR90O2aG+D7Ez25CySgccIvpJGL/dewUzJdMnRnZsI4fUT5P0w/kj3Y1wDcNtv
	 ZyzWUm5y/cFNKsqF/hM1JRSE/FCeAywLTC5+9S7oqqnCR4fGfEEQ8lYeVbXGkk07gi
	 jB+GF3ThUQRekbUQRf2Kj6HNghAo71lMcwgqqMQKhxZxo7j8tzOAadx9tBoddmZg46
	 9CJrhgYCJ+Lr9L5iQWaOesb1HcXXCFGtw+XtC9skLhIop2RnqJFLJGZueox6NbGr2u
	 0KGuFVjw4oKkA==
Date: Wed, 28 Oct 2026 03:35:39 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: key_garbage_collector(): process in chunks
Message-ID: <auFRayCXdvaZYH9R@kernel.org>
References: <20261027235820.2002072-1-jarkko@kernel.org>
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
In-Reply-To: <20261027235820.2002072-1-jarkko@kernel.org>

On Wed, Oct 28, 2026 at 01:58:19AM +0200, Jarkko Sakkinen wrote:
> key_garbage_collector() has a design that is not resistant enough for
> workqueue lockups. The duration scales up relative to the number of items
> in the serial tree, which causes a reoccuring theme of being guilty of
> causing workqueue lockups.
> 
> Resolve the problem by processing in chunks:
> 
> 1. Declare a static variable key_gc_work, which owns the garbage collection
>    in-flight state, and key_schedule_gc_work() for re-scheduling the work.
> 2. Define KEY_GC_CHUNK_SIZE, set to 1024 keys, as the bound for the number
>    of items scanned and destroyed.
> 3. Define KEY_GC_DESTROYING to mark resume to destruction without repeating
>    the RCU grace period. Drain the graveyard before advancing key-type
>    reaping.
> 4. Define KEY_GC_REAP_REQUESTED for preserving full-pass requests across
>    the continuations.
> 
> The following test was performed:
> 
> 1. Add 499995 "unused" keys.
> 2. Add 499994 "expiring" keys i.e., keys with expiration times.
> 3. Clear the first keyring.
> 4. Wait for the timeouts expire from the second.
> 
> When tested with QEMU using x86-64 and aarch64 (emulated) architectures the
> elapsed the results were the following:
> 
> - x86-64: chunk max: 125 ms, total increase: 5%
> - aarch64: chunk max: 235 ms, total increase: 6%
> 
> Tests were performed using a laptop with AMD 4650U Zen 2 archtitecture CPU.
							   ~~~~~~~~~~~~~
							   architecture

> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko: https://sashiko.dev/#/patchset/20261027235820.2002072-1-jarkko%40kernel.org

Br, Jarkko
