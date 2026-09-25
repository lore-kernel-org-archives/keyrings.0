Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE064EFFD2;
	Fri, 25 Sep 2026 22:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790377115; cv=none; b=i7q3RN52SYlIERImGO1kxtO931yUyWVmaaNSLM/4mdBMZc291NEMTOf3LV8GY7ltnph/VtflN/1CPjfvAjJdzmqIFV+md8huZhTrzo506VshE2Anf6sQC2KhsYC6QmhXjCUVmd4ms+rjPRSo7Fxn5jBdqTtsmm8JRGMa8on99H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790377115; c=relaxed/simple;
	bh=v+AG6RWdgZ91mn6d6/7szPJZ8scp6UFFv20Lym6Wxoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y81q8nPZBBEE3OAR1b9ZFeVmsaM5ziHlg8x+1ygScfBUBmzDq70/SoVbMlGtQxaRedNzVyh7+n5pWSEQV7XvRBFXZZds4shZCAE+No2JoWZnwfsusSqSv0pq6HEy9ADWSULDxbx0155+eJx8Gdp1CdyShxXRa61+RF3IgPyfraA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWSiiKEU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWSiiKEU"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id B9A271F000FF;
	Fri, 25 Sep 2026 22:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790377114;
	bh=/RxiZ6pICdZKB28+zFmygFOvg3f24FDnwwZTIKpMB8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FWSiiKEUmXzF3Mm04H4nM7LQVSDgrlx3ZsOHrmUIvMNSjCOBwuo6367+kCpqZWQah
	 SjZ0WSEGgi3Ilso05zrUejK6cf8h7sMz8CJNnHWInucMjqTMuEIPMMaAocor+mMVtV
	 HgVTBg+tGIQNDlC52nzFiRZjDy3um6q/fR2g5NIienGcf7Z8Xhfupb0qwzg+IwbK34
	 F7FHa42O7fZiD2BXYrvJq0LvcvZvNd1shpR4wKo2kzkqlsCUi7JWz+XEcgUvVulBWN
	 TOy7zcdIx/N3nb3DvG+ilK2bTuRXwT7ABNYk/n3VBCoGm3255GfddG8Up7WgSa3TYm
	 utSG/ALaPocuw==
Date: Sat, 26 Sep 2026 01:58:30 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Daehyeon Ko <4ncienth@gmail.com>, David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] assoc_array: discard shortcut when collapsing a
 leaf-only node
Message-ID: <arb8lrxxvW1d9mdV@kernel.org>
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

David, could you check up on this patch? I think you have a better
judgement here.

Br, Jarkko
