Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792761763;
	b=z5hra4aUkKQnvgJbBJ5cYlnjnoWWvyu3z9xHd3T3b3P8mC9YwR25CWtovySgDF2VU3mW
	 Lj8XQQ5E4VKK8AshBIZuVuTjQjoXFi3riEzs8kDrJ2lOGTDJG13luQ3Ji52TyeVKu8INf
	 L6VqDLtM+HKhBP2iII38XxBvR+O2+FlVZK74A3PaVtEkWY3qGZmwSlu9vX9XPlX1X6g3a
	 fLwCxEQ78CoK1przwZCxwY8VTx4trSOnMCdJh5gzWG7wht89+XdlUlJEieoYE29EDDaxd
	 DOczzGLLZSfAmVeDAbU4xNlI/WFSkza4k8LMxXrxA+DqHaeiQ3MjxtVrtrF9l30lH0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792761763;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=W2Cpxy4wVss+iIJW+q/MvPFsOUQNm5aAmpJ0e8BYxrw=;
	b=czt0il+ZdeLgOPmf0gewkb3dPX9y3oWXB0iDwBJzYDQqrPVD5GlpsSqsEuMjyVnWmztY
	 q/f0lm4Lzdgy3MxKdZ+M0ayf4u9ujkl5WX9WfV7v1Zc7O1Dvr+CU1kpzk24EyHq/NK3c6
	 WciMORUJXgQrjQYHMrwMZfKfsbziTE/ZgdESq2K8INGdgchfcRDdvFopE5WhQJj5jytO5
	 7u8xT9tJqWSk2SI+8BHTcVj2sV6t8TbHuTHqaBWqOevmyhqwlTukz7oXQVu0lb0G6h40n
	 b06/43HyPNUx6nnTKwHD242H97EEwgYZIdxh6AypLLett4zh/6+XDhYcOAGnK/nWq7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCogN7ON;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 5DA04606A31A;
	Fri, 23 Oct 2026 13:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oCogN7ON
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5B5061F01825;
	Fri, 23 Oct 2026 13:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792761762;
	bh=W2Cpxy4wVss+iIJW+q/MvPFsOUQNm5aAmpJ0e8BYxrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oCogN7ON1s3A8gapiPvC+G8QBqjFb9jRSpQgM7yTWdjtD7NiA9wkYd+c6QwlopZEP
	 vxPkhoUqWKapFuCAKBhYqkwiF/4Beq3LeOo86nE/hTzCQxM75To++V+PtmOx7GhO6g
	 vwUiEHiTMfi40tTInELCf1eemkpf55kidv/2dfNkeVEHKlMBphQlOzr7R3qE2LTwKq
	 UHX67RGrQNm60W39u7LaNN+VfPaMCB1DE5/GTSQ8jyQ4G4T/XBPoVGI0akNxOes4IY
	 TZZzGsAh3HMcihhBkHlrVg1bbVJaSFqKGafBz/ZHb5Tu0Bp/LegvLcM/As1ztDI+75
	 onGwtNPVbK/Ow==
Date: Fri, 23 Oct 2026 16:22:39 +0300
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
Message-ID: <attfn7_lt4Zhl99e@kernel.org>
References: <20261023120953.1206778-1-jarkko@kernel.org>
 <20261023120953.1206778-6-jarkko@kernel.org>
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
In-Reply-To: <20261023120953.1206778-6-jarkko@kernel.org>

On Fri, Oct 23, 2026 at 03:09:25PM +0300, Jarkko Sakkinen wrote:
> The keyring subsystem depends on assoc_array for searching keys by their
> description, type and domain. It is the sole user of this data structure,
> which has during the age of LLMs transformed into a maintenance nightmare.
> 
> assoc_array needs to be replaced with a data structure meeting the
> following criteria:
> 
> 1. Must be suitable for a sparse key-value store.
> 2. Must have multiple in-kernel users.
> 3. Would be nice if it had dedicated maintainers.
> 
> rhashtable is likely the best pick from the available options as it is
> designed for a sparse key space, has dedicated maintainers, and multiple
> in-kernel users.
> 
> assoc_array is replaced with two new data types:
> 
> - keyring_index: contains a searchable index of links to keys and an RCU
>   protected list for active links, which is used to provide stable walks.
> - keyring_link: a keyring node and its contents. Multiple of these can be
>   associated with a key as it can belong to multiple keyrings.
> 
> assoc_array_edit is substituted with two-element array of keyring_link
> pointers with no specific data type defined.
> 
> Jenkins hash digest's used by rhashtable are rehashed from the SipHash
> digests of search keys and links.
> 
> Assisted-by: LLM
> Suggested-by: Eric Biggers <ebiggers@kernel.org>
> Co-developed-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

I did quite extensive testing on this revision and have deployed these
patches to my at-work project builds, which is a vLMM appliance type of
an operating system.

Br, Jarkko
