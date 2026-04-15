Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B58014BF92;
	Wed, 15 Apr 2026 02:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776219938; cv=none; b=SsMpFzn4nMIvJYGKR4eNwBqAGL95Uo65ZistnUa+EZbsyLwUujJcTGy76ig4clB6pIMX+gwGb6WEGJKY/XHzo7aCuY1o+ciAbp+UdhTnXMNMO9nd02dc4S1O0SyHikYNHSqCMSZc4Q7/W2J/YYsEYkuL5fLml9c+GigFUMANQeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776219938; c=relaxed/simple;
	bh=RDv2/hpVyGLx9noKIvQfz6MbI61JDBM+Kb73B8RoZEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G/sZy06hRl/WJTUHvmZaDaRhYee44uEOBYk0zK+9jgRV1B1PVZqMtmJgSlEpFtD4fwi5hkhQM4UBKz6PCNKmchJ+/8QALQGINte0N2/Oolaye9y4nWsOY7CGZOcDeJ5qGSWuoDG13P+E3AW9Lwsr0UxHBkziaUOy6/MQZyjs2Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWLTXvUa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWLTXvUa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51690C19425;
	Wed, 15 Apr 2026 02:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776219937;
	bh=RDv2/hpVyGLx9noKIvQfz6MbI61JDBM+Kb73B8RoZEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LWLTXvUanGRf6bxFdMqC9QZFzdFqPqhCY+9AYUCBWMdc/GYL8aHddH3HyJXdwp6c/
	 o6HIz4E2faOnTbFK3zjR3mHfdUqjsem85EccDIajqftta0HXTo//Ji6bmLCjVAL71j
	 zpgc9u/DUajAUJy9SmUVhU7XcNf+EMuBjCAZBS1ZwelapXOPqTUD+2aH93jT0NNjnO
	 72vYrI6HGp2RCoy2BxI59oiaA9kFa8tXFtZiLkaP7alCudHGNNiSf0SL0moJNuJGtg
	 RUGWTh9ndAM3vZbxs0cunzRGvm5r9yg2vl9mNYi9P5hNDh1n3d8S94OOksDfJbYE6R
	 uySZycViFwPyw==
Date: Wed, 15 Apr 2026 05:25:33 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: David Howells <dhowells@redhat.com>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	netdev@vger.kernel.org, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] KEYS: annotate struct user_key_payload
 with __counted_by
Message-ID: <ad73HRSuW-rZlLBQ@kernel.org>
References: <20260409225703.158552-4-thorsten.blum@linux.dev>
 <20260409225703.158552-7-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409225703.158552-7-thorsten.blum@linux.dev>

On Fri, Apr 10, 2026 at 12:57:05AM +0200, Thorsten Blum wrote:
> Add the __counted_by() compiler attribute to the flexible array member
> 'data' to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
> CONFIG_FORTIFY_SOURCE.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Changes in v2:
> - Use __aligned(8) as suggested by David
> - v1: https://lore.kernel.org/lkml/20260409073711.57020-6-thorsten.blum@linux.dev/
> 
> Cc: netdev@vger.kernel.org
> ---
>  include/keys/user-type.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/keys/user-type.h b/include/keys/user-type.h
> index 386c31432789..c29ed9f5d300 100644
> --- a/include/keys/user-type.h
> +++ b/include/keys/user-type.h
> @@ -27,7 +27,8 @@
>  struct user_key_payload {
>  	struct rcu_head	rcu;		/* RCU destructor */
>  	unsigned short	datalen;	/* length of this data */
> -	char		data[] __aligned(__alignof__(u64)); /* actual data */
> +	char		data[]		/* actual data */
> +			__aligned(8) __counted_by(datalen);
>  };
>  
>  extern struct key_type key_type_user;

The change is acceptable but I see no point split the declaration into
two lines (as long as it passes checkpatch.pl as per line length).

BR, Jarkko
