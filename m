Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039C62B9BA;
	Fri,  5 Jun 2026 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780661765; cv=none; b=g3yfzxKpMnZY21WHrLk3/1/O70/oSEF1JQ3HDr8244hQP5rRR5UG25E1xzqszageJd4WRq3oX7iDfHVoV+COh6+6/JKH8F880EOf2iqO0vaNR5MMoBvYC+lO1+FrnZj7bFO/Lru8TUFEctibmcOhNvG6xGLTqbpwqI2cbrQLDvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780661765; c=relaxed/simple;
	bh=M1RLUPjQMkUazGK5E9j4rCdECXoPVJZ/G4Z0NlllhDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D68y2l5FxOmTOOt72J+CLkV/7CM8iz+jEvOaEm0B1vJe1gyQJiLDcmXJC5cHnWbaRWMPUiNDca6J8lkk9jvbSggheysmxSfExr3K6hyJLnhVX8cKaZt5ND5EWuGphqCJfgvJfzfI12sR6XjkOHsZxABDOEH1ZCM7Imu7LdVOitE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBTzWS6l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBTzWS6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AFF81F00893;
	Fri,  5 Jun 2026 12:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780661763;
	bh=beptNeEzJHYQ+94+I0PQKTOh5JgCPrdUPqAq2RLiN3U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TBTzWS6lRNEwNkUDoBT0wNjbMt5k+ani9mSxO7Ld9Djhx/+L5Cl5oShp9gA69YFWq
	 JN8qr7qbtXCQeGPG8paeMz7NQ4wsiFgMjqcuXY5wW4fgvXCO4237v3aUXQRRHxVcAU
	 AwBUpeFyCHlWJJs1/RYRCVK1AaSOz0O7ymqLEDBYW0oom309b3UCNjdCJLHZ/i+biP
	 egVR7v4mXRTTKxXq/uvndoxK7FaUnqm+Z4mAAUzA1TAnD5QSTVdV1T6ymKqcwIj7kz
	 fhFIWe5/x6U3kaQ4i5+u10Eevk3Wg/hIuQM8AGskZhKATFSqeIlYgvimchxzrQ/eWs
	 f/mM/FESXe1XA==
Message-ID: <19fb9d38-fe02-4653-bbad-58806e55ca84@kernel.org>
Date: Fri, 5 Jun 2026 14:16:00 +0200
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] keys: prevent slab cache merging for key_jar
Content-Language: en-US
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>,
 David Howells <dhowells@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>, Kees Cook <kees@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>, keyrings@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260604125034.13757-1-med08elkadiri@gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260604125034.13757-1-med08elkadiri@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/26 14:50, Mohammed EL Kadiri wrote:
> The key_jar slab cache holds struct key objects containing cryptographic
> keys, authentication tokens, and keyring linkage. This cache currently
> lacks merge prevention, allowing the SLUB allocator to merge it with
> other similarly-sized caches.
> 
> On a default Ubuntu 6.17.0-23-generic system, key_jar has 5 aliases,
> meaning 5 unrelated object types share its slab pages. struct key is
> 224 bytes, placed in 256-byte slabs alongside biovec-16, maple_node,
> ip6_dst_cache, task_delay_info, and kmalloc-256 users.
> 
> Cross-cache heap exploitation is a well-documented attack class
> (CVE-2022-29582, CVE-2022-2588, CVE-2021-22555) where slab cache
> merging enables type confusion between unrelated kernel objects. A
> use-after-free in any subsystem sharing slab pages with key_jar could
> allow an attacker to reclaim a freed slot as a struct key, or corrupt
> an existing key through a dangling pointer to a different type.
> 
> Add SLAB_NO_MERGE to ensure key_jar receives dedicated slab pages,
> eliminating cross-cache attacks targeting struct key. The memory
> overhead is minimal: with 32 objects per slab page and typical key
> usage bounded by system keyring size, the cost of dedicated pages is
> negligible. There is zero performance impact on the allocation hot
> path.
> 
> This follows the precedent set by skbuff_head_cache (net/core/skbuff.c)
> which uses SLAB_NO_MERGE for similar isolation requirements.
> 
> Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

> ---
>  security/keys/key.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/key.c b/security/keys/key.c
> index 3bbdde778631..592b65cf8539 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -1275,7 +1275,7 @@ void __init key_init(void)
>  {
>  	/* allocate a slab in which we can store keys */
>  	key_jar = kmem_cache_create("key_jar", sizeof(struct key),
> -			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL);
> +			0, SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_NO_MERGE, NULL);
>  
>  	/* add the special key types */
>  	list_add_tail(&key_type_keyring.link, &key_types_list);

