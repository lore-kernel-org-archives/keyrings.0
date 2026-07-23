Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACE841D212;
	Thu, 23 Jul 2026 13:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784814941; cv=none; b=d/3uba5rQYZzxYVC/gFCEOqwooP8sp1dJve1nMXM0MCPclfNdgtwOxUXFnQ4Bzmizkms4wh6TuW0VBZocvDRIqz99PVOGyaw9IVkfjhmMGBckx22FYIHCDyWwHFteQ4+8+Ll3uZGL4ZoGSrkkr4nLsKaBg26OFc2JqOA6W3Crno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784814941; c=relaxed/simple;
	bh=gPfaBIEUbCJuZFjFDI82bzYXaD6Ke1P53mtSqYhh4kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYLgTlUeWce3touKAjoF45P/1RyPI9p7+lcG/A4BCBLFStFe6j5ObcTlmK5Vz99hzSQpf1kUyMSUdAPox5SkPx3RbjvrrqcT0/Rqq3ONXkUsGfF2Q8YtFlaT1hNrMpyeWuRXN1BTdJnzbe2aYCYXvYNuX+5zxkfnBLRRk08niTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 9E29A1F00A3A;
	Thu, 23 Jul 2026 13:55:29 +0000 (UTC)
Date: Thu, 23 Jul 2026 16:55:26 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org, Jeffrey Altman <jaltman@auristor.com>,
	keyrings@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH net v4 5/9] keys: Add refcounting to user-defined key
 type payload
Message-ID: <amIdTmFwqpxOsPT6@kernel.org>
References: <20260723100309.530157-1-dhowells@redhat.com>
 <20260723100309.530157-6-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723100309.530157-6-dhowells@redhat.com>

On Thu, Jul 23, 2026 at 11:03:01AM +0100, David Howells wrote:
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

Nit.

Maybe a field comment just for the sake of coherency with the rest of
the fields?

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

As a field comment does not require +1 round:

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
