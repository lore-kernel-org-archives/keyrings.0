Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755453019C8;
	Fri,  2 Oct 2026 03:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790911105; cv=pass; b=tihm/4E9NBku5uoQzCID9OWhU9aM45pjsvA6su//RypdvAIjkJy5z5oBstCHJ133EVf0+IwNnchtWZBBogjqlaHlS5iJFfI4kcfMVHGmfFMW8L3e0bi4OQ5LdvzlD5BOaAABj0ENEe9umyWei10WCSKq9T/zDFG2063ssReRK+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790911105; c=relaxed/simple;
	bh=xGr1vx5ldRLqyMndGoyB8PIItqJnhJ3UVPY+IRlSnzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1mOhLehuu+j0T2aApK2QRNGqC3XoEytbMLPtf2GlhYYa0wfSAhifm+IxHB+DBlOs8hjO0LyhxuiOgkUoFq/7R3hfVpHs1Xi8ZDuy2mQBVHjR1+B0/8plPuwz0koHWy8L+2PLMIAeStacBZjwaLrACv70ls/Vt8Dny39X7Mp2aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qTvs61JE; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qTvs61JE"
Received: from localhost (n216spl99sn8f5wgjwv-1.v6.elisa-laajakaista.fi [IPv6:2001:99a:1e1:d200::ccf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by meesny.iki.fi (Postfix) with UTF8SMTPSA id 4hwvB608FyzyQx;
	Fri, 02 Oct 2026 06:18:21 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1790911102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j2LAoX1JBiGcOfRoUj2Z77dk4oMHTuKfjtptGQHQFJM=;
	b=qTvs61JEPcLwDZ1s1ITuKTcNg2Jfb4TaNvJ9X6ZU8aiNBidn5L5X1Q0+CQhJq/IulybZPf
	DsRZ+EbHAyfm2Cte9HpOxd/eM/4P42f6oF3rQcMXhGHjYqMKwzg0dE92gdT5s3vfXdS495
	m6pkU7ImukePNn/dNMJ7pGX01hUXvBE=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1790911102;
	b=bMVmI5ZCiwxVoi5rkezwciGR7RW7d7QVDLzQ6m7rHeXNl/cRXKrPG75+cRtAklg1wnvYAj
	vQMrinC1YZuHg7aHXQwIHRHy5AuXYBo4Eirw9V8t4dGyOWyjijyrRLA+DkbVGMRH/bz7xp
	G9Rd4ihPRZsInP3MCRuyaFfGgsWCzYk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1790911102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j2LAoX1JBiGcOfRoUj2Z77dk4oMHTuKfjtptGQHQFJM=;
	b=mzEVECKPNdd+rl6jluk4mw/yznIcpyF+F6yrap+Tw5iHKKT5BFTa3boSkBAG03oRKsfV09
	XMkge6kmAuoVRd/vkgH1QrMVAi6sxS1k2vgH9ljhWgn2irou4p5e0VOGar/jODsjzxtq/g
	ZfnvYtjVWBhym8WbFjzQYGDnToe26iU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
Date: Fri, 2 Oct 2026 06:18:20 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To: tjdqudcks0424@naver.com
Cc: jarkko@kernel.org, dhowells@redhat.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KEYS: Fix add_key() race with keyring restriction
Message-ID: <ar8ifHy-CQUfxfID@iki.fi>
References: <20260930041802.6114-1-tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260930041802.6114-1-tjdqudcks0424@naver.com>

On Wed, Sep 30, 2026 at 01:18:01PM +0900, tjdqudcks0424@naver.com wrote:
> From: 성병찬 <tjdqudcks0424@naver.com>
> 
> __key_create_or_update() snapshots keyring->restrict_link before taking
> the destination keyring's semaphore.  keyring_restrict() installs a
> restriction while holding that semaphore.
> 
> This allows a writer to observe no restriction, wait for the keyring
> owner to install a reject-all restriction and return successfully, and
> then link a key using the stale NULL snapshot.  The writer only needs
> write permission on the destination keyring.
> 
> Move the restrict_link read after __key_link_lock() and
> __key_link_begin().  The read and the subsequent restriction check are
> then serialized with restriction installation by keyring->sem.
> 
> The race was reproduced on v7.2.8 in 19 executions where restriction
> installation returned before the link completed.  All 19 linked the key
> despite the reject-all restriction.  With this change, 312 executions
> reached the same ordering and every add_key() call failed with -EPERM.
> 
> The issue was found by manual concurrency analysis assisted by AI-based
> analysis and independently verified with a QEMU reproducer and kernel
> instrumentation.
> 
> Fixes: 5ac7eace2d00 ("KEYS: Add a facility to restrict new links into a keyring")
> Cc: stable@vger.kernel.org
> Signed-off-by: 성병찬 <tjdqudcks0424@naver.com>
> ---
>  security/keys/key.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/security/keys/key.c b/security/keys/key.c
> index b34a64d81d47..a438c4508595 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -840,9 +840,6 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
>  
>  	key_check(keyring);
>  
> -	if (!(flags & KEY_ALLOC_BYPASS_RESTRICTION))
> -		restrict_link = keyring->restrict_link;
> -
>  	key_ref = ERR_PTR(-ENOTDIR);
>  	if (keyring->type != &key_type_keyring)
>  		goto error_put_type;
> @@ -880,6 +877,9 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
>  		goto error_link_end;
>  	}
>  
> +	if (!(flags & KEY_ALLOC_BYPASS_RESTRICTION))
> +		restrict_link = keyring->restrict_link;
> +
>  	if (restrict_link && restrict_link->check) {
>  		ret = restrict_link->check(keyring, index_key.type,
>  					   &prep.payload, restrict_link->key);
> 
> base-commit: 6f8319e3e9a44dd537d17f41565a8453c560a581
> -- 
> 2.43.0
> 


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Thanks.

Br, Jarkko
