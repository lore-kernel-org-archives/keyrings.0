Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48163570C8;
	Tue,  9 Jun 2026 14:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016768; cv=none; b=H2SXaE876CeO9fC3DKU6G0FjonIOcQRRO2D4f0LXq/1k135bPj4N50RodxmUaOAmdIgmndqeVnZE+db8lJz3jwZqYgJAd8dTbj6pvCm/bNQhPTdbJgUSlmTEWB+z20Xes0YymNQf0328WVuQQ/skIEW69pH038J+PkkKT3dgtYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016768; c=relaxed/simple;
	bh=kg6lTBBcz0J0AeRp6/oenGKb2pjka0fVQojVriKu+JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I634JdmexPsTDY9iqc0iaDL5bKs5t5MTcsMYeM9qCjUd2bP/AkRpUd/Ksfj1TosSQnoJ/xdfuhCyfL9di4gubEpYaK9lq7HfmLQwJqDstEMNkso4EsPJDLZIxREK6ZRleh8gNw7TMHjW7fOCnZDxgBdVa2vVtZLPIfexJtHAung=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tenw/uDr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tenw/uDr"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id F03BC1F00899;
	Tue,  9 Jun 2026 14:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781016767;
	bh=+anADvK5mgnjZez4qo9D0EoExS+gbDwofiWW81SIumU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tenw/uDrjCQBq4hTcbXFdasirqCMUa6+f7tYyBupvnaS1w9WNO5l9XokILMEktmS/
	 YI90nq5pkjEaSi1sllJHZkyjPB+eB/YqOgMMuOZhDKGLVtHxUZj9j4dovEIOgUgV5a
	 YH2wBvB2a7SPWTams0PuZDjdFRIRKyBKk2hVpq4OA6xCKjzt7adzDHa59bo+SCVYpC
	 rK4ht+WXnja43SxwYo2lc+gEb9H1VRRUlCnlquxDkMwEitrvbHtrL92gGNXpzHXre9
	 Oy7hIslPisO+pAhWCjGWVV9AM6MKqCuWZkaEQtqPVmm6kuF2q8Uncw/Wlq0jYVW7ty
	 fJI8HlHGcB4sQ==
Date: Tue, 9 Jun 2026 17:52:43 +0300
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
Message-ID: <aigoZeoqygyBYCbR@kernel.org>
References: <20260604125034.13757-1-med08elkadiri@gmail.com>
 <aiZDlSTqaQTcvLBl@kernel.org>
 <85a686a6-7fcc-4a1d-8574-0fc7c2f84bc8@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <85a686a6-7fcc-4a1d-8574-0fc7c2f84bc8@kernel.org>

On Mon, Jun 08, 2026 at 09:20:39AM +0200, Vlastimil Babka (SUSE) wrote:
> On 6/8/26 06:22, Jarkko Sakkinen wrote:
> > On Thu, Jun 04, 2026 at 01:50:34PM +0100, Mohammed EL Kadiri wrote:
> >> The key_jar slab cache holds struct key objects containing cryptographic
> >> keys, authentication tokens, and keyring linkage. This cache currently
> >> lacks merge prevention, allowing the SLUB allocator to merge it with
> >> other similarly-sized caches.
> >> 
> >> On a default Ubuntu 6.17.0-23-generic system, key_jar has 5 aliases,
> >> meaning 5 unrelated object types share its slab pages. struct key is
> >> 224 bytes, placed in 256-byte slabs alongside biovec-16, maple_node,
> >> ip6_dst_cache, task_delay_info, and kmalloc-256 users.
> >> 
> >> Cross-cache heap exploitation is a well-documented attack class
> >> (CVE-2022-29582, CVE-2022-2588, CVE-2021-22555) where slab cache
> >> merging enables type confusion between unrelated kernel objects. A
> >> use-after-free in any subsystem sharing slab pages with key_jar could
> >> allow an attacker to reclaim a freed slot as a struct key, or corrupt
> >> an existing key through a dangling pointer to a different type.
> >> 
> >> Add SLAB_NO_MERGE to ensure key_jar receives dedicated slab pages,
> >> eliminating cross-cache attacks targeting struct key. The memory
> >> overhead is minimal: with 32 objects per slab page and typical key
> >> usage bounded by system keyring size, the cost of dedicated pages is
> >> negligible. There is zero performance impact on the allocation hot
> >> path.
> >> 
> >> This follows the precedent set by skbuff_head_cache (net/core/skbuff.c)
> >> which uses SLAB_NO_MERGE for similar isolation requirements.
> 
> I just realized this part is somewhat misleading, because it's done there
> for performance reasons, so I wouldn't say "similar".

Mohammed, could you at least send v2, which does not emphasize on
CVEs? It's better the use no_merge for sake of hardnening but some
risk is not same as vulnerability.

I'll replace the patch in my tree with updated once I get it.

Or I can strip off the parts myself, whatever goes...

> 
> > 
> > ~/work/kernel.org/jarkko/linux-tpmdd master*
> > ❯ git log --oneline -1 d0bf7d5759c1d89fb013aa41cca5832e00b9632a
> > d0bf7d5759c1 mm/slab: introduce kmem_cache flag SLAB_NO_MERGE
> > 
> > ~/work/kernel.org/jarkko/linux-tpmdd master*
> > ❯ git describe --contains d0bf7d5759c1d89fb013aa41cca5832e00b9632a
> > v6.5-rc1~137^2^3~1
> > 
> > So we could probably forward to stable's starting from v6.6+ if that
> > is necessary / makes sense?
> 
> It won't hurt, but I doubt it's "necessary" per stable rules. But stable
> maintainers ignore those themselves anyway, so whatever.
> 
> > It's not a bug fix but kind of still I think would be a change that
> > stable kernels are better off with it than without it.
> > 
> > What do you think?
> 
> Won't object.

Yeah, I agree, and yeah I think commit message goes over the top, while
the change is for better.

BR, Jarkko
