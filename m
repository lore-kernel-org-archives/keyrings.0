Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EFF49BD8C;
	Wed,  9 Sep 2026 22:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788993915; cv=none; b=IYQ9aWvtyWfgI42iQpXZVr8FUMhC/4+G5Y4aNaL8NFsEQwhWZJJZAqbxeKWvITZq0TYXrRGIG5inXvkY65/DK62sOunN8rFZFAuRQLJZ87sSKd+lzPQsflPkM7biyVmguMwfdvPorOyGzDcz+hXsQ6vxaxVrurNLvdLvtczKz0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788993915; c=relaxed/simple;
	bh=1pohEkRkRTKr14WIc8Kdm4jTItnBwB1MtGczCR58BsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fARmFozqDH9Ir/9g9YKGoNZYQYrNh8Kh6DN3CbDkrnDRIS+qiUiD0LBK/NdUPOG88AQfItHyiw0RO87ePH1vovUxqeU0CBrT1/fFR++m/0cW2iBh0CciIV7LoWBDu5k6X6xConhLn8JMnUF8gzPsBsqRZtgeeTDGUXjfO/SzGpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiSeuaSF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiSeuaSF"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id E57F01F000FF;
	Wed,  9 Sep 2026 22:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788993896;
	bh=g2XFQ1WhPtycVFb6TdfuXMrofw2tfv8EfVRsLMQOs7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CiSeuaSFIZUcHP/TePFgqFoyArz7JQLx7EWdYp/QJf+CHxA/dUGjNPaUxRuCYrJxK
	 ICgl5s5gg+DqS32I8lcyx6QmQlDz91xs3T9cJQoNJp0uYhI/3bcCGQg6HHPCgMs20w
	 kD/BA1Ms7psXWNiG0LVRkzLd2/cOWOg0989jLEz+gf3e1KB3vRycjnxtgMlkA3O3pF
	 aTaPpEajfpOuj2y5thmJZfZKNDBhUzE+3Rp1w/iZ5Z8fHL++ngF1yY/fWpsJoe3nub
	 l19JCJHLOZVsvwSeRp0e2CzdGTyN2asGAF0XIYh172MSnpeXlRmwMZqIYqEUMoCjD4
	 NxgzNH2AfZI3Q==
Date: Thu, 10 Sep 2026 01:44:52 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] keys: Fix key_user use-after-free during ownership
 changes
Message-ID: <aqHhZO0GjMTOer4j@kernel.org>
References: <20260904080940.575882-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904080940.575882-1-nicoyip.dev@gmail.com>

On Fri, Sep 04, 2026 at 04:09:40PM +0800, Chengfeng Ye wrote:
> keyctl_chown_key() replaces key->user and then drops the key's
> reference to the previous key_user. Several paths access key->user
> without any common synchronization with this replacement, including
> the /proc/keys iterators, find_keyring_by_name(), quota accounting, and
> key instantiation.
> 
> This allows an ownership change to free the previous key_user while a
> reader is still accessing it:
> 
>   CPU 0 (/proc/keys)            CPU 1 (KEYCTL_CHOWN)
>   user = key->user
>                                 old = key->user
>                                 key->user = newowner
>                                 key_user_put(old)
>                                   kfree(old)
>   uid = user->uid
> 
> The same missing synchronization also can corrupt instantiated-key
> accounting. KEY_LOOKUP_PARTIAL allows keyctl_chown_key() to change the
> owner of a key while it is still being instantiated:
> 
>   CPU 0 (instantiate)           CPU 1 (KEYCTL_CHOWN)
>   atomic_inc(old->nikeys)
>                                 observe KEY_IS_UNINSTANTIATED
>                                 skip the nikeys transfer
>                                 key->user = newowner
>   mark key instantiated
> 
> The increment remains charged to the previous owner. Quota reservation
> can similarly select one owner for its quota limit and another owner
> for the usage update, or access an owner that has already been freed.
> 
> The existing locks do not provide common exclusion for these
> operations. keyctl_chown_key() holds key->sem, key construction uses
> key_construction_mutex, and the affected readers hold their respective
> tree or list locks.
> 
> Use key_user_lock to serialize access to key ownership. Hold it across
> the accounting transfer and key->user replacement in keyctl_chown_key().
> Use the same lock while readers copy the owner's UID, while quota usage
> is updated, and while the instantiated-key count and key state are
> committed.
> 
> key_user_lock already serializes final key_user removal, so an old
> owner cannot be freed while one of these readers is accessing it.
> 
> Fixes: 5801649d8b83 ("[PATCH] keys: let keyctl_chown() change a key's owner")
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
> Changes in v2:
> - Audit every user->uid occurrence and all direct key->user accesses.
> - Take key_user_lock explicitly at each namespace-filtering reader instead
>   of hiding the lock acquisition in an accessor.
> - Serialize quota reservation and construction accounting with ownership
>   changes while preserving the existing direct key->user accesses.
> - Use the commit that introduced ownership changes as the Fixes target.
> 
> Link: https://lore.kernel.org/keyrings/20260823170448.3856516-1-nicoyip.dev@gmail.com/ [v1]

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#separate-your-changes

I.e. no bundle commits. This unreviewable.

> ---
>  security/keys/key.c     | 13 +++++++++++--
>  security/keys/keyctl.c  |  4 ++++
>  security/keys/keyring.c |  7 ++++++-
>  security/keys/proc.c    | 15 +++++++++++++--
>  4 files changed, 34 insertions(+), 5 deletions(-)
> 
> diff --git a/security/keys/key.c b/security/keys/key.c
> index b34a64d81d47..54c675b3b58d 100644
> --- a/security/keys/key.c
> +++ b/security/keys/key.c
> @@ -21,6 +21,7 @@ struct rb_root		key_serial_tree; /* tree of keys indexed by serial */
>  DEFINE_SPINLOCK(key_serial_lock);
>  
>  struct rb_root	key_user_tree; /* tree of quota records indexed by UID */
> +/* Protects key_user_tree and key ownership changes. */
>  DEFINE_SPINLOCK(key_user_lock);
>  
>  unsigned int key_quota_root_maxkeys = 1000000;	/* root's key count quota */
> @@ -380,9 +381,12 @@ int key_payload_reserve(struct key *key, size_t datalen)
>  
>  	/* contemplate the quota adjustment */
>  	if (delta != 0 && test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
> -		unsigned maxbytes = uid_eq(key->user->uid, GLOBAL_ROOT_UID) ?
> -			key_quota_root_maxbytes : key_quota_maxbytes;
>  		unsigned long flags;
> +		unsigned int maxbytes;
> +
> +		spin_lock(&key_user_lock);
> +		maxbytes = uid_eq(key->user->uid, GLOBAL_ROOT_UID) ?
> +			key_quota_root_maxbytes : key_quota_maxbytes;
>  
>  		spin_lock_irqsave(&key->user->lock, flags);
>  
> @@ -396,6 +400,7 @@ int key_payload_reserve(struct key *key, size_t datalen)
>  			key->quotalen += delta;
>  		}
>  		spin_unlock_irqrestore(&key->user->lock, flags);
> +		spin_unlock(&key_user_lock);
>  	}
>  
>  	/* change the recorded data length if that didn't generate an error */
> @@ -447,8 +452,10 @@ static int __key_instantiate_and_link(struct key *key,
>  
>  		if (ret == 0) {
>  			/* mark the key as being instantiated */
> +			spin_lock(&key_user_lock);
>  			atomic_inc(&key->user->nikeys);
>  			mark_key_instantiated(key, 0);
> +			spin_unlock(&key_user_lock);
>  			notify_key(key, NOTIFY_KEY_INSTANTIATED, 0);
>  
>  			if (test_and_clear_bit(KEY_FLAG_USER_CONSTRUCT, &key->flags))
> @@ -604,8 +611,10 @@ int key_reject_and_link(struct key *key,
>  	/* can't instantiate twice */
>  	if (key->state == KEY_IS_UNINSTANTIATED) {
>  		/* mark the key as being negatively instantiated */
> +		spin_lock(&key_user_lock);
>  		atomic_inc(&key->user->nikeys);
>  		mark_key_instantiated(key, -error);
> +		spin_unlock(&key_user_lock);
>  		notify_key(key, NOTIFY_KEY_INSTANTIATED, -error);
>  		key_set_expiry(key, ktime_get_real_seconds() + timeout);
>  
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index d14ace88e529..83a9575b084e 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -1004,6 +1004,8 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
>  		if (!newowner)
>  			goto error_put;
>  
> +		spin_lock(&key_user_lock);
> +
>  		/* transfer the quota burden to the new user */
>  		if (test_bit(KEY_FLAG_IN_QUOTA, &key->flags)) {
>  			unsigned maxkeys = uid_eq(uid, GLOBAL_ROOT_UID) ?
> @@ -1039,6 +1041,7 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
>  		zapowner = key->user;
>  		key->user = newowner;
>  		key->uid = uid;
> +		spin_unlock(&key_user_lock);
>  	}
>  
>  	/* change the GID */
> @@ -1058,6 +1061,7 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
>  
>  quota_overrun:
>  	spin_unlock_irqrestore(&newowner->lock, flags);
> +	spin_unlock(&key_user_lock);
>  	zapowner = newowner;
>  	ret = -EDQUOT;
>  	goto error_put;
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 15bf4af8f282..5943e8b48c0f 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -1148,6 +1148,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
>  {
>  	struct user_namespace *ns = current_user_ns();
>  	struct key *keyring;
> +	kuid_t uid;
>  
>  	if (!name)
>  		return ERR_PTR(-EINVAL);
> @@ -1158,7 +1159,11 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
>  	 * grants Search permission and that hasn't been revoked
>  	 */
>  	list_for_each_entry(keyring, &ns->keyring_name_list, name_link) {
> -		if (!kuid_has_mapping(ns, keyring->user->uid))
> +		spin_lock(&key_user_lock);
> +		uid = keyring->user->uid;
> +		spin_unlock(&key_user_lock);
> +
> +		if (!kuid_has_mapping(ns, uid))
>  			continue;
>  
>  		if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
> diff --git a/security/keys/proc.c b/security/keys/proc.c
> index 4f4e2c1824f1..e507c500c068 100644
> --- a/security/keys/proc.c
> +++ b/security/keys/proc.c
> @@ -68,7 +68,13 @@ static struct rb_node *key_serial_next(struct seq_file *p, struct rb_node *n)
>  	n = rb_next(n);
>  	while (n) {
>  		struct key *key = rb_entry(n, struct key, serial_node);
> -		if (kuid_has_mapping(user_ns, key->user->uid))
> +		kuid_t uid;
> +
> +		spin_lock(&key_user_lock);
> +		uid = key->user->uid;
> +		spin_unlock(&key_user_lock);
> +
> +		if (kuid_has_mapping(user_ns, uid))
>  			break;
>  		n = rb_next(n);
>  	}
> @@ -80,6 +86,7 @@ static struct key *find_ge_key(struct seq_file *p, key_serial_t id)
>  	struct user_namespace *user_ns = seq_user_ns(p);
>  	struct rb_node *n = key_serial_tree.rb_node;
>  	struct key *minkey = NULL;
> +	kuid_t uid;
>  
>  	while (n) {
>  		struct key *key = rb_entry(n, struct key, serial_node);
> @@ -100,7 +107,11 @@ static struct key *find_ge_key(struct seq_file *p, key_serial_t id)
>  		return NULL;
>  
>  	for (;;) {
> -		if (kuid_has_mapping(user_ns, minkey->user->uid))
> +		spin_lock(&key_user_lock);
> +		uid = minkey->user->uid;
> +		spin_unlock(&key_user_lock);
> +
> +		if (kuid_has_mapping(user_ns, uid))
>  			return minkey;
>  		n = rb_next(&minkey->serial_node);
>  		if (!n)
> -- 
> 2.43.0

BR, Jarkko
