Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C552F25E4;
	Mon,  8 Jun 2026 05:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780896552; cv=none; b=oM9dsMiBagu59LKF6Betv1VDFEGUAJIKQAlg48JmKDSRPfEPo6vxrryknUxPjdMPGnQnAZh+PhA2xWp9BSf0ePi9aVR6gnxu76hcFXDU8R7CdZRZCA2UIf5qI31N2kSEEjr60xexysRDDD+gGzfmlHTb6JMXLtVATITrl8MUPuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780896552; c=relaxed/simple;
	bh=Njzdi/+ZtBVRES6PtwNc6EWHqA5jcorz6wd26u7GtxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLJ7es9Ub86OH//W30ZrRjqxMfgQK0UKAdOdWWRIwv3QWjMagF1jau3ZV4Eb9Of2FCSPxHgtuJXUnTxNkJOWpGFkW8P2Bla4XedJJomPpznx5LHlilkfWJlUMbDOV5xah784KtJMk2zgHJ9yfzv0lJtHxqIufHNUwfH92kh5BNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSTz1Qg8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSTz1Qg8"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CCBEB1F00893;
	Mon,  8 Jun 2026 05:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780896551;
	bh=8PeP5jZLdpJwPFLW/8vIApOv4xt0wtiirz+pu/C5ubw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cSTz1Qg8+D3lzSaT4BHbgQBFhAlcebur5PBRAYFxyqX1g5l04pgqd0omlc/8K2vYz
	 pJliy9lVVbUJdZevGGVBveGRKLiIspYXjLAFBbVspbQsd7v65vhEK9/Gs/ioksxnoM
	 kxplQ3AWabpxe+1SRV3w94mGkdwJH8F82MDidvS28JwqXDj7k9JEDAqGyMDs0pvadK
	 PvjFJCwDL4Ls+/X30FzK4NVTQy2zJpKcoqsDBPxrgB5ykAwpfwpcD1L9Z02rcVsZJH
	 +GMlEGpC0kxTDvGcY14/jG36TnTrRjNlQLLf9AUZE1KpJXVQFvMI+UHGPo4EKrQq7J
	 KgE+6suM64lPw==
Date: Mon, 8 Jun 2026 08:29:07 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Shaomin Chen <eeesssooo020@gmail.com>
Cc: keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH] keys: Pin request_key_auth payload in instantiate paths
Message-ID: <aiZTIzGg_peDVo1M@kernel.org>
References: <20260526024838.3368409-1-eeesssooo020@gmail.com>
 <aiYxqTyfHwrDOTCs@kernel.org>
 <aiYynOxFk3LuK4LA@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiYynOxFk3LuK4LA@kernel.org>

On Mon, Jun 08, 2026 at 06:10:23AM +0300, Jarkko Sakkinen wrote:
> On Mon, Jun 08, 2026 at 06:06:21AM +0300, Jarkko Sakkinen wrote:
> > On Tue, May 26, 2026 at 10:48:38AM +0800, Shaomin Chen wrote:
> > > keyctl_instantiate_key_common() reads request_key_auth from the assumed
> > > auth key before copying an instantiation payload from userspace.  The copy
> > > can fault and sleep.  If the request completes and revokes the auth key in
> > > that window, the auth payload can be detached and freed before the
> > > instantiate path uses it again.
> > > 
> > > A request-key helper reproducer can trigger this race.  One helper child
> > > blocks in KEYCTL_INSTANTIATE_IOV while the original helper instantiates the
> > > requested key and returns.  KASAN then reports a use-after-free from the
> > > stale request_key_auth payload in keyctl_instantiate_key_common().
> > > 
> > > Give request_key_auth payloads a refcount.  Take a payload reference while
> > 
> > Please, name concrete things accurately. I.e. 'usage' in this case. If
> > you have a name, use it instead of obfuscating generalizations.
> > 
> > > authkey->sem stabilizes the payload and revocation state.  Hold that
> > > reference across the instantiate and reject paths.  Drop the auth key
> > > owning reference from revoke and destroy.
> > > 
> > > Reported-by: Shaomin Chen <eeesssooo020@gmail.com>
> > > Closes: https://lore.kernel.org/r/20260519144403.436694-1-eeesssooo020@gmail.com
> > > Signed-off-by: Shaomin Chen <eeesssooo020@gmail.com>
> > > ---
> > >  include/keys/request_key_auth-type.h |  2 ++
> > >  security/keys/internal.h             |  2 ++
> > >  security/keys/keyctl.c               | 24 +++++++++++++++-----
> > >  security/keys/request_key_auth.c     | 33 ++++++++++++++++++++++++++--
> > >  4 files changed, 53 insertions(+), 8 deletions(-)
> > 
> > So first, couple of things.
> > 
> > I'm not going to test not that well documented involving OOT driver.
> 
> Oops, sorry typo. "not that well documented reproducer" :-)
> 
> But it is cool we just then need to draw the picture.

I think I got this:

A: request_key()       B: KEYCTL_INSTANTIATE_IOV
----------------       -------------------------
create auth key
store rka in auth key
wait for helper
                       get auth key
                       load rka from auth key
                       copy user payload
                       sleep on #PF
helper completed
detach and free rka
destroy auth key
                       wake up
                       use rka->target_key
                       **USE-AFTER-FREE**

So nothing really complicated here, is there?
`
BR, Jarkko
