Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792613009;
	b=iyHGVr3t3m/Up4J0ZAmZFiLdr4ZiI7WeM4KMOGJQFIIvSllOPw2HdVXfTH++l6sP0TCk
	 ZKQgbFxmKox4Qpc8o/+IRlL73/KIolGA9FbPtPTAZ2X40K0GVE+3KlRekm9gBix6gQ3UY
	 UYHtUumylnYdUwqycIqxVScVNBQ6aDsM6cynJsDbQHHSE4jf+0Wc730HKLko8XeKhM3iM
	 rkGx2kS9eMwD6VsLS/Pg/xuswARS0Nu+uYt7Y6+9nfrl+sox80R5jrbyJQbl8UGUMMDrG
	 k1tWm0OH+J8jGxvHcpzYT7snYWX3k5lTSYa/njEfGQ4prrT6NVPY/3zjES0pvQaHdeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792613009;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qtppOnSTv5qYf/zVAOABGaVaxEJBM9qyNT4X3oeHasc=;
	b=lV7K/TN5vvkSq55C/Sqk6X/SnfQ0QBytwZSCdSRItnqFA5uVA33Qh5F0Mwjp7o5NDKsK
	 a6+eek+cHDPuv8bnTx4KRqTbcB8+1k7BB3VhjOUXGYKHjkqwKAvUGZ+vMFZDb7P8CILiH
	 7feG+WENIAgXZ1Q1eSA8L38Fp3jbuJKV0iktOJMDqNmfGYD+8NE7L4U8A8E6IdXICBgnD
	 94w2e4omYODpq0S/lVqsxjnXpS/uMVZ3gMFOXJ0kutCvagISqAh8x2/Lm7xYh3oabncvF
	 GIRUjY1DTmcQPF/3INPyg5d7umY33tByKBSYYqJzuUKgaYtgf//57vILYHaOrxgxCRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZC55rUQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832E2606A319;
	Wed, 21 Oct 2026 20:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RZC55rUQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09CB1F000C1;
	Wed, 21 Oct 2026 20:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792613009;
	bh=qtppOnSTv5qYf/zVAOABGaVaxEJBM9qyNT4X3oeHasc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RZC55rUQu/7j4ykEMZRKWhqCCBkGEyyVcd0OnzEKQbov34BmAczn1P4FbdhBXBFwm
	 wA9tw0WQ9YLauCiHTCy9JxfCUnwJ52a4bH78/vTN5CvHhzC66VJUoiz+MB8OTmelP5
	 KiDjMpty+P6MZT1UDJfo05xW5ZQp3RGSIySnYd+FdQ5SF6QjTrjvswhjfturQGfIJw
	 xhFlqaKD0GIzoNb8Xe8zG5EFbi3iFYc1NPqGQ8nAGKDqgNX0z/XjhIxQmG/YWVIyhA
	 lv2nX58b7seAv2EeCIDrQUTPVNwfPGhAwkD75v+SyRfzxSR1DZL7i6tkX0U35wnSPd
	 07DaFdetLiyWQ==
Date: Wed, 21 Oct 2026 20:03:27 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] KEYS: rhashtable bug fixes
Message-ID: <20261021200327.GA2210933@google.com>
References: <20261020174325.2229448-1-jarkko@kernel.org>
 <atkTgEwRQfh94zeV@kernel.org>
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
In-Reply-To: <atkTgEwRQfh94zeV@kernel.org>

On Wed, Oct 21, 2026 at 10:33:20PM +0300, Jarkko Sakkinen wrote:
> On Tue, Oct 20, 2026 at 08:43:18PM +0300, Jarkko Sakkinen wrote:
> > My patch set that migrates assoc_array to rhashtable had some LLM
> > scavegend bug fixes. Unfortunately most them where either plain wrong or
> > not in the right scope. The bug fixes in this patch set are by human
> > labour constructed fully but they are derived from what I got out of the
> > original LLM source. Thus, they are tagged as LLM assisted.
> 
> I guess these are ready to be merged? Eric do you have something for
> this revision? I already sent -rc1 pull request i.e., I don't mind
> to update it if necessary but otherwise I rather would just apply
> these.

Looks okay now.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

- Eric
