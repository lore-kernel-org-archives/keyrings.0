Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11A754707A;
	Mon,  5 Oct 2026 13:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791205770; cv=none; b=Vsv60BrOXIwe5P9AqzfZQ20S7Wd1xxxE6w7qPCd6ocEWjsC9Vh9CQS/rSMMP0YAYRbCmGGIW1MJ1/wJ2acq3Gmj1V1JZFvkGwHU36hKtcdgoRPEaRey5kFy+fa1ihUECn+tWe2Y5q5tiyXgrbVM63lO9dCg+9VCH5WRDoPj2cS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791205770; c=relaxed/simple;
	bh=H9zE4uvfn8C1W52XUXt7b9IG3lDap5iEdUSer6sY4II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDwRPOxmaEn415T26PhcRPky6Zst7E4cPsnIgRvE92jRlP/GGQ858p2MXrzDxJUtMIebGv3J2CnwEUo6AdmtNAEqs5O1FxOXPRHCwsFuD0lRIA0kdqHkCJsFz1lZXwjt5kIOjUBRhiug/lDN36oba0AgHxYaToRXeHFxR04uMYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com; spf=unknown smtp.mailfrom=hallyn.com; dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b=flXsFurU; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=tempfail smtp.mailfrom=hallyn.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hallyn.com header.i=@hallyn.com header.b="flXsFurU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=hallyn.com; s=mail;
	t=1791205764; bh=H9zE4uvfn8C1W52XUXt7b9IG3lDap5iEdUSer6sY4II=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=flXsFurUJ9ftkBREpduIIKSrgQWqzZkWIlwM5OU3d69/8exUdPpzgDfrBRcg6YQR/
	 MV6LzwU38tKVK17zLuYAZ1JRAaTZteOttOsxrtG7qa2Q2OCsVemxEKWoFC4/Atz1MF
	 slnWeqmqn73TCrRVaCe6xLbncmQadPHIIWPXT8AFB54Vrp7uaDisIDbpzl3fpCeF5M
	 psXkdU2L67RxT2yHTw53Vs7pFdDb/eHQ7h4uTUB7pPoVeJA2sH7b0Ii8Ld7iUsFDwn
	 hrF0ZHFKoXWbpC+rb0/XB3HkqF8WYoBK5F3Dx8R6V801dG74x6St9R8wBHvrL2oK05
	 D8aDtgBzKyauw==
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 7D49A5A9; Mon,  5 Oct 2026 08:09:24 -0500 (CDT)
Date: Mon, 5 Oct 2026 08:09:24 -0500
From: "Serge E. Hallyn" <serge@hallyn.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org, Jann Horn <jannh@google.com>,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>
Subject: Re: [RFC PATCH 0/2] keys: Address lookup_user_key() mutability
Message-ID: <asOhhCION3dwTAo+@hallyn.com>
References: <20260924055521.1981957-1-jarkko@kernel.org>
 <asKSvjz2YLZhFI4t@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asKSvjz2YLZhFI4t@kernel.org>

On Sun, Oct 04, 2026 at 08:54:06PM +0300, Jarkko Sakkinen wrote:
> On Thu, Sep 24, 2026 at 08:55:16AM +0300, Jarkko Sakkinen wrote:
> > The main objective in these patches is to remove to unneeded mutability
> > from key look ups. It does harm and brings no value so it is pretty obvious
> > to me that addressing this harmful behaviour is what we should do.
> > 
> > I based the first patch on what Jann suggested in [1]. Nothing too clever here
> > and I'm ofc open for further suggestions.
> > 
> > [1] https://lore.kernel.org/keyrings/CAG48ez0XjVSR=M--UBauTm8sJuc+ZbhKzaPa3a6wrSVHyoKevw@mail.gmail.com/
> > 
> > Jarkko Sakkinen (2):
> >   keys: Return user session keyring on lookup
> >   keys: Reject keyring creation with overridden credentials
> > 
> >  Documentation/security/keys/core.rst |  7 ++-
> >  security/keys/process_keys.c         | 65 +++++++++++++++-------------
> >  2 files changed, 40 insertions(+), 32 deletions(-)
> > 
> > --
> > 2.47.3
> > 
> 
> So.. should I move forward to with non-RFC v2?

Patch 2 absolutely makes sense, "doc, it hurts when I do this", "don't do
that then."

Regarding patch 1, that seems like quite a change in behavior, right?  I
don't see any docs or comments that promise the current behavior, but
has any userspace or subsystem come to depend on it?  I guess that, if so,
then it just has to create a link to the user session keyring like pam
(according to what I've read) does?

> Note that some tags (e.g., Fixes) are missing simply because this is RFC.
> 
> Br, Jarkko
