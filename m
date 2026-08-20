Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A31D3164C5;
	Thu, 20 Aug 2026 23:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787268496; cv=none; b=rCbj3qgrXKxum+JR/GJ5NIlXZDSRe4WwPFuF0GySIEgOKrf3L8iEkPC5XwjA3dFXVw8OmeyTX6CTjwkvh0tCBYtUg7AzbvJVLF6/lqHp5w03s4msX703TC9xt4Odh4PlJzPlEUiyV7J3EaSf3yZPFD8pc4uh02r6RfhI9HSwdu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787268496; c=relaxed/simple;
	bh=8ELUgFeRV2RayEyxjE3WQkd6h3AZjZdG59vBILZ+4y8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kvBQzmOMsktP/jOD1Qnih+/MRlVw3vXzwxLVM8sD3sA8qB/vR6R1G3Rff3g4LJgLk4uMoqXSs5N5tHjmDevykol3KFaOjdSMYETDVNTxaveOX7stv8hh2FDkXhrcM79G/tDGgvfF8YxIdWhHhiH/w57OBkbDhPdFvTAdb9fyQYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlP1Fw2r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlP1Fw2r"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D5E671F000E9;
	Thu, 20 Aug 2026 23:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787268494;
	bh=ueo5OaFPGhfTyGwAjV1YfDV0WDIqcvzbTgRD6BW63NI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OlP1Fw2ru3IFcDO2zUlekbwtJFce7i6wEf3WyiOXlki1xhpu07lxQT8okHELnHbW5
	 olbEeLbIfP7yhdN0TvEn+v1RvNAg5l6C2lFBg/POUADuEqwCdkfF7nDHloChpa72Ao
	 kitoXlepagHq3WYfx/Xl47zHRBjAwAEz0yjJuGxIdZP9wEZTbgIcRD/bJh9QG4rlFV
	 BCKYkjEawsJ1CAdwlRyo9FspWMQw1XbyqILKih2J7cglz6MhdlSbmjTOle0Ng234eH
	 xJHIiRihJrHMg4JDJcpBcpPCcEjRCrmY3c/INHDqJEngjokhhRUKvZoCpfOW7qSEjL
	 UAKDPBy7tASAA==
Date: Fri, 21 Aug 2026 02:28:10 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: fix lost wakeup when reaping a dead key type
Message-ID: <aoeNilyh183yLH6B@kernel.org>
References: <20260811173753.67616-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811173753.67616-1-kmehltretter@gmail.com>

On Tue, Aug 11, 2026 at 07:37:53PM +0200, Karl Mehltretter wrote:
> key_garbage_collector() clears KEY_GC_REAPING_KEYTYPE and calls
> wake_up_bit() after reaping a dead key type. wake_up_bit() uses a
> lockless waitqueue check and requires a full barrier after the clear.
> 
> The existing smp_mb() is before clear_bit(), so the GC can see an empty
> waitqueue while unregister_key_type() still sees the bit set. The final
> wakeup can then be lost, leaving module unload stuck in wait_on_bit().
> 
> Use clear_and_wake_up_bit(). Its clear_bit_unlock() preserves the
> ordering of the completed GC work, and its smp_mb__after_atomic()
> orders the clear before the waitqueue check.
> 
> Fixes: 0c061b5707ab ("KEYS: Correctly destroy key payloads when their keytype is removed")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>


I think the fix good but it would be good first to have reminder that
while clear_bit() is an atomic operation as respect to the data it
holds, it is an unordered operation [1].

That is sort of the beginning of the story.

So yeah, tweak the commit message a bit and send v2.

[1] https://docs.kernel.org/core-api/wrappers/atomic_bitops.html

BR, Jarkko
