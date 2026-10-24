Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792859202;
	b=vB2YTlHvlaIZo5t+N2CaU9B7DWge6H8187IjdP87eHYLA6UB0AQNQoOhtmu2kxuidP72
	 3ujluOeu5PTSxARRsBVSJmLOMNowU5YoiVBWufLRZxitM5NNsYeQjU+ptszKUrergKwdR
	 A7QoJq9MqQzvzmciolV3K8GvSB61BAWALl/8FsErKPz+yTrDS+OJYCdNHTTvXlsbnWYB9
	 u6oEFPMSqnvFgG4nBp6bTZ1cgfHH0gPobq4TlKU1vTzigLyajV36MB9cHs+uxMrpduW5E
	 byo9L3V0OkNF5LUonTzeNVfmP9A8rvjtxfond4ZKm/sFp1wXXWkMbKdSPhCvHjBl2hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792859202;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=cjCUpJFLgm36iIs/dyRyZyVqFTn0qb8FK16OH3CULcw=;
	b=UBmH4T7bvt4H0vjB25fr2Jt1qbb743EYFzzge7b5xBWliPyRE9EgUKpNr1FRukFh5+XC
	 KvHO2IziLeGeO6BsS5tfGdt/m3m89NpUmWXrc4N+P9kCQB4QDQN5R/erYfrUmD4QqFVrQ
	 NliSqQe3qo5aMyXFgUd/+mq28HdEXeOtCcfk+MNRnnKJQt43oapgWpb7IBgRb8CpyQG4h
	 gAcUf4ea5MDlKPIBrc5OBoxEltTpjbWvufI8S2C63SbdAuH8pu6gz/n75fcZ+QL9vfjO0
	 eW6ilEr/mtm0/uU5YFU2LUzDrzOoOVIEqRMepM+cmQwyC517WQU/50CcaQzOn84CVfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfjbYBYu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E1B97606A31A;
	Sat, 24 Oct 2026 16:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jfjbYBYu
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 3B4051F01828;
	Sat, 24 Oct 2026 16:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792859201;
	bh=cjCUpJFLgm36iIs/dyRyZyVqFTn0qb8FK16OH3CULcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jfjbYBYufp5/BY1Pto7nqef9kFCdeVEqA8y+tZwDwIY9FGAi3PWm51z90I3YiIBwk
	 tcJ3VUpUB7qzldNoi2j7Gkwlwv49KmdZyMwxylpXOv0V0PO1qxf5AvX2LRBFl4iWHM
	 pbUFKAXNEpreuWKj3ECwC0pjriLFyQS9JHyhTGd1WJ4iRlYSGh7GSRU8+MEVa4S17h
	 oXJYhvgXQYBsEY3EUVniqHI1ZI3wDsgBHt5XPl8/17qozvuZOGlmoaNYbD/56Cv/es
	 lIj6php+Q8RiTMgQIdoR/isXkNmhkfNVNCXK63V6GRnwzOSxkaMKFbBS43n0KTk4fv
	 xFGX1pGCnyYKw==
Date: Sat, 24 Oct 2026 19:26:37 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: keyrings@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] KEYS: Replace assoc_array with rhashtable
Message-ID: <atzcPWlu-vh0WHbT@kernel.org>
References: <20261023120953.1206778-1-jarkko@kernel.org>
 <20261023120953.1206778-6-jarkko@kernel.org>
 <atzAk-1IhxTN5nk8@kernel.org>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atzAk-1IhxTN5nk8@kernel.org>

On Sat, Oct 24, 2026 at 05:28:39PM +0300, Jarkko Sakkinen wrote:
>  	kenter("{%d},,%zu", key_serial(keyring), buflen);
> @@ -512,20 +485,18 @@ static long keyring_read(const struct key *keyring,
>  		return -EINVAL;

This is another issue I have with the code that I recalled afters
sending the patch set.

Do we really want to retain kenter or kleave? I don't see any point
as kprobes and kretprobes have literally existed for decades already.

I propose removing them from add/modified functions in this patch
set or alternatively prepend this with a commit that deletes them
entirely from the subsystem (I like the latter better actually).

Br, Jarkko
