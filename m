Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792711413;
	b=sm+thPRenEvE35ptUjSqnHT5FUTlTgC+0jj53pRBBJ1CWTj9Rc5jckH2iEXRZ6iLrDqk
	 xmKH/jJQN+B94cjZt9i+cOMLMFypFrBnVTfO9ZaTlWdw+zpg5Xv85Vj3nXcpF/gdipFIz
	 kuk25IfZAo3dtgvj/yZKBO8pPLzgGzwzO6VeulJcteEMsqYUU7tmJfJeqXFz9HKGKlyJx
	 xpNIRWGH+GmL0JJvPCZztNDf1VKaCdXG0j6RamHUfuM8ouzexKu76FW82OnMErJNCRvmf
	 oXuo9gjlovOS+kJ1tUbNwqAKAGwskV1ZDRL2g1q7uSKJ8cVwCRpJohvgLZs0f5QgbWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792711413;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=iB1qRE5TjHcp1JAI8RwwmxnKVJod/0Zmh1zD5MFJOZs=;
	b=mEt9iz2KomsqaUBqVQDnyb7oh1gKhHTUCHFQ2j8Xo5vfCqv0RXAH1YSMyRhJOdYIMVNc
	 iE5mY+Ct9mn8TlFVJJkEjCNL1wWNaOgVEKG68MIlHDrNDsDKuX3NdDHsAN5G32HXOQKts
	 JzxgEjgCrwH1+vVx1qjAfMmNsekZ5FrwIsrgJn9/XBWmZEY89tY3y+Dsg43DkhuHqu9u9
	 rJg+DoIYndk52LmFLUsamHDb157g2h+LEm2hVuqYAb4kNJLaTjr50J+1IitmN+JxoQsFD
	 jZk1/8g/0bBNyaagXH7QUBUR5CfYMetQuJ9TRkRwbzvhAakwVqD99530NRJ7uzdsQdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEPfsY1+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 5FA65606A319;
	Thu, 22 Oct 2026 23:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IEPfsY1+
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 659721F01825;
	Thu, 22 Oct 2026 23:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792711412;
	bh=iB1qRE5TjHcp1JAI8RwwmxnKVJod/0Zmh1zD5MFJOZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IEPfsY1+/HOMvZrxgq1jThp2aLJs3QoYJusuyLv+s6xrU63qIE40rJj45+nUq7yQ3
	 +2rQaIfUjUaiz3uKc1PQVZEnLuML7Q5pamzanFikNVeq3vhK3eAKcMHpSy4BXJlvH9
	 sTTf47U16f/+6NuOBgdyzBg3bFlMISjXvqIK15LR0aiaMVzMgGcBbN1HrknId2exaf
	 IHbjTg2mzgBY+W4ADqHbdk6EY3MtmKL3WGOnt0M25ZROgHNjsXDBsjUoa+noc+zDNX
	 nRJ5GKVjaxOY+h2kEG3zffPJz4Qn03ZI+Peu5didwWl3GTNUgTLWZoKtYuV4zzJJbO
	 ZHXqsBcERNS2A==
Date: Fri, 23 Oct 2026 02:23:29 +0300
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
Message-ID: <atqa8Y0cROHISnbD@kernel.org>
References: <20261016215326.4110064-1-jarkko@kernel.org>
 <20261016215326.4110064-6-jarkko@kernel.org>
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
In-Reply-To: <20261016215326.4110064-6-jarkko@kernel.org>

On Sat, Oct 17, 2026 at 12:53:03AM +0300, Jarkko Sakkinen wrote:
> Linux keyring would be better off without struct assoc_array given the
> overhead caused by sole ownership of it. Linux has multiple popular choices
> for key-value store and there is nothing special in lib/assoc_array.c that
> would make it stand out enough to be ratiaonalize the time spent on
> maintaining it.
> 
> A keyring has a sparse data population, making rhashtable a plausible
> choice. Multiple subsystems rely on it, and best of all, rhashtable has
> dedicated maintainers.
> 
> Replace assoc_array with struct keyring_index, allocated for a keyring on
> its first link attempt. Initialize its ht member with rhashtable_init()
> to store links indexed by key type, domain tag and description.
> 
> Maintain two linked lists in the index:
> 
> - all: enumerate committed links without retrying hash table walks when
>   the table resizes.
> - keyrings: visit nested keyrings during recursive search without scanning
>   links to other key types.
> 
> A key can belong to several keyrings. Represent each link with struct
> keyring_link so it has separate hash table and list nodes and holds its
> own key reference. Traverse the lists under RCU and defer freeing removed
> links and dropping their key references until after a grace period.
> 
> Assisted-by: LLM
> Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

For the functions introduced, I'll also use cleanup.h primitives to
cover all fallible initializations. This is something that I don't
recall seeing in the review comments, and it is a nice extra safety
measure when landing a refactor like this.

Br, Jarkko
