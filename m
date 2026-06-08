Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B233A9E2;
	Mon,  8 Jun 2026 03:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780888226; cv=none; b=ujsJQk356ZU56ud/DqdDChUmBxSnqpOPSUV0IFPLBJmTfWn5dqtHMrbkeFa3WRb9/08Bc+BTZyBzoNsPFURK72qbi6//4zhoewP13wR6m1h/RG4n9p0iDgkJhiRSm/svEPRnEPv7jzsV6dwVri8cqMU1IdkEvy9G5/rK4d9VYpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780888226; c=relaxed/simple;
	bh=314N4xIF/AM3aKGkbqzE1Durjlre7Kfr/a9D1sS+XzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RhldleOyfFM2DnXLyOsWeMw/pzhPwl3jQyuk/Yu5jJIAPrdrafdGfYz42Eqx6NB9MhjkTSjBbLj15fvKYYJGE0fMukIQObsTtG47yjhqKoDIuLRotUsKbTA8T27nfPUjRsr9UKtTTUI4r0/80rvyJD21X0A3estL280IrU0/7xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wp1PH//L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wp1PH//L"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 0379F1F00893;
	Mon,  8 Jun 2026 03:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780888223;
	bh=1QNLvALZ2xHt07Yzqvk61g6MFBIA9nBKDFMWDxQX1xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wp1PH//L38M6cyhYXN/B5NqTgR5HQQsb1sYRekmIQ6aUNcsOlm9LR5U/rixVXFC9N
	 v7IcHsXr6gd/53cLHknEaK4s3XgYcNOYQxisiAaTfe3UWJMCpy/bbHY6dKpMQtxlz3
	 40RMwXCMmVlYhyS6ObfxuPkEDR4bt2dy1RqhfZuObjmWcdP3O8tPyifWhhwwcjEOm/
	 0IPIpYT1Q1o0MKNsv3xGqTH7pnIXZuH0m6gOn3KYVZmm+1k0R0BTwhx0Sb92wI1vgy
	 eWvvKk3ZJVq64efFwzghqxiWzq3vaqVD7OhgSIc3jBRDSMU3wyyo9L4C3qe8s6OmD7
	 jEkW4PLI776cw==
Date: Mon, 8 Jun 2026 06:10:20 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Shaomin Chen <eeesssooo020@gmail.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] keys: Pin request_key_auth payload in instantiate paths
Message-ID: <aiYynOxFk3LuK4LA@kernel.org>
References: <20260526024838.3368409-1-eeesssooo020@gmail.com>
 <aiYxqTyfHwrDOTCs@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiYxqTyfHwrDOTCs@kernel.org>

On Mon, Jun 08, 2026 at 06:06:21AM +0300, Jarkko Sakkinen wrote:
> On Tue, May 26, 2026 at 10:48:38AM +0800, Shaomin Chen wrote:
> > keyctl_instantiate_key_common() reads request_key_auth from the assumed
> > auth key before copying an instantiation payload from userspace.  The copy
> > can fault and sleep.  If the request completes and revokes the auth key in
> > that window, the auth payload can be detached and freed before the
> > instantiate path uses it again.
> > 
> > A request-key helper reproducer can trigger this race.  One helper child
> > blocks in KEYCTL_INSTANTIATE_IOV while the original helper instantiates the
> > requested key and returns.  KASAN then reports a use-after-free from the
> > stale request_key_auth payload in keyctl_instantiate_key_common().
> > 
> > Give request_key_auth payloads a refcount.  Take a payload reference while
> 
> Please, name concrete things accurately. I.e. 'usage' in this case. If
> you have a name, use it instead of obfuscating generalizations.
> 
> > authkey->sem stabilizes the payload and revocation state.  Hold that
> > reference across the instantiate and reject paths.  Drop the auth key
> > owning reference from revoke and destroy.
> > 
> > Reported-by: Shaomin Chen <eeesssooo020@gmail.com>
> > Closes: https://lore.kernel.org/r/20260519144403.436694-1-eeesssooo020@gmail.com
> > Signed-off-by: Shaomin Chen <eeesssooo020@gmail.com>
> > ---
> >  include/keys/request_key_auth-type.h |  2 ++
> >  security/keys/internal.h             |  2 ++
> >  security/keys/keyctl.c               | 24 +++++++++++++++-----
> >  security/keys/request_key_auth.c     | 33 ++++++++++++++++++++++++++--
> >  4 files changed, 53 insertions(+), 8 deletions(-)
> 
> So first, couple of things.
> 
> I'm not going to test not that well documented involving OOT driver.

Oops, sorry typo. "not that well documented reproducer" :-)

But it is cool we just then need to draw the picture.

BR, Jarkko
