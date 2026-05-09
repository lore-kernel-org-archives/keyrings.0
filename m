Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD7D13A3ED;
	Sat,  9 May 2026 11:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778325846; cv=none; b=oRCwqpLRLt6zA9pKtJJDvBoRdLRm5a9lTZscGsXHU+UbUfxjgVG0GYr0ZsxEB7UiGwsU88YbpBwv0FKa4RfiKrhRj3RjABKbku18f8ta6JxjVb3RxaZh1ZCssEi/nVXVWcFVGIyUzFa0WjsGke6wIjigkcQjI6/5josttOcWvWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778325846; c=relaxed/simple;
	bh=7ayMmq7ivsgMBveJdVw3QYa5SOV7ZTboJupnxjiCABA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgJReW/2N83oxU9FFwwTSdMtTdL6zx2H03n7BisST5L5aRlVvkxfY+7q5p/zhqCAIY9c8dctgh3zbfi0Ek2mdggyUp3H0yT2r5LkPw7NiQ4llGfKxZUlVSsVnxudC3Gyx8MGD8QQE9RNeEhjR7k++HhB9898kxo3CJ8ZJbuVyHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5CxC3xC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5CxC3xC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135B7C2BCB2;
	Sat,  9 May 2026 11:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778325845;
	bh=7ayMmq7ivsgMBveJdVw3QYa5SOV7ZTboJupnxjiCABA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I5CxC3xCfyr37UrDtD6523B4KCGKVejuwASuqpDUs2hAHqujLnmMjwLmeKzygi/8s
	 d+YYvIhcPJ9uWzr8NhlsnmjtVGyLm0ufNyDTQDYSHPj58YAYcr8xcLMpKnyIT8ppeq
	 WzcPWWcyttGy38jJEpvYP2X2B77VByoAfcxW+uFJwjYsNkSDW7C6HQTMwGuatqaggI
	 LmVEygAPEgkNjLz6zS9xLzCZkKEUPbPytinnAtzaIlIVDeBCDZI1WaBx2YvQfyBja5
	 B50McnVCBNiwTnxW4lZwMwYHY1IausDIVqPpnxEbZAad8bdG0M/TvglGA5fFey+0CL
	 uBJoFE3x6mzcA==
Date: Sat, 9 May 2026 14:24:01 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: David Howells <dhowells@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Tim Bird <tim.bird@sony.com>, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] KEYS: annotate struct user_key_payload
 with __counted_by
Message-ID: <af8ZUXn4uStU_vs5@kernel.org>
References: <20260427114422.313356-3-thorsten.blum@linux.dev>
 <20260427114422.313356-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427114422.313356-4-thorsten.blum@linux.dev>

On Mon, Apr 27, 2026 at 01:44:24PM +0200, Thorsten Blum wrote:
> Add the __counted_by() compiler attribute to the flexible array member
> 'data' to improve bounds checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

This is again a crippled commit message.

I.e. this requires either knowing, remembering and/or cross-referencing
"bunch of" unrelated to keyring.

I gave up already.

BR, Jarkko

> ---
> Changes in v3:
> - Formatting only, do not split the declaration into two lines (Jarkko)
> - v2: https://lore.kernel.org/lkml/20260409225703.158552-7-thorsten.blum@linux.dev/
> 
> Changes in v2:
> - Use __aligned(8) as suggested by David
> - v1: https://lore.kernel.org/lkml/20260409073711.57020-6-thorsten.blum@linux.dev/
> ---
>  include/keys/user-type.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/keys/user-type.h b/include/keys/user-type.h
> index 386c31432789..30de4f92a721 100644
> --- a/include/keys/user-type.h
> +++ b/include/keys/user-type.h
> @@ -27,7 +27,7 @@
>  struct user_key_payload {
>  	struct rcu_head	rcu;		/* RCU destructor */
>  	unsigned short	datalen;	/* length of this data */
> -	char		data[] __aligned(__alignof__(u64)); /* actual data */
> +	char		data[] __aligned(8) __counted_by(datalen); /* actual data */
>  };
>  
>  extern struct key_type key_type_user;
