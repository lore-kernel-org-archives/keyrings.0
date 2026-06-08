Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C624D19005E;
	Mon,  8 Jun 2026 04:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780892570; cv=none; b=ubkuHEIraGtfnCXhTjSlVku4GLBz0kmYgLd+ODYvU31CYcfYXFtgKSj3CqIT2HiGr8A33jThLgE6X37AAHDoEBZH399tAFTmayeLzgPL5/dsYdA/nWt9y07hGbQzZOKgXnLZ/uVdrqm4L4ROgfJKhqrMyzc4cCe4OWcbeZqtBnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780892570; c=relaxed/simple;
	bh=AqlobgsVyy/Y78M67+4dKR8yHJRrpvCcyHxjZnuKKW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssN69tk9YoekVIOUPtVc+uF7o8RFeag0sk3KpDsluEEv6PEqBXfqSj/6OX0eJ6Qz225EY9+5RjI+bJopyFJShRjnFZkdHN6RrwxZ4FYiXXwhNkivJ4pJ5Ls5vW7zy+hzqE7gNIxO5bdDgAyJrXH8ThioJeHOSYNDNIjbwxjX1KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+CEk9QK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+CEk9QK"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D03801F00893;
	Mon,  8 Jun 2026 04:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780892569;
	bh=+S3w8xELlZXCispRs1d2z4HUq4Ur88+AmZo/T6VgGBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f+CEk9QKNrABKlbnOUl/dqKzTOO0OKaCknb+Rd8F198XQt4TbB7klIx2rAtCJd1G4
	 NP78lqZroNmkzoIpgCdLFbpVMzi/M5eQ5BNB9459vJpzXAeVEP3peXABkWKO2ys6l6
	 M8bjqPn0MEswm94w+Lz2MXSc1qw8zmii8DkWmPUGzqfm5KSav6Zy4Dvqi+o0C6yu9h
	 kZ/Rhv/BHw991K4pyyFv4uTSG09F3njrNcQCdE+RM4DQfGKgPW+cLaPZ08x33a5xwo
	 DgKDtaVe3FkmCVaw915GtzhRSZlKzXGrYTLTeggEDi6iHUXxZJoi7UWteCj5/arby7
	 O+Y6YvurLAxmQ==
Date: Mon, 8 Jun 2026 07:22:45 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, Kees Cook <kees@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: prevent slab cache merging for key_jar
Message-ID: <aiZDlSTqaQTcvLBl@kernel.org>
References: <20260604125034.13757-1-med08elkadiri@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260604125034.13757-1-med08elkadiri@gmail.com>

On Thu, Jun 04, 2026 at 01:50:34PM +0100, Mohammed EL Kadiri wrote:
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

~/work/kernel.org/jarkko/linux-tpmdd master*
❯ git log --oneline -1 d0bf7d5759c1d89fb013aa41cca5832e00b9632a
d0bf7d5759c1 mm/slab: introduce kmem_cache flag SLAB_NO_MERGE

~/work/kernel.org/jarkko/linux-tpmdd master*
❯ git describe --contains d0bf7d5759c1d89fb013aa41cca5832e00b9632a
v6.5-rc1~137^2^3~1

So we could probably forward to stable's starting from v6.6+ if that
is necessary / makes sense?

It's not a bug fix but kind of still I think would be a change that
stable kernels are better off with it than without it.

What do you think?

> Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
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
> -- 
> 2.43.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
