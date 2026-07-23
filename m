Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428C74963A4;
	Thu, 23 Jul 2026 12:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784811220; cv=none; b=QNuMqtmH6vdu1iDjujXeuryDnSJAnLo+E1kDPDyGV9UaWW1U0b3jWnNXApThPTThetKWwGOfw0qstFurSKso3dpE9YcjAFHGzIGp4i/aEq/egoejupz6LGDxyPNOX5o3pdpvgl8tbhqoTJzALUSe+BB+bS5mktOt2cQSWKZyUkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784811220; c=relaxed/simple;
	bh=oc2M6EYcVNUIkpD5iWq+sL6dRZQbf9v7RACQ+Cpi+bk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sdkR6lefVLfzzn4xA/5osU9reMBHEE+1uYrS+Gtf3TiTWMXsM3HZlPgLrnEoHvzwNuhH9PE02ArnKuZEcjgqO2cyiqxfeo2PWeSk/g4TxgrbYSb/qTa9QhhhNwgg8RvwMwcr558mj+09F/KMwM2jRdTGWMruXyN5/ZJsKKpOg7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iW0prEAx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iW0prEAx"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E66AE1F000E9;
	Thu, 23 Jul 2026 12:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784811218;
	bh=FWy5ucjv4A0eiSCew/Vs5Y37WJdHkdrTE/oLjfj5Y00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iW0prEAxxChy47+D14/Uq0wuJA0EaiU0z1/8GkzP+oo6YxEUTUEvU6GCfBQLX7YGw
	 P70FMWHcZ90pnzXIULPZ6dKKGJQsg8UtZS0CA0h+XqAf05uXIZWZvPu3RAHrF9p1Zr
	 15R34yFx+iWa/o9cs+nlFDkPmUnSST+a2oIj/fpsu8K7s/ouiEzMSmsRSGT5KLq3vy
	 bcyI0WIa232cyIBh0KFlbUYknvl3ZzXYVplPDULKJezDErT95RlUKira4wACLNlUGI
	 T1Alpel8TVKpiVUlJcdd5ELDeI6WQ1TuVEPP/5+9vjFeM4DEZSH9PyNfp61ozCQDYl
	 F51FZ9qzqOG/g==
Date: Thu, 23 Jul 2026 15:53:33 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linuxfoundation.org>
Subject: Re: [PATCH v3 0/3] keys: fix keyring assoc-array out-of-bounds read
 and index inconsistency
Message-ID: <amINZJVhEBwxEixP@kernel.org>
References: <20260719161505.2423935-1-michael.bommarito@gmail.com>
 <amDiI4jc6fsbUK_X@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amDiI4jc6fsbUK_X@kernel.org>

On Wed, Jul 22, 2026 at 06:30:43PM +0300, Jarkko Sakkinen wrote:
> On Sun, Jul 19, 2026 at 12:15:02PM -0400, Michael Bommarito wrote:
> > An unprivileged keyring whose keys collide through the description-chunk
> > path can drive assoc_array node splitting into an out-of-bounds slot write.
> > Patch 1 stops the out-of-bounds read in keyring_get_key_chunk(); patch 2
> > makes the chunk byte order agree with keyring_diff_objects(); patch 3 fixes
> > the shortcut-walk trim so the walk cannot be steered down the wrong
> > descendant.
> > 
> > v3 changes (patch 1 only; patches 2 and 3 are unchanged):
> > Per Jarkko's review, patch 1 no longer extends the existing
> > keyring_get_key_chunk() declaration line; the new offset is declared on its
> > own line as unsigned int.  No functional change.
> > 
> > Patches 2 and 3 are unchanged from v2 and carry Jarkko's Reviewed-by.
> > 
> > v2: https://lore.kernel.org/keyrings/20260714115451.3773164-1-michael.bommarito@gmail.com/
> > v1: https://lore.kernel.org/keyrings/20260712014500.480410-1-michael.bommarito@gmail.com/
> > 
> > Michael Bommarito (3):
> >   keys: fix out-of-bounds read in keyring_get_key_chunk()
> >   keys: make keyring key-chunk byte order agree with
> >     keyring_diff_objects()
> >   assoc_array: trim the final shortcut word using the current chunk end
> > 
> >  lib/assoc_array.c       |  3 ++-
> >  security/keys/keyring.c | 14 ++++++++------
> >  2 files changed, 10 insertions(+), 7 deletions(-)
> > 
> > 
> > base-commit: 2c7c88a412aa6d09cd04b414211b4ef8553b5309
> > -- 
> > 2.53.0
> > 
> 
> I'm setting up the testing environment now and hopefully have final
> feedback within let's say "hours" (i.e. I'll do the job, and it takes what
> it takes).

Good news. I got it tested. I'll push and mirror the patches to
linux-next. Once they show up there, I'll send a PR to Linus.


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Jarkko Sakkinen <jarkko@kernel.org> # Done with the provided
                                               # reproducer.

Really good work IMHO and also great example of legit use of 
AI assisted patches in my books. Thank you.

BR, Jarkko
