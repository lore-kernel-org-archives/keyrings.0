Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16DF407CF4;
	Wed, 26 Aug 2026 17:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787766866; cv=none; b=UZQg8iW8Q/ACdsehVR9m+4YH0bzdFqS41NUQs1R4WkGQtCfMAwEkyY9/D90BK6RRKb8Krwr0NxKwPOM9KNlg2ntFJSpx8MF6IpGW/12EsbQpb5ASyM7hoX1Yqn2pTqytTN8e7u3pUaqJHMdO7yL0ohZuy8+2jeHKlVHDxqM+Q/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787766866; c=relaxed/simple;
	bh=w9skj64TxRaJWqssAJlZeApfM4Av3byQ44QULYgGPRk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=AqwmrVIK4xWx8LtDKIM7PYxs/UIzToGEmMEqi31oYZB/IhTt8s7UGNKSvsq7UZQ4ybXEd+3dZ0If3hfX/7m9qKUsW6BychItvgvzWKiYyiqBHznVxyw6EBC9anGnZMdJ/vbPOwihT/ycaIe2hjVONS+dENFy8vBmCwT/BC7erdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdigilCm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdigilCm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F861F00A3A;
	Wed, 26 Aug 2026 17:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787766861;
	bh=djoosPotoK1GKZs9afsH0ieLbmjIxU9SrjjGSy7Po9o=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OdigilCm1VIurW4nQSwokrnq7jEGRLuhAXLq7mi4skWnVD6+D4EmEwRLHDuT/xk3E
	 Ay6NNNeGu3AGCb6hAQ78nuZ79TsKnMjY3Wp/0vQhFStmzdPpo6LdpFkcNWvyjoRKBy
	 wRQq4ke6qvhcCIp2PlfHxT6vR2KPdTdkEpMMqLaSj3Y8pqsmhhGu/tiBC6aJFPXNUj
	 fWg3tp6CKf2iY0ZtzVWa1RxQeLLiIjzB0GYz6G6zz2Ug//fm1JbzhxN8l+Z3NYyPzI
	 PD+KrSMUP8hGYB7AKDfKA6+RBTd00ACv1d24RIYhWoL9pe4zhOXwN+135WqNkhMDMN
	 hNRuCeSEm2j8w==
Content-Type: multipart/mixed; boundary="===============2876771852046386153=="
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <85816e37ec75b37214a821f28fe985baf2d9e2e5f2b3c7d39bc7c0f0f97a6dcd@mail.kernel.org>
In-Reply-To: <20260826164136.1400997-2-daniel@iogearbox.net>
References: <20260826164136.1400997-2-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v3 01/11] bpf, keys: Add a bpf keyring for program signature validation
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,memxor@gmail.com
Cc: brauner@kernel.org,kpsingh@kernel.org,ast@kernel.org,john.fastabend@gmail.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,dhowells@redhat.com,jarkko@kernel.org,keyrings@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Aug 2026 17:54:20 +0000 (UTC)

--===============2876771852046386153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/keys.c b/kernel/bpf/keys.c
> new file mode 100644
> index 0000000000000..08549b3220c13
> --- /dev/null
> +++ b/kernel/bpf/keys.c
> @@ -0,0 +1,68 @@

[ ... ]

> +struct bpf_key *bpf_lookup_keyring(void)
> +{
> +	struct bpf_key *bkey;
> +
> +	if (!bpf_keyring)
> +		return NULL;
> +	if (!READ_ONCE(bpf_keyring->keys.nr_leaves_on_tree) ||
> +	    !READ_ONCE(bpf_keyring->restrict_link))
> +		return NULL;

A subsystem pattern flags this as potentially concerning: the activation
gate samples bpf_keyring->keys.nr_leaves_on_tree and
bpf_keyring->restrict_link while holding neither bpf_keyring->sem nor
rcu_read_lock().

Both fields are written by assoc_array_apply_edit() and
keyring_restrict() under down_write(&keyring->sem), and the stores are
unmarked, so the READ_ONCE() loads form marked-read/unmarked-write pairs.

The two existing analogues, drivers/md/dm-verity-verify-sig.c and
fs/verity/signature.c, perform the same unlocked check with plain loads
and no annotation at all, so this patch is if anything stricter than
precedent.

Could a keyring maintainer confirm whether the gate is safe as written,
or whether all three sites need the keyring semaphore?

> +
> +	bkey = kmalloc_obj(*bkey);
> +	if (!bkey)
> +		return NULL;
> +
> +	bkey->key = bpf_keyring;
> +	bkey->has_ref = false;
> +	return bkey;
> +}

Does this overload struct bpf_key::has_ref in a way that breaks its
existing consumers?

bpf_lookup_keyring() introduces a third meaning for has_ref: a valid
struct key pointer with has_ref == false. The existing contract,
documented in bpf_lookup_system_key()'s kernel-doc, is that
has_ref == false means bkey->key is not a real pointer at all - it is a
sentinel understood only by verify_pkcs7_signature().

bpf_lookup_user_key() sets has_ref = true for real keys;
bpf_lookup_system_key() sets has_ref = false and stores
(struct key *)(unsigned long)id. This new code stores a real, live,
borrowed keyring pointer but flags it like a sentinel.

The borrow itself is safe - bpf_keyring keeps keyring_alloc()'s initial
reference for the lifetime of the system. But the two existing readers
of has_ref now behave wrongly for this case:

1) bpf_verify_pkcs7_signature() in kernel/bpf/helpers.c skips validation
   for has_ref == false:

     if (trusted_keyring->has_ref) {
             ret = key_validate(trusted_keyring->key);
             if (ret < 0)
                     return ret;
     }

   Revocation and invalidation of the .bpf keyring are still caught
   downstream by search_nested_keyrings(). Expiry is not caught anywhere.

   keyring_search_rcu() never tests the root keyring's expiry, and
   keyring_search_iterator() only tests the expiry of candidate leaf
   keys. Because the perm mask includes KEY_USR_SETATTR, root can
   'keyctl timeout <.bpf serial> <n>'; after the timeout the .bpf keyring
   keeps validating BPF program signatures, whereas the same operation on
   a caller-supplied keyring correctly makes the load fail with
   -EKEYEXPIRED.

2) bpf_key_serial() in include/linux/bpf.h is:

     return key->has_ref ? key->key->serial : 0;

   so the caller records prog->aux->sig.keyring_serial = 0 even though a
   genuine serial is available here. BPF LSM programs read this field
   directly, so they cannot see which keyring was used; they only get
   the new keyring_type == BPF_SIG_KEYRING_BPF.

Would it be clearer to either call key_validate() explicitly in
bpf_lookup_keyring(), or split the sentinel meaning out of has_ref with
a separate flag?

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e036ae20bf6b9..b45d201c25357 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -21016,10 +21019,17 @@ static int bpf_prog_verify_signature(struct bpf_verifier_env *env,
>  	if (!attr->signature_size ||
>  	    attr->signature_size > KMALLOC_MAX_CACHE_SIZE)
>  		return -EINVAL;
> -	if (system_keyring_id_check(attr->keyring_id) == 0)
> +	if (attr->keyring_id == KEY_SPEC_BPF_KEYRING) {
> +		key = bpf_lookup_keyring();
> +		if (!key) {
> +			verbose(env, "the bpf keyring is empty or has not been restricted\n");
> +			return -ENOKEY;

bpf_lookup_keyring() returns NULL for four distinct reasons:

  kernel/bpf/keys.c:
    if (!bpf_keyring)                              /* (a) never created */
            return NULL;
    if (!READ_ONCE(bpf_keyring->keys.nr_leaves_on_tree) ||
        !READ_ONCE(bpf_keyring->restrict_link))
            return NULL;                           /* (b) empty or (c) unrestricted */
    bkey = kmalloc_obj(*bkey);
    if (!bkey)
            return NULL;                           /* (d) allocation failure */

(a) covers 'the keyring was never created' - if keyring_alloc() or
keyring_restrict() failed at late_initcall, both leave bpf_keyring NULL
after only pr_err(). It also covers CONFIG_KEYS=n builds, where
bpf_lookup_keyring() is the static inline stub that unconditionally
returns NULL.

(d) is an -ENOMEM condition reported to userspace as -ENOKEY together
with the message "empty or has not been restricted", which is actively
misleading when debugging an OOM.

Could the message and errno distinguish these cases so the feedback is
actionable when provisioning the keyring?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32991355707
--===============2876771852046386153==--
