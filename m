Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A607133065D;
	Mon, 15 Jun 2026 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524198; cv=none; b=RhlLwgsMeblo+TTutaSGSjoZUSeDmORUKslKzIAEpeDPm98BJrql3OCKS80ht5ShhS2fbhIda7CX9PVp8mDgq/vvIlIguFnPfbiUgC/u35JYwdvm+zkIx/8wdReS3Z6/l5SRjzrDBF8yS6SOSUrVyIcb/edRwmCNChUTU8Ao4U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524198; c=relaxed/simple;
	bh=OQ5HvODVnmopJa7d4VK6L/T/SWRPhMJ8Xgu5e9hVisc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n3gIMU5KxirBUH69/A/drwbR2eTsrc1mGh0EuNwzmpo/R2Ax2y2BvkmNYJRr1YZg3LFXo4gM+KcaDU9hinGfb3raJ+aCfdnQU60jEj7j/aPLlW6GrqUUnDgSrQO1uNdUgtLLiFoZjbWgFWN4DX43wW5fMSj1z5LK5Q4JzbVF4e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKo1BzUX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKo1BzUX"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BB0661F000E9;
	Mon, 15 Jun 2026 11:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781524197;
	bh=LVL8fBjSIGxZf9QPFsVEA2k93KAySQM8VorbCXzgt1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AKo1BzUXICbzsWUpk8seVrxj/oVw/XFdXBHz6F48colNV+SbuhHAow5LIgRbivHar
	 0XC9mIRZV6KSDF6Bl4EqA0oYKmpRmissTpoHq46NFrAifhgPiNg3r9PW6EyzqE1/el
	 XzxFmENo9gWh4zIqFrnHkj2gDBar6BEDdOEI5GkfCQifgHMZ6zhUqqnFdR2hDDCk3T
	 MooKW64NYjKEnDpHqJd/2n2mHo4hxFuQaB22Z5axrkHTZ6oqoehntFEpJJ8/YkC/Hf
	 uUFCFaAYbuyYEScaTqy4FVqE0dCP9TtkZl2CfUmPNOoj0cc4wbILrwffKu/0cDTuSu
	 /zXIZStx0tt4Q==
Date: Mon, 15 Jun 2026 14:49:53 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Gary Guo <gary@garyguo.net>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: allow request-key path to be configured via Kconfig
Message-ID: <ai_m4RPDpT1N75if@kernel.org>
References: <20260607134928.2832202-1-gary@kernel.org>
 <aiZJ94eugtNHcILD@kernel.org>
 <aiZMT5UYhVDlLVHq@kernel.org>
 <DJ3LJFFPMAOW.QA3EZSAB2S5A@garyguo.net>
 <ailfPUbn8gbUqB1D@kernel.org>
 <DJ5ES5DZ15W8.2KLL7VS1JMQOE@garyguo.net>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJ5ES5DZ15W8.2KLL7VS1JMQOE@garyguo.net>

On Wed, Jun 10, 2026 at 02:37:41PM +0100, Gary Guo wrote:
> On Wed Jun 10, 2026 at 1:57 PM BST, Jarkko Sakkinen wrote:
> > On Mon, Jun 08, 2026 at 11:30:06AM +0100, Gary Guo wrote:
> >> 
> >> This is really just for distros to be able to configure where /sbin is located.
> >> Given usr merge and (some distros) bin/sbin merge, the canonical path of
> >> request-key binary is very likely not /sbin/request-key anymore, so it seems to
> >> make sense to me to allow this to be changed rather than always go through
> >> compatibility symlinks.
> >
> > I doubt there's a huge demand other than NixOS. Just basing this on that
> > no other noise have been made so far.
> 
> Just to add on this, both Fedora and openSUSE for example changes their
> CONFIG_MODPROBE_PATH to be /usr/sbin/modprobe after /usr merge. They still have
> the /sbin -> /usr/sbin symlink available, so it's not like they cannot work with
> /sbin/request-key, but I would think that if the option is available then they
> might switch to use /usr/sbin/request-key, too.
> 
> After all, why would one perform a symlink walk for no reason?
> 
> Best,
> Gary

It's not who is right or who is wrong. "The representation
of the argument" is not working here.

Back to the drawing board...

BR, Jarkko
