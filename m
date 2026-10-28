Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157344;
	b=KdNQZhFyKF8NBIycXd4t8uoUUwjYIYuyCg/fxwHkqKUuKbLN7PB/dEF7T6XUHnbnxbcR
	 HVNZZ1+ASUQkWJeDjcxFyQhSSV/SXIeJtztyO++t1UShh9A2FiGCAdTNkBmDEwzcj8cIQ
	 eVIYLjmd8ffn9M8+3HWqaTE/FABvjtXR01m1bXO+Z8xZF0Mtzz4wRsdbTpeEuC0uFaocW
	 U9CZipYeu1Cp9zG0Opacz9I8kvoKDQm07E3fU2RvLi8SWg2O7KH61rsFEfj+rDUIgl3m9
	 AOdPsAj0X8704i7OqZPNhvGSO7BYi3jvMnZIeBUWDQDFnHVB0bTafcQbeHrgSSTXNqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157344;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=vL8GmYAurpaxhncV/HncQrdnh5DUf3BHiMGC96xTVM4=;
	b=yX0e9D7mrnh5dToXbvO0fX2GNK6RmHcwV2zVC+qrzT9dPfG5MiTsOzUGD9NOqZJ7wyP5
	 e8QI1PyAYkDcixgD6HkIpUdpG7U64y0VFoRvMZc+0J0MYn3M0uvgncVyY03Ef1OWCcyOW
	 ML3qfawffqbUduC4fHejHz2fr5xK5w7yqtJYgUEbrQmM+rFgdQO4RsDOoVIC2rVqUeQZj
	 ZiB6sZfdxtGpLTG9XNTMFy+AAFOdHO/V3lpjc//R3JDyb9uCc8nZS5/flm/BuyMGVwd+1
	 yvsZxKdCuB4Rgr7OpuaipXxQ73o3xl3x0z9tbBDs+FkMIGYtygBcaxwqLUiNlJKoK2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=klHz1XWg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9DA61606A31E;
	Wed, 28 Oct 2026 03:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=klHz1XWg
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C06051F01828;
	Wed, 28 Oct 2026 03:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793157344;
	bh=vL8GmYAurpaxhncV/HncQrdnh5DUf3BHiMGC96xTVM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=klHz1XWg8sVLF4LIXA3f7p1BZJkBFDGcxjbqgyS63284ldFIkI/j9fw+84Fuv1j6e
	 ngV2QPDaE55ZSpqvDEuG/DdBtrLyaicQZ7ZdgEk7jI9yPogS+aT044zVNBbl4zOjXL
	 r3bqNqZ7V5kbBZB84ljaRi32/BIvrkM/nc3+qRjnqrlDOAa0qbaWYhXLPe/8PA3DdB
	 MqTrSPlYMCxl+6754+/Os4+m+8e1/6CUL4xNKPC36MjrEBtMTLt7+sQHooFNaEE2lX
	 OlD1sxcPUzdkNG3ahSrTDe1SJ+KHozZjJ+DFlS+quzxS3vvwvwAphnXmR5XJMko9KA
	 rE1A7OoupdTsQ==
Date: Wed, 28 Oct 2026 05:15:40 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	"open list:KEYS/KEYRINGS" <keyrings@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] KEYS: key_garbage_collector(): process in chunks
Message-ID: <auFo3KrYXWq3UKmi@kernel.org>
References: <20261028025306.2063007-1-jarkko@kernel.org>
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
In-Reply-To: <20261028025306.2063007-1-jarkko@kernel.org>

On Wed, Oct 28, 2026 at 04:53:04AM +0200, Jarkko Sakkinen wrote:
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
> - x86-64: chunk max: 125 ms, total time increase: 5%
> - aarch64: chunk max: 235 ms, total time increase: 6%
> 
> Tests were performed using a laptop with AMD 4650U (Zen 2 uarch) CPU.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

The big picture here is that e.g., [1] might be a good idea (or might
not) but it would be a mistake to apply the patch before the data flow
overall has some sanity in it.

And with, I think, somewhat pretty modest changes the state has been
put in a nice box :-) Much better shovelling position I'd say.

[1] https://lore.kernel.org/keyrings/20261026031219.2627968-1-jarkko@kernel.org/

Br, Jarkko
