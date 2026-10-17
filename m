Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42E63E6DC9;
	Sat, 17 Oct 2026 05:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792215768; cv=none; b=dG6Tnsupg6PmzVJMoBhlaej5hM15VDESHoqMbS5c2Sj4C0r6DybGlTsqqpHaEblBxfJjY6O/tL6jQiDliACoI5bn3td+Uega4vl3nGoWVj742Q7iaLUFPa7N3lGe5+vKAfG+3IaSyBTToLQ8ylM9Lw1xwy+MG8xFkAEaJQP9Xuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792215768; c=relaxed/simple;
	bh=gOoUxQcq8z5zTFQajUtP3bngC5FmeZ1Yn5dN4S5TfzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9UG/6vbdF9gX6zV4QI/J8KnewvE/+a3vmskg8CFRwVuKKB6xdaeds+x6HN7UiI4GeSSh1pisp/kSZix+vJBJ4Okouw6aoWA2HYAQJL44Gm6+DHMilA4csfHLtDdeng94WSn71/N4fqW0dlQUeNDGFOORUBnKrqtKg1nNMPbfhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfESymtP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfESymtP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007821F000C4;
	Sat, 17 Oct 2026 05:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792215766;
	bh=JhawJTbNv3fvvJJQx80j2hVI7739vTSfPmLCcJmLHZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WfESymtPUNYy+3x1+3+c9yshOOZexUg1F0oIK0ghIEduke5a+KOJ5+JVSIr7HRqoK
	 gEkhpmV5fdHwFYQHWtZXI/tNeD9rB5VR0qomw/tMlNaVpNiy84tb6kM0pmdRQ/vucP
	 C7lPHwzFKJOmVXhFFnxNGONpGcFQyJE0lZ0XBw97M92OM8sVCRJ0jIBJEFqHMGTeEP
	 C8wDVXEqY0nV2w0MaHXv2nZnvUDOCNYL6zT4CpJPaknDElNbYaINuNjmuJpUYZKvp6
	 bNGxVvEK5sa88+qvbYliR7gl9GvsXSDviJUUa5r3N71EKutC7/RH5cNzbMA9l0cWvt
	 AN3P6osBtkBNA==
Date: Fri, 16 Oct 2026 22:42:44 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/6] keys: reclaim link quota during keyring garbage
 collection
Message-ID: <20261017054244.GD29318@sol>
References: <20261016215326.4110064-1-jarkko@kernel.org>
 <20261016215326.4110064-3-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016215326.4110064-3-jarkko@kernel.org>

On Sat, Oct 17, 2026 at 12:53:00AM +0300, Jarkko Sakkinen wrote:
> Garbage collection removes dead key links without releasing their quota.
> Repeated collection therefore leaves the owner charged for links that no
> longer exist, eventually preventing further links with -EDQUOT.
> 
> Update the payload reservation from the surviving link count while holding
> the keyring semaphore. If assoc_array_gc() fails, the tree and its count
> remain unchanged, so the existing reservation is retained.
> 
> Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> Assisted-by: LLM
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>  security/keys/keyring.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 7143f3079d20..db987c891811 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -1755,6 +1755,8 @@ void keyring_gc(struct key *keyring, time64_t limit)
>  	down_write(&keyring->sem);
>  	assoc_array_gc(&keyring->keys, &keyring_assoc_array_ops,
>  		       keyring_gc_select_iterator, &limit);
> +	key_payload_reserve(keyring,
> +			    keyring->keys.nr_leaves_on_tree * KEYQUOTA_LINK_BYTES);
>  	up_write(&keyring->sem);
>  	kleave(" [gc]");

This doesn't actually hold a reference to the keyring, so can't it race
with key_put() which released the quota already?  Then the quota for a
link can be released multiple times.

- Eric
