Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286A49BB5A;
	Fri, 16 Oct 2026 22:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792189662; cv=none; b=flNFFWqKw2j0AlN9xZ29g4DT0MkDdcgPG4Q7pdz5gYGg+QMevkXjLVEXsPhqNmwUsM8+mljIyld8/i8NcxCXfGAzmD6jEsjlsQRHBMBHwW5JevBxQ7ElgoWjxpE51kATnXnPrZXUueAwHkKbjFeADoNrSdsGGMSv4o/DNh5p9/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792189662; c=relaxed/simple;
	bh=KvRqbGiJODWvSveA75SM9Tl0ng2HLqgKBo81fFBl4bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ciCroabb306GIY2ZCYC7X7PMCP+wZfsRd/yFsl8JtHknnKR+LHnhTdseDJo+pKcXp49rbZXNrvwdc1XkACwYr3dJpYRsyCNcT0VD5mpI5QxX/jQtZ54GqWBTYDMG6+qN3YA2e12Y24TDH6f1/iGJ1usb/sNQHlfaVF2baZ0lQMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gifN0ONY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gifN0ONY"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BCBFF1F000C4;
	Fri, 16 Oct 2026 22:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792189660;
	bh=e2syvwN5/w2tvL/mGWWR3p7LIcfvkVdT3OK7zkpB4Zo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gifN0ONYg06fLbh6AmrU5rEfTaQaoZjrMi4ifkGsKz0AZIlWE/QNf1dU7xHjSUErf
	 OmL8J7M8n7NHxcJAO2+hm6mvfzmpUwjXIo+ox4LJTaL8gFgTZB0skCNBaYC62vx9F+
	 ajNkTqLNkFMo0gkDMueVi7a3ep38G2+02ZSsbCixE4SQhIMSKMLRsZeD5yao0rF0wW
	 behvI57AsklbI0KEQaH5gxvZzNBX7LBzS130AtiMCtwwmK9WeP5tBRH+ZCWy/Ey+/b
	 EGuC/xKD1Kuj5uH8+3cr4+dED4HKTTYj7Rr4N3QKTeUeymJ9s5mYPszgM794bTQvcT
	 eigSQxx62p3fQ==
Date: Sat, 17 Oct 2026 01:27:36 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH 5/6] KEYS: Replace assoc_array with struct
 keyring_index
Message-ID: <atKk2IZxEQh3AEtP@kernel.org>
References: <20261016215326.4110064-1-jarkko@kernel.org>
 <20261016215326.4110064-6-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016215326.4110064-6-jarkko@kernel.org>

On Sat, Oct 17, 2026 at 12:53:03AM +0300, Jarkko Sakkinen wrote:
> -/*
> - * Finish unlinking a key from to a keyring.
> - */
> -static void __key_unlink_end(struct key *keyring,
> -			     struct key *key,
> -			     struct assoc_array_edit *edit)
> -	__releases(&keyring->sem)
> -{
> -	if (edit)
> -		assoc_array_cancel_edit(edit);
> -	up_write(&keyring->sem);
> -}
> -

This is the part that I'm particularly happy about because it would be
nice if teardown type of operations would not allocate new resources.
And it is also incompatible with OOM handler expectations, if not 
formal, at least intuitive.

Br, Jarkko
