Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537640;
	b=FLsu0S7XVfACApJ1GW693DjSIF9qKajwDnmBvNHWR2YgKT4jO9hOwisIqF0kBO55OPi0
	 +7gW2qXgh7rEo34IsxbAqFkfWltiZL2swuhr6+NmMr9kiVwDELHt32G0QkwEaziO/tv5B
	 4rGoiza5oAW4xpVmCDhJAqUCfeeN5l4RzkjFDn61UHbYJuUpYyGyMGNZn0zAvQhRHT/7j
	 eNkRsZwzwlx5H8Q1lFOpFJV7XYpLdPFm0f/nTUckHu7JyWJwKdTRhMv2LY5pt5DRItmOz
	 +Xu1zn9sm/PrFMwDsr5FkC/uQPcs77v8AV23HM62xC91LgPYfF4PHdOOPz7vHIACPXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537640;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/+3j8Kgy9C8irEIqEgZC/GGq9yhGv+BkGWWDPqpisWM=;
	b=AW6csCyaFrkDLIodyTKHM+JhXHAadDxtWfeL2ougez8CW3Y8y5pN700q+SHWc/3yHZ35
	 58J9A4HZaeDnx5biBDpA+lbCMPqjKB+yio2PdLda6zq4Sk+8jDdAA4MwvCNjwuFGi0N53
	 DvDo2BpATNECNNuylIZR0pGmkaFqcKLS0Bw1V9IRc/84zTJxIyaVwXeFMrT03wBRblSMS
	 Vm+l93x6YPg+X9yURKpQGlXOrMk2WMl+I1iLVYgABDiRs+lYeZ5LDrFIMXDgaHf9iSxaj
	 Wfa01cV+0PR/lIitM+qn8oGc5aogervuU0i83sBsYBNKEN9CPHXlRrhXT5S91g9GwKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFxswjOq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E2B4A606A31E;
	Tue, 24 Nov 2026 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HFxswjOq
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7E3641F000C6;
	Tue, 24 Nov 2026 16:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795537639;
	bh=/+3j8Kgy9C8irEIqEgZC/GGq9yhGv+BkGWWDPqpisWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HFxswjOqjlOU5O8sEduHm9m2VZFLGo+Mn5AZc6zBg2oA1Zd7d/lMbMjPQWJhXOBn9
	 Cfxe+++lyg58q0+DzTMzbO2x8+bXrq+kDL5FVyMF3xieg687ljG1o4TgKSnBXqOpFc
	 WLGP6nFvAcsE0chG6ha18UaNjckmWqafRBWVion0okOvMM7UdAeckOyXJiXMAeCO5J
	 a5oJuuaMvXQ5AN1NqyX/N/Xt4DEVqG653oo7UsEjJwijcwG2+XjaReUScKEAG6Ecpg
	 jwFBF/KH6uQgSU2/j4/0aTmnAy+8b5ZHhc7+h+UySkg+1XzbeW3drR6oo/lPyAybFN
	 usLHHzy2AA60A==
Date: Tue, 24 Nov 2026 18:27:15 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guicai Ma <maguicai@kylinos.cn>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] KEYS: Protect key instantiation and rejection against
 type removal
Message-ID: <awW640zaT8Bnqd0-@kernel.org>
References: <20261124053303.940216-1-maguicai@kylinos.cn>
 <20261124091243.1019217-1-maguicai@kylinos.cn>
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Post: <mailto:keyrings@vger.kernel.org>
List-Help: <mailto:keyrings+help@vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
List-Owner: <mailto:keyrings+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124091243.1019217-1-maguicai@kylinos.cn>

On Tue, Nov 24, 2026 at 04:12:43AM -0500, Guicai Ma wrote:
> key_instantiate_and_link() reads key->type->def_datalen and ->preparse,
> passes key->type to restrict_link->check(), and invokes ->instantiate()
> and ->free_preparse() without synchronizing against key type removal.
> A reference on the key keeps the key object alive, but does not pin the
> module that provides its type.
> 
> unregister_key_type() removes the type from key_types_list and waits for
> key_garbage_collector() to run three passes: pass 1 sets KEY_FLAG_DEAD
> and clears key->perm, pass 2 unlinks dead keys from keyrings, and pass 3
> takes key->sem for writing, retypes key->type to &key_type_dead, and
> destroys the payload. A key still under construction stays in
> KEY_IS_UNINSTANTIATED with a valid authorisation key, so an upcall
> helper calling KEYCTL_INSTANTIATE after pass 3 reaches
> __key_instantiate_and_link() and jumps to key_type_dead.instantiate,
> which is NULL:
> 
>   Unable to handle kernel NULL pointer dereference at
>   virtual address 0000000000000000
>   Internal error: Oops: 0000000086000006 [#1] SMP
>   pc : 0x0
>   lr : __key_instantiate_and_link+0xb8/0x2f8
>   Call trace:
>    0x0 (P)
>    key_instantiate_and_link+0x2e8/0x36c
>    keyctl_instantiate_key_common+0x1cc/0x338
>    keyctl_instantiate_key+0xbc/0x120
>    __arm64_sys_keyctl+0x218/0x3f0
> 
> If the module unloads while ->preparse() or ->instantiate() is running,
> execution can also return into freed module text or skip
> ->free_preparse(). While the request_key() syscall holds key_types_sem
> across the upcall, in-kernel request_key() callers do not, so
> unregister_key_type() can run before KEYCTL_INSTANTIATE or
> KEYCTL_REJECT.
> 
> key_reject_and_link() shares the same window: it links the key into
> @keyring and calls key_set_expiry() (which reads key->type->flags)
> without checking KEY_FLAG_DEAD. Linking a dead key between GC pass 2 and
> pass 3 leaves it in the keyring's assoc_array while pass 3 overwrites
> key->type (which aliases key->index_key.type) in place.
> 
> Neither key->sem nor key_types_sem can be taken here: holding key->sem
> across __key_link_lock() and __key_instantiate_and_link() inverts lock
> order against encrypted_instantiate() (which locks the master key's
> semaphore under keyring->sem and key_construction_mutex), and
> key_instantiate_and_link() is already called with key_types_sem held for
> reading (e.g. from request_key_auth_new()).
> 
> Add key_type_srcu and call synchronize_srcu(&key_type_srcu) at the end
> of GC pass 1 (KEY_GC_REAPING_DEAD_1) whenever dead keys were marked.
> SRCU rather than RCU because ->preparse() and ->instantiate() may sleep.
> Hold key_type_srcu across the full body of key_instantiate_and_link()
> and key_reject_and_link() and check KEY_FLAG_DEAD:
> 
> - Callers that observe !KEY_FLAG_DEAD finish all key->type accesses and
>   any keyring linking before pass 2 unlinks dead keys and pass 3 retypes
>   them to key_type_dead.
> - Callers entering after synchronize_srcu() observe KEY_FLAG_DEAD:
>   key_instantiate_and_link() returns -EKEYREVOKED (matching
>   key_validate()), and key_reject_and_link() skips linking (returning
>   -EKEYREVOKED if @keyring was given) and key_set_expiry() while still
>   completing negative instantiation so waiters wake up and @authkey is
>   invalidated.
> 
> Also return -EOPNOTSUPP in key_instantiate_and_link() if a live key type
> does not provide ->instantiate().

The commit message is incomprehensible.

Br, Jarkko
