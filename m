Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27FB33A702;
	Mon,  8 Jun 2026 04:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780892833; cv=none; b=TwLHGXkeR5aMbC8YMJpSmNiG2rPpPqRq/BB49N02SOmat7y3BorLe4JH70998dhpdYJ7gmxBLjGRCgHUAslFdlQzwJjtTBP36mJhmHg4mz8CZ2et1EK2u0M//dru/fJkvbk1I1jG/+nCvUP8FDqK4Ec+yedjmDpRhanIvTWH9Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780892833; c=relaxed/simple;
	bh=ZyeDEgLTpl1t1NAIwQhO9XLbEN9BblMa0g6H87ABUw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLedp246EVqbJ7ZkiiD45xYr0bGuDdLsFDgfRvqGO4V2IT8qZyLg0z0fc0+JsQxtYqenR1jXRUKryVDaJs1Su3VYhU95inF55ngF2dax1KTB90ryrCnK6hfzt1ypGOBRlVKzeQ3PCGfbO0dJW5tE16IFjKhnBjd1hlf9NQo+IAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nS58AK/y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nS58AK/y"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C7A801F00893;
	Mon,  8 Jun 2026 04:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780892832;
	bh=RSLBCAubqOBXkJj4C3n1J1E6z0vbrZkeIcgM2AXJy3I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nS58AK/y2J8BRi3VyhJ4WApQE9D9s+YzkPZDtgaFYF546cMdJPmg9J6fbXY3g6Dqo
	 01j4dH7AIlZw6bGJceoVuoLrZL87yzklImjRr9MXxAq5B9SdDnEKP82UaXvjr2MF+T
	 4yCIUr37OyduR51e23Es9lL2UM5PIADt0JuBGw0OzlxHeLl1CPGxVEoQC1bqUNyaUH
	 iTeeGGBFQRjlJIoakdAR6LBMeKGkxZe6850Vz0jfzn0+X/sBjY3IL8gRwD2KISOM/K
	 2lg493Dy/v2s6Ryk45BuZOioJPlP0ISemMHNXwo8Io2p9VQHD979TF+x7+kRL3Nsc3
	 FxTz6VY4z5yMQ==
Date: Mon, 8 Jun 2026 07:27:08 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Mohammed EL Kadiri <med08elkadiri@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, Kees Cook <kees@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: prevent slab cache merging for key_jar
Message-ID: <aiZEnGKso1YRi4UR@kernel.org>
References: <20260604125034.13757-1-med08elkadiri@gmail.com>
 <19fb9d38-fe02-4653-bbad-58806e55ca84@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19fb9d38-fe02-4653-bbad-58806e55ca84@kernel.org>

On Fri, Jun 05, 2026 at 02:16:00PM +0200, Vlastimil Babka (SUSE) wrote:
> On 6/4/26 14:50, Mohammed EL Kadiri wrote:
> > The key_jar slab cache holds struct key objects containing cryptographic
> > keys, authentication tokens, and keyring linkage. This cache currently
> > lacks merge prevention, allowing the SLUB allocator to merge it with
> > other similarly-sized caches.
> > 
> > On a default Ubuntu 6.17.0-23-generic system, key_jar has 5 aliases,
> > meaning 5 unrelated object types share its slab pages. struct key is
> > 224 bytes, placed in 256-byte slabs alongside biovec-16, maple_node,
> > ip6_dst_cache, task_delay_info, and kmalloc-256 users.
> > 
> > Cross-cache heap exploitation is a well-documented attack class
> > (CVE-2022-29582, CVE-2022-2588, CVE-2021-22555) where slab cache
> > merging enables type confusion between unrelated kernel objects. A
> > use-after-free in any subsystem sharing slab pages with key_jar could
> > allow an attacker to reclaim a freed slot as a struct key, or corrupt
> > an existing key through a dangling pointer to a different type.
> > 
> > Add SLAB_NO_MERGE to ensure key_jar receives dedicated slab pages,
> > eliminating cross-cache attacks targeting struct key. The memory
> > overhead is minimal: with 32 objects per slab page and typical key
> > usage bounded by system keyring size, the cost of dedicated pages is
> > negligible. There is zero performance impact on the allocation hot
> > path.
> > 
> > This follows the precedent set by skbuff_head_cache (net/core/skbuff.c)
> > which uses SLAB_NO_MERGE for similar isolation requirements.
> > 
> > Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
> 
> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

Thank you.

has been applied

BR, Jarkko
