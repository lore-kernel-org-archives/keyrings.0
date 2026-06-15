Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0164833F8A3;
	Mon, 15 Jun 2026 12:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525182; cv=none; b=msOrPhk4uF7RgvSi7ZP60D/zglewnCXu4zM/H71zuORQKumNod/hDOnP0S1qZ4XhcJjZC+5pfJgvf0bsev0LPMWZrsKQIBLKOVQaYXVeS13MubdBWj8v6zW0TLTDD9v7ost0ZS3f4I5Mb6JvR6IBFsp+M+/xLWs2vCPCVnQKcIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525182; c=relaxed/simple;
	bh=NMBWBw26CsazVfHE/BDPu50yLewe2Z0xrQWCO1+HeYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LxSU7DIPlzPotErrRWILWyxo4otGm/zpyLU5JvQ1TUBwrQ46xgLuM9dHN0pg+vlzuEhAEhD6POs0lo2QqVTr+XRoDXFwZ6VEdSjH1I2iNinmM2IVeJxbNWvicjXQY10ee4qcHw6Hg0jK9F6+wPqZRQtFNXe8D5LWIW2xE1L2QxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iurg5bh/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iurg5bh/"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 13A1B1F000E9;
	Mon, 15 Jun 2026 12:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781525181;
	bh=txaycEabgz8RQMutcRh4zHJqAxv1hD15VORupNuZ1o0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Iurg5bh/5Jx4WjEMQuFtsaR7JG2WU7xmGbmxeHJS4IfzAaTRtpELKqMQcdlr5ZXOs
	 89nlrWwlGKI6PBSBALPkglBpbx+VbxmDuqy38RkInmeSv9CeMZ6xDT4D8qJ8jt+sI5
	 rwNU0aEN6A2TaM7BjArf4Za84j42nSRkNZp6b80VNroDZV14J2hXq8htQCy66vGeFu
	 yAZqv5EgnoeL8Irgqe9Fi9t9pcWbeXZM5q2hipp9tzS1OLqqKDWlpDZH2zngUpdqJ+
	 f3zUAsv1xrHBoF1eZInG8a9plFbRzlfI60wJkTnniyrUd5nqC8upXN3dSKB9BX8lFi
	 u30DYs8DHWBtQ==
Date: Mon, 15 Jun 2026 15:06:18 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, kees@kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] keys: request_key: replace BUG with return -EINVAL
Message-ID: <ai_qulp8qvyMyNK5@kernel.org>
References: <20260613130408.13709-1-med08elkadiri@gmail.com>
 <20260613130408.13709-2-med08elkadiri@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613130408.13709-2-med08elkadiri@gmail.com>

On Sat, Jun 13, 2026 at 02:04:07PM +0100, Mohammed EL Kadiri wrote:
> Replace BUG() in construct_get_dest_keyring() default case
> with return -EINVAL to handle the unimplemented group keyring
> destination gracefully.
> 
> Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
> ---
>  security/keys/request_key.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/request_key.c b/security/keys/request_key.c
> index a7673ad86d18..fa2bb9f2f538 100644
> --- a/security/keys/request_key.c
> +++ b/security/keys/request_key.c
> @@ -332,7 +332,7 @@ static int construct_get_dest_keyring(struct key **_dest_keyring)
>  
>  		case KEY_REQKEY_DEFL_GROUP_KEYRING:
>  		default:
> -			BUG();
> +			return -EINVAL;
>  		}
>  
>  		/*
> -- 
> 2.43.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
