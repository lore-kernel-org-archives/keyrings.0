Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268E14B9207;
	Sun, 18 Oct 2026 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792336343; cv=none; b=qLBxwltINfpE30xCZ8muW70YQ0uSKW/sdFD3TvTDjA666x2M+jM6W9l7gDy9AvPtenpdQrYiZtB87OZ1HWoKGYexb3dmbrvnOlsG5D6eN0WylpYG6ptFa2fbWihFukVuzpbiKPYKaJzu7a7gdQNu8Q7EboGzx9Wrk7kQUh96CB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792336343; c=relaxed/simple;
	bh=aTcXQyd0bfz95derB+41v5Ozer2CHkbGPRkY2mCVeng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFMc/31jj99b0XJwas8pzo6snsddofAEGDsc7RC6F0S1U3Xo81OTmyG4aOlv9hQKfkZgn8byfdrnGlBr98G3w1zc+Ai/ZTrAo7WGv1FrR8Jgt3dZq1LH1XcoLX3NYz7aWui/ATXAiZVe7hDAqLy9yb3cxmPs9OidQoGSPxLP4xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l8CaPk86; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l8CaPk86"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6D3EA1F000C5;
	Sun, 18 Oct 2026 15:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792336342;
	bh=Ef9StHJmTMw6s7hUX1qnYXGCHmMwlyAMJhgpQkKkpAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=l8CaPk86NsRSnM7qq96DvUcDDBvOfa78ogrdfgZpHZnOLCde5dhuowKVS+/FZdOH+
	 s2P08pIjbDQzv2nYHYsCB4zDzp3+hYUDi2spKooYyo49xnxapA+ymKTTjie4244uZf
	 JFq2uXNz/5V3kG9TQcvlSXhm5v6XAHVwFm/DBmZuGymqxjhywYYdDDcxSjgrGRkI2t
	 YmZJFrmI0H73IO7Kja8BilDTVbfneOejqPl0/WpIJkECfj2EVCMYiW9rO1OktRJmOE
	 toNdjWx7W3Z3xk9lz4e2xgFLYIrsDZRKTUg/J9uXn2KjwvkRGSsaF9DmTQpGaqNYfH
	 ROXvUkQlokTAA==
Date: Sun, 18 Oct 2026 18:12:18 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH 5/6] KEYS: Replace assoc_array with struct
 keyring_index
Message-ID: <atTh0jMiOhk-rF3L@kernel.org>
References: <20261016215326.4110064-1-jarkko@kernel.org>
 <20261016215326.4110064-6-jarkko@kernel.org>
 <20261018070822.GA1904@sol>
 <atThQG91lL9CLW3H@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atThQG91lL9CLW3H@kernel.org>

On Sun, Oct 18, 2026 at 06:09:56PM +0300, Jarkko Sakkinen wrote:
> > 
> > - Eric
> 
> 
> Hey, this was very useful, thanks. I've already polished the patch where
> I see low-hanging fruit. I've split the bug fixes perhaps a bit over the
> top because I've noticed that unchecked LLM bug fixes are surpsingly
> often not that great. They are often short circuited to the nearest 
> surface, instead of thinking the overall vector.
> 
> I go all comments through that are added or modified. Especially with
> LLM originated code it is a one place to do a sanity check for yourself
> whether you are actually reading the code or not.
> 
> LLMs feel in kernel development more like a power tool than an
> assistant. I can make big holes fast but that does not take care of the
> "precission work".

Right the patch lacks your suggested-by :-) I'll add it. It was
actually unintentionally forgotten.

Br, Jarkko
