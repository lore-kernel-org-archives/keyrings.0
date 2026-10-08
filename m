Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2BC3AEF3A;
	Thu,  8 Oct 2026 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791480486; cv=none; b=ASv5Gh0pE0hdL0UrW2dO/R82cW+TnweB9dOlkUmcMlZwsi6aA8oCux7wVeW/KqbmZ0ffIUjjy5txBuyqoBeTck0JUBW4cstQynjcKvChU1idlUoFHrSYbGrnWdhddNkoroJuVOf2QkakdXR0u21g7xyjTvfskOJgVthHIODG3Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791480486; c=relaxed/simple;
	bh=/U2lphRr6npPlYS1erXpLu2mq3qjh0J8PqShg0Xymu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVup16H5gLNjkLXjvaqC9T9h0kYEl/LdfWph5bYAkwhjUpShAGMj1bv3jHQRIfC9Omp4/De2xoKFsvzt5LWwGPOYnIUMMLE10FaQXOykdcDOyNOHEZ8sEv8z+tNlpQGPcH6BT9iRtjSMfx/uOPzQfFdK1azMHCAbcvAt2Vuv8DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nTobY/78; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nTobY/78"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id CCCD51F000FF;
	Thu,  8 Oct 2026 17:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791480484;
	bh=QbSNvMSvd0vDRp1ZmrnAQYBIpsOVj4OsTYhiY+DWIbY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nTobY/78fdjTLcGSs5RDAMqDcO93rZw23LYOSNVKY/4b9bCqWE06l7Lp7VKW/AMth
	 DRcd4lM1SA1s6Tz1vTIkwZTBwuTNh9OFOhoYlPj4xzEYqi2VJTgEXOBqDfrMp94ncF
	 skWPEadT1P8kl/vJHgi9Rl+lkqirclsq9Poa9o7bpqHE6affCsuQ4QnS4FJsII2+Fb
	 Ldzrt2fOLZ1rLXCtf+a6UL0jggFsCNVDXpW7hL6591nZS1zQ0chCuZmg4YMfjfMtCZ
	 S2EW7N+/61+lFwX+RpqUZ5vbwnZPs9KiYYpeTJ3d3gZstURt9KwIMBTSQXg9TGy4BH
	 JOYJOGlnPixIQ==
Date: Thu, 8 Oct 2026 20:28:00 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Kyle Zeng <kylebot@openai.com>, dhowells@redhat.com
Cc: keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org, dhowells@redhat.com,
	outbounddisclosures@openai.com
Subject: Re: [PATCH] keys: make keyring indexes independent of kernel
 addresses
Message-ID: <asfSoKL_0NreaEnz@kernel.org>
References: <20261006223746.48940-1-kylebot@openai.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261006223746.48940-1-kylebot@openai.com>

On Tue, Oct 06, 2026 at 03:37:46PM -0700, Kyle Zeng wrote:
> KEYCTL_READ returns the serial numbers in a keyring in associative-array
> traversal order.  The first word of the index is a public, deterministic
> hash of the type pointer, domain pointer and description.  An unprivileged
> user can therefore insert keys with known descriptions, predict their
> order for each possible KASLR slide, and recover the kernel image address.
> On an x86-64 build with 16 MiB alignment, 45 user keys suffice to
> distinguish the candidate slides.
> 
> Remove the addresses from the whole index, not just its first hash word.
> Assign each key type and domain a nonzero 64-bit ID and hash those IDs and
> the description with a once-initialized SipHash key.  Use the full IDs in
> the later index chunks as well.  Truncating or hashing the IDs there would
> lose the guarantee that distinct type/domain/description tuples have a
> differing index bit.
> 
> Allocate IDs lazily since private key types need not be registered.  Cache
> them in the index key so tree walks and copies of an existing index do not
> need to dereference a type descriptor that may have been unregistered.
> Keep the 32-bit chunk layout and diff_objects() bit offsets consistent,
> and retain the separate root slot for keyrings used by recursive search.
> The key comparison, permissions and userspace data format are unchanged;
> only the address-dependent in-memory ordering is replaced.
> 
> Fixes: b2a4df200d57 ("KEYS: Expand the capacity of a keyring")
> Assisted-by: Codex:gpt-6-astra
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---

I personally am for this approach  but I'd like to have ACK or feedback
from David for this before moving further.

David, please take a look at this.

>  include/linux/key-type.h |   1 +
>  include/linux/key.h      |   5 ++
>  security/keys/keyring.c  | 145 +++++++++++++++++++++------------------
>  3 files changed, 83 insertions(+), 68 deletions(-)
> 
> diff --git a/include/linux/key-type.h b/include/linux/key-type.h
> index bb97bd3e5af4..c4f329b6ae3f 100644
> --- a/include/linux/key-type.h
> +++ b/include/linux/key-type.h
> @@ -161,6 +161,7 @@ struct key_type {
>  				     const void *in, const void *in2);
>  
>  	/* internal fields */
> +	atomic64_t		index_id;	/* Opaque keyring index ID */
>  	struct list_head	link;		/* link in types list */
>  	struct lock_class_key	lock_class;	/* key->sem lock class */
>  } __randomize_layout;
> diff --git a/include/linux/key.h b/include/linux/key.h
> index 81b8f05c6898..e40b5267658f 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -107,6 +107,7 @@ struct keyring_name;
>  
>  struct key_tag {
>  	struct rcu_head		rcu;
> +	atomic64_t		index_id;	/* Opaque keyring index ID */
>  	refcount_t		usage;
>  	bool			removed;	/* T when subject removed */
>  };
> @@ -129,6 +130,8 @@ struct keyring_index_key {
>  	struct key_type		*type;
>  	struct key_tag		*domain_tag;	/* Domain of operation */
>  	const char		*description;
> +	u64			type_id;	/* Cached index IDs */
> +	u64			domain_id;
>  };
>  
>  union key_payload {
> @@ -251,6 +254,8 @@ struct key {
>  			struct key_type	*type;		/* type of key */
>  			struct key_tag	*domain_tag;	/* Domain of operation */
>  			char		*description;
> +			u64		type_id;
> +			u64		domain_id;
>  		};
>  	};
>  
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 15bf4af8f282..c03e394b885d 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -14,6 +14,9 @@
>  #include <linux/err.h>
>  #include <linux/user_namespace.h>
>  #include <linux/nsproxy.h>
> +#include <linux/once.h>
> +#include <linux/random.h>
> +#include <linux/siphash.h>
>  #include <keys/keyring-type.h>
>  #include <keys/user-type.h>
>  #include <linux/assoc_array_priv.h>
> @@ -147,49 +150,46 @@ static int keyring_instantiate(struct key *keyring,
>  }
>  
>  /*
> - * Multiply 64-bits by 32-bits to 96-bits and fold back to 64-bit.  Ideally we'd
> - * fold the carry back too, but that requires inline asm.
> + * Give key types and domains address-independent identities.  Zero means that
> + * an ID has not yet been allocated.  As with inode sequence numbers used by
> + * futexes, this relies on the 64-bit counter not wrapping in a machine's
> + * lifetime.
>   */
> -static u64 mult_64x32_and_fold(u64 x, u32 y)
> +static u64 key_index_id(atomic64_t *id)
>  {
> -	u64 hi = (u64)(u32)(x >> 32) * y;
> -	u64 lo = (u64)(u32)(x) * y;
> -	return lo + ((u64)(u32)hi << 32) + (u32)(hi >> 32);
> +	static atomic64_t next_id;
> +	u64 old, new;
> +
> +	old = atomic64_read(id);
> +	if (likely(old))
> +		return old;
> +
> +	do {
> +		new = atomic64_inc_return(&next_id);
> +	} while (WARN_ON_ONCE(!new));
> +
> +	old = 0;
> +	if (!atomic64_try_cmpxchg_relaxed(id, &old, new))
> +		return old;
> +	return new;
>  }
>  
>  /*
> - * Hash a key type and description.
> + * Hash a key type, domain and description.  KEYCTL_READ exposes the tree's
> + * traversal order, so no part of the index may contain kernel addresses.
>   */
>  static void hash_key_type_and_desc(struct keyring_index_key *index_key)
>  {
> +	static siphash_key_t hash_key __read_mostly;
>  	const unsigned level_shift = ASSOC_ARRAY_LEVEL_STEP;
>  	const unsigned long fan_mask = ASSOC_ARRAY_FAN_MASK;
> -	const char *description = index_key->description;
> -	unsigned long hash, type;
> -	u32 piece;
> +	unsigned long hash;
>  	u64 acc;
> -	int n, desc_len = index_key->desc_len;
> -
> -	type = (unsigned long)index_key->type;
> -	acc = mult_64x32_and_fold(type, desc_len + 13);
> -	acc = mult_64x32_and_fold(acc, 9207);
> -	piece = (unsigned long)index_key->domain_tag;
> -	acc = mult_64x32_and_fold(acc, piece);
> -	acc = mult_64x32_and_fold(acc, 9207);
> -
> -	for (;;) {
> -		n = desc_len;
> -		if (n <= 0)
> -			break;
> -		if (n > 4)
> -			n = 4;
> -		piece = 0;
> -		memcpy(&piece, description, n);
> -		description += n;
> -		desc_len -= n;
> -		acc = mult_64x32_and_fold(acc, piece);
> -		acc = mult_64x32_and_fold(acc, 9207);
> -	}
> +
> +	get_random_once(&hash_key, sizeof(hash_key));
> +	acc = siphash(index_key->description, index_key->desc_len, &hash_key);
> +	acc = siphash_3u64(index_key->type_id, index_key->domain_id, acc,
> +			   &hash_key);
>  
>  	/* Fold the hash down to 32 bits if need be. */
>  	hash = acc;
> @@ -209,7 +209,7 @@ static void hash_key_type_and_desc(struct keyring_index_key *index_key)
>  
>  /*
>   * Finalise an index key to include a part of the description actually in the
> - * index key, to set the domain tag and to calculate the hash.
> + * index key, to set the domain tag and index IDs, and to calculate the hash.
>   */
>  void key_set_index_key(struct keyring_index_key *index_key)
>  {
> @@ -225,6 +225,14 @@ void key_set_index_key(struct keyring_index_key *index_key)
>  			index_key->domain_tag = &default_domain_tag;
>  	}
>  
> +	/* Preserve the IDs when copying an existing key's index.  In
> +	 * particular, its type may already have been unregistered.
> +	 */
> +	if (!index_key->type_id)
> +		index_key->type_id = key_index_id(&index_key->type->index_id);
> +	if (!index_key->domain_id)
> +		index_key->domain_id = key_index_id(&index_key->domain_tag->index_id);
> +
>  	hash_key_type_and_desc(index_key);
>  }
>  
> @@ -263,11 +271,14 @@ void key_remove_domain(struct key_tag *domain_tag)
>  /*
>   * Build the next index key chunk.
>   *
> + * The hash and inline description are followed by the 64-bit type and domain
> + * IDs, low word first, and then by the rest of the description.
>   * We return it one word-sized chunk at a time.
>   */
>  static unsigned long keyring_get_key_chunk(const void *data, int level)
>  {
>  	const struct keyring_index_key *index_key = data;
> +	const unsigned int id_chunks = sizeof(u64) / sizeof(unsigned long);
>  	unsigned long chunk = 0;
>  	const u8 *d;
>  	int desc_len = index_key->desc_len, n = sizeof(chunk);
> @@ -279,27 +290,30 @@ static unsigned long keyring_get_key_chunk(const void *data, int level)
>  		return index_key->hash;
>  	case 1:
>  		return index_key->x;
> -	case 2:
> -		return (unsigned long)index_key->type;
> -	case 3:
> -		return (unsigned long)index_key->domain_tag;
> -	default:
> -		level -= 4;
> -		offset = sizeof(index_key->desc) + level * sizeof(long);
> -		if (desc_len <= offset)
> -			return 0;
> -
> -		d = index_key->description + offset;
> -		desc_len -= offset;
> -		if (desc_len > n)
> -			desc_len = n;
> -		d += desc_len;
> -		do {
> -			chunk <<= 8;
> -			chunk |= *--d;
> -		} while (--desc_len > 0);
> -		return chunk;
>  	}
> +
> +	level -= 2;
> +	if (level < id_chunks)
> +		return index_key->type_id >> (level * ASSOC_ARRAY_KEY_CHUNK_SIZE);
> +	level -= id_chunks;
> +	if (level < id_chunks)
> +		return index_key->domain_id >> (level * ASSOC_ARRAY_KEY_CHUNK_SIZE);
> +	level -= id_chunks;
> +
> +	offset = sizeof(index_key->desc) + level * sizeof(long);
> +	if (desc_len <= offset)
> +		return 0;
> +
> +	d = index_key->description + offset;
> +	desc_len -= offset;
> +	if (desc_len > n)
> +		desc_len = n;
> +	d += desc_len;
> +	do {
> +		chunk <<= 8;
> +		chunk |= *--d;
> +	} while (--desc_len > 0);
> +	return chunk;
>  }
>  
>  static unsigned long keyring_get_object_key_chunk(const void *object, int level)
> @@ -330,6 +344,7 @@ static int keyring_diff_objects(const void *object, const void *data)
>  	const struct keyring_index_key *a = &key_a->index_key;
>  	const struct keyring_index_key *b = data;
>  	unsigned long seg_a, seg_b;
> +	u64 diff;
>  	int level, i;
>  
>  	level = 0;
> @@ -339,28 +354,22 @@ static int keyring_diff_objects(const void *object, const void *data)
>  		goto differ;
>  	level += ASSOC_ARRAY_KEY_CHUNK_SIZE / 8;
>  
> -	/* The number of bits contributed by the hash is controlled by a
> -	 * constant in the assoc_array headers.  Everything else thereafter we
> -	 * can deal with as being machine word-size dependent.
> -	 */
> +	/* The inline description contributes one machine-word-sized chunk. */
>  	seg_a = a->x;
>  	seg_b = b->x;
>  	if ((seg_a ^ seg_b) != 0)
>  		goto differ;
>  	level += sizeof(unsigned long);
>  
> -	/* The next bit may not work on big endian */
> -	seg_a = (unsigned long)a->type;
> -	seg_b = (unsigned long)b->type;
> -	if ((seg_a ^ seg_b) != 0)
> -		goto differ;
> -	level += sizeof(unsigned long);
> +	diff = a->type_id ^ b->type_id;
> +	if (diff)
> +		return level * 8 + __ffs64(diff);
> +	level += sizeof(u64);
>  
> -	seg_a = (unsigned long)a->domain_tag;
> -	seg_b = (unsigned long)b->domain_tag;
> -	if ((seg_a ^ seg_b) != 0)
> -		goto differ;
> -	level += sizeof(unsigned long);
> +	diff = a->domain_id ^ b->domain_id;
> +	if (diff)
> +		return level * 8 + __ffs64(diff);
> +	level += sizeof(u64);
>  
>  	i = sizeof(a->desc);
>  	if (a->desc_len <= i)
> -- 
> 2.53.0
> 

Br, Jarkko
