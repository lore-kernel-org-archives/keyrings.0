Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D537B33E345;
	Sun, 18 Oct 2026 07:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792307306; cv=none; b=imL1fXF1rd0uBxLlJUWW0J6blT+iDMmlqXeSOPyHSlwaYjyyPW7LmmgRcy1xnd7iuzy4NMBqqDFnGTmltxZYrGDSYwFbhqb+NrBOuDR9exsD4QIe61LFPeIm7dpIk8yZlnm15uyWkshWXUtaBEF6QFBMQ4XYrAFWk64VYPyLY3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792307306; c=relaxed/simple;
	bh=FRtr34HF4ELZu293sn/gvPOY/M12nV0zuxFDnXhcvrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jP0ZhlcR/qhCGeX/BI/HV3oFIZdf3zNAlIeIu7eXVGQu9NI4gllV7ffhKTinXlPEXbtBE4PiOHKMHnhzeEzCuOlGc+N/FJGdfN67aZ1soTixwRQ0MOaQPxaXJufMdL15dE8jH+NlamBr3+Cr6vWxZ26rEh9SmlOxm6TKwVeghmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S39nGnyX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S39nGnyX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231741F000C4;
	Sun, 18 Oct 2026 07:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792307304;
	bh=JIKTiPL3NrJQwBDP+6SkARVHuBRhnm2uYsaOktMPKMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=S39nGnyX8lwA0McMI3Kqe9dqntBgtvOsUU4tvFxgD9QWeOsoIJ0rmptGkrlCSF2Bo
	 9ZXkGLXnTS3RCKM22QC2HJbebc0eEmPpL5b1xKq3ZhS8KFOj2FIevM3xPDJ6tiLQvX
	 2Qzm/Qoug+/uFAt56N675FeI9d0U20idlNYtiDAwR9TT6vsM4K+6BgoYVWBZa1n8Wi
	 HkbyKP8clWdOl0zBlwsUk3SYtKdrg6P6WsuCJ2tdLad0ZVpgkMLkraV1PeUMF+qMXy
	 BDzNBr56FWBCbEpxzyJCeR7PYC4Fhi/4BaaWwDFAjBL+iGY5te+saLde0Gmr1ms6Xu
	 5g+6016k6CNzg==
Date: Sun, 18 Oct 2026 00:08:22 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [RFC PATCH 5/6] KEYS: Replace assoc_array with struct
 keyring_index
Message-ID: <20261018070822.GA1904@sol>
References: <20261016215326.4110064-1-jarkko@kernel.org>
 <20261016215326.4110064-6-jarkko@kernel.org>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016215326.4110064-6-jarkko@kernel.org>

Thanks, this generally looks good.

I was tempted to recommend a custom hashtable, instead of rhashtable
plus the two lists alongside it, to save memory and avoid the rhashtable
dependency.  Especially given that the keyrings subsystem already uses
its own lock for writes, so the rhashtable bucket locks are wasted.

But ultimately I think I lean towards the rhashtable plus the two lists,
as this patch does.  It's slightly less code, it allows the hash table
to be shrunk (whereas custom solution would likely be grow-only), and it
continues to allow iterating over just the keyrings in a keyring without
traversing every key in that keyring.

On Sat, Oct 17, 2026 at 12:53:03AM +0300, Jarkko Sakkinen wrote:
> Linux keyring would be better off without struct assoc_array given the
> overhead caused by sole ownership of it. Linux has multiple popular choices
> for key-value store and there is nothing special in lib/assoc_array.c that
> would make it stand out enough to be ratiaonalize the time spent on
> maintaining it.

"to be ratiaonalize" => "to rationalize"

>  /*
> - * We mark pointers we pass to the associative array with bit 1 set if
> - * they're keyrings and clear otherwise.
> + * The contents of a keyring, allocated when the first link is made.
> + *
> + * Modified only with keyring->sem write-locked; read under RCU.  @ht indexes
> + * the links by index key, for direct lookup.  @all holds every committed link
> + * and @keyrings the committed links to keyrings, for iteration: an RCU walk of
> + * a list sees every entry that stays on it for the duration of the walk, which
> + * a walk of @ht racing with a resize does not.
> + */

"which a walk of @ht" => "while a walk of ht"

> + * ->hash is copied from the index key at __key_link_begin() and never changes,
> + * so the hash table can rehash the link without looking at the key, whose
> + * type the garbage collector may change (key_type_dead).
> +struct keyring_link {

This explanation seems inaccurate.  The actual reason ->hash is needed
is because reserved links can be inserted while ->key is still NULL.

> +	struct rhash_head	node;
> +	struct key __rcu	*key;		/* NULL while reserved */
> +	unsigned long		hash;
> +	struct list_head	all_link;	/* in keyring_index::all */
> +	struct list_head	keyrings_link;	/* in keyring_index::keyrings */
> +	struct keyring_link	*replaces;	/* Link this one replaces, or NULL */
> +	bool			is_keyring;

Make 'hash' u32 and make it adjacent to 'is_keyring' to get rid of the
hole?

Or at least make it u64, given that it's a SipHash value.

But it ultimately just gets combined with the rhashtable seed to produce
a 32-bit hash anyway, so u32 is enough.  (Then in keyring_hashfn() and
keyring_obj_hashfn(), use jhash_1word() instead of jhash_2word().)

'unsigned long' doesn't make much sense and seems to just be a holdover
from the assoc_array based code.

> +/*
> + * Pass each key linked from a keyring to @iterator until it returns non-zero.
> + * Returns the last value @iterator returned, or 0 if the keyring is empty.
> + * Concurrent links and unlinks may be seen or not; a key that stays linked
> + * throughout is passed to @iterator.
> + */
> +static int keyring_iterate(const struct key *keyring,
> +			   int (*iterator)(const struct key *key, void *data),
> +			   void *data)
> +{
> +	struct keyring_index *links;
> +	struct keyring_link *link;
> +	int ret = 0;
> +
> +	rcu_read_lock();

guard(rcu)()

> +	links = rcu_dereference(keyring->links);
> +	if (links) {
> +		list_for_each_entry_rcu(link, &links->all, all_link) {
> +			ret = iterator(keyring_link_key(link), data);
> +			if (ret)
> +				break;
> +		}
> +	}
> +	rcu_read_unlock();
> +	return ret;

... then 'return ret' in the loop, and 'return 0' at the end

> -/*
> - * Build the next index key chunk.
> - *
> - * The hash and inline description are followed by the 64-bit type and domain
> - * IDs, low word first, and then by the rest of the description.
> - * We return it one word-sized chunk at a time.
> - */
> -static unsigned long keyring_get_key_chunk(const void *data, int level)
> -{
> -	const unsigned int id_chunks = sizeof(u64) / sizeof(unsigned long);
> -	const struct keyring_index_key *index_key = data;
> -	int desc_len = index_key->desc_len;
> -	unsigned long chunk = 0;
> -	int n = sizeof(chunk);
> -	unsigned int offset;
> -	const u8 *d;
> -
> -	level /= ASSOC_ARRAY_KEY_CHUNK_SIZE;
> -	switch (level) {
> -	case 0:
> -		return index_key->hash;
> -	case 1:
> -		return index_key->x;
> -	}
> -
> -	level -= 2;
> -	if (level < id_chunks)
> -		return index_key->type_id >> (level * ASSOC_ARRAY_KEY_CHUNK_SIZE);
> -	level -= id_chunks;
> -	if (level < id_chunks)
> -		return index_key->domain_id >> (level * ASSOC_ARRAY_KEY_CHUNK_SIZE);
> -	level -= id_chunks;
> -
> -	offset = sizeof(index_key->desc) + level * sizeof(long);
> -	if (desc_len <= offset)
> -		return 0;

With type_id and domain_id no longer being used directly as part of a
radix tree key, they're no longer actually needed at all.  Provided that
we continue to use SipHash (or another cryptographically secure PRF)
with a random key, using the pointers directly (as was done originally)
no longer leaks kernel addresses.  E.g., we can just do:

	/* Finalize an index key: set the domain tag and calculate the hash. */
	void key_set_index_key(struct keyring_index_key *index_key)
	{
		static struct key_tag default_domain_tag = { .usage = REFCOUNT_INIT(1), };
		static siphash_key_t hash_key __read_mostly;
		u64 acc;

		if (!index_key->domain_tag) {
			if (index_key->type->flags & KEY_TYPE_NET_DOMAIN)
				index_key->domain_tag = current->nsproxy->net_ns->key_domain;
			else
				index_key->domain_tag = &default_domain_tag;
		}

		get_random_once(&hash_key, sizeof(hash_key));

		/*
		 * Compute a SipHash value of the description, type pointer, and domain
		 * tag pointer using a per-boot random key.
		 *
		 * Note that using the pointers as input to the hash is safe, since
		 * SipHash is a cryptographically secure pseudorandom function.  Thus
		 * the hash values don't leak any information about the pointers.
		 *
		 * Similarly, truncating the SipHash values to the required 32 bits is
		 * also safe.  No "folding" step is needed.
		 */
		acc = siphash(index_key->description, index_key->desc_len, &hash_key);
		acc = siphash_3u64((unsigned long)index_key->type,
				(unsigned long)index_key->domain_tag, acc,
				&hash_key);
		index_key->hash = (u32)acc;
	}

... and remove the type_id and domain_id fields.

Might be worth folding this into "keys: make keyring indexes independent
of kernel addresses" actually, since otherwise this just supersedes all
of that commit except for the introduction of SipHash.  And I guess this
commit will end up needing to be backported anyway, since otherwise
assoc_array bugs will be unfixed in stable.

> +/*
> + * The number of links in a keyring.
> + */
> +static unsigned long keyring_nr_links(const struct key *keyring)
> +{
> +	const struct keyring_index *links;
> +	unsigned long nr;
> +
> +	rcu_read_lock();
> +	links = rcu_dereference(keyring->links);
> +	nr = links ? READ_ONCE(links->nr) : 0;
> +	rcu_read_unlock();
> +	return nr;
>  }

Another opportunity for guard(rcu)():

	static unsigned long keyring_nr_links(const struct key *keyring)
	{
		const struct keyring_index *links;

		guard(rcu)();
		links = rcu_dereference(keyring->links);
		return links ? READ_ONCE(links->nr) : 0;
	}

> /*
>  * Search inside a keyring for a key.  We can search by walking to it
>  * directly based on its index-key or we can iterate over the entire
>  * tree looking for it, based on the match function.
>  */
>  static int search_keyring(struct key *keyring, struct keyring_search_context *ctx)

"entire tree" => "entire keyring", given that it seemed to be referring
to the implementation detail of the assoc_array being a tree.

On the topic of outdated comments, two comments also mention -ENFILE
being the error for when the keyring is full.  That's been outdated for
over a decade: there's no concept of a keyring being "full".

> +		link = keyring_find_link(rcu_dereference(keyring->links),
> +					 &ctx->index_key);
> +		if (!link)
> +			return 0;
> +		key = keyring_link_key(link);
> +		return key ? ctx->iterator(key, ctx) : 0;

Checking 'key' for NULL here is unnecessary, since keyring_find_link()
only matches a keyring_link that has a non-NULL key pointer.

> @@ -1123,8 +1055,8 @@ EXPORT_SYMBOL(keyring_restrict);
>  key_ref_t find_key_to_update(key_ref_t keyring_ref,
>  			     const struct keyring_index_key *index_key)
>  {
> +	struct keyring_link *link;
>  	struct key *keyring, *key;
> -	const void *object;
>  
>  	keyring = key_ref_to_ptr(keyring_ref);
>  
> @@ -1132,17 +1064,15 @@ key_ref_t find_key_to_update(key_ref_t keyring_ref,
>  	       keyring->serial, index_key->type->name, index_key->description);
>  
>  	guard(rcu)();
> -	object = assoc_array_find(&keyring->keys, &keyring_assoc_array_ops,
> -				  index_key);
> -
> -	if (object)
> +	link = keyring_find_link(rcu_dereference(keyring->links), index_key);
> +	key = link ? keyring_link_key(link) : NULL;
> +	if (key)
>  		goto found;

Similarly here.  Checking 'key' for NULL is unnecessary and this could
be:

	if (link) {
		key = keyring_link_key(link);
		goto found;
	}

>  /**
>   * key_unlink - Unlink the first link to a key from a keyring.
>   * @keyring: The keyring to remove the link from.
> @@ -1576,7 +1557,7 @@ static void __key_unlink_end(struct key *keyring,
>   * Returns 0 if successful, -ENOTDIR if the keyring isn't a keyring, -ENOENT if
>   * the key isn't linked to by the keyring or -ENOMEM if there's insufficient
>   * memory.
[..]
>   */
>  int key_unlink(struct key *keyring, struct key *key)

-ENOMEM is no longer a possible error from key_unlink(), since this
patch fixes the design to no longer need memory allocations for unlinks.

>  void keyring_gc(struct key *keyring, time64_t limit)
>  {
> +	struct keyring_index *links;
> +	struct keyring_link *link, *tmp;
>  	int result;
>  
>  	kenter("%x{%s}", keyring->serial, keyring->description ?: "");
> @@ -1756,10 +1711,7 @@ void keyring_gc(struct key *keyring, time64_t limit)
>  		goto dont_gc;
>  
>  	/* scan the keyring looking for dead keys */
> -	rcu_read_lock();
> -	result = assoc_array_iterate(&keyring->keys,
> -				     keyring_gc_check_iterator, &limit);
> -	rcu_read_unlock();
> +	result = keyring_iterate(keyring, keyring_gc_check_iterator, &limit);
>  	if (result == true)
>  		goto do_gc;

As long as this line is being changed, probably should remove the weird
comparison of an int to 'true':

	if (keyring_iterate(keyring, keyring_gc_check_iterator, &limit))
		goto do_gc;

> @@ -1769,10 +1721,11 @@ void keyring_gc(struct key *keyring, time64_t limit)
>  
>  do_gc:
>  	down_write(&keyring->sem);
> -	assoc_array_gc(&keyring->keys, &keyring_assoc_array_ops,
> -		       keyring_gc_select_iterator, &limit);
> -	key_payload_reserve(keyring,
> -			    keyring->keys.nr_leaves_on_tree * KEYQUOTA_LINK_BYTES);
> +	links = keyring_index_locked(keyring);

Would be worth leaving a comment here:

	/* links != NULL here, since at least one link was found. */

- Eric
