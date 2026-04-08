Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897A93AD50F;
	Wed,  8 Apr 2026 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775638949; cv=none; b=pQi59Zn5YbuLaTpNmSmPxMhUTRQ3UN011iDE91HATPBJeU34uOxBUZADjhmsOrf/YlPRSQAtTNfCA2dUlasKp9jqFMwv+mYq4g0PqjhEJ58bj/35nCfZbh1OsYw6BhhmMeIwGkt6cHhMNVzqYq+QHQSRZcmGAfxNWKgX4S3x4FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775638949; c=relaxed/simple;
	bh=8HJY8cNdJXb02kkoJJ7x9aMgy8ezsiUjKxHotqn5Sv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sv5mUw6HisZa1H5pYGaA3o2b/RILDQHnw4Vv0N8Or4PUywZd02b8HVSrsdICiYzLfZ17szzUPQ4+4Upj9Nxdzz4h/IXmSQPz6fjQNw+LUZ/75WwgS6EJvlBJIvXc/zn7ienv9YpmrHCiQN1fZkt1ZGojiYFsAz+ouvkaJ0t6OV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hV4a7JFr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hV4a7JFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D496EC19424;
	Wed,  8 Apr 2026 09:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775638949;
	bh=8HJY8cNdJXb02kkoJJ7x9aMgy8ezsiUjKxHotqn5Sv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hV4a7JFrJaiwBGe/mEElR+CppACwETMdyePFujVL/U1soO89eOcWL79XDO7fChcd9
	 61tYC1KDhqdpaLRBqFxR162I1xq3vYuPD8dwX8L+b80CroZhdnZwJy4VjXfRHhA6XA
	 gH+0/WdAfV2cYDkOLmJo0v6AtifnydC03YcHYv7k6Z9I/Ofd2xJIlNrWjuwARs1Zo0
	 Jo+6jh1NFDzCopnqNANvtxckn+cOO63Ber2p/9PJRa1QYV453fQ80e8z+3kzKPGcdQ
	 IKuSw95nY3n1a2K3lwTmwZ18NNWKOAMOhnjGMRhQWUvXQ10C12KJhSwZ5ZRiqjYS4R
	 B6JED8Usq4Q9Q==
Date: Wed, 8 Apr 2026 12:02:25 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: David Howells <dhowells@redhat.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] KEYS: annotate struct user_key_payload with
 __counted_by
Message-ID: <adYZoWK_CTv2-RA_@kernel.org>
References: <20260406175810.1018681-3-thorsten.blum@linux.dev>
 <20260406175810.1018681-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406175810.1018681-4-thorsten.blum@linux.dev>

On Mon, Apr 06, 2026 at 07:58:10PM +0200, Thorsten Blum wrote:
> Add the __counted_by() compiler attribute to the flexible array member
> 'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  include/keys/user-type.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/keys/user-type.h b/include/keys/user-type.h
> index 386c31432789..2305991f4fcd 100644
> --- a/include/keys/user-type.h
> +++ b/include/keys/user-type.h
> @@ -27,7 +27,8 @@
>  struct user_key_payload {
>  	struct rcu_head	rcu;		/* RCU destructor */
>  	unsigned short	datalen;	/* length of this data */
> -	char		data[] __aligned(__alignof__(u64)); /* actual data */
> +	char		data[]		/* actual data */
> +			__aligned(__alignof__(u64)) __counted_by(datalen);
>  };
>  
>  extern struct key_type key_type_user;

You don't provide any evidence of any improvement.

BR, Jarkko
