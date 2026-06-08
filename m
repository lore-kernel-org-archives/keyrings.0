Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A9378D9F;
	Mon,  8 Jun 2026 07:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780903245; cv=none; b=J3XYQj1Ainx06bGmNn9hEQtMjjAbiG4yRPww6uyKtOPs5EbLS4+AVlNBgYxNfh9zQpEgO73d32vRx6AjyqN7ofaKh0+P9vfe4xiFgtwDC11HDUSmexq+3Ywe3SIrlpepax3rcZ1QPsOqG5bl5keUZ7zjXn/op8Bq8xw+9z/vrHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780903245; c=relaxed/simple;
	bh=j0n8JRFGmrgBwxUYBf2PtTFHpDFBICuuKnDivLtANPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2rinCnRlv4sXCpz0zF6DZbiflBTqEraIJ3q8166emFQR04rQ9cghyx8fwiHB+rODdNE4SG88fDdX4kjA+ZxVpke38idrWGO7tyOmgY7qruN5cjS3r1KUpqx60thvOZ3JxLE1DytVXzHar3tR5vjhMNmxMQGeIDAArvQ2h4WWtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I//PKWiC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I//PKWiC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A553A1F00893;
	Mon,  8 Jun 2026 07:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780903243;
	bh=AgP533YwYUweKVolJCO08aTvc0kuMhlkUMDGQVhwWPk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=I//PKWiCXWYKDolSTUHKj359oOZUNT962zKjpBzM04sNTBJ7hRzzjjtPayh5Tnbf0
	 NV1dj3XYzivGCTgnbYXuYgQ3giUKLpPAqDYBt6ZNNMQvn1qnVyjQkWk3Y6C6dPqu53
	 2xjpLNMM+Z+NdgPFStj1oyGAJKkifVuZ9sfFE9ntBAfY32L930JS28RewnnVBJOVlg
	 Q42XDapliqjBu9t5sKzj+hrxleE+54s7uVSz7j42tbAlzdFhI1okcHvB0rfYnMNQg+
	 F0ER0CWZeIP3ffZfdlKiw266luHoo2rmvEL4vB0jY7QnU5bkR4UomaFkdA1dLlGJIa
	 zjfe/v1mULsug==
Message-ID: <85a686a6-7fcc-4a1d-8574-0fc7c2f84bc8@kernel.org>
Date: Mon, 8 Jun 2026 09:20:39 +0200
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] keys: prevent slab cache merging for key_jar
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>,
 Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260604125034.13757-1-med08elkadiri@gmail.com>
 <aiZDlSTqaQTcvLBl@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <aiZDlSTqaQTcvLBl@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/8/26 06:22, Jarkko Sakkinen wrote:
> On Thu, Jun 04, 2026 at 01:50:34PM +0100, Mohammed EL Kadiri wrote:
>> The key_jar slab cache holds struct key objects containing cryptographic
>> keys, authentication tokens, and keyring linkage. This cache currently
>> lacks merge prevention, allowing the SLUB allocator to merge it with
>> other similarly-sized caches.
>> 
>> On a default Ubuntu 6.17.0-23-generic system, key_jar has 5 aliases,
>> meaning 5 unrelated object types share its slab pages. struct key is
>> 224 bytes, placed in 256-byte slabs alongside biovec-16, maple_node,
>> ip6_dst_cache, task_delay_info, and kmalloc-256 users.
>> 
>> Cross-cache heap exploitation is a well-documented attack class
>> (CVE-2022-29582, CVE-2022-2588, CVE-2021-22555) where slab cache
>> merging enables type confusion between unrelated kernel objects. A
>> use-after-free in any subsystem sharing slab pages with key_jar could
>> allow an attacker to reclaim a freed slot as a struct key, or corrupt
>> an existing key through a dangling pointer to a different type.
>> 
>> Add SLAB_NO_MERGE to ensure key_jar receives dedicated slab pages,
>> eliminating cross-cache attacks targeting struct key. The memory
>> overhead is minimal: with 32 objects per slab page and typical key
>> usage bounded by system keyring size, the cost of dedicated pages is
>> negligible. There is zero performance impact on the allocation hot
>> path.
>> 
>> This follows the precedent set by skbuff_head_cache (net/core/skbuff.c)
>> which uses SLAB_NO_MERGE for similar isolation requirements.

I just realized this part is somewhat misleading, because it's done there
for performance reasons, so I wouldn't say "similar".

> 
> ~/work/kernel.org/jarkko/linux-tpmdd master*
> ❯ git log --oneline -1 d0bf7d5759c1d89fb013aa41cca5832e00b9632a
> d0bf7d5759c1 mm/slab: introduce kmem_cache flag SLAB_NO_MERGE
> 
> ~/work/kernel.org/jarkko/linux-tpmdd master*
> ❯ git describe --contains d0bf7d5759c1d89fb013aa41cca5832e00b9632a
> v6.5-rc1~137^2^3~1
> 
> So we could probably forward to stable's starting from v6.6+ if that
> is necessary / makes sense?

It won't hurt, but I doubt it's "necessary" per stable rules. But stable
maintainers ignore those themselves anyway, so whatever.

> It's not a bug fix but kind of still I think would be a change that
> stable kernels are better off with it than without it.
> 
> What do you think?

Won't object.

>> Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
>> ---
>>  security/keys/key.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/security/keys/key.c b/security/keys/key.c
>> index 3bbdde778631..592b65cf8539 100644
>> --- a/security/keys/key.c
>> +++ b/security/keys/key.c
>> @@ -1275,7 +1275,7 @@ void __init key_init(void)
>>  {
>>  	/* allocate a slab in which we can store keys */
>>  	key_jar = kmem_cache_create("key_jar", sizeof(struct key),
>> -			0, SLAB_HWCACHE_ALIGN|SLAB_PANIC, NULL);
>> +			0, SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_NO_MERGE, NULL);
>>  
>>  	/* add the special key types */
>>  	list_add_tail(&key_type_keyring.link, &key_types_list);
>> -- 
>> 2.43.0
>> 
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
> BR, Jarkko

