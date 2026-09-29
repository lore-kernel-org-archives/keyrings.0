Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E301A38F9;
	Tue, 29 Sep 2026 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790708680; cv=none; b=HdOl5uRUDWlcBl5Edw5Cq4yut+ui6I0damja7dSG1+5lhgpOsH53uwRfu8V7uwcfJmSFuBOTRs0oxZIXoA2VuukCSu8TgVZXfFbdO00mmRsM8Bri6eRkJ06m0g6KMJgopO01sNUm7wi2K9F5dD2YejYv3sIVuW84r/zI0jppEvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790708680; c=relaxed/simple;
	bh=cuteT0xc98zu7wYh9flsBJW9aeiuujy2n4scgjzyDac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/fcg+41kfVyRjypDjXw+YisXqPpwhkpcG6vpescwoTmOSJ44guznpyaxnWMR16XxxMZ1jrD+FED2ToMlyeQHRTWGQRMRt1zB4+jQohnAqlXRDT4dBxI+LX0Mslau+kxMRlQgHADZZWwbdEoiZg5SKRUV/zWXTt86cHoF7Ea/fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TydOuKRW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TydOuKRW"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7876A1F000FF;
	Tue, 29 Sep 2026 19:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790708679;
	bh=eHaqzCuJc1kBrB33K8XKBsjQAOa0goRZo+KTjM6jp3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TydOuKRWm2i7bEvVXXVFHjPcFiUs0cib+bMoGEEed5rLImehWFJ4Wth/rCa1HcfUi
	 3sVZh02xiV2wLkPm40AKTnNz2KZsYafRSP3SYAav2vm3Jr5oHm/jGOwPpgsudG/37V
	 TCzoAK9MnR2rWyyNX0iWOYQ5bqlnBMaTs1x/8LgNhefYHoPm+MvL2wT/NSuKw+d6la
	 q7AuAGgieqATyXQmdLNqj0RI3SsMzmEAGOKiVCIRFouDEsqSCBhCOiSQNgcgVJBYVw
	 NAbZbqcJ8HvDj6aRYThtyXq3ynKIEgYLw1btaLIi3yPwLTyTGGpR/IAiLCEgVePC30
	 0JuyMHgisuaTQ==
Date: Tue, 29 Sep 2026 22:04:34 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] assoc_array: discard shortcut when collapsing a
 leaf-only node
Message-ID: <arwLwmkwMG2vuTg9@kernel.org>
References: <20260925080548.2505640-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925080548.2505640-1-4ncienth@gmail.com>

On Fri, Sep 25, 2026 at 05:05:48PM +0900, Daehyeon Ko wrote:
> assoc_array_delete() can collapse a subtree into a node that contains only
> leaves while retaining the shortcut that led to it.  If that node later
> fills, all_leaves_cluster_together replaces it with another shortcut.  The
> first shortcut then points directly to the second one.
> 
> assoc_array_apply_edit() publishes this topology and propagates branch
> counts from the new child node.  It skips the inner shortcut, encounters
> the outer shortcut where it requires a node and triggers the BUG_ON().
> 
> Linux v7.2 and v6.12.105 are affected.  The same root remains at the
> base-commit below and in every supported stable branch checked down to
> 5.10.  It requires CONFIG_KEYS, but no capability, user namespace or race.
> A UID/GID 1000 process produced:
> 
>   CONTROL_BEGIN mode=exact uid=1000 gid=1000
>   CONTROL_CapEff: 0000000000000000
>   kernel BUG at lib/assoc_array.c:1388!
>   Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
>   CPU: 0 UID: 1000 PID: 154 Comm: exploit
>   RIP: assoc_array_apply_edit+0x4aa/0x690
>   Call Trace:
>    __key_link
>    __key_instantiate_and_link
>    __key_create_or_update
>    __do_sys_add_key
>   Kernel panic - not syncing: Fatal exception
> 
> When deletion produces a leaf-only node, bypass its preceding shortcut as
> garbage collection already does.  Retire the shortcut and old node together
> after an RCU grace period; reused leaves keep their references and the
> deleted leaf is still freed separately.
> 
> The exact trigger reached the BUG in 3/3 unmodified v7.2 KASAN boots and
> completed cleanly in 3/3 fixed boots.  Fixed v6.12.105 also passed 3/3.  A
> source reproducer is available privately on request.
> 
> Fixes: 3cb989501c26 ("Add a generic associative array implementation.")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>

Right so we end up to topology:

    A -> S1 -> S2 -> B

> ---
>  lib/assoc_array.c | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
> 
> diff --git a/lib/assoc_array.c b/lib/assoc_array.c
> index b6c9723e12ced..841dfe07dc962 100644
> --- a/lib/assoc_array.c
> +++ b/lib/assoc_array.c
> @@ -1210,8 +1210,22 @@ found_leaf:
>  				goto enomem;
>  			edit->new_meta[0] = assoc_array_node_to_ptr(new_n0);
>  
> -			new_n0->back_pointer = node->back_pointer;
> -			new_n0->parent_slot = node->parent_slot;
> +			/* A shortcut above a leaf-only node is redundant.  Drop it as
> +			 * GC does so that a later split can't create two shortcuts in a row.
> +			 */
> +			ptr = node->back_pointer;
> +			if (assoc_array_ptr_is_shortcut(ptr)) {
> +				struct assoc_array_shortcut *s =
> +					assoc_array_ptr_to_shortcut(ptr);
> +
> +				new_n0->back_pointer = s->back_pointer;
> +				new_n0->parent_slot = s->parent_slot;
> +				edit->excised_subtree = ptr;
> +			} else {
> +				new_n0->back_pointer = ptr;
> +				new_n0->parent_slot = node->parent_slot;
> +				edit->excised_subtree = assoc_array_node_to_ptr(node);
> +			}

And this code consumes the shortcut.

>  			new_n0->nr_leaves_on_branch = node->nr_leaves_on_branch;
>  			edit->adjust_count_on = new_n0;
>  
> @@ -1225,21 +1239,15 @@ found_leaf:
>  			pr_devel("collapsed %d,%lu\n", collapse.slot, new_n0->nr_leaves_on_branch);
>  			BUG_ON(collapse.slot != new_n0->nr_leaves_on_branch - 1);
>  
> -			if (!node->back_pointer) {
> +			if (!new_n0->back_pointer) {
>  				edit->set[1].ptr = &array->root;
> -			} else if (assoc_array_ptr_is_leaf(node->back_pointer)) {
> -				BUG();
> -			} else if (assoc_array_ptr_is_node(node->back_pointer)) {
> -				struct assoc_array_node *p =
> -					assoc_array_ptr_to_node(node->back_pointer);
> -				edit->set[1].ptr = &p->slots[node->parent_slot];
> -			} else if (assoc_array_ptr_is_shortcut(node->back_pointer)) {
> -				struct assoc_array_shortcut *s =
> -					assoc_array_ptr_to_shortcut(node->back_pointer);
> -				edit->set[1].ptr = &s->next_node;
> +			} else {
> +				struct assoc_array_node *p;
> +
> +				p = assoc_array_ptr_to_node(new_n0->back_pointer);
> +				edit->set[1].ptr = &p->slots[new_n0->parent_slot];
>  			}
>  			edit->set[1].to = assoc_array_node_to_ptr(new_n0);
> -			edit->excised_subtree = assoc_array_node_to_ptr(node);
>  		}
>  	}
>  
> 
> base-commit: 165768bb70265b5c38cf0b73fafd75be235f8b14
> -- 
> 2.55.0
> 

I checked also how garbage collector part works, compared the
implementations, and based on that this looks good to me.

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

Br, Jarkko
