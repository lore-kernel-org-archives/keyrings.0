Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142403F106F;
	Thu, 27 Aug 2026 22:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787868362; cv=none; b=CSW5xlTukDnkWy1KqUTm1sspWJPtmPvrC5at2qGsu44kdJEn3U761T13knNKp6vDdvEViU5pW1Q4zzd0OZ4x4+wGVzrsCDLZeDHcYfoKrCEWzS2N58dOCi9D/ADabSkUxfqaT1EfHwSf6CK1REx3y/POThPwvG457QztkSuGROo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787868362; c=relaxed/simple;
	bh=poBYDZ4Eg3HvpbH01Bcr5xv8th65vKN6a6r+FEOdTW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fOEpKqNem19quo7Vrr/QdZMPxUUNJNDaof5jmEkmW/RFUhTN+bYHd/qTrx2Ebd1T6PGTTNmMaj0xCDoGNfIyIFAZGOABTUrdgXGYx5ltV5+ntMYlQsHRTro/zmKOacZ0RBrz7sZUMJy4ZO7m4TdGjQuEt45bznNe86BsqLlVnFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6L9etGk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6L9etGk"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 250941F000E9;
	Thu, 27 Aug 2026 22:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787868360;
	bh=uYQ//+Nc6FOYi0VIuRjLfmYOORJZwY6o51QG645xVho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R6L9etGkhGx1vUChACmOrrebXlCOnn9Fr08hZEt2UyklwGmgleywwVgoIZOWwjPVR
	 OEMa4EqfwKCZmeLN3Tu96ZTPggJsqvw92Vog1htRPk68ORqdFgWZBxLh4iqzwqvMHj
	 rpkTSVGDo0/M3Z6juKJagH0wd8PpLuhOz5VtCK2Ao6wsZVHrnPUFYwnd3EioISX5hr
	 5MLSypr++shF7PkdoNMQ2ov9zEmnzVcB4ztM7RLWPv5D5XWPT+IgYiT8YmkLaQKADj
	 OBFgcAcqaMvbj6vjB7RTwC/j/2jFoR4nqjLDt9Xe0PuVX1Tln+w9pCkUyRPYkW3ctg
	 95y8yovIUGr8Q==
Date: Fri, 28 Aug 2026 01:05:56 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Serge Hallyn <sergeh@kernel.org>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] keys: Fix key_user use-after-free during ownership
 changes
Message-ID: <apC0xGqWTIXTIgBU@kernel.org>
References: <20260823152858.3839939-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: keyrings@vger.kernel.org
List-Id: <keyrings.vger.kernel.org>
List-Subscribe: <mailto:keyrings+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:keyrings+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260823152858.3839939-1-nicoyip.dev@gmail.com>

On Sun, Aug 23, 2026 at 11:28:58PM +0800, Chengfeng Ye wrote:
> keyctl_chown_key() replaces key->user while holding key->sem and drops
> the old key_user reference after releasing the semaphore. The /proc/keys
> iterators and find_keyring_by_name() instead dereference key->user while
> holding unrelated locks.
> 
> This allows the following interleaving:
> 
>   CPU 0 (/proc/keys)            CPU 1 (KEYCTL_CHOWN)
>   load old key->user
>                                 replace key->user
>                                 key_user_put(old)
>                                   kfree(old)
>   read old->uid
> 
> Serialize the namespace-mapping reads and the pointer replacement with
> key_user_lock. This lock already protects final key_user removal, so the
> old object cannot be freed while its uid is being read. Keep reading the
> quota-owner UID rather than key->uid because those values can legitimately
> differ for thread keyrings.
> 
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  security/keys/internal.h | 10 ++++++++++
>  security/keys/keyctl.c   |  2 ++
>  security/keys/keyring.c  |  2 +-
>  security/keys/proc.c     |  4 ++--
>  4 files changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/security/keys/internal.h b/security/keys/internal.h
> index b7b622bc36a1..741d547ba5c4 100644
> --- a/security/keys/internal.h
> +++ b/security/keys/internal.h
> @@ -70,6 +70,16 @@ extern struct key_user	root_key_user;
>  extern struct key_user *key_user_lookup(kuid_t uid);
>  extern void key_user_put(struct key_user *user);
>  
> +static inline kuid_t key_user_uid(const struct key *key)
> +{
> +	kuid_t uid;
> +
> +	spin_lock(&key_user_lock);
> +	uid = key->user->uid;
> +	spin_unlock(&key_user_lock);
> +	return uid;
> +}
> +
>  /*
>   * Key quota limits.
>   * - root has its own separate limits to everyone else
> diff --git a/security/keys/keyctl.c b/security/keys/keyctl.c
> index d14ace88e529..c17924609317 100644
> --- a/security/keys/keyctl.c
> +++ b/security/keys/keyctl.c
> @@ -1036,8 +1036,10 @@ long keyctl_chown_key(key_serial_t id, uid_t user, gid_t group)
>  			atomic_inc(&newowner->nikeys);
>  		}
>  
> +		spin_lock(&key_user_lock);
>  		zapowner = key->user;
>  		key->user = newowner;
> +		spin_unlock(&key_user_lock);
>  		key->uid = uid;
>  	}
>  
> diff --git a/security/keys/keyring.c b/security/keys/keyring.c
> index 15bf4af8f282..49f4be934525 100644
> --- a/security/keys/keyring.c
> +++ b/security/keys/keyring.c
> @@ -1158,7 +1158,7 @@ struct key *find_keyring_by_name(const char *name, bool uid_keyring)
>  	 * grants Search permission and that hasn't been revoked
>  	 */
>  	list_for_each_entry(keyring, &ns->keyring_name_list, name_link) {
> -		if (!kuid_has_mapping(ns, keyring->user->uid))
> +		if (!kuid_has_mapping(ns, key_user_uid(keyring)))
>  			continue;
>  
>  		if (test_bit(KEY_FLAG_REVOKED, &keyring->flags))
> diff --git a/security/keys/proc.c b/security/keys/proc.c
> index 4f4e2c1824f1..8d6d26652aab 100644
> --- a/security/keys/proc.c
> +++ b/security/keys/proc.c
> @@ -68,7 +68,7 @@ static struct rb_node *key_serial_next(struct seq_file *p, struct rb_node *n)
>  	n = rb_next(n);
>  	while (n) {
>  		struct key *key = rb_entry(n, struct key, serial_node);
> -		if (kuid_has_mapping(user_ns, key->user->uid))
> +		if (kuid_has_mapping(user_ns, key_user_uid(key)))
>  			break;
>  		n = rb_next(n);
>  	}
> @@ -100,7 +100,7 @@ static struct key *find_ge_key(struct seq_file *p, key_serial_t id)
>  		return NULL;
>  
>  	for (;;) {
> -		if (kuid_has_mapping(user_ns, minkey->user->uid))
> +		if (kuid_has_mapping(user_ns, key_user_uid(minkey)))
>  			return minkey;
>  		n = rb_next(&minkey->serial_node);
>  		if (!n)
> -- 
> 2.43.0
> 

I hope you don't mind that I sanity check a bit:

 git grep "user->uid" security/keys
security/keys/internal.h:       uid = key->user->uid;
security/keys/key.c:            if (uid_lt(uid, user->uid))
security/keys/key.c:            else if (uid_gt(uid, user->uid))
security/keys/key.c:            unsigned maxbytes = uid_eq(key->user->uid, GLOBAL_ROOT_UID) ?
security/keys/proc.c:           if (kuid_has_mapping(user_ns, user->uid))
security/keys/proc.c:   unsigned maxkeys = uid_eq(user->uid, GLOBAL_ROOT_UID) ?
security/keys/proc.c:   unsigned maxbytes = uid_eq(user->uid, GLOBAL_ROOT_UID) ?
security/keys/proc.c:              from_kuid_munged(seq_user_ns(m), user->uid),
security/keys/process_keys.c:   uid_t uid = from_kuid(user_ns, cred->user->uid);
security/keys/process_keys.c:           uid_keyring = keyring_alloc(buf, cred->user->uid, INVALID_GID,
security/keys/process_keys.c:           session_keyring = keyring_alloc(buf, cred->user->uid, INVALID_GID,
security/keys/process_keys.c:                                               cred->user->uid));

Have you audited these and reflected against your current patch?

BR, Jarkko

