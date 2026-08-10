Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AC13D902E;
	Mon, 10 Aug 2026 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366674; cv=none; b=TFEtqWUNovXtrnQ2NlTkcm2qxhEsyMUUJE4H/LPq5+oROZIJPmRs6IZWXpMZgZmM4URpqFVT7E8NvyJigYviMg7xOAB0Qi7ccuzcdIUlu6obsd6xwOShQvhBfnHmrAXRvSRZMtjUODC7O0J5gyAAYkzeyq49FREA5eAJ+M81+GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366674; c=relaxed/simple;
	bh=DQjf+KucJ+jed7ob44FFbJu5tppNMb5li7uPQiokmTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHJZGVAWEiecM+L7aBkoB3Si/26PyrbUlGrz8acdIdzpxlCbLhc+ZTsJkMApuSC4YNL+xSRYjxHX3lpnYdYy62n9F8jetzg73HV6BGfu7wHCeEk6DjudZ3OCGvU9QIJ33UXWhfZcqSVAQb6sRrENpwXlWKIm2YSQ+orZPJffgJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIubOLfp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIubOLfp"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id DA9DB1F00A3A;
	Mon, 10 Aug 2026 12:57:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786366672;
	bh=3ZeEy7IuBwMj26/HiR6/hC3qNvr2j5BrXzeiwUpb40k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mIubOLfp/5bqJTFBZTzj3RpXFNGFBReUQmUom84L1q+iouwfc+/HTFhJsOBgyTZz5
	 sSHyO52hkl6xkuzTEI2f50MdlGc9WTIFoLxvbOc2xSkIVI9UNCx/pzDwCqHKXiHWl2
	 M0ua1HT1FxfSO5CPhnwg8GGOEcwwgu+bu7DrFqxqlNNCbYEBrXk7QEtCH1YbQ+cNp+
	 EDl32LgWI2SMSpzevQD41Xbt+NGGmNaUtUNEWraZaLCQrpjTKVlUshyZLQZpSH0GYo
	 w5paHIfIRaBBH+jTyZOaNXms/bh9lH6YzEtbXZBzRO99AxpRW9zcYER/8J1O8FqLOh
	 PAxHsBZNPq5ow==
Date: Mon, 10 Aug 2026 15:57:48 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org, Jeffrey Altman <jaltman@auristor.com>,
	keyrings@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH net v5 06/10] keys: Add refcounting to user-defined key
 type payload
Message-ID: <annKzJSDhvHjk-wK@kernel.org>
References: <20260729160108.2031453-1-dhowells@redhat.com>
 <20260729160108.2031453-7-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729160108.2031453-7-dhowells@redhat.com>

On Wed, Jul 29, 2026 at 05:01:03PM +0100, David Howells wrote:
> Add refcounting to user-defined key type payload so that a kernel service
> wanting to use such a key can hold onto the payload without the RCU read
> lock held in order that it can do an allocation without having to be
> concerned with the key getting updated.
> 
> This is the first part of the fix for the AF_RXRPC challenge response
> generation code.
> 
> Link: https://sashiko.dev/#/patchset/20260624163819.3017002-1-dhowells%40redhat.com
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Marc Dionne <marc.dionne@auristor.com>
> cc: Jeffrey Altman <jaltman@auristor.com>
> cc: Eric Dumazet <edumazet@google.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Simon Horman <horms@kernel.org>
> cc: Jarkko Sakkinen <jarkko@kernel.org>
> cc: linux-afs@lists.infradead.org
> cc: keyrings@vger.kernel.org
> cc: stable@kernel.org
> ---
>  include/keys/user-type.h     |  2 ++
>  net/dns_resolver/dns_key.c   |  1 +
>  security/keys/user_defined.c | 23 ++++++++++++++++-------
>  3 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/include/keys/user-type.h b/include/keys/user-type.h
> index 386c31432789..7002a993a472 100644
> --- a/include/keys/user-type.h
> +++ b/include/keys/user-type.h
> @@ -26,6 +26,7 @@
>   */
>  struct user_key_payload {
>  	struct rcu_head	rcu;		/* RCU destructor */
> +	refcount_t	ref;
>  	unsigned short	datalen;	/* length of this data */
>  	char		data[] __aligned(__alignof__(u64)); /* actual data */
>  };
> @@ -37,6 +38,7 @@ struct key_preparsed_payload;
>  
>  extern int user_preparse(struct key_preparsed_payload *prep);
>  extern void user_free_preparse(struct key_preparsed_payload *prep);
> +void put_user_key_payload(struct user_key_payload *payload);
>  extern int user_update(struct key *key, struct key_preparsed_payload *prep);
>  extern void user_revoke(struct key *key);
>  extern void user_destroy(struct key *key);
> diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
> index c3c8c3240ef9..aa3c058f4095 100644
> --- a/net/dns_resolver/dns_key.c
> +++ b/net/dns_resolver/dns_key.c
> @@ -208,6 +208,7 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
>  		kleave(" = -ENOMEM");
>  		return -ENOMEM;
>  	}
> +	refcount_set(&upayload->ref, 1);
>  
>  	upayload->datalen = result_len;
>  	memcpy(upayload->data, data, result_len);
> diff --git a/security/keys/user_defined.c b/security/keys/user_defined.c
> index 6f88b507f927..90c1bd5d7dfe 100644
> --- a/security/keys/user_defined.c
> +++ b/security/keys/user_defined.c
> @@ -67,6 +67,7 @@ int user_preparse(struct key_preparsed_payload *prep)
>  	upayload = kmalloc_flex(*upayload, data, datalen);
>  	if (!upayload)
>  		return -ENOMEM;
> +	refcount_set(&upayload->ref, 1);
>  
>  	/* attach the data */
>  	prep->quotalen = datalen;
> @@ -88,12 +89,22 @@ EXPORT_SYMBOL_GPL(user_free_preparse);
>  
>  static void user_free_payload_rcu(struct rcu_head *head)
>  {
> -	struct user_key_payload *payload;
> +	struct user_key_payload *payload =
> +		container_of(head, struct user_key_payload, rcu);
>  
> -	payload = container_of(head, struct user_key_payload, rcu);
>  	kfree_sensitive(payload);
>  }
>  
> +/*
> + * Free a user defined key payload.
> + */
> +void put_user_key_payload(struct user_key_payload *payload)
> +{
> +	if (payload && refcount_dec_and_test(&payload->ref))
> +		call_rcu(&payload->rcu, user_free_payload_rcu);
> +}
> +EXPORT_SYMBOL_GPL(put_user_key_payload);
> +
>  /*
>   * update a user defined key
>   * - the key's semaphore is write-locked
> @@ -115,8 +126,7 @@ int user_update(struct key *key, struct key_preparsed_payload *prep)
>  	rcu_assign_keypointer(key, prep->payload.data[0]);
>  	prep->payload.data[0] = NULL;
>  
> -	if (zap)
> -		call_rcu(&zap->rcu, user_free_payload_rcu);
> +	put_user_key_payload(zap);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(user_update);
> @@ -134,7 +144,7 @@ void user_revoke(struct key *key)
>  
>  	if (upayload) {
>  		rcu_assign_keypointer(key, NULL);
> -		call_rcu(&upayload->rcu, user_free_payload_rcu);
> +		put_user_key_payload(upayload);
>  	}
>  }
>  
> @@ -147,9 +157,8 @@ void user_destroy(struct key *key)
>  {
>  	struct user_key_payload *upayload = key->payload.data[0];
>  
> -	kfree_sensitive(upayload);
> +	put_user_key_payload(upayload);
>  }
> -
>  EXPORT_SYMBOL_GPL(user_destroy);
>  
>  /*
> 

It's quite solid change imho.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
