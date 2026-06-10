Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3763BB9FC;
	Wed, 10 Jun 2026 09:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781085447; cv=none; b=Z4p8U7gH76a/Z5bJeLDYd7FPbabmVXzXqwGRn0ZmlCUdjzqKhvkUxzu/2XVk9pjwe4ZEfiYirqTuQxfre4pVef1jxhNPa463VG2ChvxPnk343ZHbXU4kVAU2wD6jp2NyBIPsmr9jsj3c0081bja4ohi/pXPxHidEy046uO2bDhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781085447; c=relaxed/simple;
	bh=aOK/oBAWHn3CV+aL+eX+Rak3Rmu51SZxBgS4lfJJJfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgEeyWo5+RZT6om8hCfAeVGQQbssdHhSK5aoZ6j2XgIcKYSaJOWkHJPGLWzq1b/ACSeb/I788JIilxGqMdEUQ9Eu1adElba4TPT+b/5MGNUBZQtXSdngVIYNvF8Fn5/aFnzKF31M9DdDsq7+eQTsPayghMeDOYg9hbdt6lwe/Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8b16b38; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q8b16b38"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 436DD1F00893;
	Wed, 10 Jun 2026 09:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781085445;
	bh=VnGlpoQtfKIEsVKjf7IumpJ/LYNiRRatXj5KMEL7zsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Q8b16b38XDlH7sRo3y6aGQvRwqEZp44GiDSdb7Mc2jsk+dfuyd0yHU2etDmfZYiDu
	 Tb7pRt3Nx+e5W9/tVAEiq6155vknwLfL69PgBv3+r45JvwraSwt4owGiaUPWaXYo2a
	 IpcWtOki620QQiI8BfM1Sl8ZKDk2hYyv0r0CfYvHSyXbnG3YI5zLovwtfFM76V9XFJ
	 K/T1GknduH+nnT0LUPMbrco2GjUsl5fvModwaRVH2yuzjzCaEW/hZfjj1KnqwvTOf1
	 sfCGhuSfxXlbUs6+4aFvzVzQ2TXYFSECj5e8Q4u7XYRfnOFm1lpdXu2UES2CRE4im4
	 VB9FuwZYdglrg==
Date: Wed, 10 Jun 2026 12:57:22 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, kees@kernel.org, vbabka@kernel.org,
	keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] keys: prevent slab cache merging for key_jar
Message-ID: <aik1AiIdGwpv_dkg@kernel.org>
References: <20260610065052.9120-1-med08elkadiri@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610065052.9120-1-med08elkadiri@gmail.com>

On Wed, Jun 10, 2026 at 07:50:52AM +0100, Mohammed EL Kadiri wrote:
> Add SLAB_NO_MERGE to key_jar to prevent the allocator from merging it
> with other similarly-sized caches. This hardens struct key isolation by
> ensuring dedicated slab pages.
> 
> Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
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

I swapped the commit.

https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/log/?h=for-next-keys

BR, Jarkko
