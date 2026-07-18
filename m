Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FFA31A04D;
	Sat, 18 Jul 2026 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784399019; cv=none; b=slzIGwfQS2F5Ed9+HwaTVn5c7wdzgUpf8mUMd7gvRM/Y2hoW9uC7U/K2ZZx63zjHyTVysFSAYCmBSkUnXt3//bRl1hw8pjI50hHg4JyfZntwBwMtcEA6OnKcGFMknBXcQrpROPWLSfRfLaNSfjB67okZBOgAOCU+355tcaMQPyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784399019; c=relaxed/simple;
	bh=wEqfKIr1mT9ld/U/ypyNCupN314SqtNlwcvM2UWxf1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tsZhmagy36HmIwa5rHkUvhGQ4IPBDf4QrR7oVhrtHRo+G0WdUyVbYhxFQe72bVVn0xezxjRTakDRT+Z3xd0HEjA3i8NmcbzoaARhkQWMtnW0FqvSRS3F0PdvHpkgaKr263/GLUbCLqYR/3lDGfZEhvg1NfdmBLCjhBbL0A33Iq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTwSwRmZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTwSwRmZ"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7BA531F000E9;
	Sat, 18 Jul 2026 18:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784399018;
	bh=wabnUQ7FZEz7Rfy2aims9V1MA4VS7Zmje25yjyLtt74=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aTwSwRmZRDZRRmhckXcgtLfHEGaxWidOWdFozZyMEQaErqHuLg2vMkqvEIT3fpF5j
	 gi4sZ6VlvfwbqwqFWfFrhtB9/EJSwuwRM3HGSxX1O0fGDotd8BqZqV94OKW//+V8jl
	 NdOZKN0uzDuu+3NKXu/8CcJPG+cDzrpSBMDvPU+DPkEGykEOgYc2RoYQd2J3IseXvn
	 LYUZeXdMGMhcxWJ3ViG42xcRfh8qqK13bpKCCKPWzjUriS+RftTv/7W1ZB/w1T4q6U
	 scNX7U1leVpt9815mrWWVaJoYEam7CDZ+zEJsvBbuJVPzcWjyNNPI4wdISHl6bZr5S
	 wATpv05IujKYg==
Date: Sat, 18 Jul 2026 21:23:34 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] keys: fix keyring assoc-array out-of-bounds read and
 index inconsistency
Message-ID: <alvEpnv-IyXDhfeu@kernel.org>
References: <20260712014500.480410-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712014500.480410-1-michael.bommarito@gmail.com>

On Sat, Jul 11, 2026 at 09:44:57PM -0400, Michael Bommarito wrote:
> keyring_get_key_chunk() advances the description read pointer by
> level * sizeof(long) past the inline prefix but only bounds-checks the
> prefix, so once the associative-array walk reaches a description-level
> chunk it reads past the kmemdup(desc, desc_len + 1) description
> allocation.  Reaching that depth needs two keys that collide through the
> hash, x, type and domain_tag chunks, which an unprivileged add_key(2)
> can arrange with a crafted pair of same-type keys.

Thanks for the description. I fully get the scenario from this.

> 
> An unprivileged user can thus read up to sizeof(long) bytes past a
> keyring key's description; on kernels built without init-on-alloc the
> same collision, read back with KEYCTL_READ, returns uninitialized kernel
> slab.
> 
> Patch 1 is the memory-safety fix and stands alone.  Patches 2 and 3 fix
> two index-key consistency bugs that let the crafted keys collide into a
> single malformed node in the first place, which is what enables the
> KEYCTL_READ disclosure.
> 
> The KASAN reproduction is on patch 1. Trigger is available off-list.
> 
> Michael Bommarito (3):
>   keys: fix out-of-bounds read in keyring_get_key_chunk()
>   keys: make keyring key-chunk byte order agree with
>     keyring_diff_objects()
>   assoc_array: trim the final shortcut word when skip_to_level is
>     chunk-aligned
> 
>  lib/assoc_array.c       |  2 +-
>  security/keys/keyring.c | 15 ++++++++-------
>  2 files changed, 9 insertions(+), 8 deletions(-)
> 
> 
> base-commit: 2c7c88a412aa6d09cd04b414211b4ef8553b5309
> --
> 2.53.0
> 

BR, Jarkko
