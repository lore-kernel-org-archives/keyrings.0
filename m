Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323B8582781;
	Mon, 19 Oct 2026 14:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792420441; cv=none; b=irKWnNZ3Z2Ur4Adl1TAGp7rXmi14MzrSNO8IbezK5VKPxE9q+py8ceMvFKDwv8957Acktd1RDMFXh1oxCYg6UfYV5lXvZynLtI1C1o992XgOEx1fZwXcEFuXk1Xw6gGyqhmElpQKDqXbOT9Or1WXKx1g26lqxeasUAfKDQQR+Fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792420441; c=relaxed/simple;
	bh=IOL7wJtEx3AfiZsM8M2Us2AyLmTm2xVU6vZzN8+7my0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmQKhbGnlSTseIV0mTSpHYrP3A4rU60iryanJ52jfQmCxe4prJinoJO62Gw8Ex5YHbgVRz9Uo6J/AtrTxXSm0LQaNUw6SczL5Tjgcx6RjcgPWQRwnCofsNFnrNLxeMLEJga/yzk1/uXuFJMcYNjmZ0S/BysKMyPog9GRr+36bGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hALJynfT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hALJynfT"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 54C2B1F000C4;
	Mon, 19 Oct 2026 14:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792420439;
	bh=hDEkNsOTWRCGCSeVEmLAlJqwm4BUgukeVWe+6mEaM4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hALJynfTmJ2YccCVjcEb7hQ5TPA8lK2OkAc/7SyZHXOq8pHw36MMWPfS8FIbCT7bp
	 QqnhY8DKIYqKUnWq6AdUHcRNQRxTFjFxcx8mlAKztiEWp62xwbWSFe2hIzatNQN/FI
	 gUWGld2ZlWpby1NRhbSo0IDaEohdBE31awo27Pk1piFAH27ujGpX4ADARleTA9enH+
	 95EPyyVZYmK0AzsW5PFS5gHvNi/iJCGNqzGVH/9+fM42uGTLGBoe8Pe/WqpwVVceJn
	 RgCcJlkW0kGHEJlPaQec1sVmqq3FALOTa/3G0DpGVOY+3sJMMwUuYBLaKekylCI3cH
	 3YGXvisG9Cl/Q==
Date: Mon, 19 Oct 2026 17:33:56 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/8] KEYS: rhashtable bug fixes
Message-ID: <atYqVKhU8N5R1gnE@kernel.org>
References: <20261019142516.300040-1-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261019142516.300040-1-jarkko@kernel.org>

On Mon, Oct 19, 2026 at 05:25:00PM +0300, Jarkko Sakkinen wrote:
> My patch set that migrates assoc_array to rhashtable had some LLM
> scavegend bug fixes. Unfortunately most them where either plain wrong or
> not in the right scope. The bug fixes in this patch set are by human
> labour constructed fully but they are derived from what I got out of the
> original LLM source. Thus, they are tagged as LLM assisted.

I like to document any possible LLM association mostly for
self-reflection. I'm still adapting and not fully comfortable
with every detail so this gives a chance to look back and
learn how to do things better in the future.

So I'm neither supporter or desupporter of LLMs but more
like representing the "I don't know what to think about this"
camp :-)

Somewhat fuzzy opinion I have that more guards and checks
should be set to the patch submission process to address
"proxy contributors". At high rate such fixes are right
bug but wrong fix type of situations where author is
really not an author but instead a reporter. This is both
time consuming and unfair for legit contributors.

> 
> Jarkko Sakkinen (8):
>   KEYS: Change the type of key->quotalen to unsigned int
>   KEYS: Change the type of key->datalen to unsigned int
>   KEYS: Reject @desclen values over U16_MAX in key_alloc()
>   KEYS: Prevent overflow of user->qnkeys in key_alloc()
>   KEYS: Prevent overflow of quota in key_alloc()
>   KEYS: Prevent overflow of user->qnbytes in key_alloc()
>   KEYS: Reject @datalen values over INT_MAX
>   KEYS: Verify the key identity in __keyctl_unlink
> 
>  include/linux/key.h     |  4 ++--
>  security/keys/key.c     | 13 ++++++++++++-
>  security/keys/keyring.c |  6 ++++++
>  3 files changed, 20 insertions(+), 3 deletions(-)
> 
> --
> 2.47.3
> 

Br, Jarkko
