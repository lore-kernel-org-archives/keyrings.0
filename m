Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8980046AECC;
	Wed, 22 Jul 2026 15:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784734253; cv=none; b=fUiUEvNdCyeVKzLSBA3jimW+Hsozwp+FEfz0MNF1GVeSURi2e6VKoihENIrTzIXQ/g25K/cq1bJfg9PyPE6ZNbleLkipXDvQ9sA87U8IQTtEcYJSSK0JNods6Hf91cLIC/PUlx2acxvKkAWjgIn7D4n4Oh/dnB3ZHPqAM2wQ6I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784734253; c=relaxed/simple;
	bh=/oB6i+yzNJPsGBGfPr2Pf9vtp53RzJzYkA4lYcxxRV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=frv9KPrEoPUQFzW5d3TWBrKt82lCC8HZ6dnY7nSLJoPAQ/9cZAnkrtgBYqHRSgZIYq0dOOwq+jOSDZfl6LwQ57oGDQOvzaZX64U9L8LuWPCTVNhOJIbHspowCf3YF81wAnX2EpVxeVI+D+3Fk6Yvbb/03ZEZyuSNNop2MGOVieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glZ5dQBp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glZ5dQBp"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id AB3481F00A3A;
	Wed, 22 Jul 2026 15:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784734247;
	bh=aRhMhZuwb/Q7zXP9Xfwf6Ajwa99GR5rC8/Ng6aG/XiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=glZ5dQBpBCsngZ8COuCdOs9/o3KjWwGmeZ1Z+OcZ80sLv2Ul0D/dzMRZ/SWEFAK5w
	 j8TWSNX4IGYLZ4eRp+2mfyBf5AvwQz5l+oJQlYLcex5kKz6wWoIUxYzXd1hdpqp9m6
	 qPKeJ2mSogvkDqCeqFOJEWyE6DZo8p5GFIg6m81NWFtgNTuJ2zKOo5DpywG7sacBx1
	 rgmRqHQWQKI6+BWrofCq78kgcxmUDvNNJ2na0xv5EsoYAj447syCamjFip4bIQXer1
	 AfjETCH07dIj/lwkiideg+0zdXvmko3XXAkT06scaYfNsOX7Us+qC5l3HH/sONH2Iu
	 3jGQoQK18E5uA==
Date: Wed, 22 Jul 2026 18:30:43 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] keys: fix keyring assoc-array out-of-bounds read
 and index inconsistency
Message-ID: <amDiI4jc6fsbUK_X@kernel.org>
References: <20260719161505.2423935-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260719161505.2423935-1-michael.bommarito@gmail.com>

On Sun, Jul 19, 2026 at 12:15:02PM -0400, Michael Bommarito wrote:
> An unprivileged keyring whose keys collide through the description-chunk
> path can drive assoc_array node splitting into an out-of-bounds slot write.
> Patch 1 stops the out-of-bounds read in keyring_get_key_chunk(); patch 2
> makes the chunk byte order agree with keyring_diff_objects(); patch 3 fixes
> the shortcut-walk trim so the walk cannot be steered down the wrong
> descendant.
> 
> v3 changes (patch 1 only; patches 2 and 3 are unchanged):
> Per Jarkko's review, patch 1 no longer extends the existing
> keyring_get_key_chunk() declaration line; the new offset is declared on its
> own line as unsigned int.  No functional change.
> 
> Patches 2 and 3 are unchanged from v2 and carry Jarkko's Reviewed-by.
> 
> v2: https://lore.kernel.org/keyrings/20260714115451.3773164-1-michael.bommarito@gmail.com/
> v1: https://lore.kernel.org/keyrings/20260712014500.480410-1-michael.bommarito@gmail.com/
> 
> Michael Bommarito (3):
>   keys: fix out-of-bounds read in keyring_get_key_chunk()
>   keys: make keyring key-chunk byte order agree with
>     keyring_diff_objects()
>   assoc_array: trim the final shortcut word using the current chunk end
> 
>  lib/assoc_array.c       |  3 ++-
>  security/keys/keyring.c | 14 ++++++++------
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 
> 
> base-commit: 2c7c88a412aa6d09cd04b414211b4ef8553b5309
> -- 
> 2.53.0
> 

I'm setting up the testing environment now and hopefully have final
feedback within let's say "hours" (i.e. I'll do the job, and it takes what
it takes).

BR, Jarkko
