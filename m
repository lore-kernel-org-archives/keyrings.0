Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ED73403F3;
	Sat, 30 May 2026 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780159802; cv=none; b=Vde+VfxIKV0UgjK5kkJwghFQNNcjDEbA26U/WEbXbYyoib9DrB3SESAhiDaExl7ivSzVg26/VFpTUkxN9Cn+Wa3qb3VqPogCRB3Mx+rrscltLcxYp0RfutP7d7R+EsSxO7pEnoWHFm3e5DsX1oJXM7e8hynKDsi9Y/lwZc8Sqx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780159802; c=relaxed/simple;
	bh=Q35NdZAHjibDUz+rFjEf0Ewd/FS1poKk1d0BIkHPbhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ov0DuKPNvgUVfTd8t7F7aAmX/GHEhQG6fSE145V1sfJHPHaAitH4r3Ebvzf8fdrH4w88iLI1gGXkHJlU2wc9M73pDGtoQS8tQVrIlPJoy5QfpdOP/wcPwB86A8tx4SATLar3hpaB4aSeV5xq3eBWFdWUZlMRMWYBKB8MpjhZZuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvJ3sdMr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvJ3sdMr"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9477B1F00893;
	Sat, 30 May 2026 16:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780159801;
	bh=3CXecMsFkZJJq8+uxTkg+IW89ROBmVKejn90ygC9KyU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VvJ3sdMrkEZaRcdAx22nVsv5Cy90K6UXq1lN3KeZT835wI1TONLwbho6Z2fdjZ8Dy
	 PUhysIJGGeA6c+SNbpXO6BbKRbg/lhSOj0qga74b5cl3gZ97AMSfvMfbLQhamrvp8J
	 s9pa66kA5akZJOrkfZ375PGX6rbnFljjviE9q2+EPxpTrbf07OcR04Iys6nLKCHEam
	 wc/V7yIGWFyY9Ldh8OMkxE9M4xn9FIawpo5fw67J31LpLXpFTS/80TJ1dj4sXGvYwY
	 VXMyYuG8Th1Kidpgk1GHupw9WHf+jatrNv6/YT37ODkSsleLY/r81xq46Qhc3bm5ut
	 c7xXydCgRZg8g==
Date: Sat, 30 May 2026 19:49:57 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: eee sss <eeesssooo020@gmail.com>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] keys: Pin request_key_auth payload in instantiate paths
Message-ID: <ahsVNQgmKuTeaAZH@kernel.org>
References: <20260526024838.3368409-1-eeesssooo020@gmail.com>
 <ahoY3mRUf5cF-tr3@kernel.org>
 <CA+TOyfhe=0Ty-FQDZy-9_LWJ6dgakzyjog5rNfQ2NdCc5X+dFQ@mail.gmail.com>
 <ahsUxQryCvPggKBt@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahsUxQryCvPggKBt@kernel.org>

On Sat, May 30, 2026 at 07:48:10PM +0300, Jarkko Sakkinen wrote:
> On Sat, May 30, 2026 at 09:19:33AM -0700, eee sss wrote:
> > Hi Jarkko,
> > 
> > Yes, I have a reproducer available as a tar.gz file.
> > 
> > I am not attaching it directly here because I am not sure what the preferred
> > way is to share a tar.gz reproducer in this mail context, especially with
> > mailing lists on Cc. Please let me know whether you would prefer a direct
> > attachment, a private upload location, encrypted transfer, or another channel.
> > 
> > BR,
> > Shaomin
> 
> Drop it to me as private! I actually have now queue of total three
> reproducers but I'll get to this sometime next week :-) Lots of stuff
> apparently happening in sec.

polite request: it is advicable to use plain text in. It's not just me
whining but also sometimes some ML servers simply drop HTML mail i.e.
only non-ML recipients will get it. Just something to be aware of that's
all.

BR, Jarkko

