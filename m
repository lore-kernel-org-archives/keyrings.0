Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E191F4315F;
	Tue, 28 Jul 2026 00:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785199769; cv=none; b=FnS3PsiV1OMnTGTL2wgr/+2IrkIkUG4TF3U0Qw3KGkgkDIM9HjhU7PSDbUmpGMrUGV0rIL+m8jaF8cUxCRcukdaZJGZHIlmfAhywBRVR7M9zuMb1HMD8iSU4DkfkvPK8YDFvdW74fltRbJMefbaNDXFvb84dTIfIqzpjwe26/9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785199769; c=relaxed/simple;
	bh=oosCYnWmgxePIEDtXyTh5syo7EBriO/jeMARD3FOfLo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ha8vqAKBTBaPE4bDIKb0cn4W/Yv1gsr7sxo0VQqcQ3jUUazAc+kVkYJ9Z+R+5IXDmsOlMOR/IUML5ZlROxl0qmP4fzNmA029Zq/oZNIEc6b8ydPgx6LUGHEcH/CA50JO2BiulnwDemxwcYBhweu/2o65dQYBDIBm/SUAwdHoDHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6MjoW8M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6MjoW8M"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F32801F000E9;
	Tue, 28 Jul 2026 00:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785199768;
	bh=wxJnO2GzK/YoQZOo68Xxpxxn7Y7qqH1kzHEmE92su40=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O6MjoW8M7NUKyJGjoqmFNnb2LJT7rAzFKSSH37N1z7qFBwLOhjFbyDpBQPgJfjjBK
	 6bpETEkQuNmZawKd5w+Ikq7UE0T/T4seu/h9DK8ZTAQ8AvHiI/msCOTlLdWUWGrY3/
	 DVfNWnestp/uqjJXI7280p6SJHjoTkCxYTE4KyFf69IqhcCBCPftA2atDMbRs1toch
	 EC2tXOUEzXr+2+0JVV/MSD+izMlCA2ucOtkGoyWaBLBg5VzhncT7+IXG2FjEa0obdw
	 t5oGMEEc+iSTjSzoxMwrHNBkz2XEm2+jo4Fqaa57jZ0kL7F3lzxXTw0ZTjqJpZqibf
	 6WxVvK+aDV4OQ==
Date: Tue, 28 Jul 2026 03:49:24 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Howells <dhowells@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	Fabrice Derepas <fabrice.derepas@canonical.com>,
	Michael Bommarito <michael.bommarito@gmail.com>
Subject: Re: [GIT PULL] KEYS: for-next-keys-7.2-rc6
Message-ID: <amf8lG0-TnummN5Q@kernel.org>
References: <amenZnA_QgqwMNeC@kernel.org>
 <CAHk-=wj9JjzWfnoscfj7xg5NrHswXtU+sjZjrO4kcnwE_ET3Wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj9JjzWfnoscfj7xg5NrHswXtU+sjZjrO4kcnwE_ET3Wg@mail.gmail.com>

On Mon, Jul 27, 2026 at 02:22:47PM -0700, Linus Torvalds wrote:
> On Mon, 27 Jul 2026 at 11:46, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> > This pull request contains bug fixes discussed in [1] and two fixes
> > (in one commit) from Fabrice for DCP trusted keys backend..
> 
> Please don't explain commits with links. The commit log is supposed to
> be legible without a network connection. Links are ok as supplements
> and background information, but not as a "this is explained by link".
> 
> And the pull request is supposed to have what I can useas that commit
> log (either in the email or in the tag). Yes, I edit things for
> clarity and consistency, but I don't want to follow links and try to
> figure out what some discussion was all about.
> 
> So please give me an explanation for what you are asking me to pull.
> Both so that I see what I'm pulling, and so that I'll have a merge
> message explaining things for later.
> 
> I've done this myself this time, but please make your pull requests
> legible in the future. The patch series you merged even had a cover
> letter, please keep track of these things and don't make people search
> for them.
> 
>              Linus

I'll keep this is mind and yeah, get the frustration with this.

BR, Jarkko
