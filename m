Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12D739BFFE;
	Thu, 20 Aug 2026 23:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787269012; cv=none; b=PROcfzpIFMjXoSuk41PxKHc3Tbwr1GHak4QlObetUGCa45LLHKg5OejGO0s8WU9ftGh0WjIpb8p45GbU1tHQ+FNJvQRkYZ9xpwUwpH6HQe0dYR8Xb80Q18Yfz3wf6aHhqaGc+j/GRtkU39VkmdUIiF1Gi/ck5DYKddG/BMEzaWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787269012; c=relaxed/simple;
	bh=WYdS8cuXDQ4Jbws4BDAaBy1iXKHcHdiyXPopP085M+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gqSJ2iSVcfWW7f64r5dkIJv1ENZtG7FILKSnMX7xzbMxPHda4NPWbaPe1AXK0qt03ydJIla4InWhAmzFn/uMDBzsvepqWV6s28LxjEdveT5jv/mv3MyntmvfCGHyE80ssPpTHfoJu8/UzFGQOsbjEXwg93p1rFhYQa3ZKTwTWTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMj2JenB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMj2JenB"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B3E331F000E9;
	Thu, 20 Aug 2026 23:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787269011;
	bh=Zh9idyOh197MX3SCXLYzWxIQZd6s6K24PVFf7BacxzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VMj2JenBtyjelTQFTPnYDVQrlGy+jExggBnh3IcSoXVQp/qUumqzw6jvmQC2LW7sg
	 JM7FK2QQXl7n3QMjMaOZAlUizM4+OO3AA9x0/WRZcQlC4qI3SET8lSZyzDFEsInZl1
	 9cKH+RbppRbTh8lfMe6Z9bVnhSXwvNiBH5wMBT1MgwZorsmA1Qe1/vmyD9+/uq3SVq
	 B9WMX+PBigyM4clft9RfkCdmsddZP4/T1OnVjQABDYjTWvnMuiwaZGjy8Q+yLqfExr
	 EUPX7yA3R4zoOw70KnpfGlIeP49C7U91dJBgiVR2+v6xhGM6VWGcyChNKa5deXKISs
	 RSYiFN+Oop+ig==
Date: Fri, 21 Aug 2026 02:36:47 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org, Jeffrey Altman <jaltman@auristor.com>,
	keyrings@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH net v7 07/11] keys: Add refcounting to user-defined key
 type payload
Message-ID: <aoePj0fIQTn6Plae@kernel.org>
References: <20260812110129.979970-1-dhowells@redhat.com>
 <20260812110129.979970-8-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812110129.979970-8-dhowells@redhat.com>

On Wed, Aug 12, 2026 at 12:01:22PM +0100, David Howells wrote:
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


Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko
