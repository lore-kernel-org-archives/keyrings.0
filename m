Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B71A1D5160;
	Mon, 15 Jun 2026 12:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525208; cv=none; b=MMEQWEYL6U5Ckz3P4Bg0jb4udkA+bY2CysF1LrYaDYHRyk8HRRGzZJ97T876QgRPUmDiMkg6YRgkjuPq+TpbKcuS2z0em3UF6QSaBZRmXA5WX6/UYfRV+x+98+d8oNesCe+GIkuOZ0r+3//84k2X+EHBLOvXP8x5aQOriwYHwVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525208; c=relaxed/simple;
	bh=ZIMxhuDxCWdmYBHNtcIA0eYiDmlet/iUB9dtkyY/qkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usZkWKOGkUbgbinlJ+MmIUZHSDDRHcpGk4ePF8XM7MsIstsH0i/70z1ma0ZmfL0HMJ/zqlh4azW/Ghq9AdV85Fu0xwnsAtXgg2KVDGOtvz3uGh/dOr7nphfcdH0vLMbH+0fRyxVBus5swun72lmrYBn44vWA5hqDvlFzOHiQDvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeF0fuqN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeF0fuqN"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 75CAF1F000E9;
	Mon, 15 Jun 2026 12:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781525207;
	bh=0L+fbfWsGhN+xlLpQva9V7A1R/2F1jFzjoIIItcuE3s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TeF0fuqNn9sWyeYXsyCd5z00Zi1cM5N6MnBAW9lPnHaonmttcEX8WTa9Fm6P002Rp
	 38PcN/J9JQ3i1nF550V1CFvBPaxwNq5Z5JR+ayBb1uD7ryr/RTVakElPXd7cWicTaI
	 NsAk+2AyV//DhbYmMSExOo3J+tp9k3lOCiPDLRVt6XQVcyHROVkMYWalU+5lN7GjHU
	 9JG7EOIXgcqoQv9prcd36AosKkkFnlspUkYGRWF2fKHNxPnhYcPukBEpQexgzf5ael
	 J6Sl66BiwwSqFoVCnPaGZUVo40nfasK6jHRuNmuximndCotzuga7PIVm86wGiNZjs9
	 xdF25Q65YkE5A==
Date: Mon, 15 Jun 2026 15:06:43 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Mohammed EL Kadiri <med08elkadiri@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, kees@kernel.org, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/2] keys: keyctl_pkey: replace BUG with return
 -EOPNOTSUPP
Message-ID: <ai_q07fuXUO3cNea@kernel.org>
References: <20260613130408.13709-1-med08elkadiri@gmail.com>
 <20260613130408.13709-3-med08elkadiri@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613130408.13709-3-med08elkadiri@gmail.com>

On Sat, Jun 13, 2026 at 02:04:08PM +0100, Mohammed EL Kadiri wrote:
> Replace two BUG() calls in keyctl_pkey_params_get_2() and
> keyctl_pkey_e_d_s() default cases with -EOPNOTSUPP, matching
> the error style already used in these functions.
> 
> Signed-off-by: Mohammed EL Kadiri <med08elkadiri@gmail.com>
> ---
>  security/keys/keyctl_pkey.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> index 97bc27bbf079..6b2821ffeb6c 100644
> --- a/security/keys/keyctl_pkey.c
> +++ b/security/keys/keyctl_pkey.c
> @@ -155,7 +155,7 @@ static int keyctl_pkey_params_get_2(const struct keyctl_pkey_params __user *_par
>  			return -EINVAL;
>  		break;
>  	default:
> -		BUG();
> +		return -EOPNOTSUPP;
>  	}
>  
>  	params->in_len  = uparams.in_len;
> @@ -238,7 +238,8 @@ long keyctl_pkey_e_d_s(int op,
>  		params.op = kernel_pkey_sign;
>  		break;
>  	default:
> -		BUG();
> +		ret = -EOPNOTSUPP;
> +		goto error_params;
>  	}
>  
>  	in = memdup_user(_in, params.in_len);
> -- 
> 2.43.0
> 

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thank you.

BR, Jarkko

