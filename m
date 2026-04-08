Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1101391856
	for <keyrings@vger.kernel.org>; Wed,  8 Apr 2026 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775679920; cv=none; b=JZ0rRmTHJQ7xedGVsz7vlJKcOSc3x8Y1FPjILaxLSIR9f1Ruy8dE2hh6t5PV2bL1gRIV+xK0xmnfH9cAnM/1NHT+yDzFkR9xQMGDIBqhhEM9beClYP+UCOxMYnwj/HkWMHg2naR8BYYcbALqEUfPhGtFMsJQCYt+dy4VQxUKr+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775679920; c=relaxed/simple;
	bh=YK2ErFGtqJmjNXRFUKyoD+PTGXRuF4JLe0eoAfWTn3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EANSSR8xAIgJ8+94Qe/zam+yRWcufw8cAVtdVgTRZTgO+C0TJjWm24Jf62t+Uyejkk1PwHLL+Njw4lW9YWm28oneQXeIOzFF0ybPOjVUYxIld8GLgy/hwQdGpMcFRpQ0u1Ck1o5PACrrVT3xN7oqV8Itnlx8tOWIG08PN7CBOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h+4CDHXV; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h+4CDHXV"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c76c067bc51so86696a12.0
        for <keyrings@vger.kernel.org>; Wed, 08 Apr 2026 13:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775679918; x=1776284718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qtez7uO2X5FjsGHqGis7qBChcDlylFjTSAlBvJbABwk=;
        b=h+4CDHXVKB5TtWWN1DQ4w19egGCrJEuQ7L2O729FNN6ypKu8RYyLM31dYGeETYo73t
         9kUT/25ZSaplj+XAKaDnwuRMSaH11T+IrISdl4sCB/Rc29bS8EMC5uq230Y6jyErv4nZ
         5EpYLz9phFMW6iXjY49RUCn6Fr++JRhzC0LeoBiZVY5LcvN+wQ8pE6I76QpP06vzYn/A
         /AxcW213j6RVOpULzBq9OaZNSK+NFtP3OBZoYz0XLnpYq1QfhZaHbAWHtPSfGL6Z5tvN
         qZYtwbk3D3dDQDDuakz7IwSijDpLnTTDhA0N4oDKUJ9ylmnDaeyH5V9yu2GQ8iZPimPY
         S7XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775679918; x=1776284718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qtez7uO2X5FjsGHqGis7qBChcDlylFjTSAlBvJbABwk=;
        b=MqQmA6FJ5UMhqaY0OeRSqaUTQmLQ43u6UTGckvnAwvmybexHmr1YZk3cZgzHeePahe
         P7NRI4miLRcadGcM2uLMGSqT8E6b4/xLDdetFGOE2zmSPewrp6ZTnfIS38NdCCZBUsdX
         4csYpmFlkFuFcdzynye738LzCjQmYHnlix9wPmLO5U3XV/eXdL8bxrxY1MGrFZyL3ThP
         i6FB+u1ni2p8x28rYVpCCYTYH+zeVW+HBUWXndJ/tQqq0hsITtrRiOEQ6yLxbKgQDSJm
         Hdy/3F3lKgFnuVV4eIy6zLlxL3J/kkyvtgIhHXuYdpeizX2Q4Cz+DZAgxcxXzjbaN21B
         HxVg==
X-Forwarded-Encrypted: i=1; AJvYcCUn+N75b7/GarUso4vCDCGIzi1flh3+2crY6M44XS/nPnhaqbGgJELOpgBZ12l9UOd56DRSCE5Ntg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzogf3hRTsQc++JUvy7E1R8OjTYA2AAm2zhUmb2wQBYsafRtccF
	FBYekF3ayjIHUkNudKh383PaZ1KqjNb59DIBPYZBSeVoG+xIr54kZoplL7EY2UJiJdHaespI/d1
	wHm1fPw==
X-Gm-Gg: AeBDieueTLlkir8/t3fcKYTjGmdrn//ysYBYtqQV9+P8TaJ+zDeTiIow2RPBz3VKwcv
	txRX8jGmzbAWGztUU1uXqNlCn9V+1BUbpX8B3iiq9Ib2fThzB4Hv0WChiy2jwXsieoogDcSNx3h
	kjcxMAAjMcvoYyB5u0GzrBOfbYQ7raJMSazk5z+vH0zB1RBTh5m/ajAxm3jJm8xmbMBEbxmNVBx
	bz619L0qDy4adEENKDNCuc3g/cSk2I8PD5z52DAa01dv4yL4RqEF0yBxfGlZ7pxqQwIB5Wc4Sja
	xbYVjjs85h7ngy5SAC1e/JeDWK3nIjxSEmCJ6YaoG6wcRQqkH68Z/fMdIYoP5DRoTdhCAY/7Fmf
	3CRFPaO7u1I7yNM5H0qQjco+0BnaVM9ngObKxRg2XLjbLxyVcfTZN58/wfMsmbk3+lgm2HbLL62
	w805Q2uzJXLdZeo9eAjmVfMq/eTWT9rlj9VXgJqjLR2+zDZWzqwLyFslicn+/DinIS
X-Received: by 2002:a05:7022:40b:b0:12a:8ea4:252 with SMTP id a92af1059eb24-12c28b7f511mr541759c88.4.1775679917525;
        Wed, 08 Apr 2026 13:25:17 -0700 (PDT)
Received: from google.com (78.93.125.34.bc.googleusercontent.com. [34.125.93.78])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bfea5f860sm21165384c88.2.2026.04.08.13.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 13:25:16 -0700 (PDT)
Date: Wed, 8 Apr 2026 20:25:12 +0000
From: Nick Desaulniers <ndesaulniers@google.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: David Howells <dhowells@redhat.com>, 
	David Woodhouse <dwmw2@infradead.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, keyrings@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] extract-cert: Wrap key_pass with '#ifdef
 USE_PKCS11_ENGINE'
Message-ID: <ada5jlwkMYrtfRHv@google.com>
References: <20260325-certs-extract-cert-key_pass-unused-but-set-global-v1-1-ecf94326d532@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325-certs-extract-cert-key_pass-unused-but-set-global-v1-1-ecf94326d532@kernel.org>

On Wed, Mar 25, 2026 at 06:19:15PM -0700, Nathan Chancellor wrote:
> A recent strengthening of -Wunused-but-set-variable (enabled with -Wall)
> in clang under a new subwarning, -Wunused-but-set-global, points out an
> unused static global variable in certs/extract-cert.c:
> 
>   certs/extract-cert.c:46:20: error: variable 'key_pass' set but not used [-Werror,-Wunused-but-set-global]
>      46 | static const char *key_pass;
>         |                    ^
> 
> After commit 558bdc45dfb2 ("sign-file,extract-cert: use pkcs11 provider
> for OPENSSL MAJOR >= 3"), key_pass is only used with the OpenSSL engine
> API, not the new provider API. Wrap key_pass's declaration and
> assignment with '#ifdef USE_PKCS11_ENGINE' so that it is only included
> with its use to clear up the warning. While this is a little uglier than
> just marking key_pass with the unused attribute, this will make it
> easier to clean up all code associated with the use of the engine API if
> it were ever removed in the future. While in the area, use a tab for
> the key_pass assignment line to match the rest of the file.
> 
> Cc: stable@vger.kernel.org
> Fixes: 558bdc45dfb2 ("sign-file,extract-cert: use pkcs11 provider for OPENSSL MAJOR >= 3")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> I am taking a fix for a similar warning in modpost through the kbuild
> tree so I don't mind picking this up with an appropriate Ack or it can
> just go through the keyring tree, does not matter to me.
> ---
>  certs/extract-cert.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/certs/extract-cert.c b/certs/extract-cert.c
> index 7d6d468ed612..54ecd1024274 100644
> --- a/certs/extract-cert.c
> +++ b/certs/extract-cert.c
> @@ -43,7 +43,9 @@ void format(void)
>  	exit(2);
>  }
>  
> +#ifdef USE_PKCS11_ENGINE
>  static const char *key_pass;
> +#endif
>  static BIO *wb;
>  static char *cert_dst;
>  static bool verbose;
> @@ -135,7 +137,9 @@ int main(int argc, char **argv)
>  	if (verbose_env && strchr(verbose_env, '1'))
>  		verbose = true;
>  
> -        key_pass = getenv("KBUILD_SIGN_PIN");
> +#ifdef USE_PKCS11_ENGINE
> +	key_pass = getenv("KBUILD_SIGN_PIN");
> +#endif
>  
>  	if (argc != 3)
>  		format();
> 
> ---
> base-commit: d2a43e7f89da55d6f0f96aaadaa243f35557291e
> change-id: 20260325-certs-extract-cert-key_pass-unused-but-set-global-23007ecfadf9
> 
> Best regards,
> --  
> Nathan Chancellor <nathan@kernel.org>
> 
